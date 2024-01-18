Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 934EE83116A
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 03:27:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQI7n-0000lT-1y; Wed, 17 Jan 2024 21:27:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQI7k-0000if-MB; Wed, 17 Jan 2024 21:27:20 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQI7j-0007WZ-2G; Wed, 17 Jan 2024 21:27:20 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6d9344f30caso200804b3a.1; 
 Wed, 17 Jan 2024 18:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705544837; x=1706149637; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAgnLusL+StN9Nwq80NzXjv+BAtwnLsP7JZrcmyUjeA=;
 b=mtGBJM791WMxBX2lFPr+RayOTCgQXzR66HBRnDLQdFHvrJCGPLa7gJH1ZyuGEoP5dK
 uiUsKZ8Ijc0AU7dGhMWX33+49UWSMnxdFeBLV5kTqTfs5ieT2I5k70W8/Rl61Conpwrh
 jHIYc+LWNBuce01+dAW2ryjN5bAPdHTA5JFn4GDCl1zrN4aWBGsJGSlWn7XkCcqacVOf
 GHGD4+ksA/PzZfPlcV2njHF7ceUuDQikhiNkW1uXjcuy5L+92cGhUH2Soh7cz5hF0h6O
 nDECis/zIXhyP0XfYNs/vZjYQcI8d17DkLxUCu5T0HwSf9v+GTh+zgV83ZOyJzlUh6jE
 j/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705544837; x=1706149637;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HAgnLusL+StN9Nwq80NzXjv+BAtwnLsP7JZrcmyUjeA=;
 b=nz6zPaH3ywTdOARPlNR+hAt9gzh2URSq0O9/KK+Sq8EX5jRDrGAKcXb/DLv4/oOFeG
 6aA5oKjHxxsBImS3SmGNut/xulS6ViIrNBkj0lErKIvIo6L4TY7bEt4MUYUkr837biuU
 MwtO6mQurQ9FdY6ovOHzciqt2FV6ekVYtWPpscaSGpHIThUGEMwqeZT2I45bKIvMciUr
 eKKLtuj6P5f35ahpAzWQn1ibBb37sIIj1BQw4sj4JD4aI+K1rTkSi8c27Xl3w9D/30wv
 x92El+/ysNiud/e32WFWO5DpTYfukcQNh/t4rLbc+PzzGxJqaqkw75G6OXM1/StL/4bj
 wytA==
X-Gm-Message-State: AOJu0Yws6IjAVeqMIa5vkk4yUFkUmvoA0rgUHgl2qwaVeIuEN7LX5mAk
 gXSmwVI+Tn6IBWudWQy7n3OZnLmxA1MmjDo/7I8W2Z3lNdSjmlZg
X-Google-Smtp-Source: AGHT+IGaoQ9c3AvXNUJySEG5xXPZwf0hiekZUF6JoRghv3xaxURp4gpT9M6j3W7s0yBQPYNlfK8c+A==
X-Received: by 2002:a05:6a20:12c3:b0:199:fffd:a3e3 with SMTP id
 v3-20020a056a2012c300b00199fffda3e3mr328648pzg.52.1705544837317; 
 Wed, 17 Jan 2024 18:27:17 -0800 (PST)
Received: from localhost ([1.146.114.176]) by smtp.gmail.com with ESMTPSA id
 jw15-20020a056a00928f00b006db6633f5edsm2105464pfb.159.2024.01.17.18.27.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 18:27:17 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jan 2024 12:27:12 +1000
Message-Id: <CYHH6N9OXRGH.1EJXKKN4KDDAB@wheely>
Cc: <danielhb413@gmail.com>, <clg@kaod.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH]     ppc/pnv: Add PowerPC Special Purpose Registers (SPRs):
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "dan tan" <dantan@linux.vnet.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240117223429.2295-1-dantan@linux.vnet.ibm.com>
 <20240117223429.2295-2-dantan@linux.vnet.ibm.com>
