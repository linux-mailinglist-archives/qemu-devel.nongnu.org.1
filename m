Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC8B7A0000
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 11:29:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgido-0006NQ-LT; Thu, 14 Sep 2023 05:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1qgidj-0006Mk-Sm
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 05:28:00 -0400
Received: from mail.astralinux.ru ([217.74.38.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1qgidh-0005jc-JL
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 05:27:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id C63D9186525E;
 Thu, 14 Sep 2023 12:27:43 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id OLVEz2MyDiA9; Thu, 14 Sep 2023 12:27:43 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id 7AC311863FAB;
 Thu, 14 Sep 2023 12:27:43 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 1ZC2QQN9-cbO; Thu, 14 Sep 2023 12:27:43 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.41])
 by mail.astralinux.ru (Postfix) with ESMTPSA id 0A912186524B;
 Thu, 14 Sep 2023 12:27:42 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Anastasia Belova <abelova@astralinux.ru>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: [PATCH] hw/qxl: move check of slot_id before accessing guest_slots
Date: Thu, 14 Sep 2023 12:27:17 +0300
Message-Id: <20230914092717.7158-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=217.74.38.119; envelope-from=abelova@astralinux.ru;
 helo=mail.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

If slot_id >=3D NUM_MEMSLOTS, buffer overflow is possible.
So the check should be upper than d->guest_slots[slot_id]
where size of d->guest_slots is NUM_MEMSLOTS.

Fixes: e954ea2873 ("qxl: qxl_add_memslot: remove guest trigerrable panics=
")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 hw/display/qxl.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 7bb00d68f5..dc618727c0 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1309,16 +1309,17 @@ static int qxl_add_memslot(PCIQXLDevice *d, uint3=
2_t slot_id, uint64_t delta,
     QXLDevMemSlot memslot;
     int i;
=20
-    guest_start =3D le64_to_cpu(d->guest_slots[slot_id].slot.mem_start);
-    guest_end   =3D le64_to_cpu(d->guest_slots[slot_id].slot.mem_end);
-
-    trace_qxl_memslot_add_guest(d->id, slot_id, guest_start, guest_end);
-
     if (slot_id >=3D NUM_MEMSLOTS) {
         qxl_set_guest_bug(d, "%s: slot_id >=3D NUM_MEMSLOTS %d >=3D %d",=
 __func__,
                       slot_id, NUM_MEMSLOTS);
         return 1;
     }
+
+    guest_start =3D le64_to_cpu(d->guest_slots[slot_id].slot.mem_start);
+    guest_end   =3D le64_to_cpu(d->guest_slots[slot_id].slot.mem_end);
+
+    trace_qxl_memslot_add_guest(d->id, slot_id, guest_start, guest_end);
+
     if (guest_start > guest_end) {
         qxl_set_guest_bug(d, "%s: guest_start > guest_end 0x%" PRIx64
                          " > 0x%" PRIx64, __func__, guest_start, guest_e=
nd);
--=20
2.30.2


