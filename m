Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E25A995B3B1
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Aug 2024 13:25:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh5v7-00088r-I1; Thu, 22 Aug 2024 07:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sh5v1-000811-ED
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 07:23:55 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sh5uz-00035I-L8
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 07:23:55 -0400
Received: from 172.17.5.170 by netsrv01.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Thu, 22 Aug 2024 11:18:47 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1724325527; bh=AWbZyhEyhRSnXlYcrTmec6OE0eilRfZnjfvknaWGikc=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 Z9dmkT9WkwrOCkEd48M54Ukez3tvQaKBftghlKrE4316v8W6h95JB/7u40f+2PhAr3KxuFgrEKh0WdxlLDpoBQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1724325527; bh=AWbZyhEyhRSnXlYcrTmec6OE0eilRfZnjfvknaWGikc=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 FHlzjauIl3Lc2nGih3lK2Ew1LhnAYXvoje45y2t0gWCF5sPwARqLOi8x58cNlFfLY98C7XvZk/raIU62oeWvYPYTMm6JRTCz/vmQ2meuqWbXcSUKQc3rueZP75JlFh6WyosIXdR04BSxM3mhCoBQqMIqQKfuQ84A8myEHdNjZHlBJv+vSBnqeqFskLaHSEmzUzds1Sfn6QIUpUeZL2Q0zOzy9J3aA34cz6RPoX0q3h4APMIlViIiud+wzg1IreOlmkUP9vZEvypfT7RyXS4CIAw40wmFBt8xnY5pEJb9m0WuPS01DKCCqsLi0c8SN5B8eBc/VUMmEjaspTDOR2+8Eg==
Received: from corvink-nb.c.koehne.headscale.beckhoff.dev (172.17.61.20) by
 ex04.beckhoff.com (172.17.5.170) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 Aug
 2024 13:18:45 +0200
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/7] vfio/igd: support legacy mode for all known generations
Date: Thu, 22 Aug 2024 13:08:27 +0200
Message-ID: <20240822111819.34306-3-c.koehne@beckhoff.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822111819.34306-1-c.koehne@beckhoff.com>
References: <20240822111819.34306-1-c.koehne@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.17.61.20]
X-ClientProxiedBy: ex01.beckhoff.com (172.17.2.168) To ex04.beckhoff.com
 (172.17.5.170)
X-OLX-Disclaimer: EX04.BECKHOFF.COM
Received-SPF: pass client-ip=62.159.14.10; envelope-from=C.Koehne@beckhoff.com;
 helo=netsrv01.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

=EF=BB=BFWe're soon going to add support for legacy mode to ElkhartLake and
TigerLake devices. Those are gen 11 and 12 devices. At the moment, all
devices identified by our igd_gen function do support legacy mode. This
won't change when adding our new devices of gen 11 and 12. Therefore, it
makes more sense to accept legacy mode for all known devices instead of
maintaining a long list of known good generations. If we add a new
generation to igd_gen which doesn't support legacy mode for some reason,
it'll be easy to advance the check to reject legacy mode for this
specific generation.

Signed-off-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
---
 hw/vfio/igd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 650a323dda..d5e57656a8 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -416,7 +416,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int=
 nr)
      * devices maintain compatibility with generation 8.
      */
     gen =3D igd_gen(vdev);
-    if (gen !=3D 6 && gen !=3D 8) {
+    if (gen =3D=3D -1) {
         error_report("IGD device %s is unsupported in legacy mode, "
                      "try SandyBridge or newer", vdev->vbasedev.name);
         return;
--=20
2.46.0

This email contains confidential information. If you have received it in er=
ror, you must not read, use, copy or pass on this e-mail or its attachments=
. If you have received the e-mail in error, please inform me immediately by=
 reply e-mail and then delete this e-mail from your system. Thank you
=20
Diese E-Mail enth=C3=A4lt vertrauliche Informationen. Sollten Sie sie irrt=
=C3=BCmlich erhalten haben, d=C3=BCrfen Sie diese E-Mail oder ihre Anh=C3=
=A4nge nicht lesen, verwenden, kopieren oder weitergeben. Sollten Sie die M=
ail versehentlich erhalten haben, teilen Sie mir dies bitte umgehend per An=
twort-E-Mail mit und l=C3=B6schen Sie diese E-Mail dann aus Ihrem System. V=
ielen Dank

Beckhoff Automation GmbH & Co. KG | Managing Director: Dipl. Phys. Hans Bec=
khoff
Registered office: Verl, Germany | Register court: Guetersloh HRA 7075




