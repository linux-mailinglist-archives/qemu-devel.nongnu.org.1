Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C258838E27
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 13:07:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSFYX-00030k-QO; Tue, 23 Jan 2024 07:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rSFYV-000308-7q; Tue, 23 Jan 2024 07:07:03 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rSFYN-0007Cp-Hw; Tue, 23 Jan 2024 07:06:57 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5cfb81124ecso2974954a12.2; 
 Tue, 23 Jan 2024 04:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706011613; x=1706616413; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iuQdVqnNuzDqdrPKt8YlC3R5dF8phyxX7z3Sej1qaTA=;
 b=J3kXOoBX2mKyMpCol2uEWSsvaRLlVQ6sYeRAQJvhXm3IreCvofC02NPOGyRofK6m1w
 NPZRYZN0bdPrLQdChQF3ncOZQOVVHv9hElfoKF7u5z9Dk4x56IfE9vcIt2zZB8hb1Aq2
 /s3oN3rSCj+OgRteeRs4kNnVkh3WCaG0glW/fL7EbfMpV3Jw4G1cg0IYnmNHK0mw2vJQ
 s+o+OXsrIY0Ky8L9FbEbBbPB0BYrY30YD85o71BjyIo7BDSacf3hO62WIpzfgx/YhaJ7
 A8eXLbAXuDWKcTzJ2bdQW7EuZFWaGVf5oDqachs7W1x8kRPuECiGffOp9EdV/hkR65y8
 C8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706011613; x=1706616413;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iuQdVqnNuzDqdrPKt8YlC3R5dF8phyxX7z3Sej1qaTA=;
 b=K6JnRV2wGqNpnEjnm/6ixkxHu5sowTX6arUjBahi9nEXydPpjWMdwyXPmWyEhXYd/L
 bFiGYiLQbNy+0KCg3AR1QH/yfPIWuDDaB+GBdLCLhPm/aEfnhtc5jEgPFTMmmO19rZml
 Qt+zVDDIe5MOEhpFT4qj9s3KMOXxgEQAtZXpftvFaeMCvYXz/KkkhY6bHIzRfO2/RFIh
 EPBGrV+ltIndEr7MTygO0xQbZZ0mBZKBLr6wphflncM5nNgLFL54VhFnzbM6C1RfxprT
 6pgrdRrO1T9N3cMlnrUSIqrXqgxroh7e++zO6EGRQOaF+qnkrg+xTvnjBikozvENO0d5
 yGnw==
X-Gm-Message-State: AOJu0YyHwH3ugHvTZwE06HDs4DbbdDogZOorJGYdN2Mh/IXDn8WGlaqD
 JJW6qugQSGtZtlXEVOuPzseR9HnnYy5ReJD1TBLl7ZBZlWw0d5P3
X-Google-Smtp-Source: AGHT+IE9LK0azHbJ6N9UsOq+sqJiXLwjR5xZiX/EBZPxx8rjSW312NKG0RR4EEIiyeguHn9EFTWpkQ==
X-Received: by 2002:a05:6a20:3d01:b0:19c:5c71:8221 with SMTP id
 y1-20020a056a203d0100b0019c5c718221mr581257pzi.76.1706011613445; 
 Tue, 23 Jan 2024 04:06:53 -0800 (PST)
Received: from localhost (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a62b516000000b006dbd2405882sm5697389pfe.148.2024.01.23.04.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 04:06:53 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 22:06:47 +1000
Message-Id: <CYM2N4QA6ZDB.8JC8WRV7JPK3@wheely>
To: "Shivaprasad G Bhat" <sbhat@linux.ibm.com>, <danielhb413@gmail.com>,
 <clg@kaod.org>, <david@gibson.dropbear.id.au>, <harshpb@linux.ibm.com>,
 <pbonzini@redhat.com>, <qemu-ppc@nongnu.org>, <kvm@vger.kernel.org>
Cc: <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH v7] ppc: Enable 2nd DAWR support on p10
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <170063834599.621665.9541440879278084501.stgit@ltcd48-lp2.aus.stglab.ibm.com>
In-Reply-To: <170063834599.621665.9541440879278084501.stgit@ltcd48-lp2.aus.stglab.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x534.google.com
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

On Wed Nov 22, 2023 at 5:32 PM AEST, Shivaprasad G Bhat wrote:
> Extend the existing watchpoint facility from TCG DAWR0 emulation
> to DAWR1 on POWER10.
>
> As per the PAPR, bit 0 of byte 64 in pa-features property
> indicates availability of 2nd DAWR registers. i.e. If this bit is set, 2n=
d
> DAWR is present, otherwise not. Use KVM_CAP_PPC_DAWR1 capability to find
> whether kvm supports 2nd DAWR or not. If it's supported, allow user to se=
t
> the pa-feature bit in guest DT using cap-dawr1 machine capability.

Sorry for the late review.

>
> Signed-off-by: Ravi Bangoria <ravi.bangoria at linux.ibm.com>
> Signed-off-by: Shivaprasad G Bhat <sbhat at linux.ibm.com>
> ---
> Changelog:
> v6: https://lore.kernel.org/qemu-devel/168871963321.58984.156283826146212=
48470.stgit@ltcd89-lp2/
> v6->v7:
>   - Sorry about the delay in sending out this version, I have dropped the
>     Reviewed-bys as suggested and converted the patch to RFC back again.
>   - Added the TCG support. Basically, converted the existing DAWR0 suppor=
t
>     routines into macros for reuse by the DAWR1. Let me know if the macro
>     conversions should be moved to a separate independent patch.

I don't really like the macros. I have nightmares from Linux going
overboard with defining functions using spaghetti of generator macros.

Could you just make most functions accept either SPR number or number
(0, 1), or simply use if/else, to select between them?

Splitting the change in 2 would be good, first add regs + TCG, then the
spapr bits.

[snip]

> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index a05bdf78c9..022b984e00 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -204,16 +204,24 @@ void helper_store_ciabr(CPUPPCState *env, target_ul=
ong value)
>      ppc_store_ciabr(env, value);
>  }
>
> -void helper_store_dawr0(CPUPPCState *env, target_ulong value)
> -{
> -    ppc_store_dawr0(env, value);
> +#define HELPER_STORE_DAWR(id)                                           =
      \
> +void helper_store_dawr##id(CPUPPCState *env, target_ulong value)        =
      \
> +{                                                                       =
      \
> +    env->spr[SPR_DAWR##id] =3D value;                                   =
        \
>  }
>
> -void helper_store_dawrx0(CPUPPCState *env, target_ulong value)
> -{
> -    ppc_store_dawrx0(env, value);
> +#define HELPER_STORE_DAWRX(id)                                          =
      \
> +void helper_store_dawrx##id(CPUPPCState *env, target_ulong value)       =
      \
> +{                                                                       =
      \
> +    env->spr[SPR_DAWRX##id] =3D value;                                  =
        \
>  }

Did we lose the calls to ppc_store_dawr*? That will
break direct register access (i.e., powernv) if so.

>
> +HELPER_STORE_DAWR(0)
> +HELPER_STORE_DAWRX(0)
> +
> +HELPER_STORE_DAWR(1)
> +HELPER_STORE_DAWRX(1)

I would say open-code all these too instead of generating. If we
ever grew to >=3D 4 of them maybe, but as is this saves 2 lines,
and makes 'helper_store_dawrx0' more difficult to grep for.

Thanks,
Nick

