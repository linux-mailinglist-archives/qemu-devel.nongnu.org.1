Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E997442C1
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 21:37:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFJur-0003Jp-Ez; Fri, 30 Jun 2023 15:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFJup-0003JT-QT; Fri, 30 Jun 2023 15:36:23 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFJuo-0007MI-1H; Fri, 30 Jun 2023 15:36:23 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a1ebb85f99so1707283b6e.2; 
 Fri, 30 Jun 2023 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688153780; x=1690745780;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=am2aFKH7j5pw3o4YFocoUi3ugzJbF9POqRRwx4lJAFw=;
 b=ILwgaVJ1ZUU640N5Nk8i0mfoXJ2z087gWX3qiGjFqPFZQQMSZQAAC7JSLrYGTpvuxM
 cMxWwd4uRhT62V9c+DAT21itOi60zjsRrAse1dmLq6yAKtGY/JK14rBX0DljnhOXRm5F
 u9uhtkxYF8eMb1F3di+gR09zOoz6CUv+fjgaP5r96Eqd1K8HyavsI+co8Q9SOs4YSFji
 4ymykED2/mH1HBJZRfenis1RIVmSwFffwYoaj/bjKm414D1MZ/0d6LK69Xr6gQHtXDES
 UyYOioV1Pzuw0gfajwCXUhrTkigGGLnh+6F2eHwN4HGuEPeFktdiSkH7XlULoijp+tZ8
 rYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688153780; x=1690745780;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=am2aFKH7j5pw3o4YFocoUi3ugzJbF9POqRRwx4lJAFw=;
 b=WDzzs2rMcfh5CWGhZ/+vBKaZ7rqIhts6RGU4iAfBq6LrSHjjHd214zNbdzoF02iVQF
 Ipz/Gfbq3WiTKificrHjYC+VAlUsoKp3h0sT9r1YifXg0rvTVxvgy2K/H490veyBGnFP
 urKPt2bR+nZhbaGIpJajnCOLpa5WZjP5hrWlV3nZ1NWmjZH7lq59AqlRgYVa8aBz+BXU
 /PEWQWsExEhABGXxGNOFqOaQlZei8wO394Ve5+4SuegIpU009GZec1DHq7tKAUzTvNg/
 /Trb546czKkUrJWVLx4OLDGQh2+VhBOjnDuRI+nDXylDrzhf13QBRdCYdeZLqLTbOmsi
 Wshg==
X-Gm-Message-State: AC+VfDxJkvYmVQBlm8av19qR3rAf8jcCLPRuPja6Gs124KDRXIMo055r
 t3AOsiraK2JUD2qtLfjdp5A=
X-Google-Smtp-Source: ACHHUZ78BDGySUob6YCb4zyLLmR4GRjN9f96xm/9eMGSNTCvhgdb83jh03PoE6DtYCI3mTcVkI3kcw==
X-Received: by 2002:a54:488c:0:b0:3a1:e7fb:76fc with SMTP id
 r12-20020a54488c000000b003a1e7fb76fcmr3659162oic.17.1688153780331; 
 Fri, 30 Jun 2023 12:36:20 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 es20-20020a056808279400b003a054ec1d90sm6989966oib.6.2023.06.30.12.36.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 12:36:20 -0700 (PDT)
Message-ID: <1d6fed0b-1338-d359-89af-9a4e30e97589@gmail.com>
Date: Fri, 30 Jun 2023 16:36:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] target/ppc: Tidy POWER book4 SPR registration
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230625120317.13877-1-npiggin@gmail.com>
 <20230625120317.13877-2-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230625120317.13877-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x232.google.com
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
> POWER book4 (implementation-specific) SPRs are sometimes in their own
> functions, but in other cases are mixed with architected SPRs. Do some
> spring cleaning on these.
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

