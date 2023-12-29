Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E6C82003B
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 16:28:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJElk-0002ZY-AW; Fri, 29 Dec 2023 10:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adiupina@astralinux.ru>)
 id 1rJElg-0002ZJ-W6
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 10:27:25 -0500
Received: from mail.astralinux.ru ([217.74.38.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adiupina@astralinux.ru>)
 id 1rJElf-0001tD-6L
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 10:27:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id E4EA71869409;
 Fri, 29 Dec 2023 18:27:08 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id Cwxdms1_RbCD; Fri, 29 Dec 2023 18:27:08 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id 9967A186942A;
 Fri, 29 Dec 2023 18:27:08 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 10HuT6Jy75DA; Fri, 29 Dec 2023 18:27:08 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.233.160])
 by mail.astralinux.ru (Postfix) with ESMTPSA id EFD6D1869409;
 Fri, 29 Dec 2023 18:27:07 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexandra Diupina <adiupina@astralinux.ru>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Subject: [PATCH v2] esp: process the result of scsi_device_find()
Date: Fri, 29 Dec 2023 18:26:47 +0300
Message-Id: <20231229152647.19699-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <a5dd59b0-1b49-4a96-8c82-8383412afdc3@ilande.co.uk>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=217.74.38.119;
 envelope-from=adiupina@astralinux.ru; helo=mail.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add a 'current_lun' check for a null value
to avoid null pointer dereferencing and
recover host if NULL return

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 4eb8606560 (esp: store lun coming from the MESSAGE OUT phase)
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
v2: duplicate the scsi_device_find() logic from esp_select()
 hw/scsi/esp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9b11d8c573..03fdd53de6 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -292,6 +292,16 @@ static void do_command_phase(ESPState *s)
     esp_fifo_pop_buf(&s->cmdfifo, buf, cmdlen);
=20
     current_lun =3D scsi_device_find(&s->bus, 0, s->current_dev->id, s->=
lun);
+
+    if (!current_lun) {
+        /* No such drive */
+        s->rregs[ESP_RSTAT] =3D 0;
+        s->rregs[ESP_RINTR] =3D INTR_DC;
+        s->rregs[ESP_RSEQ] =3D SEQ_0;
+        esp_raise_irq(s);
+        return;
+    }
+
     s->current_req =3D scsi_req_new(current_lun, 0, s->lun, buf, cmdlen,=
 s);
     datalen =3D scsi_req_enqueue(s->current_req);
     s->ti_size =3D datalen;
--=20
2.30.2


