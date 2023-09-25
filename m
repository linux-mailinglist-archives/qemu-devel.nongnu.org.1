Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD4B7ADF57
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:58:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqki-0000vh-JD; Mon, 25 Sep 2023 14:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qkqkf-0000tq-Am
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:56:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qkqkc-0004S6-Vy
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695668168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=R2yjQ8u6dXbkENl+fE58S2dXDz0xOzogXPAzVNv2rYE=;
 b=FV8fq61g1Eg4LUNt7/6INUY3sAWeoTAhwYUmkrvP/XVRnfkUMxsOJ0KfgK49dboePqhxxz
 0xxQAa6oDoRCmYBhbzSUhj3Mg+GiE6qG9+Us07zF68aFn2IaHK0pSn+xHbvT59F09tRrkn
 L9uXkeQpZG2wE9olAEEEnxl9L1e9Vr4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623--cNawG1TMVm3Rm08iC2wXw-1; Mon, 25 Sep 2023 14:56:06 -0400
X-MC-Unique: -cNawG1TMVm3Rm08iC2wXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33A4A3C14AA7;
 Mon, 25 Sep 2023 18:56:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1616428FE;
 Mon, 25 Sep 2023 18:56:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>,
	qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] m68k: Silence -Wshadow=local warnings in the m68k code
Date: Mon, 25 Sep 2023 20:56:03 +0200
Message-ID: <20230925185603.106945-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Rename the innermost variables to make the code compile
without warnings when using -Wshadow=local.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/m68k/bootinfo.h      | 10 ++++------
 disas/m68k.c            |  8 ++++----
 target/m68k/translate.c |  8 ++++----
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/m68k/bootinfo.h b/hw/m68k/bootinfo.h
index a3d37e3c80..d077d03559 100644
--- a/hw/m68k/bootinfo.h
+++ b/hw/m68k/bootinfo.h
@@ -44,15 +44,14 @@
 
 #define BOOTINFOSTR(base, id, string) \
     do { \
-        int i; \
         stw_p(base, id); \
         base += 2; \
         stw_p(base, \
                  (sizeof(struct bi_record) + strlen(string) + \
                   1 /* null termination */ + 3 /* padding */) & ~3); \
         base += 2; \
-        for (i = 0; string[i]; i++) { \
-            stb_p(base++, string[i]); \
+        for (int _i = 0; string[_i]; _i++) { \
+            stb_p(base++, string[_i]); \
         } \
         stb_p(base++, 0); \
         base = QEMU_ALIGN_PTR_UP(base, 4); \
@@ -60,7 +59,6 @@
 
 #define BOOTINFODATA(base, id, data, len) \
     do { \
-        int i; \
         stw_p(base, id); \
         base += 2; \
         stw_p(base, \
@@ -69,8 +67,8 @@
         base += 2; \
         stw_p(base, len); \
         base += 2; \
-        for (i = 0; i < len; ++i) { \
-            stb_p(base++, data[i]); \
+        for (int _i = 0; _i < len; ++_i) { \
+            stb_p(base++, data[_i]); \
         } \
         base = QEMU_ALIGN_PTR_UP(base, 4); \
     } while (0)
diff --git a/disas/m68k.c b/disas/m68k.c
index aefaecfbd6..a384b4cb64 100644
--- a/disas/m68k.c
+++ b/disas/m68k.c
@@ -1632,10 +1632,10 @@ print_insn_arg (const char *d,
     case '2':
     case '3':
       {
-	int val = fetch_arg (buffer, place, 5, info);
+	int val2 = fetch_arg (buffer, place, 5, info);
         const char *name = 0;
 
-	switch (val)
+	switch (val2)
 	  {
 	  case 2: name = "%tt0"; break;
 	  case 3: name = "%tt1"; break;
@@ -1655,12 +1655,12 @@ print_insn_arg (const char *d,
 	      int break_reg = ((buffer[3] >> 2) & 7);
 
 	      (*info->fprintf_func)
-		(info->stream, val == 0x1c ? "%%bad%d" : "%%bac%d",
+		(info->stream, val2 == 0x1c ? "%%bad%d" : "%%bac%d",
 		 break_reg);
 	    }
 	    break;
 	  default:
-	    (*info->fprintf_func) (info->stream, "<mmu register %d>", val);
+	    (*info->fprintf_func) (info->stream, "<mmu register %d>", val2);
 	  }
 	if (name)
 	  (*info->fprintf_func) (info->stream, "%s", name);
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 9e224fe796..b28d7f7d4b 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -824,14 +824,14 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
         reg = get_areg(s, reg0);
         result = gen_ldst(s, opsize, reg, val, what, index);
         if (what == EA_STORE || !addrp) {
-            TCGv tmp = tcg_temp_new();
+            TCGv tmp2 = tcg_temp_new();
             if (reg0 == 7 && opsize == OS_BYTE &&
                 m68k_feature(s->env, M68K_FEATURE_M68K)) {
-                tcg_gen_addi_i32(tmp, reg, 2);
+                tcg_gen_addi_i32(tmp2, reg, 2);
             } else {
-                tcg_gen_addi_i32(tmp, reg, opsize_bytes(opsize));
+                tcg_gen_addi_i32(tmp2, reg, opsize_bytes(opsize));
             }
-            delay_set_areg(s, reg0, tmp, true);
+            delay_set_areg(s, reg0, tmp2, true);
         }
         return result;
     case 4: /* Indirect predecrememnt.  */
-- 
2.41.0


