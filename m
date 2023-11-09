Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C18F47E6B7B
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:49:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Ki-0000dZ-Bs; Thu, 09 Nov 2023 08:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15KX-0008Hy-CM; Thu, 09 Nov 2023 08:44:21 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15KV-0001Ar-Ba; Thu, 09 Nov 2023 08:44:21 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A3F2B31B02;
 Thu,  9 Nov 2023 16:43:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B28CC344A9;
 Thu,  9 Nov 2023 16:43:03 +0300 (MSK)
Received: (nullmailer pid 1461794 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 11/55] linux-user: Fixes for zero_bss
Date: Thu,  9 Nov 2023 16:42:15 +0300
Message-Id: <20231109134300.1461632-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

The previous change, 2d385be6152, assumed !PAGE_VALID meant that
the page would be unmapped by the elf image.  However, since we
reserved the entire image space via mmap, PAGE_VALID will always
be set.  Instead, assume PROT_NONE for the same condition.

Furthermore, assume bss is only ever present for writable segments,
and that there is no page overlap between PT_LOAD segments.
Instead of an assert, return false to indicate failure.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1854
Fixes: 2d385be6152 ("linux-user: Do not adjust zero_bss for host page size")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit e6e66b03287331abc6f184456dbc6d25505590ec)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a69e7d7eab..47170fe5d3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2217,31 +2217,58 @@ static abi_ulong setup_arg_pages(struct linux_binprm *bprm,
  * Map and zero the bss.  We need to explicitly zero any fractional pages
  * after the data section (i.e. bss).  Return false on mapping failure.
  */
-static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss, int prot)
+static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss,
+                     int prot, Error **errp)
 {
     abi_ulong align_bss;
 
+    /* We only expect writable bss; the code segment shouldn't need this. */
+    if (!(prot & PROT_WRITE)) {
+        error_setg(errp, "PT_LOAD with non-writable bss");
+        return false;
+    }
+
     align_bss = TARGET_PAGE_ALIGN(start_bss);
     end_bss = TARGET_PAGE_ALIGN(end_bss);
 
     if (start_bss < align_bss) {
         int flags = page_get_flags(start_bss);
 
-        if (!(flags & PAGE_VALID)) {
-            /* Map the start of the bss. */
+        if (!(flags & PAGE_BITS)) {
+            /*
+             * The whole address space of the executable was reserved
+             * at the start, therefore all pages will be VALID.
+             * But assuming there are no PROT_NONE PT_LOAD segments,
+             * a PROT_NONE page means no data all bss, and we can
+             * simply extend the new anon mapping back to the start
+             * of the page of bss.
+             */
             align_bss -= TARGET_PAGE_SIZE;
-        } else if (flags & PAGE_WRITE) {
-            /* The page is already mapped writable. */
-            memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
         } else {
-            /* Read-only zeros? */
-            g_assert_not_reached();
+            /*
+             * The start of the bss shares a page with something.
+             * The only thing that we expect is the data section,
+             * which would already be marked writable.
+             * Overlapping the RX code segment seems malformed.
+             */
+            if (!(flags & PAGE_WRITE)) {
+                error_setg(errp, "PT_LOAD with bss overlapping "
+                           "non-writable page");
+                return false;
+            }
+
+            /* The page is already mapped and writable. */
+            memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
         }
     }
 
-    return align_bss >= end_bss ||
-           target_mmap(align_bss, end_bss - align_bss, prot,
-                       MAP_FIXED | MAP_PRIVATE | MAP_ANON, -1, 0) != -1;
+    if (align_bss < end_bss &&
+        target_mmap(align_bss, end_bss - align_bss, prot,
+                    MAP_FIXED | MAP_PRIVATE | MAP_ANON, -1, 0) == -1) {
+        error_setg_errno(errp, errno, "Error mapping bss");
+        return false;
+    }
+    return true;
 }
 
 #if defined(TARGET_ARM)
@@ -3265,8 +3292,8 @@ static void load_elf_image(const char *image_name, int image_fd,
 
             /* If the load segment requests extra zeros (e.g. bss), map it. */
             if (vaddr_ef < vaddr_em &&
-                !zero_bss(vaddr_ef, vaddr_em, elf_prot)) {
-                goto exit_mmap;
+                !zero_bss(vaddr_ef, vaddr_em, elf_prot, &err)) {
+                goto exit_errmsg;
             }
 
             /* Find the full program boundaries.  */
-- 
2.39.2


