Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BA07493C8
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 04:35:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHEoa-0004Tt-G8; Wed, 05 Jul 2023 22:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qHEoJ-0004TX-JP; Wed, 05 Jul 2023 22:33:36 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qHEoG-0004qE-Qi; Wed, 05 Jul 2023 22:33:34 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-992e22c09edso14892766b.2; 
 Wed, 05 Jul 2023 19:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1688610809; x=1691202809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+pS7VmVKZRb82wwgtLZxWdDaT1jbAtExkgiBO5G1Tm0=;
 b=e3XRZvpHiYnsGDu+0XmsP9TplTXh7pusmiRP6w5B74feafchX1+5qArqqQ6EcXe7Wx
 OWQX1eAriU3CEsQkU5+z637p7AOhLmY/a8dWDUzCdLHDtR8BpCVnla2NxMyuKP49qJjb
 czrsHJqm2j3V3ppBpjbhrRqGVIjXVEk6QTs28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688610809; x=1691202809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+pS7VmVKZRb82wwgtLZxWdDaT1jbAtExkgiBO5G1Tm0=;
 b=CgHCQIfiEIs9oejqXqXjhJ+qV852pRc4/TtqS4reKXPoANLiv5sM78pa78vQ8WO3d+
 iFt/b3V5bUCW3+sWokybNNZ8xESb3k5J8sLxL528LW2LYcLcAEDA3VpgG1ZAUroW9xTR
 BwRKxeZa49CoLUZ0+wZuaAjkY8S9LazHuFX0wqlvxf1zM3j0FIJI8BlSfkV2+aQI77Q5
 EcGzLLBKqdRFEl0u17KyAOU56g0oS7ZVtVWz9sSFHKGjZZ2mOmcUV8l8h/Mve8Kkbehz
 /MS/hFbMwof81kHRBnUOHkknMcrDayRefhXhKXXj4ddO6049MFydOPM+NsBSDyuhFuNw
 hwew==
X-Gm-Message-State: ABy/qLY8+Nd/gXcbU8mfdmLRR1OClzWlGz+OjVQI0DwCsUtRQDB1Je67
 yHW7N3VTu15Qr5XyFK1XulP1u2MiIjgvljzzMNk=
X-Google-Smtp-Source: APBJJlEJn6ZyKOT8hPropctWIpNy5QF9eI2edbDP0R5P0mDSm3aA0Au5nF0TiFNqhgbAOjRifGsR/Rozip//Tjv4qCQ=
X-Received: by 2002:a17:907:587:b0:990:8807:8f86 with SMTP id
 vw7-20020a170907058700b0099088078f86mr335653ejb.38.1688610809182; Wed, 05 Jul
 2023 19:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230705012736.20020-1-npiggin@gmail.com>
 <CACPK8XcsBt5ZQ=SRFd2+6OjRx4zM1gmcr12djiMugS9QTa6SGw@mail.gmail.com>
 <4b916a32-daf3-7081-af1a-c10c3ea26a40@kaod.org>
In-Reply-To: <4b916a32-daf3-7081-af1a-c10c3ea26a40@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 6 Jul 2023 02:33:17 +0000
Message-ID: <CACPK8XeLUOzviiT_8daqB2edCbLkBeeEB6HGMxboVTwcx9q2yA@mail.gmail.com>
Subject: Re: [PATCH] ppc/pnv: Set P10 core xscom region size to match hardware
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

