Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 798CC8162BA
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 23:05:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEzFS-0006VI-A5; Sun, 17 Dec 2023 17:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1rEzFN-0006Ti-6Y; Sun, 17 Dec 2023 17:04:29 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1rEzFJ-00033n-LS; Sun, 17 Dec 2023 17:04:28 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 783AF11EF81;
 Sun, 17 Dec 2023 22:04:23 +0000 (UTC)
From: ~jmbert <jmbert@git.sr.ht>
Date: Sun, 17 Dec 2023 14:57:55 +0000
Subject: [PATCH qemu v2] target/i386: Fix "info mem" when LA57 is enabled
MIME-Version: 1.0
Message-ID: <170285066337.23861.17596309977698945459-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 FREEMAIL_FORGED_REPLYTO=2.095, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: ~jmbert <joe2157b@gmail.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Joe Berthels <joe2157b@gmail.com>

"info mem" now correctly displays virtual address map instead of hanging
and displaying nothing.

Signed-off-by: Joe Berthels (joe2157b@gmail.com)
---
'l0' should have been shifted 48 bits to form 'end', instead of 47 bits

 target/i386/monitor.c | 136 +++++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 67 deletions(-)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 950ff9ccbc..d632a93971 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -467,82 +467,84 @@ static void mem_info_la57(Monitor *mon, CPUArchState *e=
nv)
         cpu_physical_memory_read(pml5_addr + l0 * 8, &pml5e, 8);
         pml5e =3D le64_to_cpu(pml5e);
         end =3D l0 << 48;
