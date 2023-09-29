Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 768897B2E69
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:52:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Dk-0005FO-Ih; Fri, 29 Sep 2023 04:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DW-00053o-VE
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DC-0005dZ-PB
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5rfn6Asg21XhrzZfBCY3GYKV0hmgXGMupa9rdBuXxo=;
 b=jPK3dUmUgUN+vdVh/8Jy5ASO6RvW9FP1jAi/RwV51XKOdd74ow9GZv2MBgOf6It8Pz+Uxe
 sIZihCIp+FMPJpEQ3Oez3Vff4xPJsNxtSFdEyiD7rkPnL6TQI+u5h3PFFqOniy9p2NrfP1
 tqnLCtJEZOZogLuhvl5hCV91PtOok60=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-V1oPfnATNM2MnCvmCcU39w-1; Fri, 29 Sep 2023 04:50:58 -0400
X-MC-Unique: V1oPfnATNM2MnCvmCcU39w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9680C29AB45F;
 Fri, 29 Sep 2023 08:50:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72D30492C37;
 Fri, 29 Sep 2023 08:50:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD4FC21E6899; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 36/56] spapr/drc: Clean up local variable shadowing in
 prop_get_fdt()
Date: Fri, 29 Sep 2023 10:50:33 +0200
Message-ID: <20230929085053.2789105-37-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cédric Le Goater <clg@kaod.org>

Rename 'name' variable to avoid this warning :

  ../hw/ppc/spapr_drc.c: In function ‘prop_get_fdt’:
  ../hw/ppc/spapr_drc.c:344:21: warning: declaration of ‘name’ shadows a parameter [-Wshadow=compatible-local]
    344 |         const char *name = NULL;
        |                     ^~~~
  ../hw/ppc/spapr_drc.c:325:63: note: shadowed declaration is here
    325 | static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
        |                                                   ~~~~~~~~~~~~^~~~

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230918145850.241074-9-clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ppc/spapr_drc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 843e318312..2b99d3b4b1 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -341,7 +341,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
     fdt_depth = 0;
 
     do {
-        const char *name = NULL;
+        const char *dt_name = NULL;
         const struct fdt_property *prop = NULL;
         int prop_len = 0, name_len = 0;
         uint32_t tag;
@@ -351,8 +351,8 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
         switch (tag) {
         case FDT_BEGIN_NODE:
             fdt_depth++;
-            name = fdt_get_name(fdt, fdt_offset, &name_len);
-            if (!visit_start_struct(v, name, NULL, 0, errp)) {
+            dt_name = fdt_get_name(fdt, fdt_offset, &name_len);
+            if (!visit_start_struct(v, dt_name, NULL, 0, errp)) {
                 return;
             }
             break;
@@ -369,8 +369,8 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
         case FDT_PROP: {
             int i;
             prop = fdt_get_property_by_offset(fdt, fdt_offset, &prop_len);
-            name = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
-            if (!visit_start_list(v, name, NULL, 0, errp)) {
+            dt_name = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
+            if (!visit_start_list(v, dt_name, NULL, 0, errp)) {
                 return;
             }
             for (i = 0; i < prop_len; i++) {
-- 
2.41.0


