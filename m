Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E84B7A02BB
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 13:34:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgkbA-0000kI-BY; Thu, 14 Sep 2023 07:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgkb5-0000h0-8k
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgkb1-000829-Bd
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694691198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kbuF+g1FjxuOcbVTKhy2Mky4MOIcfRtu8c/CwwAuRwE=;
 b=JwDDobdGUCi3XEKGHOg6dLPsee9yQEdTKCXvKqdbrIs9pIM3nzqQs+7AyVizimZy4kaEyu
 DItOTV7E46NcgSxJXBzyi8HDxtO8m7P3JICwa8EQJm/Mg61GpHIBccui/xwcdR5nUKfcuS
 I7gR+7Wsjb3pKXjph9YLR6xnah0qr2g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-HrkBKEnqO4m4Sqk56xTlIg-1; Thu, 14 Sep 2023 07:33:16 -0400
X-MC-Unique: HrkBKEnqO4m4Sqk56xTlIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3A1A802E5A;
 Thu, 14 Sep 2023 11:33:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E97711054FC0;
 Thu, 14 Sep 2023 11:33:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [risu PATCH v3 1/7] Pass siginfo_t->si_addr to the reginfo_init()
 function
Date: Thu, 14 Sep 2023 13:33:05 +0200
Message-ID: <20230914113311.379537-2-thuth@redhat.com>
In-Reply-To: <20230914113311.379537-1-thuth@redhat.com>
References: <20230914113311.379537-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On s390x, we need the si_addr from the siginfo_t to get to
the address of the illegal instruction (the PSW address in
the ucontext_t is already pointing to the next instruction
there). So let's prepare for that situation and pass the
si_addr to the reginfo_init() function everywhere.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 risu.c                     | 12 ++++++------
 risu.h                     |  2 +-
 risu_reginfo_aarch64.c     |  2 +-
 risu_reginfo_arm.c         |  2 +-
 risu_reginfo_i386.c        |  2 +-
 risu_reginfo_loongarch64.c |  2 +-
 risu_reginfo_m68k.c        |  2 +-
 risu_reginfo_ppc64.c       |  2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/risu.c b/risu.c
index 714074e..36fc82a 100644
--- a/risu.c
+++ b/risu.c
@@ -106,14 +106,14 @@ static void respond(RisuResult r)
     }
 }
 
-static RisuResult send_register_info(void *uc)
+static RisuResult send_register_info(void *uc, void *siaddr)
 {
     uint64_t paramreg;
     RisuResult res;
     RisuOp op;
     void *extra;
 
-    reginfo_init(&ri[MASTER], uc);
+    reginfo_init(&ri[MASTER], uc, siaddr);
     op = get_risuop(&ri[MASTER]);
 
     /* Write a header with PC/op to keep in sync */
@@ -178,7 +178,7 @@ static void master_sigill(int sig, siginfo_t *si, void *uc)
     RisuResult r;
     signal_count++;
 
-    r = send_register_info(uc);
+    r = send_register_info(uc, si->si_addr);
     if (r == RES_OK) {
         advance_pc(uc);
     } else {
@@ -232,13 +232,13 @@ static RisuResult recv_register_info(struct reginfo *ri)
     }
 }
 
-static RisuResult recv_and_compare_register_info(void *uc)
+static RisuResult recv_and_compare_register_info(void *uc, void *siaddr)
 {
     uint64_t paramreg;
     RisuResult res;
     RisuOp op;
 
-    reginfo_init(&ri[APPRENTICE], uc);
+    reginfo_init(&ri[APPRENTICE], uc, siaddr);
 
     res = recv_register_info(&ri[MASTER]);
     if (res != RES_OK) {
@@ -315,7 +315,7 @@ static void apprentice_sigill(int sig, siginfo_t *si, void *uc)
     RisuResult r;
     signal_count++;
 
-    r = recv_and_compare_register_info(uc);
+    r = recv_and_compare_register_info(uc, si->si_addr);
     if (r == RES_OK) {
         advance_pc(uc);
     } else {
diff --git a/risu.h b/risu.h
index bdb70c1..2c43384 100644
--- a/risu.h
+++ b/risu.h
@@ -115,7 +115,7 @@ RisuOp get_risuop(struct reginfo *ri);
 uintptr_t get_pc(struct reginfo *ri);
 
 /* initialize structure from a ucontext */
-void reginfo_init(struct reginfo *ri, ucontext_t *uc);
+void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr);
 
 /* return 1 if structs are equal, 0 otherwise. */
 int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index be47980..1244454 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -82,7 +82,7 @@ int reginfo_size(struct reginfo *ri)
 }
 
 /* reginfo_init: initialize with a ucontext */
-void reginfo_init(struct reginfo *ri, ucontext_t *uc)
+void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
 {
     int i;
     struct _aarch64_ctx *ctx, *extra = NULL;
diff --git a/risu_reginfo_arm.c b/risu_reginfo_arm.c
index 202120b..85a39ac 100644
--- a/risu_reginfo_arm.c
+++ b/risu_reginfo_arm.c
@@ -118,7 +118,7 @@ static void reginfo_init_vfp(struct reginfo *ri, ucontext_t *uc)
     }
 }
 
-void reginfo_init(struct reginfo *ri, ucontext_t *uc)
+void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
 {
     memset(ri, 0, sizeof(*ri));         /* necessary for memcmp later */
 
diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index e9730be..834b2ed 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -102,7 +102,7 @@ static void *xsave_feature_buf(struct _xstate *xs, int feature)
 }
 
 /* reginfo_init: initialize with a ucontext */
-void reginfo_init(struct reginfo *ri, ucontext_t *uc)
+void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
 {
     int i, nvecregs;
     struct _fpstate *fp;
diff --git a/risu_reginfo_loongarch64.c b/risu_reginfo_loongarch64.c
index af6ab77..16384f1 100644
--- a/risu_reginfo_loongarch64.c
+++ b/risu_reginfo_loongarch64.c
@@ -81,7 +81,7 @@ static int parse_extcontext(struct sigcontext *sc, struct extctx_layout *extctx)
 }
 
 /* reginfo_init: initialize with a ucontext */
-void reginfo_init(struct reginfo *ri, ucontext_t *context)
+void reginfo_init(struct reginfo *ri, ucontext_t *context, void *siaddr)
 {
     int i;
     struct ucontext *uc = (struct ucontext *)context;
diff --git a/risu_reginfo_m68k.c b/risu_reginfo_m68k.c
index 4c25e77..e29da84 100644
--- a/risu_reginfo_m68k.c
+++ b/risu_reginfo_m68k.c
@@ -33,7 +33,7 @@ int reginfo_size(struct reginfo *ri)
 }
 
 /* reginfo_init: initialize with a ucontext */
-void reginfo_init(struct reginfo *ri, ucontext_t *uc)
+void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
 {
     int i;
     memset(ri, 0, sizeof(*ri));
diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index 9899b36..bbdd63c 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -42,7 +42,7 @@ int reginfo_size(struct reginfo *ri)
 }
 
 /* reginfo_init: initialize with a ucontext */
-void reginfo_init(struct reginfo *ri, ucontext_t *uc)
+void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
 {
     int i;
 
-- 
2.41.0