-        if (!(pml5e & PG_PRESENT_MASK)) {
-            prot =3D 0;
-            mem_print(mon, env, &start, &last_prot, end, prot);
-            continue;
-        }
-
-        pml4_addr =3D pml5e & 0x3fffffffff000ULL;
-        for (l1 =3D 0; l1 < 512; l1++) {
-            cpu_physical_memory_read(pml4_addr + l1 * 8, &pml4e, 8);
-            pml4e =3D le64_to_cpu(pml4e);
-            end =3D (l0 << 48) + (l1 << 39);
-            if (!(pml4e & PG_PRESENT_MASK)) {
-                prot =3D 0;
-                mem_print(mon, env, &start, &last_prot, end, prot);
-                continue;
-            }
-
-            pdp_addr =3D pml4e & 0x3fffffffff000ULL;
-            for (l2 =3D 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8);
-                pdpe =3D le64_to_cpu(pdpe);
-                end =3D (l0 << 48) + (l1 << 39) + (l2 << 30);
-                if (pdpe & PG_PRESENT_MASK) {
-                    prot =3D 0;
-                    mem_print(mon, env, &start, &last_prot, end, prot);
-                    continue;
-                }
-
-                if (pdpe & PG_PSE_MASK) {
-                    prot =3D pdpe & (PG_USER_MASK | PG_RW_MASK |
-                            PG_PRESENT_MASK);
-                    prot &=3D pml5e & pml4e;
-                    mem_print(mon, env, &start, &last_prot, end, prot);
-                    continue;
-                }
-
-                pd_addr =3D pdpe & 0x3fffffffff000ULL;
-                for (l3 =3D 0; l3 < 512; l3++) {
-                    cpu_physical_memory_read(pd_addr + l3 * 8, &pde, 8);
-                    pde =3D le64_to_cpu(pde);
-                    end =3D (l0 << 48) + (l1 << 39) + (l2 << 30) + (l3 << 21=
);
-                    if (pde & PG_PRESENT_MASK) {
-                        prot =3D 0;
-                        mem_print(mon, env, &start, &last_prot, end, prot);
-                        continue;
-                    }
-
-                    if (pde & PG_PSE_MASK) {
-                        prot =3D pde & (PG_USER_MASK | PG_RW_MASK |
-                                PG_PRESENT_MASK);
-                        prot &=3D pml5e & pml4e & pdpe;
-                        mem_print(mon, env, &start, &last_prot, end, prot);
-                        continue;
-                    }
-
-                    pt_addr =3D pde & 0x3fffffffff000ULL;
-                    for (l4 =3D 0; l4 < 512; l4++) {
-                        cpu_physical_memory_read(pt_addr + l4 * 8, &pte, 8);
-                        pte =3D le64_to_cpu(pte);
-                        end =3D (l0 << 48) + (l1 << 39) + (l2 << 30) +
-                            (l3 << 21) + (l4 << 12);
-                        if (pte & PG_PRESENT_MASK) {
-                            prot =3D pte & (PG_USER_MASK | PG_RW_MASK |
-                                    PG_PRESENT_MASK);
-                            prot &=3D pml5e & pml4e & pdpe & pde;
+        if (pml5e & PG_PRESENT_MASK) {
+            pml4_addr =3D pml5e & 0x3fffffffff000ULL;
+            for (l1 =3D 0; l1 < 512; l1++) {
+                cpu_physical_memory_read(pml4_addr + l1 * 8, &pml4e, 8);
+                pml4e =3D le64_to_cpu(pml4e);
+                end =3D (l0 << 48) + (l1 << 39);
+                if (pml4e & PG_PRESENT_MASK) {
+                    pdp_addr =3D pml4e & 0x3fffffffff000ULL;
+                    for (l2 =3D 0; l2 < 512; l2++) {
+                        cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8=
);
+                        pdpe =3D le64_to_cpu(pdpe);
+                        end =3D (l0 << 48) + (l1 << 39) + (l2 << 30);
+                        if (pdpe & PG_PRESENT_MASK) {
+                            if (pdpe & PG_PSE_MASK) {
+                                prot =3D pdpe & (PG_USER_MASK | PG_RW_MASK |
+                                               PG_PRESENT_MASK);
+                                prot &=3D pml5e & pml4e;
+                                mem_print(mon, env, &start, &last_prot, end,=
 prot);
+                            } else {
+                                pd_addr =3D pdpe & 0x3fffffffff000ULL;
+                                for (l3 =3D 0; l3 < 512; l3++) {
+                                    cpu_physical_memory_read(pd_addr + l3 * =
8, &pde, 8);
+                                    pde =3D le64_to_cpu(pde);
+                                    end =3D (l0 << 48) + (l1 << 39) +
+                                            (l2 << 30) + (l3 << 21);
+                                    if (pde & PG_PRESENT_MASK) {
+                                        if (pde & PG_PSE_MASK) {
+                                            prot =3D pde & (PG_USER_MASK | P=
G_RW_MASK |
+                                                          PG_PRESENT_MASK);
+                                            prot &=3D pml5e & pml4e & pdpe;
+                                            mem_print(mon, env, &start,
+                                                      &last_prot, end, prot);
+                                        } else {
+                                            pt_addr =3D pde & 0x3fffffffff00=
0ULL;
+                                            for (l4 =3D 0; l4 < 512; l4++) {
+                                                cpu_physical_memory_read(pt_=
addr
+                                                                         + l=
4 * 8,
+                                                                         &pt=
e, 8);
+                                                pte =3D le64_to_cpu(pte);
+                                                end =3D (l0 << 48) + (l1 << =
39) +
+                                                    (l2 << 30) +
+                                                    (l3 << 21) + (l4 << 12);
+                                                if (pte & PG_PRESENT_MASK) {
+                                                    prot =3D pte & (PG_USER_=
MASK |
+                                                                  PG_RW_MASK=
 |
+                                                                  PG_PRESENT=
_MASK);
+                                                    prot &=3D pml5e & pml4e =
& pdpe & pde;
+                                                } else {
+                                                    prot =3D 0;
+                                                }
+                                                mem_print(mon, env, &start,
+                                                          &last_prot, end, p=
rot);
+                                            }
+                                        }
+                                    } else {
+                                        prot =3D 0;
+                                        mem_print(mon, env, &start,
+                                                  &last_prot, end, prot);
+                                    }
+                                }
+                            }
                         } else {
                             prot =3D 0;
+                            mem_print(mon, env, &start, &last_prot, end, pro=
t);
                         }
-                        mem_print(mon, env, &start, &last_prot, end, prot);
                     }
+                } else {
+                    prot =3D 0;
+                    mem_print(mon, env, &start, &last_prot, end, prot);
                 }
             }
+        }  else {
+            prot =3D 0;
+            mem_print(mon, env, &start, &last_prot, end, prot);
         }
     }
     /* Flush last range */
-    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 57, 0);
+    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 58, 0);
 }
 #endif /* TARGET_X86_64 */
=20
--=20
2.38.5

