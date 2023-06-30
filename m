Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C57EE7442C0
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 21:37:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFJue-0003IL-Py; Fri, 30 Jun 2023 15:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFJuc-0003I9-Ei; Fri, 30 Jun 2023 15:36:10 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFJua-0007KK-Mw; Fri, 30 Jun 2023 15:36:10 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6b7279544edso1924335a34.0; 
 Fri, 30 Jun 2023 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688153767; x=1690745767;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dnBdBow/wMXmxA2Z9w4XoKT6KdIq6kOh/GswhuIf++M=;
 b=kQUO4sV5ZiQfv2mmsyrWslF5vgOKa/ETADNyraMRDAkY0hS3hKVSbVQXdI29P38C4M
 T4LzwXLHa9bTonJfWjmU0WEfRjYk9aC92zZ8jj0onh+3RL5pjxoBcaALGU3FPEo+Qy29
 fJ+iz9kZ/MCOrhFgTAyJASMjHqx966i94w9pF2GOyiFm6/fbGER0RLIBD/fpUoJui6lI
 CVx0Z1oc7gen0VAOuhczvGrooptppELQQdkn+2eluWarQ0AoH+ft04C0p6eXDxTKRvrB
 eh9d0TbdwFBAYHy2OLivQn+/A+TnyqwBEt56dvm9EUjivFpxwIKY63QTba15cuK0df2o
 2Img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688153767; x=1690745767;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dnBdBow/wMXmxA2Z9w4XoKT6KdIq6kOh/GswhuIf++M=;
 b=QPM4kecFBtbm54BqpR6nsyHU1oNbOcDofork7YJ9FiuItYu92AqWLwWgJwyNSQqUGv
 gtS7RU05CPTZBw59q6QuP49K6Ne4v2Q3rF8bIt3va/j/TTeQmO8U+qykGGAdWPsRyP7k
 Rw+IxqzC5owN+dxPuKSn8dXKq5XTZnuJL2vBEudPOrYaRrayFJtKkyuXIAANpUFeaiDO
 tuZLIgTvr6wGPxw1AA3WN1wf7lBoN9FwrH0jeEa7kk5mDSUinDjdA2lrYlsX0Bd8gdWS
 e/Ecf1eXQ2s6BG1cf2DZ91p5EBRUA66/06Oc6hyjerd4lPsTd19l36/1tJ+MHL45WAik
 RkVg==
X-Gm-Message-State: AC+VfDzB+jRprFCLyojGLJZoI7RrBFvr8AwuFinjCzhDkZqpRFosW108
 Nae0jXpj/kWzatU5ipS7oxc=
X-Google-Smtp-Source: ACHHUZ79dA1lFbJaDrbtNV7ohitjp0pjU71QfBpMAk9cu+Ga2mqBnvEsBZWR5m2rFLjzRrqtBIAjKA==
X-Received: by 2002:a9d:6f92:0:b0:6b7:e9ad:db90 with SMTP id
 h18-20020a9d6f92000000b006b7e9addb90mr3504894otq.11.1688153766892; 
 Fri, 30 Jun 2023 12:36:06 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 s1-20020a9d7581000000b006b8abc7a738sm482025otk.69.2023.06.30.12.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 12:36:06 -0700 (PDT)
Message-ID: <02047f1e-acc4-70e3-ffe9-25f5c4ab66c2@gmail.com>
Date: Fri, 30 Jun 2023 16:36:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] target/ppc: Add TFMR SPR implementation with read and
 write helpers
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230625120317.13877-1-npiggin@gmail.com>
 <20230625120317.13877-3-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230625120317.13877-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.095,
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



On 6/25/23 09:03, Nicholas Piggin wrote:
> TFMR is the Time Facility Management Register which is specific to
> POWER CPUs, and used for the purpose of timebase management (generally
> by firmware, not the OS).
> 
> Add helpers for the TFMR register, which will form part of the core
> timebase facility model in future but for now behaviour is unchanged.
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---


Queued in gitlab.com/danielhb/qemu/tree/ppc-next after amending this
qemu-system-ppc build error:

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index eac5e7ab5d..828f7844c8 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -722,6 +722,8 @@ DEF_HELPER_FLAGS_1(load_dpdes, TCG_CALL_NO_RWG, tl, env)
  DEF_HELPER_FLAGS_2(store_dpdes, TCG_CALL_NO_RWG, void, env, tl)
  DEF_HELPER_2(book3s_msgsndp, void, env, tl)
  DEF_HELPER_2(book3s_msgclrp, void, env, tl)
