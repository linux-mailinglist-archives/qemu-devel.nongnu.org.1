Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E4573F84A
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:08:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4gW-0008KM-0d; Tue, 27 Jun 2023 05:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4gP-0008ID-Pe
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:08:23 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4gO-0002KQ-5S
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:08:21 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51d91e9b533so2985406a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687856898; x=1690448898;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JRkiIQLsPL11uz0HtkgRIe8fPoEnvfYkMni+L16rh/c=;
 b=r0KrmgAukh1CDTLENxf+a/a8T8lvMMS8C7pnVhPJ8nfSdTtw9y3GsCGzRXnPloGMJv
 QyZr31YGJKmNSfb75O7D4/0JKYojmwVaSI+ueq/Zhrd7Phga0Qe6jCs1SgtGOZfkwG75
 Bm85UG4ymuzKD0Y+CJ2eeCEFi0a5driYoITPnNR8BWTeYNF5YM05jwv56NEEqwndJIMk
 oPbNZMhHur+DKgXS/dYvsc8MmwVFjX0VxfjCgoBMQX32E2BUGCCQeszDo28/RieRCjmN
 uedRT9G2LM7oph2IqF+PuvnWNABU7UOgZXYSTW2IkgrjCP57f9vgrCu6TWMF+mi+0xW5
 byrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687856898; x=1690448898;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JRkiIQLsPL11uz0HtkgRIe8fPoEnvfYkMni+L16rh/c=;
 b=g+GcoKgD1LkRWzRA8M21coQ/2Cnr73asigDoiTMRdTjb0NlRPAcrqL2PIwbsNZCWOT
 szU+ksAy4UfAf0iXBydCZ6PM5+LTe50cSPCdbnQ8Rmz2LnIYu1BLjX1iDB56J0nVTuH1
 xukghb9IzryeT7DTXtkR6P7W2VFdWwbvtQXSJ7dTS1GrSC/4MU4nwz/OEvKKvo7COHr5
 JTdnIH2+iu1sgFAuxyizfilHzkkNpdUDF/DqnIkvbNeQ/G7drVGYn4vpMWw0GWV9UPLJ
 H8BpROPdsisKSSPDG453rdgvAX/TUs5bVlVuBDU0/GYllNWrr6T1gA5ly6cnkVruXM2f
 fiEw==
X-Gm-Message-State: AC+VfDwejmldrhBoGk+RoH5VoZIXie6FC98iWzqcVAKeg/U2Z75hrSfO
 wG6w7mJQ71XKn30ThqX/GsBHlZ99tsEpWRWsh5I=
X-Google-Smtp-Source: ACHHUZ6SGW2CGNxxLcz/zb9cW5xjeB5Hu+fkf95KOMnFR9nLtzSX0Yt/ZElKcKFdtmEa8zR2bzHRhg==
X-Received: by 2002:aa7:cd43:0:b0:51b:df62:4f0b with SMTP id
 v3-20020aa7cd43000000b0051bdf624f0bmr10856377edw.6.1687856898652; 
 Tue, 27 Jun 2023 02:08:18 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 c20-20020aa7df14000000b0051d984e610esm2104839edy.66.2023.06.27.02.08.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 02:08:18 -0700 (PDT)
Message-ID: <4eaf927c-673b-5f44-8f76-b825cc0e135d@linaro.org>
Date: Tue, 27 Jun 2023 11:08:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/8] target/sparc: Introduce DYNAMIC_PC_LOOKUP
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
 <20230621180607.1516336-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230621180607.1516336-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 21/6/23 20:06, Richard Henderson wrote:
> Create a new artificial "next pc" which also indicates
> that nothing has changed within the cpu state which
> requires returning to the main loop.
> 
> Pipe this new value though all pc/npc checks.
> Do not produce this new value yet.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 155 ++++++++++++++++++++++++++++-----------
>   1 file changed, 111 insertions(+), 44 deletions(-)


> @@ -5608,20 +5649,46 @@ static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
>   static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>   {
>       DisasContext *dc = container_of(dcbase, DisasContext, base);
> +    bool may_lookup;
>   
>       switch (dc->base.is_jmp) {
>       case DISAS_NEXT:
>       case DISAS_TOO_MANY:
> -        if (dc->pc != DYNAMIC_PC &&
> -            (dc->npc != DYNAMIC_PC && dc->npc != JUMP_PC)) {
> +        if (((dc->pc | dc->npc) & 3) == 0) {
>               /* static PC and NPC: we can use direct chaining */
>               gen_goto_tb(dc, 0, dc->pc, dc->npc);
> -        } else {
> -            if (dc->pc != DYNAMIC_PC) {
> -                tcg_gen_movi_tl(cpu_pc, dc->pc);
> +            break;
> +        }
> +
> +        if (dc->pc & 3) {
> +            switch (dc->pc) {
> +            case DYNAMIC_PC_LOOKUP:
> +                may_lookup = true;
> +                break;
> +            case DYNAMIC_PC:
> +                may_lookup = false;
> +                break;
> +            default:
> +                g_assert_not_reached();
>               }
> -            save_npc(dc);
> +        } else {
> +            tcg_gen_movi_tl(cpu_pc, dc->pc);
> +            may_lookup = true;
> +        }
> +
> +        save_npc(dc);
> +        switch (dc->npc) {

switch (dc->npc & 3)?

> +        case DYNAMIC_PC_LOOKUP:
> +            if (may_lookup) {
> +                tcg_gen_lookup_and_goto_ptr();
> +                break;
> +            }
> +            /* fall through */
> +        case DYNAMIC_PC:
>               tcg_gen_exit_tb(NULL, 0);
> +            break;
> +        default:
> +            g_assert_not_reached();
>           }
>           break;
>   


