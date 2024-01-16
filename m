Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4175982F1DD
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:51:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPlij-00039Y-Lu; Tue, 16 Jan 2024 10:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1rPliZ-00036L-E7
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:51:12 -0500
Received: from bg4.exmail.qq.com ([43.154.221.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1rPliS-0004Wl-Oi
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:51:09 -0500
X-QQ-mid: bizesmtp63t1705420251t7gens3y
X-QQ-Originating-IP: XTdb3Z9S5QHnE7d6IvJUpYh+ObF9+E9YzQkUZdqrZQ4=
Received: from ubuntu.. ( [111.196.133.100]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 16 Jan 2024 23:50:49 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: znfcQSa1hKYf2yOU6bl01h45+i/9VQsJWHprM6TpQLhjPIrsuY26iEjeCyRpd
 U0gqKyyWS3S5ur+JmawRlRBpnLYlbrLQmeMkKRB+OS995bNlKpcJFAhg62Y4T3FVSPdpMiC
 KgEwuBTSy8vAlCdwcWmcPwlIbKJuTH7h1HWHBZEiGL0N5exvNa7tap6Pr9ngWnTu80vyBZY
 gYPse7DSpsTB50ONzz8sMqo409k0Y1GxvqHmlnGxsxj3K+NSxEygBKHu56iVZ+D289utWsh
 SOKnwe7Q84Q6deqGKPDFFAUbw/mQ8WAwtvMSk8jvLDMYGbxSdEO9YAUg9ZBeOpK+nOBjAji
 X9q9BgjyZ13PQgSDd8=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9292020933538547469
From: Bin Meng <bmeng@tinylab.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] hw/elf_ops: Ignore loadable segments with zero size
Date: Tue, 16 Jan 2024 23:50:49 +0800
Message-Id: <20240116155049.390301-1-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
Received-SPF: pass client-ip=43.154.221.58; envelope-from=bmeng@tinylab.org;
 helo=bg4.exmail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Some ELF files really do have segments of zero size, e.g.:

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  RISCV_ATTRIBUT 0x00000000000025b8 0x0000000000000000 0x0000000000000000
                 0x000000000000003e 0x0000000000000000  R      0x1
  LOAD           0x0000000000001000 0x0000000080200000 0x0000000080200000
                 0x00000000000001d1 0x00000000000001d1  R E    0x1000
  LOAD           0x00000000000011d1 0x00000000802001d1 0x00000000802001d1
                 0x0000000000000e37 0x0000000000000e37  RW     0x1000
  LOAD           0x0000000000000120 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000         0x1000

The current logic does not check for this condition, resulting in
the incorrect assignment of 'lowaddr' as zero.

There is already a piece of codes inside the segment traversal loop
that checks for zero-sized loadable segments for not creating empty
ROM blobs. Let's move this check to the beginning of the loop to
cover both scenarios.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 include/hw/elf_ops.h | 75 +++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 0a5c258fe6..f014399b50 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -427,6 +427,16 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
             file_size = ph->p_filesz; /* Size of the allocated data */
             data_offset = ph->p_offset; /* Offset where the data is located */
 
+            /*
+             * Some ELF files really do have segments of zero size;
+             * just ignore them rather than trying to set the wrong addr,
+             * or create empty ROM blobs, because the zero-length blob can
+             * falsely trigger the overlapping-ROM-blobs check.
+             */
+            if (mem_size == 0) {
+                continue;
+            }
+
             if (file_size > 0) {
                 if (g_mapped_file_get_length(mapped_file) <
                     file_size + data_offset) {
@@ -530,45 +540,38 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
                 *pentry = ehdr.e_entry - ph->p_vaddr + ph->p_paddr;
             }
 
-            /* Some ELF files really do have segments of zero size;
-             * just ignore them rather than trying to create empty
-             * ROM blobs, because the zero-length blob can falsely
-             * trigger the overlapping-ROM-blobs check.
-             */
-            if (mem_size != 0) {
-                if (load_rom) {
-                    g_autofree char *label =
-                        g_strdup_printf("%s ELF program header segment %d",
-                                        name, i);
-
-                    /*
-                     * rom_add_elf_program() takes its own reference to
-                     * 'mapped_file'.
-                     */
-                    rom_add_elf_program(label, mapped_file, data, file_size,
-                                        mem_size, addr, as);
-                } else {
-                    MemTxResult res;
-
-                    res = address_space_write(as ? as : &address_space_memory,
-                                              addr, MEMTXATTRS_UNSPECIFIED,
-                                              data, file_size);
+            if (load_rom) {
+                g_autofree char *label =
+                    g_strdup_printf("%s ELF program header segment %d",
+                                    name, i);
+
+                /*
+                 * rom_add_elf_program() takes its own reference to
+                 * 'mapped_file'.
+                 */
+                rom_add_elf_program(label, mapped_file, data, file_size,
+                                    mem_size, addr, as);
+            } else {
+                MemTxResult res;
+
+                res = address_space_write(as ? as : &address_space_memory,
+                                          addr, MEMTXATTRS_UNSPECIFIED,
+                                          data, file_size);
+                if (res != MEMTX_OK) {
+                    goto fail;
+                }
+                /*
+                 * We need to zero'ify the space that is not copied
+                 * from file
+                 */
+                if (file_size < mem_size) {
+                    res = address_space_set(as ? as : &address_space_memory,
+                                            addr + file_size, 0,
+                                            mem_size - file_size,
+                                            MEMTXATTRS_UNSPECIFIED);
                     if (res != MEMTX_OK) {
                         goto fail;
                     }
-                    /*
-                     * We need to zero'ify the space that is not copied
-                     * from file
-                     */
-                    if (file_size < mem_size) {
-                        res = address_space_set(as ? as : &address_space_memory,
-                                                addr + file_size, 0,
-                                                mem_size - file_size,
-                                                MEMTXATTRS_UNSPECIFIED);
-                        if (res != MEMTX_OK) {
-                            goto fail;
-                        }
-                    }
                 }
             }
 
-- 
2.34.1


