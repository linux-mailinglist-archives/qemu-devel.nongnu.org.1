Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9A17A5FAA
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:33:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiY17-0003oZ-RM; Tue, 19 Sep 2023 06:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY0D-00036d-K6
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY0B-0001vG-TW
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695119443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VhS/fzD7JOGnA1954033G5f6f9WT8hvs3vLVrgbYy0=;
 b=MVA/rGCWS5bLrd98y5w3DCUQgXpFxn2JRudKvfBxM9TJTOAnELY9V/49pNlYR57f2Lp7oP
 F/lYpdW0/kUzF+BeVBBCyMGhrO/hdYp3O3/913332u14lCqBH0obyYffPUGcEvOXPqymG6
 qUaWdB5Ti5ge/qo3XO2TJqGK8fN3Moc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-UKg5nhTSNsm6dc4eADOQ2w-1; Tue, 19 Sep 2023 06:30:41 -0400
X-MC-Unique: UKg5nhTSNsm6dc4eADOQ2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D1E9811E7D;
 Tue, 19 Sep 2023 10:30:41 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AF3240C6EBF;
 Tue, 19 Sep 2023 10:30:40 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, ThinerLogoer <logoerthiner1@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mario Casquero <mcasquer@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [GIT PULL 11/12] machine: Improve error message when using default
 RAM backend id
Date: Tue, 19 Sep 2023 12:30:28 +0200
Message-ID: <20230919103029.235736-12-david@redhat.com>
In-Reply-To: <20230919103029.235736-1-david@redhat.com>
References: <20230919103029.235736-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

Message-ID: <20230906120503.359863-12-david@redhat.com>
Suggested-by: ThinerLogoer <logoerthiner1@163.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
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


