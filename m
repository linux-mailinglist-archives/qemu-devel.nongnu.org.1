Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AFF7481A5
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 12:03:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGzKc-00011s-Kf; Wed, 05 Jul 2023 06:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qGzKZ-00010k-Ht; Wed, 05 Jul 2023 06:01:51 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qGzKX-0004N6-4V; Wed, 05 Jul 2023 06:01:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1688551288; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=LNaOMNNRMY2F5zccsJlDKxn195SI16MN7LLgnNX1HEEf/Frlgn4XSdP8XeUkG2LOaT
 sCEcegd1Oo7rL4DvwX0OtUly4u8HIbrL4pPu6t/3OKj6780Q7yBHAXLXNlPyp1fvA1u9
 TGLBIom6cSV7SJdR5hfCTkQFE49DIBamb5AdlZdLzy8hA27cxDfmOdee6IRNDnlwThab
 sTxMSxWUcDchV7a9boe9irXYSfiX0vN/KfTOl+bnikaeNETO+iPMmlp2gSkqzSRGmWRq
 R4ZTpjAFl5JKXpYPnb4b2grm88Annyo2q7riiRG6WQo6n2kVklzq8FogmuyEccmlb9hq
 cyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688551288;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=WDJQ1aunseNiwYyyTV3q0wnD2jHgoXyl1SYmG7xfIUw=;
 b=ZLQJUvguQsuSM0VrMoKX5+ANEMIGqSYrkqkQevSuGcaw+YXfBH4FoQ5PUnF0KCrC24
 e2SPtc9JQAMESZYX+d9wXrE5PPuPvrOP1Umb5+gxDqlsvNkNdDfd76gt4bkecWAfFGyn
 7tD/kKP9phkg1oOUH4TrO1Jny2+EFJ1ZXXN5zXuIfL5+y3H4zy12XCuZFQi2c/0vz5yw
 zRPbUWONCN0xj/9yuyA6zaLzZTTJ2IQ7RdYDALBixD75GPio1tBqv9COv2n+FuugfOLZ
 7ojCCmOwALbFezm2Mx+bjOWm9Ax4lhJ+MMy1BqbNQ64CEAo2CZA6j2LXpznDBwNE4tTG
 jvKQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688551288;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=WDJQ1aunseNiwYyyTV3q0wnD2jHgoXyl1SYmG7xfIUw=;
 b=CJAuy8E7/9URsqWo4p3sMLqhlPRiLz9Ndo/Nxpt0KDh3pDWBceUFomF498pFWYu0VD
 lfyRzHAaa8ypGf5/DrH5UEnOz/V8dKknzjtjRRfdFnL9KwUUXI3K5x6xeyjLtcAWiN/p
 8VMiJbMwND8RC5CspuvEwwP1f+gPrLwmzHP/RuLz6QhxMsvC10YWSfvB2jm4RuIrp0ap
 2upWAOvfKa9mQ/RP3hO0Wu5avNrYuZTcmNOO8I5CxtW+q02NX2DE/V+YZt7S0Hjuy866
 hBWEnQYW7nS5QYi7x9/+9whRPborOsqBQXHVbpK3t6+pyX7T9e0VbwUcE77nxvECUo9h
 qAjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688551288;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=WDJQ1aunseNiwYyyTV3q0wnD2jHgoXyl1SYmG7xfIUw=;
 b=W2ANCz62Qgg2SoOgp5bJ6CiiC1zkfpTGHqWgvGDv9c+9y6zO2RVv2YBuCHCY/gM1ga
 RXVgY55iz8Ap+yPvWqDg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4VReIOE3s+xIC8HZ8TOtjelmE6SkKgUS6xMby0Q=="
Received: from sender by smtp.strato.de (RZmta 49.6.0 AUTH)
 with ESMTPSA id y5401az65A1RGEZ
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 5 Jul 2023 12:01:27 +0200 (CEST)
Date: Wed, 5 Jul 2023 12:01:21 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Lev Kujawski
 <lkujaw@member.fsf.org>, qemu-block@nongnu.org, John Snow
 <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] hw/ide/piix: properly initialize the BMIBA register
Message-ID: <20230705120121.4f353ba6.olaf@aepfle.de>
In-Reply-To: <dded4d33-d64f-9369-0742-a57a1e173153@redhat.com>
References: <20230701174659.10246-1-olaf@aepfle.de>
 <62EDA748-11A3-473F-913D-F9464335A382@gmail.com>
 <20230703095929.6e793dcf.olaf@aepfle.de>
 <93902CB6-7A6E-49E5-A55F-432C6B4BC00F@gmail.com>
 <dded4d33-d64f-9369-0742-a57a1e173153@redhat.com>