+DEF_HELPER_1(load_tfmr, tl, env)
+DEF_HELPER_2(store_tfmr, void, env, tl)
  #endif
  DEF_HELPER_2(store_sdr1, void, env, tl)
  DEF_HELPER_2(store_pidr, void, env, tl)
@@ -745,8 +747,6 @@ DEF_HELPER_2(store_40x_dbcr0, void, env, tl)
  DEF_HELPER_2(store_40x_sler, void, env, tl)
  DEF_HELPER_FLAGS_2(store_booke_tcr, TCG_CALL_NO_RWG, void, env, tl)
  DEF_HELPER_FLAGS_2(store_booke_tsr, TCG_CALL_NO_RWG, void, env, tl)
-DEF_HELPER_1(load_tfmr, tl, env)
-DEF_HELPER_2(store_tfmr, void, env, tl)
  DEF_HELPER_3(store_ibatl, void, env, i32, tl)
  DEF_HELPER_3(store_ibatu, void, env, i32, tl)
  DEF_HELPER_3(store_dbatl, void, env, i32, tl)




Daniel

>   target/ppc/cpu_init.c        |  2 +-
>   target/ppc/helper.h          |  2 ++
>   target/ppc/spr_common.h      |  2 ++
>   target/ppc/timebase_helper.c | 13 +++++++++++++
>   target/ppc/translate.c       | 10 ++++++++++
>   5 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 21ff4861c3..7d1b148fd4 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -5658,7 +5658,7 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
>       spr_register_hv(env, SPR_TFMR, "TFMR",
>                    SPR_NOACCESS, SPR_NOACCESS,
>                    SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> +                 &spr_read_tfmr, &spr_write_tfmr,
>                    0x00000000);
>   #endif
>   }
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index fda40b8a60..eac5e7ab5d 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -745,6 +745,8 @@ DEF_HELPER_2(store_40x_dbcr0, void, env, tl)
>   DEF_HELPER_2(store_40x_sler, void, env, tl)
>   DEF_HELPER_FLAGS_2(store_booke_tcr, TCG_CALL_NO_RWG, void, env, tl)
>   DEF_HELPER_FLAGS_2(store_booke_tsr, TCG_CALL_NO_RWG, void, env, tl)
> +DEF_HELPER_1(load_tfmr, tl, env)
> +DEF_HELPER_2(store_tfmr, void, env, tl)
>   DEF_HELPER_3(store_ibatl, void, env, i32, tl)
>   DEF_HELPER_3(store_ibatu, void, env, i32, tl)
>   DEF_HELPER_3(store_dbatl, void, env, i32, tl)
> diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
> index 4c0f2bed77..fbf52123b5 100644
> --- a/target/ppc/spr_common.h
> +++ b/target/ppc/spr_common.h
> @@ -194,6 +194,8 @@ void spr_write_ebb(DisasContext *ctx, int sprn, int gprn);
>   void spr_read_ebb_upper32(DisasContext *ctx, int gprn, int sprn);
>   void spr_write_ebb_upper32(DisasContext *ctx, int sprn, int gprn);
>   void spr_write_hmer(DisasContext *ctx, int sprn, int gprn);
> +void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn);
> +void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn);
>   void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn);
>   void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn);
>   #endif
> diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
> index b80f56af7e..08a6b47ee0 100644
> --- a/target/ppc/timebase_helper.c
> +++ b/target/ppc/timebase_helper.c
> @@ -144,6 +144,19 @@ void helper_store_booke_tsr(CPUPPCState *env, target_ulong val)
>       store_booke_tsr(env, val);
>   }
>   
> +#if defined(TARGET_PPC64)
> +/* POWER processor Timebase Facility */
> +target_ulong helper_load_tfmr(CPUPPCState *env)
> +{
> +    return env->spr[SPR_TFMR];
> +}
> +
> +void helper_store_tfmr(CPUPPCState *env, target_ulong val)
> +{
> +    env->spr[SPR_TFMR] = val;
> +}
> +#endif
> +
>   /*****************************************************************************/
>   /* Embedded PowerPC specific helpers */
>   
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index eb278c2683..9ce03344de 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1175,6 +1175,16 @@ void spr_write_hmer(DisasContext *ctx, int sprn, int gprn)
>       spr_store_dump_spr(sprn);
>   }
>   
> +void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn)
> +{
> +    gen_helper_load_tfmr(cpu_gpr[gprn], cpu_env);
> +}
> +
> +void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn)
> +{
> +    gen_helper_store_tfmr(cpu_env, cpu_gpr[gprn]);
> +}
> +
>   void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn)
>   {
>       gen_helper_store_lpcr(cpu_env, cpu_gpr[gprn]);

