Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE2A82D081
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 13:23:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOzVL-0007AS-MQ; Sun, 14 Jan 2024 07:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rOzVF-00079w-DJ
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 07:22:13 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rOzVD-0007sS-0C
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 07:22:13 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50e6ee8e911so9161700e87.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 04:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705234928; x=1705839728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4WLy0Jn5L0bRVN3nquFYC5ivaTwn2STN2BPox24LN8=;
 b=TWsRu3Ru9euC++mSoPYTzYv06eo3e9ycHeHVpLXA7UHezTQDPawx+Aj934JE5jUIhn
 2FGMOEpPT5pgsQP1MoMUauzzWVjl1TmR91BSbj+iteG4GTVgmAc+76XjOCrfY9RiUazf
 SK6sJHRzf9f8YgCou0JPiTmxattz9umhcW113/Ri9+xLjg/McH3iCK0xnEh3DpQqbujZ
 w8v50ICh/qBPonR+XeyRG1xm/MHfq3bGVKCDRjz86Mkr0W6Z4jCP30XhwO4a6r/rAPi9
 gqMAD9B6yK98MmIX1WAh7Ys0KhKz+HCG6JFzboIoKNnm90uPDX6jNe7dQBykWLzHEQJ6
 0G4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705234928; x=1705839728;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4WLy0Jn5L0bRVN3nquFYC5ivaTwn2STN2BPox24LN8=;
 b=jkF0xkzgLueW7l3J2R5z0byP/wsGAFctiCrrFdEwiusycaLCQBsaydYZO/lRPZCIE5
 DvArJs6aidXO7ZbFhG1sZ2cQItCT9IPyC+rCgdrlmZkFXXcrRy5LGA+P+PSp+hoNavwM
 U64k0gdcCkpOmcBI7gi/LZMWS7KfmEzaIbFY1erPTO2do4eivhrCmc/upqSMsl91+SlC
 VEpR5oG8CqbBxkpjqPqkGGUKrsdYVbmaF3UuY3kcgE++6EqeVM7w1dvpFFyu76BiPbfm
 pE9w/9rfJMQ5iypXLFyCE0J70vvLe/nvHM9XgXmkEFqNryjNryvUPa9alL9Z/BjfG6dy
 179A==
X-Gm-Message-State: AOJu0YyB6wltlH5nTjn6Bu35kd6jaEQvG2uwrzOnbdx/VfpQnh1aAlyF
 Hdjel7QbSXgt2/KxWvGvE4X1Ux6GM1I=
X-Google-Smtp-Source: AGHT+IGffXqbfcTbgvg/M/WX4Vodo0S9K719nbuFypYeXJPw/acIGJ2/C85yJ2piMEImH0Z207xfCg==
X-Received: by 2002:a05:6512:39d5:b0:50e:aa46:2a95 with SMTP id
 k21-20020a05651239d500b0050eaa462a95mr2216499lfu.18.1705234927908; 
 Sun, 14 Jan 2024 04:22:07 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-183-249-018.77.183.pool.telefonica.de.
 [77.183.249.18]) by smtp.gmail.com with ESMTPSA id
 d14-20020a170906c20e00b00a298e2f6b3csm3998496ejz.213.2024.01.14.04.22.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jan 2024 04:22:06 -0800 (PST)
Date: Sun, 14 Jan 2024 12:21:59 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: Chuck Zmudzinski <brchuckz@aol.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 David Woodhouse <dwmw2@infradead.org>, Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anthony PERARD <anthony.perard@citrix.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/i386/pc=5Fpiix=3A_Make_piix=5Fintx=5Fr?=
 =?US-ASCII?Q?outing=5Fnotifier=5Fxen=28=29_more_device_independent?=
In-Reply-To: <20240107231623.5282-1-shentey@gmail.com>
References: <20240107231623.5282-1-shentey@gmail.com>
Message-ID: <B404ABCE-E6B5-4716-BA60-3CEE74B72701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x130.google.com
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



Am 7=2E Januar 2024 23:16:23 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>This is a follow-up on commit 89965db43cce "hw/isa/piix3: Avoid Xen-speci=
fic
>variant of piix3_write_config()" which introduced
>piix_intx_routing_notifier_xen()=2E This function is implemented in board=
 code but
>accesses the PCI configuration space of the PIIX ISA function to determin=
e the
>PCI interrupt routes=2E Avoid this by reusing pci_device_route_intx_to_ir=
q() which
>makes piix_intx_routing_notifier_xen() more device-agnostic=2E
>
>One remaining improvement would be making piix_intx_routing_notifier_xen(=
)
>agnostic towards the number of PCI interrupt routes and move it to xen-hv=
m=2E
>This might be useful for possible Q35 Xen efforts but remains a future ex=
ercise
>for now=2E
>
>Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>

Hi Michael,

could you tag this, too? Or do we need another R-b?

Best regards,
Bernhard

>---
> hw/i386/pc_piix=2Ec | 9 +++------
> 1 file changed, 3 insertions(+), 6 deletions(-)
>
>diff --git a/hw/i386/pc_piix=2Ec b/hw/i386/pc_piix=2Ec
>index 042c13cdbc=2E=2Eabfcfe4d2b 100644
>--- a/hw/i386/pc_piix=2Ec
>+++ b/hw/i386/pc_piix=2Ec
>@@ -92,13 +92,10 @@ static void piix_intx_routing_notifier_xen(PCIDevice =
*dev)
> {
>     int i;
>=20
>-    /* Scan for updates to PCI link routes (0x60-0x63)=2E */
>+    /* Scan for updates to PCI link routes=2E */
>     for (i =3D 0; i < PIIX_NUM_PIRQS; i++) {
>-        uint8_t v =3D dev->config_read(dev, PIIX_PIRQCA + i, 1);
>-        if (v & 0x80) {
>-            v =3D 0;
>-        }
>-        v &=3D 0xf;
>+        const PCIINTxRoute route =3D pci_device_route_intx_to_irq(dev, i=
);
>+        const uint8_t v =3D route=2Emode =3D=3D PCI_INTX_ENABLED ? route=
=2Eirq : 0;
>         xen_set_pci_link_route(i, v);
>     }
> }

