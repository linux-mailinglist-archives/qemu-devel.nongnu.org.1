Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 236697D8F01
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 08:55:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwGkJ-0004Fq-HC; Fri, 27 Oct 2023 02:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=R2rW=GJ=redhat.com=clg@ozlabs.org>)
 id 1qwGkH-0004FV-BL
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 02:55:01 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=R2rW=GJ=redhat.com=clg@ozlabs.org>)
 id 1qwGkF-0000BD-7W
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 02:55:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SGthB4ktfz4xF9;
 Fri, 27 Oct 2023 17:54:50 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGth82YK9z4xF7;
 Fri, 27 Oct 2023 17:54:48 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] util/uuid: Define UUID_STR_LEN from UUID_NONE string
Date: Fri, 27 Oct 2023 08:54:43 +0200
Message-ID: <20231027065443.1305431-1-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=R2rW=GJ=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Cc: Fam Zheng <fam@euphon.net>
Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Follow up on :
 
 https://lore.kernel.org/qemu-devel/20231026070636.1165037-1-clg@redhat.com/

 include/qemu/uuid.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
index 356efe7b5797911640ed347fc08f4ef5ebbd0476..869f84af09ddc4aa80d53e133c323781ade4d190 100644
--- a/include/qemu/uuid.h
+++ b/include/qemu/uuid.h
@@ -78,9 +78,10 @@ typedef struct {
                  "%02hhx%02hhx-" \
                  "%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
 
-#define UUID_STR_LEN (36 + 1)
-
 #define UUID_NONE "00000000-0000-0000-0000-000000000000"
+QEMU_BUILD_BUG_ON(sizeof(UUID_NONE) - 1 != 36);
+
+#define UUID_STR_LEN sizeof(UUID_NONE)
 
 void qemu_uuid_generate(QemuUUID *out);
 
-- 
2.41.0


