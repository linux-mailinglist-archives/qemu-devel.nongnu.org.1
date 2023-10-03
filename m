Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE017B6AFA
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:02:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnfxz-0004Rh-LT; Tue, 03 Oct 2023 10:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qnfAu-0005ZC-RS
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:10:56 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qnfAs-0000CL-FI
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:10:56 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 789C411F0AA
 for <qemu-devel@nongnu.org>; Tue,  3 Oct 2023 13:10:52 +0000 (UTC)
From: ~h0lyalg0rithm <h0lyalg0rithm@git.sr.ht>
Date: Tue, 03 Oct 2023 14:45:14 +0200
Subject: [PATCH qemu 1/1] Switch memory management calls to new coding
 conventions
Message-ID: <169633865224.24639.8449528816550514313-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <169633865224.24639.8449528816550514313-0@git.sr.ht>
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_REPLYTO=2.095,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Oct 2023 10:01:37 -0400
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
Reply-To: ~h0lyalg0rithm <surajshirvankar@gmail.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Suraj Shirvankar <surajshirvankar@gmail.com>

Signed-off-by: Suraj Shirvankar <surajshirvankar@gmail.com>
---
 contrib/elf2dmp/addrspace.c | 4 ++--
 contrib/elf2dmp/main.c      | 4 ++--
 contrib/elf2dmp/pdb.c       | 4 ++--
 contrib/elf2dmp/qemu_elf.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index 64b5d680ad..3bfbb5093c 100644
--- a/contrib/elf2dmp/addrspace.c
+++ b/contrib/elf2dmp/addrspace.c
@@ -72,7 +72,7 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
         }
     }
=20
-    ps->block =3D malloc(sizeof(*ps->block) * ps->block_nr);
+    ps->block =3D g_new(struct pa_block, ps->block_nr);
     if (!ps->block) {
         return 1;
     }
@@ -97,7 +97,7 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
 void pa_space_destroy(struct pa_space *ps)
 {
     ps->block_nr =3D 0;
-    free(ps->block);
+    g_free(ps->block);
 }
=20
 void va_space_set_dtb(struct va_space *vs, uint64_t dtb)
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 5db163bdbe..97baf0c0c1 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -120,14 +120,14 @@ static KDDEBUGGER_DATA64 *get_kdbg(uint64_t KernBase, s=
truct pdb_reader *pdb,
         }
     }
=20
-    kdbg =3D malloc(kdbg_hdr.Size);
+    kdbg =3D g_malloc(kdbg_hdr.Size);
     if (!kdbg) {
         return NULL;
     }
=20
     if (va_space_rw(vs, KdDebuggerDataBlock, kdbg, kdbg_hdr.Size, 0)) {
         eprintf("Failed to extract entire KDBG\n");
-        free(kdbg);
+        g_free(kdbg);
         return NULL;
     }
=20
diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index 6ca5086f02..625001d1cf 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -116,7 +116,7 @@ static void *pdb_ds_read(const PDB_DS_HEADER *header,
=20
     nBlocks =3D (size + header->block_size - 1) / header->block_size;
=20
-    buffer =3D malloc(nBlocks * header->block_size);
+    buffer =3D g_malloc(nBlocks * header->block_size);
     if (!buffer) {
         return NULL;
     }
@@ -201,7 +201,7 @@ static int pdb_init_symbols(struct pdb_reader *r)
     return 0;
=20
 out_symbols:
-    free(symbols);
+    g_free(symbols);
=20
     return err;
 }
diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index de6ad744c6..9aa8715108 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -94,7 +94,7 @@ static int init_states(QEMU_Elf *qe)
=20
     printf("%zu CPU states has been found\n", cpu_nr);
=20
-    qe->state =3D malloc(sizeof(*qe->state) * cpu_nr);
+    qe->state =3D g_new(QEMUCPUState*, cpu_nr);
     if (!qe->state) {
         return 1;
     }
@@ -115,7 +115,7 @@ static int init_states(QEMU_Elf *qe)
=20
 static void exit_states(QEMU_Elf *qe)
 {
-    free(qe->state);
+    g_free(qe->state);
 }
=20
 static bool check_ehdr(QEMU_Elf *qe)
--=20
2.38.5

