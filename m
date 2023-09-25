Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA4E7ADB09
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:11:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknEV-0008Je-OC; Mon, 25 Sep 2023 11:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qknEM-0008Dq-9G
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:10:39 -0400
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qknEK-0005LB-Cw
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:10:38 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MgNMV-1rJ3aR0KHn-00htAs; Mon, 25
 Sep 2023 17:10:32 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 3/5] linux-user/syscall.c: clean up local variable shadowing
 in do_ioctl_dm()
Date: Mon, 25 Sep 2023 17:10:27 +0200
Message-ID: <20230925151029.461358-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925151029.461358-1-laurent@vivier.eu>
References: <20230925151029.461358-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xjUKcxF5dVPOhm09IN9+CEoO6jTC//sS6ONqZJTuCQ5ZS41iXjR
 yNoIZUvHEd8oaf61MB7CF5aOh7WgZ445KBUXzSt6m+hVPCXbaB99u+Ds3CIHetX9vH/g+Hp
 WK5qlCU6wkZnMUuo9UmHe+WOTxdrBcM7IeGK9WYUEOMisKFqMrpPdkENkE1Upk+ApUMUqQA
 esb4iKcjMf/Dd596e2yAw==
UI-OutboundReport: notjunk:1;M01:P0:7QU5inpb/5w=;MReOPhqRPJu6xEPguvwSMlzxASd
 fOg6h8NQhwRu1nL2RVT3yl1GyZnUkiqXyj0c1yLniOWvKdcriCT7PNZI5XVO0jWFzVgrFH8pH
 76H84jSbAo5LDe0a8XEvKp096ZteCE1QZG/FT2RDlMsYOznD/Y9EM4jvuI4dCL1tGhRK5LKIL
 b2cILuOtY7i9jgI3p8iOVGs/wbxbhsZ5OnjXk2GxYinJwyNeb5St6vU1ZmMKgISWhkOHAWc0O
 EXq6Rx7zy8LKxitwm+64PSXEsejB0QNGDD7gGZyjtmjCGDrJorY92S4lQfNj91ch029DAZJPH
 Y/tSl6CnRF+i0A09wL69DtnKF2tYj9V7mnWFGR2QouSGqHiTN7tpibdWs5lkSqbSc7ldlEKjv
 aS6q7VYs7PM8Q7VsqufoINCPtc+RKsXUjcRdC/vs8tit1clDJCnXEosNFssD4O7TPcybPH6KT
 zQoN3MxVEl87nzWcBbwLIOaG8dtIbYxyq27+dY9hddW9xutLEDdl4bdhi4EIBOS4IRLd8XWuI
 gQBfzWdlobNC9Qz6nQNMOcblt+8jofkyenGZId54LWH+zeGK4cDhmBmDlkh6CJiphXwcvFYab
 Zs3yzYS2i8NHe4qkUBjz+XsvNQUIXIwDWCViwpFg1beV+UtKO1AZ0F0iX2DEZ/S3xq/FlYOzn
 78W1Wjig0tI4+Gnmw8Q6pn9Qx6Vs2bsYongbcn1q0KOViOgSzBTSEbveMIOVpDcBmJ0agCUTt
 XOiHA0zM71JQM0J8URjHz5yIF4MV+xPhN2XYddpEFOS00Fx9oTx3Lr5092aUdoFGg/zHOCYcw
 uzhqubkLPFZC17R4Ftql9cSn/TU4xgIrnZQOCvunWyumL/i3Nyt8is6SHr/8IvdWlvWXBisg0
 Kx7Mpkh8rtgrkqA==
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Fix following warnings:

.../linux-user/syscall.c: In function 'do_ioctl_dm':
.../linux-user/syscall.c:5053:23: warning: declaration of 'arg_type' shadows a previous local [-Wshadow=local]
 5053 |         const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_target_spec) };
      |                       ^~~~~~~~
.../linux-user/syscall.c:4991:20: note: shadowed declaration is here
 4991 |     const argtype *arg_type = ie->arg_type;
      |                    ^~~~~~~~
...//linux-user/syscall.c:5102:27: warning: declaration of 'arg_type' shadows a previous local [-Wshadow=local]
 5102 |             const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_name_list) };
      |                           ^~~~~~~~
.../linux-user/syscall.c:4991:20: note: shadowed declaration is here
 4991 |     const argtype *arg_type = ie->arg_type;
      |                    ^~~~~~~~