In-Reply-To: <20240117223429.2295-2-dantan@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Jan 18, 2024 at 8:34 AM AEST, dan tan wrote:
>     The handling of the following SPRs are added -
>         ITV1  (0x375, 885) - noop (not in Power10 ISA)

I can't see where this is defined. Not in P10 user manual AFAIKS?

>         SIER2 (0x2f0, 752) - Sampled Instruction Event Register 2
>         SIER2 (0x2f1, 753) - Sampled Instruction Event Register 3
>         MMCR3 (0x2f2, 754) - Performance Monitor Mode Control Register 3

These are new in POWER10 (ISA 3.1) too.

Thanks,
Nick

>
>     Signed-off-by: dan tan <dantan@linux.vnet.ibm.com>
> ---
>  target/ppc/cpu.h      |  4 ++++
>  target/ppc/cpu_init.c | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index f8101ff..de0af02 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1933,6 +1933,9 @@ void ppc_compat_add_property(Object *obj, const cha=
r *name,
>  #define SPR_BOOKE_TLB2CFG     (0x2B2)
>  #define SPR_BOOKE_TLB3CFG     (0x2B3)
>  #define SPR_BOOKE_EPR         (0x2BE)
> +#define SPR_POWER_SIER2       (0x2F0)
> +#define SPR_POWER_SIER3       (0x2F1)
> +#define SPR_POWER_MMCR3       (0x2F2)
>  #define SPR_PERF0             (0x300)
>  #define SPR_RCPU_MI_RBA0      (0x300)
>  #define SPR_MPC_MI_CTR        (0x300)
> @@ -2053,6 +2056,7 @@ void ppc_compat_add_property(Object *obj, const cha=
r *name,
>  #define SPR_440_INV3          (0x373)
>  #define SPR_440_ITV0          (0x374)
>  #define SPR_440_ITV1          (0x375)
> +#define SPR_ITV1              (0x375)
>  #define SPR_440_ITV2          (0x376)
>  #define SPR_440_ITV3          (0x377)
>  #define SPR_440_CCR1          (0x378)
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 40fe14a..71c46b2 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -5294,6 +5294,18 @@ static void register_power8_pmu_sup_sprs(CPUPPCSta=
te *env)
>                       SPR_NOACCESS, SPR_NOACCESS,
>                       &spr_read_generic, &spr_write_generic,
>                       KVM_REG_PPC_CSIGR, 0x00000000);
> +    spr_register_kvm(env, SPR_POWER_MMCR3, "MMCR3",
> +                     SPR_NOACCESS, SPR_NOACCESS,
> +                     &spr_read_generic, &spr_write_generic,
> +                     KVM_REG_PPC_MMCR3, 0x00000000);
> +    spr_register_kvm(env, SPR_POWER_SIER2, "SIER2",
> +                     SPR_NOACCESS, SPR_NOACCESS,
> +                     &spr_read_generic, &spr_write_generic,
> +                     KVM_REG_PPC_SIER2, 0x00000000);
> +    spr_register_kvm(env, SPR_POWER_SIER3, "SIER3",
> +                     SPR_NOACCESS, SPR_NOACCESS,
> +                     &spr_read_generic, &spr_write_generic,
> +                     KVM_REG_PPC_SIER3, 0x00000000);
>  }
> =20
>  static void register_power8_pmu_user_sprs(CPUPPCState *env)
> @@ -5670,6 +5682,11 @@ static void register_power_common_book4_sprs(CPUPP=
CState *env)
>                   &spr_access_nop, &spr_write_generic,
>                   &spr_access_nop, &spr_write_generic,
>                   0x00000000);
> +    spr_register_hv(env, SPR_ITV1, "ITV1",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_access_nop, &spr_write_generic,
> +                 &spr_access_nop, &spr_write_generic,
> +                 0x00000000);
>  #endif
>  }
> =20


