Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CB270BF7C
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:18:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15Pp-0004Kw-BA; Mon, 22 May 2023 09:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q15Pn-0004Jc-AN
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q15Pj-0000Hh-JN
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684761442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6On8HcWnRqf9TY4SPdSjN+Twjwtzn/93XLhDyEInlpE=;
 b=LoHIyIYE94gVKq8nJszhffkEnsYaKkd2mhM6O7FZxyh3ku4/WYOrwRnl2rvBH1fHRShkd7
 cyMwAqJTGNFklV2ah5rLOFOXz9SKCy11xBn+JpFg8VvzJUbFZ4N/H4wPRTPPyJ7/HgFX+5
 K/IqCzaYLxcXxif/GBv1P8IeQVp4ToQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-xNI-Up_dMG6iPE_FWhRPsw-1; Mon, 22 May 2023 09:17:20 -0400
X-MC-Unique: xNI-Up_dMG6iPE_FWhRPsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D66E185A794;
 Mon, 22 May 2023 13:17:20 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5726FC1ED99;
 Mon, 22 May 2023 13:17:19 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, wangyanan55@huawei.com, pbonzini@redhat.com,
 thuth@redhat.com
Subject: [PATCH] machine: do not crash if default RAM backend name has been
 stollen
Date: Mon, 22 May 2023 15:17:17 +0200
Message-Id: <20230522131717.3780533-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

QEMU aborts when default RAM backend should be used (i.e. no
explicit '-machine memory-backend=' specified) but user
has created an object which 'id' equals to default RAM backend
name used by board.

 $QEMU -machine pc \
       -object memory-backend-ram,id=pc.ram,size=4294967296

 Actual results:
 QEMU 7.2.0 monitor - type 'help' for more information
 (qemu) Unexpected error in object_property_try_add() at ../qom/object.c:1239:
 qemu-kvm: attempt to add duplicate property 'pc.ram' to object (type 'container')
 Aborted (core dumped)

Instead of abort, check for the conflicting 'id' and exit with
an error, suggesting how to remedy the issue.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
CC: thuth@redhat.com
---
 hw/core/machine.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 07f763eb2e..1000406211 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1338,6 +1338,14 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
         }
     } else if (machine_class->default_ram_id && machine->ram_size &&
                numa_uses_legacy_mem()) {
+        if (object_property_find(object_get_objects_root(),
+                                 machine_class->default_ram_id)) {
+            error_setg(errp, "object name '%s' is reserved for the default"
+                " RAM backend, it can't be used for any other purposes."
+                " Change the object's 'id' to something else",
+                machine_class->default_ram_id);
+            return;
+        }
         if (!create_default_memdev(current_machine, mem_path, errp)) {
             return;
         }
-- 
2.39.3


