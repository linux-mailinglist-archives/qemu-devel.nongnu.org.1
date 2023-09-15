Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 310037A1271
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 02:40:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgwsH-0008PV-5l; Thu, 14 Sep 2023 20:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgwsF-0008P8-3J; Thu, 14 Sep 2023 20:39:55 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgwsD-00023c-A3; Thu, 14 Sep 2023 20:39:54 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3aca1543608so1045949b6e.0; 
 Thu, 14 Sep 2023 17:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694738391; x=1695343191; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oX2LxN07rccS8MlsdtcEYVTTWMnY3rImH8I3TCjxdME=;
 b=AWPhQrTrJD/avo3BFY6VZ7MWX7I92Pw0wRlVCOEM+ANpH/lDn3HaVWSmkf5lbeCaIy
 Iwr3V7oJSOGME1YexKjTZH9Sn3Iw3rs6/vDlfVlqiuhnY6Ufu/iiiUF1imBjoO1rQ7qV
 Izp/ABxBkBaj+gDJaM1ClwtVQ7eTovPk3CBkdAossoma8mwG7BUE+6/w2GLkG4fiJ+Gu
 4ZfDn/zGietX8TZWMYMJVkEwW35Wp3BSwT564iSK+G36HzdUOa27DFNqS/QzR1p+4f/P
 AMwUj3BpPJSpbjtybWvVXZmSEGPSfHJ624h+OXq3cURb2LSWg0caFcPrTv48H7RrOXF9
 AaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694738391; x=1695343191;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oX2LxN07rccS8MlsdtcEYVTTWMnY3rImH8I3TCjxdME=;
 b=BASkxL3TUvIOOcDgjNy8Mh6ek/NE6UVcJhjRfiW/8yScP5zhPcPL8Y/YnFWLpUHLVJ
 N84aRFcpnVUdH4d5v//2nBektMoFdqYXsLQZT6cMUNpXWppjwC8Nc/cqVqLtbD/lo8OE
 7qyTw5pnV81A8EfvBBWOBLFhY2go39aEYRH2GpBhLv7CTc1SsUc7Fgj/x/D1hVSK7w28
 KxRE7rv4uQx6b+CRzZpVennvK3Sa0p09sXvivxfhtZTeEVLJczXBWEU3hZmfZv2FHGcu
 SC2LmS2UfZKYBJ8WUsrWiASOTCfEJ4mELRVhNtF+VaKkvQPrpWc51N/+1tOpaOccttQL
 eeoA==
X-Gm-Message-State: AOJu0YzuHEG2Vpi5lxusCd1KcPlufnZFoMN3x3ybzylnk/ry16a4AT+D
 ns8g2+ohoZown+HhdZjR+Gw=
X-Google-Smtp-Source: AGHT+IFf4j7QBVAs5fHLCJEiGnD2NZzemxPJm/ODi5vnJ0bZ+/MaP0P6Ai7crmv8srMR+ZLN4FXxrw==
X-Received: by 2002:a05:6808:2796:b0:3a8:5fa6:47c0 with SMTP id
 es22-20020a056808279600b003a85fa647c0mr222854oib.16.1694738391025; 
 Thu, 14 Sep 2023 17:39:51 -0700 (PDT)
Received: from localhost ([193.114.103.68]) by smtp.gmail.com with ESMTPSA id
 bm1-20020a056a00320100b0068fbaea118esm1862476pfb.45.2023.09.14.17.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 17:39:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 Sep 2023 10:39:43 +1000
Message-Id: <CVJ2M9HZE734.1G62AT05YOJTP@wheely>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>, "open
 list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>
Subject: Re: [PATCH 1/4] target/ppc: Add new hflags to support BHRB
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Glenn Miles" <milesg@linux.vnet.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230912192144.3330174-1-milesg@linux.vnet.ibm.com>
 <20230912202347.3381298-1-milesg@linux.vnet.ibm.com>
