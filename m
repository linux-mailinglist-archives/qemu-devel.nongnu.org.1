Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EC97C9BAE
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 23:00:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs8D0-00050M-Vo; Sun, 15 Oct 2023 16:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qs8Cz-0004zn-83
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 16:59:33 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qs8Cs-0007Rb-Jd
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 16:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=80Z0Y31UPbDwIDkcYfm1X3NtyYZY95KwKeU6wGFptW0=; b=FJSTRossS7jgIdwr5q6iJfqvyV
 wk/UDm3MKHuuC07yFLss8EwICtI3mijT5Niixohy951GOD/gTd+WWOJNz/tZFJnU3TALsAIt1ZFWC
 ry7eT822+AVk5q6TWd/f+EkruDiyonDeTYwvC4bTcTEhTjRQOybtxK+tnze0OEYBV5QQ=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 2/6] target/tricore: Add read and write semihosting calls
Date: Sun, 15 Oct 2023 22:59:09 +0200
Message-ID: <20231015205913.264782-3-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015205913.264782-1-kbastian@mail.uni-paderborn.de>
References: <20231015205913.264782-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.10.15.205116, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.10.8.602001
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::16;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=doohan.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/tricore-semi.c | 52 +++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/target/tricore/tricore-semi.c b/target/tricore/tricore-semi.c
index 27e1bdc59d..ccbeae4bc0 100644
--- a/target/tricore/tricore-semi.c
+++ b/target/tricore/tricore-semi.c
@@ -164,6 +164,52 @@ static void tricore_vio_set_result(CPUTriCoreState *env, int retval,
     env->gpr_d[12] = tricore_vio_errno_h2g(host_errno);
 }
 
+static void tricore_vio_readwrite(CPUTriCoreState *env, bool is_write)
+{
+    CPUState *cs = env_cpu(env);
+    hwaddr paddr, sz;
+    uint32_t page_left, io_sz, vaddr;
+    size_t count;
+    ssize_t ret = 0;
+
+    int fd = env->gpr_d[4];
+    vaddr  = env->gpr_a[4];
+    count = env->gpr_d[5];
+
+    while (count > 0) {
+        paddr = cpu_get_phys_page_debug(cs, vaddr);
+        page_left = TARGET_PAGE_SIZE - (vaddr & (TARGET_PAGE_SIZE - 1));
+        io_sz = page_left < count ? page_left : count;
+        sz = io_sz;
+        void *buf = cpu_physical_memory_map(paddr, &sz, true);
+
+        if (buf) {
+            vaddr += io_sz;
+            count -= io_sz;
+            ret = is_write ?
+                write(fd, buf, io_sz) :
+                read(fd, buf, io_sz);
+            if (ret == -1) {
+                ret = 0;
+                tricore_vio_set_result(env, ret, EINVAL);
+            } else {
+                tricore_vio_set_result(env, ret, errno);
+            }
+        }
+        cpu_physical_memory_unmap(buf, sz, !is_write, ret);
+    }
+}
+
+static void tricore_vio_read(CPUTriCoreState *env)
+{
+    tricore_vio_readwrite(env, false);
+}
+
+static void tricore_vio_write(CPUTriCoreState *env)
+{
+    tricore_vio_readwrite(env, true);
+}
+
 
 #define TRICORE_VIO_MARKER 0x6f69765f /* "_vio" */
 #define TRICORE_VIO_EXIT_MARKER 0xE60
@@ -188,6 +234,12 @@ void helper_tricore_semihost(CPUTriCoreState *env, uint32_t pc)
 
     syscall = (int)env->gpr_d[12];
     switch (syscall) {
+    case SYS__READ:
+        tricore_vio_read(env);
+        break;
+    case SYS__WRITE:
+        tricore_vio_write(env);
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s(%d): not implemented\n", __func__,
                       syscall);
-- 
2.42.0