.../linux-user/syscall.c:5130:27: warning: declaration of 'arg_type' shadows a previous local [-Wshadow=local]
 5130 |             const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_target_spec) };
      |                           ^~~~~~~~
.../linux-user/syscall.c:4991:20: note: shadowed declaration is here
 4991 |     const argtype *arg_type = ie->arg_type;
      |                    ^~~~~~~~
.../linux-user/syscall.c:5170:27: warning: declaration of 'arg_type' shadows a previous local [-Wshadow=local]
 5170 |             const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_target_versions) };
      |                           ^~~~~~~~
.../linux-user/syscall.c:4991:20: note: shadowed declaration is here
 4991 |     const argtype *arg_type = ie->arg_type;
      |                    ^~~~~~~~

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3521a2d70b00..c81e8d344486 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5050,8 +5050,8 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
     {
         void *gspec = argptr;
         void *cur_data = host_data;
-        const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_target_spec) };
-        int spec_size = thunk_type_size(arg_type, 0);
+        const argtype dm_arg_type[] = { MK_STRUCT(STRUCT_dm_target_spec) };
+        int spec_size = thunk_type_size(dm_arg_type, 0);
         int i;
 
         for (i = 0; i < host_dm->target_count; i++) {
@@ -5059,7 +5059,7 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
             uint32_t next;
             int slen;
 
-            thunk_convert(spec, gspec, arg_type, THUNK_HOST);
+            thunk_convert(spec, gspec, dm_arg_type, THUNK_HOST);
             slen = strlen((char*)gspec + spec_size) + 1;
             next = spec->next;
             spec->next = sizeof(*spec) + slen;
@@ -5099,7 +5099,7 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
             struct dm_name_list *nl = (void*)host_dm + host_dm->data_start;
             uint32_t remaining_data = guest_data_size;
             void *cur_data = argptr;
-            const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_name_list) };
+            const argtype dm_arg_type[] = { MK_STRUCT(STRUCT_dm_name_list) };
             int nl_size = 12; /* can't use thunk_size due to alignment */
 
             while (1) {
@@ -5111,7 +5111,7 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
                     host_dm->flags |= DM_BUFFER_FULL_FLAG;
                     break;
                 }
-                thunk_convert(cur_data, nl, arg_type, THUNK_TARGET);
+                thunk_convert(cur_data, nl, dm_arg_type, THUNK_TARGET);
                 strcpy(cur_data + nl_size, nl->name);
                 cur_data += nl->next;
                 remaining_data -= nl->next;
@@ -5127,8 +5127,8 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
         {
             struct dm_target_spec *spec = (void*)host_dm + host_dm->data_start;
             void *cur_data = argptr;
-            const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_target_spec) };
-            int spec_size = thunk_type_size(arg_type, 0);
+            const argtype dm_arg_type[] = { MK_STRUCT(STRUCT_dm_target_spec) };
+            int spec_size = thunk_type_size(dm_arg_type, 0);
             int i;
 
             for (i = 0; i < host_dm->target_count; i++) {
@@ -5139,7 +5139,7 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
                     host_dm->flags |= DM_BUFFER_FULL_FLAG;
                     break;
                 }
-                thunk_convert(cur_data, spec, arg_type, THUNK_TARGET);
+                thunk_convert(cur_data, spec, dm_arg_type, THUNK_TARGET);
                 strcpy(cur_data + spec_size, (char*)&spec[1]);
                 cur_data = argptr + spec->next;
                 spec = (void*)host_dm + host_dm->data_start + next;
@@ -5167,8 +5167,8 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
             struct dm_target_versions *vers = (void*)host_dm + host_dm->data_start;
             uint32_t remaining_data = guest_data_size;
             void *cur_data = argptr;
-            const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_target_versions) };
-            int vers_size = thunk_type_size(arg_type, 0);
+            const argtype dm_arg_type[] = { MK_STRUCT(STRUCT_dm_target_versions) };
+            int vers_size = thunk_type_size(dm_arg_type, 0);
 
             while (1) {
                 uint32_t next = vers->next;
@@ -5179,7 +5179,7 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
                     host_dm->flags |= DM_BUFFER_FULL_FLAG;
                     break;
                 }
-                thunk_convert(cur_data, vers, arg_type, THUNK_TARGET);
+                thunk_convert(cur_data, vers, dm_arg_type, THUNK_TARGET);
                 strcpy(cur_data + vers_size, vers->name);
                 cur_data += vers->next;
                 remaining_data -= vers->next;
-- 
2.41.0


