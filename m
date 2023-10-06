Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CF87BB6BF
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:42:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9K-00059A-5V; Fri, 06 Oct 2023 07:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8w-00051r-Ib
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8t-00008T-7x
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IiuLRIOLTArS9qxuC7vVu92Tiusj+SO0PvCD56qkjVU=;
 b=DpnDSqhFcn/k2Nb/n+tKPdwFPj0PoCOWOi9SNKVjsATeenLz6j6ID3tX3ASweTMmPv1YCE
 zqZ3hI3vABNt43JrYJBe78HwjaqG1qP6yBwu7w/HiRAESPkL50aarJaDjXTud1l43D5Oxo
 AUtPURUYg8nxL2PfVZlD43r3hYTDnpI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-P-APc64XNb-m3vwr6sRSfw-1; Fri, 06 Oct 2023 07:37:01 -0400
X-MC-Unique: P-APc64XNb-m3vwr6sRSfw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 049EB101A59B;
 Fri,  6 Oct 2023 11:37:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7BED2156711;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B121C21E6895; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Laurent Vivier <laurent@vivier.eu>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 32/32] linux-user/syscall.c: clean up local variable shadowing
 in xattr syscalls
Date: Fri,  6 Oct 2023 13:36:57 +0200
Message-ID: <20231006113657.3803180-33-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Laurent Vivier <laurent@vivier.eu>

p is a generic variable in syscall() and can be used by any syscall
case, so this patch removes the useless local variable declaration for
the following syscalls: TARGET_NR_llistxattr, TARGET_NR_listxattr,
TARGET_NR_setxattr, TARGET_NR_lsetxattr, TARGET_NR_getxattr,
TARGET_NR_lgetxattr, TARGET_NR_removexattr, TARGET_NR_lremovexattr.

Fix following warnings:

.../linux-user/syscall.c:12342:15: warning: declaration of 'p' shadows a previous local [-Wshadow=compatible-local]
12342 |         void *p, *b = 0;
      |               ^
.../linux-user/syscall.c:8975:11: note: shadowed declaration is here
 8975 |     void *p;
      |           ^
.../linux-user/syscall.c:12379:19: warning: declaration of 'p' shadows a previous local [-Wshadow=compatible-local]
12379 |             void *p, *n, *v = 0;
      |                   ^
.../linux-user/syscall.c:8975:11: note: shadowed declaration is here
 8975 |     void *p;
      |           ^
.../linux-user/syscall.c:12424:19: warning: declaration of 'p' shadows a previous local [-Wshadow=compatible-local]
12424 |             void *p, *n, *v = 0;
      |                   ^
.../linux-user/syscall.c:8975:11: note: shadowed declaration is here
 8975 |     void *p;
      |           ^
.../linux-user/syscall.c:12469:19: warning: declaration of 'p' shadows a previous local [-Wshadow=compatible-local]
12469 |             void *p, *n;
      |                   ^
.../linux-user/syscall.c:8975:11: note: shadowed declaration is here
 8975 |     void *p;
      |           ^

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20230925151029.461358-6-laurent@vivier.eu>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 linux-user/syscall.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 97a5e9ddf2..d49cd314a2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12339,7 +12339,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_listxattr:
     case TARGET_NR_llistxattr:
     {
-        void *p, *b = 0;
+        void *b = 0;
         if (arg2) {
             b = lock_user(VERIFY_WRITE, arg2, arg3, 0);
             if (!b) {
@@ -12376,7 +12376,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_setxattr:
     case TARGET_NR_lsetxattr:
         {
-            void *p, *n, *v = 0;
+            void *n, *v = 0;
             if (arg3) {
                 v = lock_user(VERIFY_READ, arg3, arg4, 1);
                 if (!v) {
@@ -12421,7 +12421,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_getxattr:
     case TARGET_NR_lgetxattr:
         {
-            void *p, *n, *v = 0;
+            void *n, *v = 0;
             if (arg3) {
                 v = lock_user(VERIFY_WRITE, arg3, arg4, 0);
                 if (!v) {
@@ -12466,7 +12466,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_removexattr:
     case TARGET_NR_lremovexattr:
         {
-            void *p, *n;
+            void *n;
             p = lock_user_string(arg1);
             n = lock_user_string(arg2);
             if (p && n) {
-- 
2.41.0


