Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 444207B2E9B
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:57:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Dm-0005Il-55; Fri, 29 Sep 2023 04:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9Db-0005Be-Np
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DB-0005cd-NH
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dGZdvVBakkMPiy5r9uddsx0SOw4gUpw7qzyBErOGYps=;
 b=hhRLaGldmF4+TLQuXI9fh9BQsxy5WInhvof1Wi8FigXYS1pzJ4Nt3DbgXXPtwvrfC+DY1o
 /ko4Dj5dhaW96aaw5KEwBia4S6F43pQpHEYSTBxvt5nF3/NAtUgrVEqmYfiGU23I0cjprA
 WY5vAZY1QhOpsWZJtk0E7mHkAQozrog=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-FN3ZuuFPMVCZMa1O0EfefA-1; Fri, 29 Sep 2023 04:50:57 -0400
X-MC-Unique: FN3ZuuFPMVCZMa1O0EfefA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AABCB1C05149;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 88C8A40C2064;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 949B321E6888; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/56] sysemu/device_tree: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:21 +0200
Message-ID: <20230929085053.2789105-25-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Fix:

  hw/mips/boston.c:472:5: error: declaration shadows a local variable [-Werror,-Wshadow]
    qemu_fdt_setprop_cells(fdt, name, "reg", reg_base, reg_size);
    ^
  include/sysemu/device_tree.h:129:13: note: expanded from macro 'qemu_fdt_setprop_cells'
        int i;
            ^
  hw/mips/boston.c:461:9: note: previous declaration is here
    int i;
        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904161235.84651-21-philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/sysemu/device_tree.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
index ca5339beae..8eab395934 100644
--- a/include/sysemu/device_tree.h
+++ b/include/sysemu/device_tree.h
@@ -126,10 +126,8 @@ int qemu_fdt_add_path(void *fdt, const char *path);
 #define qemu_fdt_setprop_cells(fdt, node_path, property, ...)                 \
     do {                                                                      \
         uint32_t qdt_tmp[] = { __VA_ARGS__ };                                 \
-        int i;                                                                \
-                                                                              \
-        for (i = 0; i < ARRAY_SIZE(qdt_tmp); i++) {                           \
-            qdt_tmp[i] = cpu_to_be32(qdt_tmp[i]);                             \
+        for (unsigned i_ = 0; i_ < ARRAY_SIZE(qdt_tmp); i_++) {               \
+            qdt_tmp[i_] = cpu_to_be32(qdt_tmp[i_]);                           \
         }                                                                     \
         qemu_fdt_setprop(fdt, node_path, property, qdt_tmp,                   \
                          sizeof(qdt_tmp));                                    \
-- 
2.41.0


