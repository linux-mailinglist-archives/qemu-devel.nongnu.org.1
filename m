Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7314C7B2E8A
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:56:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Df-0005CM-Ui; Fri, 29 Sep 2023 04:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DQ-000508-TL
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DB-0005cA-Ip
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=leHG7gs8FX5ozx1PuThc684J6vqDCXFzX9PpzbgoAp4=;
 b=GVmxfLdONDHF3pJ8yITsGrZDuhkCl/5Vf2FbZMQfq1rgH8UofFc7RYle1xjXt9L567OjmV
 TlJLYR8jscC1GU1/Dip0TCvtruLy/lR3qjD7S7zNIlHlLx0qg7U59pJQtmmIjW5ef8VgUv
 4nck108RVyOoqRrLGG7Wd6znKG19v+o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-TJ4lZUCHPkePP2HED3Wqvw-1; Fri, 29 Sep 2023 04:50:56 -0400
X-MC-Unique: TJ4lZUCHPkePP2HED3Wqvw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DDAB803DBD;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AC012026D4B;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 80EF621E6880; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 17/56] hw/m68k: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:14 +0200
Message-ID: <20230929085053.2789105-18-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Fix:

  hw/m68k/virt.c:263:13: error: declaration shadows a local variable [-Werror,-Wshadow]
            BOOTINFOSTR(param_ptr, BI_COMMAND_LINE,
            ^
  hw/m68k/bootinfo.h:47:13: note: expanded from macro 'BOOTINFOSTR'
        int i; \
            ^
  hw/m68k/virt.c:130:9: note: previous declaration is here
    int i;
        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904161235.84651-13-philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/m68k/bootinfo.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/bootinfo.h b/hw/m68k/bootinfo.h
index a3d37e3c80..0e6e3eea87 100644
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
+        for (unsigned i_ = 0; string[i_]; i_++) { \
+            stb_p(base++, string[i_]); \
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
+        for (unsigned i_ = 0; i_ < len; ++i_) { \
+            stb_p(base++, data[i_]); \
         } \
         base = QEMU_ALIGN_PTR_UP(base, 4); \
     } while (0)
-- 
2.41.0


