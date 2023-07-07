Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FEB74AC53
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 09:56:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHgJZ-0006Ro-5a; Fri, 07 Jul 2023 03:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qHgJU-0006Ph-Sd; Fri, 07 Jul 2023 03:55:37 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qHgJS-0000m3-T8; Fri, 07 Jul 2023 03:55:36 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-992af8b3b1bso192853466b.1; 
 Fri, 07 Jul 2023 00:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1688716533; x=1691308533;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFr1tZrrjp5H3h6Ax3mdMe3NLSpiO/ilud1S8H3B9oA=;
 b=UNmx3LhURZb9KVM2iU7Rxt2XBif9ySbVxSwB1SIaM9NNhmkeE9gMESoMg3OOB8LXPQ
 VnJvb0VuUn5lBEYLVcrEJveokf58on/B/QT/ovAVQLxG9P973bQGfzm7lQnnSRl9vA8j
 6BBJW9vvN5ru2tx3iekFF5/3LwGcS/oDeMX9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688716533; x=1691308533;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFr1tZrrjp5H3h6Ax3mdMe3NLSpiO/ilud1S8H3B9oA=;
 b=if4eSyZEOAuhmH8zM1DfpcNZo6uV3MoeEgWRR5w51aPSYWUH2pS8DkHoJm0bFUcrTZ
 /EEyKB/p9hoYQgMHbGXg/T0Fz58Lb/WK0L+vJYEMzlBYnfQTnNfUsk0i+tlD9zc/ZrqA
 INNCWNPKfvc0RYi+jKbrFiXxahsTTzL6zmuyIUw8BbfXt7TgAWhBJDbCMr7uM+YQetnm
 7uAwT4zHTbyo/Sy5bKfJPUwUoAG5/qIBszWrWv5p53j+8k44EwhFY3Ig0bLwCIU44kyG
 r4OuUSoDZUsW4Z213A+tv5qlPjR6eDaLJ4TXJrJZjPuDN5n8UFKbgjuZsPRLf0JD6NlS
 xl0Q==
X-Gm-Message-State: ABy/qLbg32/0CumnraXLG5qXQfBr3h2952NL3d489YoPit1tw/21+tvN
 vAvyY1Mfz8pdbA9ZEmagqTl1Cdhl4/TFmWqxuMY=
X-Google-Smtp-Source: APBJJlFfwR3kzesWvK3uV3YMdpc5A1N/zoY4tzka5zMtDCt6J+RLIerIYbl+t1gBCjA6iCWPxhfQk6rpLAOQrWuQOEA=
X-Received: by 2002:a17:906:242:b0:993:ce6c:685c with SMTP id
 2-20020a170906024200b00993ce6c685cmr1328476ejl.18.1688716532730; Fri, 07 Jul
 2023 00:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230707071213.9924-1-joel@jms.id.au>
 <4df588a9-7897-8ed5-bc72-c418034ad242@kaod.org>
In-Reply-To: <4df588a9-7897-8ed5-bc72-c418034ad242@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 7 Jul 2023 07:55:20 +0000
Message-ID: <CACPK8XdtYGqx-zSEa8MXO+2x5hVO2Vbku-+nqRmsjfdywFLjDg@mail.gmail.com>
Subject: Re: [PATCH v2] ppc/pnv: Add QME region for P10
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URIBL_CSS=0.1 autolearn=no autolearn_force=no
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

On Fri, 7 Jul 2023 at 07:30, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 7/7/23 09:12, Joel Stanley wrote:
> > The Quad Management Engine (QME) manages power related settings for its
> > quad. The xscom region is separate from the quad xscoms, therefore a ne=
w
> > region is added. The xscoms in a QME select a given core by selecting
> > the forth nibble.
> >
> > Implement dummy reads for the stop state history (SSH) and special
> > wakeup (SPWU) registers. This quietens some sxcom errors when skiboot
> > boots on p10.
> >
> > Power9 does not have a QME.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
>
> Nice, how about these now :
>
>
> [   24.482066616,3] Could not set special wakeup on 0:0: operation timeou=
t.
> [   25.022003091,3] Could not set special wakeup on 0:0: operation timeou=
t.
> [   25.073902795,3] Could not set special wakeup on 0:0: operation timeou=
t.
>
> [ 1593.383133413,3] Could not set special wakeup on 0:0: timeout waiting =
for SPECIAL_WKUP_DONE.
> [ 1593.435173594,3] Could not set special wakeup on 0:0: timeout waiting =
for SPECIAL_WKUP_DONE.

Yes, something like below, except hard coding is not sufficient. We
need to pass the core state into the quad model so the qme callbacks
can keep track of the wakeup state.

From: Joel Stanley <joel@jms.id.au>
Date: Fri, 7 Jul 2023 13:37:17 +0930
Subject: [PATCH] ppc/pnv: Implement more sleep related registers

We need to get the core object into the quad callback so we can update
the sleep state.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/ppc/pnv_core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 09eb2bf94b9e..359b341c748f 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -179,6 +179,7 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops =
=3D {
  */

 #define PNV10_XSCOM_EC_CORE_THREAD_STATE    0x412
+#define PNV10_XSCOM_EC_RAS_STATUS           0x454

 static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
                                            unsigned int width)
@@ -190,6 +191,9 @@ static uint64_t pnv_core_power10_xscom_read(void
*opaque, hwaddr addr,
     case PNV10_XSCOM_EC_CORE_THREAD_STATE:
         val =3D 0;
         break;
+    case PNV10_XSCOM_EC_RAS_STATUS:
+        val =3D -1;
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
                       offset);
@@ -494,7 +498,12 @@ static const MemoryRegionOps pnv_quad_power10_xscom_op=
s =3D {
 };

 #define P10_QME_SPWU_HYP 0x83c
+#define  P10_SPWU_REQ           PPC_BIT(0)
+#define  P10_SPWU_DONE          PPC_BIT(4)
+
 #define P10_QME_SSH_HYP  0x82c
+#define  P10_SSH_CORE_GATED     PPC_BIT(0)
+#define  P10_SSH_SPWU_DONE      PPC_BIT(1)

 static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
                                             unsigned int width)
@@ -508,8 +517,11 @@ static uint64_t pnv_qme_power10_xscom_read(void
*opaque, hwaddr addr,
      */
     switch (offset & ~0xf000) {
     case P10_QME_SPWU_HYP:
+        val =3D 0;
+        break;
     case P10_QME_SSH_HYP:
-        return 0;
+        val =3D P10_SSH_SPWU_DONE;
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
                       offset);
@@ -524,6 +536,8 @@ static void pnv_qme_power10_xscom_write(void
*opaque, hwaddr addr,
     uint32_t offset =3D addr >> 3;

     switch (offset) {
+    case P10_QME_SSH_HYP:
+    case P10_QME_SPWU_HYP:
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                       offset);
--=20
2.40.1