In-Reply-To: <20230912202347.3381298-1-milesg@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed Sep 13, 2023 at 6:23 AM AEST, Glenn Miles wrote:
> This commit is preparatory to the addition of Branch History
> Rolling Buffer (BHRB) functionality, which is being provided
> today starting with the P8 processor.
>
> BHRB uses several SPR register fields to control whether or not
> a branch instruction's address (and sometimes target address)
> should be recorded.  Checking each of these fields with each
> branch instruction using jitted code would lead to a significant
> decrease in performance.
>
> Therefore, it was decided that BHRB configuration bits that are
> not expected to change frequently should have their state stored in
> hflags so that the amount of checking done by jitted code can
> be reduced.
>
> This commit contains the changes for storing the state of the
> following register fields as hflags:
>
> 	MMCR0[FCP] - Determines if BHRB recording is frozen in the
>                      problem state
>
> 	MMCR0[FCPC] - A modifier for MMCR0[FCP]
>
> 	MMCRA[BHRBRD] - Disables all BHRB recording for a thread
>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
>  target/ppc/cpu.h                 |  9 +++++++++
>  target/ppc/cpu_init.c            |  4 ++--
>  target/ppc/helper.h              |  1 +
>  target/ppc/helper_regs.c         | 12 ++++++++++++
>  target/ppc/machine.c             |  2 +-
>  target/ppc/power8-pmu-regs.c.inc |  5 +++++
>  target/ppc/power8-pmu.c          | 15 +++++++++++----
>  target/ppc/power8-pmu.h          |  4 ++--
>  target/ppc/spr_common.h          |  1 +
>  target/ppc/translate.c           |  6 ++++++
>  10 files changed, 50 insertions(+), 9 deletions(-)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 25fac9577a..20ae1466a5 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -439,6 +439,9 @@ FIELD(MSR, LE, MSR_LE, 1)
>  #define MMCR0_FC56   PPC_BIT(59)         /* PMC Freeze Counters 5-6 bit =
*/
>  #define MMCR0_PMC1CE PPC_BIT(48)         /* MMCR0 PMC1 Condition Enabled=
 */
>  #define MMCR0_PMCjCE PPC_BIT(49)         /* MMCR0 PMCj Condition Enabled=
 */
> +#define MMCR0_BHRBA  PPC_BIT_NR(42)      /* BHRB Available */

It's confusing to use NR for this. Either call it MMCR0_BHRBA_NR or have
the facility check in patch 3 take the bit value. I'd move it to patch 3
too.

> +#define MMCR0_FCP    PPC_BIT(34)         /* Freeze Counters/BHRB if PR=
=3D1 */
> +#define MMCR0_FCPC   PPC_BIT(51)         /* Condition for FCP bit */
>  /* MMCR0 userspace r/w mask */
>  #define MMCR0_UREG_MASK (MMCR0_FC | MMCR0_PMAO | MMCR0_PMAE)
>  /* MMCR2 userspace r/w mask */
> @@ -451,6 +454,9 @@ FIELD(MSR, LE, MSR_LE, 1)
>  #define MMCR2_UREG_MASK (MMCR2_FC1P0 | MMCR2_FC2P0 | MMCR2_FC3P0 | \
>                           MMCR2_FC4P0 | MMCR2_FC5P0 | MMCR2_FC6P0)
> =20
> +#define MMCRA_BHRBRD    PPC_BIT(26)            /* BHRB Recording Disable=
 */
> +
> +
>  #define MMCR1_EVT_SIZE 8
>  /* extract64() does a right shift before extracting */
>  #define MMCR1_PMC1SEL_START 32
> @@ -703,6 +709,9 @@ enum {
>      HFLAGS_PMCJCE =3D 17, /* MMCR0 PMCjCE bit */
>      HFLAGS_PMC_OTHER =3D 18, /* PMC other than PMC5-6 is enabled */
>      HFLAGS_INSN_CNT =3D 19, /* PMU instruction count enabled */
> +    HFLAGS_FCPC =3D 20,   /* MMCR0 FCPC bit */
> +    HFLAGS_FCP =3D 21,    /* MMCR0 FCP bit */
> +    HFLAGS_BHRBRD =3D 22, /* MMCRA BHRBRD bit */
>      HFLAGS_VSX =3D 23, /* MSR_VSX if cpu has VSX */
>      HFLAGS_VR =3D 25,  /* MSR_VR if cpu has VRE */

hflags are an interesting tradeoff. You can specialise some code but
at the cost of duplicating your jit footprint, which is often the
most costly thing. The ideal hflag is one where code is not shared
between flag set/clear like PR and HV. Rarely used features is another
good one, that BHRB falls into.

But, we do want flags that carry stronger or more direct semantics
wrt code generation because you want to avoid redundant hflags values
that result in the same code generation. I might have missed something
but AFAIKS BHRB_ENABLED could be a combination of this logic (from
later patch):

+    /* ISA 3.1 adds the PMCRA[BRHBRD] and problem state checks */
+    if ((ctx->insns_flags2 & PPC2_ISA310) && (ctx->mmcra_bhrbrd || !ctx->p=
r)) {
+        return;
+    }
+
+    /* Check for BHRB "frozen" conditions */
+    if (ctx->mmcr0_fcpc) {
+        if (ctx->mmcr0_fcp) {
+            if ((ctx->hv) && (ctx->pr)) {
+                return;
+            }
+        } else if (!(ctx->hv) && (ctx->pr)) {
+            return;
+        }
+    } else if ((ctx->mmcr0_fcp) && (ctx->pr)) {
+        return;
+    }

Otherwise the patch looks good to me.

Thanks,
Nick