>   target/ppc/cpu_init.c | 82 +++++++++++++++++++++++++++++--------------
>   1 file changed, 55 insertions(+), 27 deletions(-)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index a97fb7fe10..21ff4861c3 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -5370,31 +5370,6 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
>                    &spr_read_generic, SPR_NOACCESS,
>                    &spr_read_generic, NULL,
>                    0x00000000);
> -    spr_register_hv(env, SPR_HID0, "HID0",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    spr_register_hv(env, SPR_TSCR, "TSCR",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic32,
> -                 0x00000000);
> -    spr_register_hv(env, SPR_HMER, "HMER",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_hmer,
> -                 0x00000000);
> -    spr_register_hv(env, SPR_HMEER, "HMEER",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    spr_register_hv(env, SPR_TFMR, "TFMR",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
>       spr_register_hv(env, SPR_LPIDR, "LPIDR",
>                    SPR_NOACCESS, SPR_NOACCESS,
>                    SPR_NOACCESS, SPR_NOACCESS,
> @@ -5656,14 +5631,60 @@ static void register_power8_ic_sprs(CPUPPCState *env)
>   #endif
>   }
>   
> +/* SPRs specific to IBM POWER CPUs */
> +static void register_power_common_book4_sprs(CPUPPCState *env)
> +{
> +#if !defined(CONFIG_USER_ONLY)
> +    spr_register_hv(env, SPR_HID0, "HID0",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_generic,
> +                 0x00000000);
> +    spr_register_hv(env, SPR_TSCR, "TSCR",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_generic32,
> +                 0x00000000);
> +    spr_register_hv(env, SPR_HMER, "HMER",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_hmer,
> +                 0x00000000);
> +    spr_register_hv(env, SPR_HMEER, "HMEER",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_generic,
> +                 0x00000000);
> +    spr_register_hv(env, SPR_TFMR, "TFMR",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_generic,
> +                 0x00000000);
> +#endif
> +}
> +
> +static void register_power9_book4_sprs(CPUPPCState *env)
> +{
> +    /* Add a number of P9 book4 registers */
> +    register_power_common_book4_sprs(env);
> +#if !defined(CONFIG_USER_ONLY)
> +    spr_register_kvm(env, SPR_WORT, "WORT",
> +                     SPR_NOACCESS, SPR_NOACCESS,
> +                     &spr_read_generic, &spr_write_generic,
> +                     KVM_REG_PPC_WORT, 0);
> +#endif
> +}
> +
>   static void register_power8_book4_sprs(CPUPPCState *env)
>   {
>       /* Add a number of P8 book4 registers */
> +    register_power_common_book4_sprs(env);
>   #if !defined(CONFIG_USER_ONLY)
>       spr_register_kvm(env, SPR_ACOP, "ACOP",
>                        SPR_NOACCESS, SPR_NOACCESS,
>                        &spr_read_generic, &spr_write_generic,
>                        KVM_REG_PPC_ACOP, 0);
> +    /* PID is only in BookE in ISA v2.07 */
>       spr_register_kvm(env, SPR_BOOKS_PID, "PID",
>                        SPR_NOACCESS, SPR_NOACCESS,
>                        &spr_read_generic, &spr_write_pidr,
> @@ -5679,10 +5700,12 @@ static void register_power7_book4_sprs(CPUPPCState *env)
>   {
>       /* Add a number of P7 book4 registers */
>   #if !defined(CONFIG_USER_ONLY)
> +    register_power_common_book4_sprs(env);
>       spr_register_kvm(env, SPR_ACOP, "ACOP",
>                        SPR_NOACCESS, SPR_NOACCESS,
>                        &spr_read_generic, &spr_write_generic,
>                        KVM_REG_PPC_ACOP, 0);
> +    /* PID is only in BookE in ISA v2.06 */
>       spr_register_kvm(env, SPR_BOOKS_PID, "PID",
>                        SPR_NOACCESS, SPR_NOACCESS,
>                        &spr_read_generic, &spr_write_generic32,
> @@ -5716,6 +5739,11 @@ static void register_power9_mmu_sprs(CPUPPCState *env)
>                       SPR_NOACCESS, SPR_NOACCESS,
>                       &spr_read_generic, &spr_write_generic,
>                       0x0000000000000000);
> +    /* PID is part of the BookS ISA from v3.0 */
> +    spr_register_kvm(env, SPR_BOOKS_PID, "PID",
> +                     SPR_NOACCESS, SPR_NOACCESS,
> +                     &spr_read_generic, &spr_write_pidr,
> +                     KVM_REG_PPC_PID, 0);
>   #endif
>   }
>   
> @@ -6269,7 +6297,7 @@ static void init_proc_POWER9(CPUPPCState *env)
>       register_power8_dpdes_sprs(env);
>       register_vtb_sprs(env);
>       register_power8_ic_sprs(env);
> -    register_power8_book4_sprs(env);
> +    register_power9_book4_sprs(env);
>       register_power8_rpr_sprs(env);
>       register_power9_mmu_sprs(env);
>   
> @@ -6462,7 +6490,7 @@ static void init_proc_POWER10(CPUPPCState *env)
>       register_power8_dpdes_sprs(env);
>       register_vtb_sprs(env);
>       register_power8_ic_sprs(env);
> -    register_power8_book4_sprs(env);
> +    register_power9_book4_sprs(env);
>       register_power8_rpr_sprs(env);
>       register_power9_mmu_sprs(env);
>       register_power10_hash_sprs(env);