On Wed, 5 Jul 2023 at 10:02, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 7/5/23 04:05, Joel Stanley wrote:
> > On Wed, 5 Jul 2023 at 01:27, Nicholas Piggin <npiggin@gmail.com> wrote:
> >>
> >> The P10 core xscom memory regions overlap because the size is wrong.
> >> The P10 core+L2 xscom region size is allocated as 0x1000 (with some
> >> unused ranges). "EC" is used as a closer match, as "EX" includes L3
> >> which has a disjoint xscom range that would require a different
> >> region if it were implemented.
> >>
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >
> > Nice, that looks better:
> >
> > 0000000100000000-00000001000fffff (prio 0, i/o): xscom-quad.0: 0x100000
> > 0000000100108000-000000010010ffff (prio 0, i/o): xscom-core.3: 0x8000
> > 0000000100110000-0000000100117fff (prio 0, i/o): xscom-core.2: 0x8000
> > 0000000100120000-0000000100127fff (prio 0, i/o): xscom-core.1: 0x8000
> > 0000000100140000-0000000100147fff (prio 0, i/o): xscom-core.0: 0x8000
> > 0000000108000000-00000001080fffff (prio 0, i/o): xscom-quad.4: 0x100000
> > 0000000108108000-000000010810ffff (prio 0, i/o): xscom-core.7: 0x8000
> > 0000000108110000-0000000108117fff (prio 0, i/o): xscom-core.6: 0x8000
> > 0000000108120000-0000000108127fff (prio 0, i/o): xscom-core.5: 0x8000
> > 0000000108140000-0000000108147fff (prio 0, i/o): xscom-core.4: 0x8000
> >
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> It'd interesting to add some dummy SLW handlers to get rid of the
> XSCOM errors at boot and shutdown on P10 :
>
> [ 4824.393446266,3] XSCOM: write error gcid=3D0x0 pcb_addr=3D0x200e883c s=
tat=3D0x0
> [ 4824.393588777,5] Unable to log error
> [ 4824.393650582,3] XSCOM: Write failed, ret =3D  -6
> [ 4824.394124623,3] Could not set special wakeup on 0:0: Unable to write =
QME_SPWU_HYP.
> [ 4824.394368459,3] XSCOM: write error gcid=3D0x0 pcb_addr=3D0x200e883c s=
tat=3D0x0
> [ 4824.394382007,5] Unable to log error
> [ 4824.394384603,3] XSCOM: Write failed, ret =3D  -6

Yes. I was looking at this yesterday. We need to figure out how to do
the xscom addressing for the QME. It sets (different) bits in order to
address a given core.

For a -smp 4 machine, the P10_QME_SPWU_HYP read comes in on these addresses=
:

    case 0x200e883c:
    case 0x200e483c:
    case 0x200e283c:
    case 0x200e183c:

ie, the fourth nibble selects the core.

For a -smp 8 machine, the address now has bit 24 set to select the
second quad, so we need to cover these addresses:

    case 0x210e883c:
    case 0x210e483c:
    case 0x210e283c:
    case 0x210e183c:

I am thinking about how to map this into an address range that a model
can claim.

Cheers,

Joel

PS. For reference, this is sufficient to silence xscom errors with
skiboot and -M powernv10 -smp4. A different set of hacks is required
for p9.

--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -106,6 +106,26 @@ static uint64_t xscom_read_default(PnvChip *chip,
uint32_t pcba)
     case 0x401082a:
     case 0x4010828:
         return 0;
+
+    /* P10_QME_SPWU_HYP */
+    case 0x200e883c:
+    case 0x200e483c:
+    case 0x200e283c:
+    case 0x200e183c:
+        return 0;
+
+    /* P10_QME_SSH_HYP */
+    case 0x200e882c:
+    case 0x200e482c:
+    case 0x200e282c:
+    case 0x200e182c:
+        return 0;
+
+    /* XPEC_P10_PCI_CPLT_CONF1 */
+    case 0x08000009:
+    case 0x09000009:
+        return 0;
+
     default:
         return -1;
     }
@@ -152,6 +172,13 @@ static bool xscom_write_default(PnvChip *chip,
uint32_t pcba, uint64_t val)
     case PRD_P8_IPOLL_REG_STATUS:
     case PRD_P9_IPOLL_REG_MASK:
     case PRD_P9_IPOLL_REG_STATUS:
+
+    /* P10_QME_SPWU_HYP */
+    case 0x200e883c:
+    case 0x200e483c:
+    case 0x200e283c:
+    case 0x200e183c:
+
         return true;
     default:
         return false;