X-Mailer: Claws Mail 20230601T090920.68bc28c0 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bUxWgjEYJo0GGljeHIos_Ho";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=85.215.255.51; envelope-from=olaf@aepfle.de;
 helo=mo4-p01-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--Sig_/bUxWgjEYJo0GGljeHIos_Ho
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Tue, 4 Jul 2023 08:38:33 +0200 Paolo Bonzini <pbonzini@redhat.com>:

> I agree that calling pci_device_reset() would be a better match for=20
> pci_xen_ide_unplug().

This change works as well:

--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -164,8 +164,9 @@ static void pci_unplug_nics(PCIBus *bus)
  *
  * [1] https://xenbits.xen.org/gitweb/?p=3Dxen.git;a=3Dblob;f=3Ddocs/misc/=
hvm-emulated-unplug.pandoc
  */
-static void pci_xen_ide_unplug(DeviceState *dev, bool aux)
+static void pci_xen_ide_unplug(PCIDevice *d, bool aux)
 {
+    DeviceState *dev =3D DEVICE(d);
     PCIIDEState *pci_ide;
     int i;
     IDEDevice *idedev;
@@ -195,7 +196,7 @@ static void pci_xen_ide_unplug(DeviceState *dev, bool a=
ux)
             blk_unref(blk);
         }
     }
-    device_cold_reset(dev);
+    pci_device_reset(d);
 }
=20
 static void unplug_disks(PCIBus *b, PCIDevice *d, void *opaque)
@@ -210,7 +211,7 @@ static void unplug_disks(PCIBus *b, PCIDevice *d, void =
*opaque)
=20
     switch (pci_get_word(d->config + PCI_CLASS_DEVICE)) {
     case PCI_CLASS_STORAGE_IDE:
-        pci_xen_ide_unplug(DEVICE(d), aux);
+        pci_xen_ide_unplug(d, aux);
         break;
=20
     case PCI_CLASS_STORAGE_SCSI:
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -118,7 +118,6 @@ static void piix_ide_reset(DeviceState *dev)
     pci_set_word(pci_conf + PCI_COMMAND, 0x0000);
     pci_set_word(pci_conf + PCI_STATUS,
                  PCI_STATUS_DEVSEL_MEDIUM | PCI_STATUS_FAST_BACK);
-    pci_set_byte(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */
 }
=20
 static bool pci_piix_init_bus(PCIIDEState *d, unsigned i, Error **errp)


Olaf

--Sig_/bUxWgjEYJo0GGljeHIos_Ho
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmSlP3EACgkQ86SN7mm1
DoBUlA/+LCOJOHRoIwZs/b2/zWoamfsx0FIE7dKQRNP4yJ12f//mywbLPcdWezm9
MkokLlczbMjWtH9jPZaW6Al+3xTcCFuNeSPw1dTQPmU+pSraj1Fn7RwaQUECCjC2
t/ZGhTOUCP/r8/cSSNxNMxfOLsPTeffCSFH/epc9GPKY7BLSwSvaCiWHqdYXX12l
nAS/WxeyPCl4sT0R6Rx05rHGE77aRLGdJRJFEZsHjZdiwTie57BbXyQvTv5fhxMo
8tngObqnNrQLkoHDqmdBX6pDQTpH1qgBKkToP5HQ1jj/Fym5Xt9GwcQixTBKSQSe
b1D4n4jUpgZrTvq2vuwmjbDeieyvOEpRWkEBe7iKhnYmpw3m8zlC5jElE6UwoGpE
/+m4sNgRkoFdhWWqtpeLoWpqzw25Kz7ovn9KZ5JY+gLbD3K0NEvP2TqH1w7JT9vm
vYI9gDdzkfcnyXN+wcqGZhZjA7OCT4RMl3TPgiPgtz72aqAsOsO5tATlldqAcEG7
dtaH/Tw9SrQEVHysZAm5h6nzJ4SY2E6LFRqEKYqNqs/TMFJRzVlt5TpMGhHa22fB
OCyzrtiHnC+GzgyFdFjAZZ4Yv0PzYUrzYHsJJqsXNNgaXIN3Pu1NzLVoLAHSlyz4
WJHQeTnG7FN0T3sf8Mi5PJjtPU1B/bX6HetDQ7uJT1yi+ByoJ1s=
=WBC8
-----END PGP SIGNATURE-----

--Sig_/bUxWgjEYJo0GGljeHIos_Ho--

