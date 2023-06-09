Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AAF7294ED
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 11:25:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7YLJ-0000p0-W1; Fri, 09 Jun 2023 05:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1q7YLI-0000oq-2l
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 05:23:36 -0400
Received: from mail.astralinux.ru ([217.74.38.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1q7YLF-0004fP-1Z
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 05:23:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id 0A4191869DDA;
 Fri,  9 Jun 2023 12:23:17 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id VpBygL7NlPIq; Fri,  9 Jun 2023 12:23:16 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id B4F641869DD3;
 Fri,  9 Jun 2023 12:23:16 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id g6XoB4dTIrOT; Fri,  9 Jun 2023 12:23:16 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.23])
 by mail.astralinux.ru (Postfix) with ESMTPSA id 4D5A61869DCE;
 Fri,  9 Jun 2023 12:23:16 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: qemu-devel@nongnu.org
Cc: Anastasia Belova <abelova@astralinux.ru>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] vnc: move assert in vnc_worker_thread_loop
Date: Fri,  9 Jun 2023 12:23:06 +0300
Message-Id: <20230609092306.19836-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=217.74.38.119; envelope-from=abelova@astralinux.ru;
 helo=mail.astralinux.ru
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

job may be NULL if queue->exit is true. Check
it before dereference job.

Fixes: f31f9c1080 ("vnc: add magic cookie to VncState")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 ui/vnc-jobs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 886f9bf611..fcca7ec632 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -250,12 +250,13 @@ static int vnc_worker_thread_loop(VncJobQueue *queu=
e)
     /* Here job can only be NULL if queue->exit is true */
     job =3D QTAILQ_FIRST(&queue->jobs);
     vnc_unlock_queue(queue);
-    assert(job->vs->magic =3D=3D VNC_MAGIC);
=20
     if (queue->exit) {
         return -1;
     }
=20
+    assert(job->vs->magic =3D=3D VNC_MAGIC);
+
     vnc_lock_output(job->vs);
     if (job->vs->ioc =3D=3D NULL || job->vs->abort =3D=3D true) {
         vnc_unlock_output(job->vs);
--=20
2.30.2


