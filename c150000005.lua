--Action Card -  Battle Change
function c150000005.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c150000005.condition)
	e1:SetOperation(c150000005.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetCondition(c150000005.handcon)
	c:RegisterEffect(e2)
end
function c150000005.handcon(e)
	return tp~=Duel.GetTurnPlayer()
end
function c150000005.actcondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_BATTLE
end
function c150000005.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c150000005.condition)
	e1:SetOperation(c150000005.operation)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c150000005.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()	and Duel.GetAttacker():GetFlagEffect(150000005)==0
end
function c150000005.operation(e,tp,eg,ep,ev,re,r,rp)
	local ats=eg:GetFirst():GetAttackableTarget()
	local at=Duel.GetAttackTarget()
	if ats:GetCount()==0 or (at and ats:GetCount()==1) then return end
	if Duel.SelectYesNo(tp,aux.Stringid(150000005,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(150000005,1))
		local g=ats:Select(tp,1,1,at)
		Duel.Hint(HINT_CARD,0,150000005)
		Duel.HintSelection(g)
		Duel.ChangeAttackTarget(g:GetFirst())
		Duel.GetAttacker():RegisterFlagEffect(150000005,RESET_EVENT+0x1fe0000,0,1) 	
	end
end