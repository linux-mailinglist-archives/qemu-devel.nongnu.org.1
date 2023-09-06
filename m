Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81417793C4F
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 14:07:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdrIf-0004a6-5y; Wed, 06 Sep 2023 08:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qdrIA-0003xZ-Dz
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 08:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qdrI7-0006q9-U6
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 08:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694001950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1DczjnIEca6RHkhQ7AKfccFVCGwL2Fb+fSKnjqPUL30=;
 b=ROKAjcR61mIRKckm/fJlRJCBc9LGHPYed0evhL9GBwUs/W8s6C8euo8KO+nvdG1OTG3kh2
 +UzI1F+WZIwttjsCN3kxM2EzCbtYmOuRD6ZHg5OFQuon2tnRPlvYuSho4HrddqBQhOZs3n
 oxOB2893/qlbPOFDNN8wXcPNMrmdjBo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-diMTYx2xMpG63pV_arkJxQ-1; Wed, 06 Sep 2023 08:05:47 -0400
X-MC-Unique: diMTYx2xMpG63pV_arkJxQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C395C873238;
 Wed,  6 Sep 2023 12:05:45 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C56EC493112;
 Wed,  6 Sep 2023 12:05:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mario Casquero <mcasquer@redhat.com>
Subject: [PATCH v4 11/11] machine: Improve error message when using default
 RAM backend id
Date: Wed,  6 Sep 2023 14:05:03 +0200
Message-ID: <20230906120503.359863-12-david@redhat.com>
In-Reply-To: <20230906120503.359863-1-david@redhat.com>
References: <20230906120503.359863-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

For migration purposes, users might want to reuse the default RAM
backend id, but specify a different memory backend.

For example, to reuse "pc.ram" on q35, one has to set
    -machine q35,memory-backend=pc.ram
Only then, can a memory backend with the id "pc.ram" be created
manually.

Let's improve the error message by improving the hint. Use
error_append_hint() -- which in turn requires ERRP_GUARD().

Suggested-by: ThinerLogoer <logoerthiner1@163.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/machine.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index da699cf4e1..db0c263ff6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1355,6 +1355,7 @@ out:
 
 void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp)
 {
+    ERRP_GUARD();
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
     ObjectClass *oc = object_class_by_name(machine->cpu_type);
     CPUClass *cc;
@@ -1383,9 +1384,13 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
                numa_uses_legacy_mem()) {
         if (object_property_find(object_get_objects_root(),
                                  machine_class->default_ram_id)) {
-            error_setg(errp, "object name '%s' is reserved for the default"
-                " RAM backend, it can't be used for any other purposes."
-                " Change the object's 'id' to something else",
+            error_setg(errp, "object's id '%s' is reserved for the default"
+                " RAM backend, it can't be used for any other purposes",
+                machine_class->default_ram_id);
+            error_append_hint(errp,
+                "Change the object's 'id' to something else or disable"
+                " automatic creation of the default RAM backend by setting"
+                " 'memory-backend=%s' with '-machine'.\n",
                 machine_class->default_ram_id);
             return;
         }
-- 
2.41.0


