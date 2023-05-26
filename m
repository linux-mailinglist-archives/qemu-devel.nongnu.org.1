Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CD171231D
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:11:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TRa-0003ID-G6; Fri, 26 May 2023 05:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2TRX-0003Fw-8A
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2TRV-0000lC-8n
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685092139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEy1EnPNjKiC9Xew0JwSdNOd0hK/nxorYYyEySf/o/E=;
 b=P88Q9ReFXf5HaN3m6LdtG1uSc2tsfnITB5niCVxxTsck6jdfBaljS0SegLhTop2wlk6KwW
 l//C0m17I1iJs4xn6pvFh+ix6N/GBfmIz6HSNwj5h8uNHN8pZ4CwR1ISq8rbjvD1meyirt
 HwclQVHytW423LvWiKp/T/IHOoysa8Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-Ad_Zkm3YME-oSuRUCTZfLg-1; Fri, 26 May 2023 05:08:58 -0400
X-MC-Unique: Ad_Zkm3YME-oSuRUCTZfLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6FBF8015D8;
 Fri, 26 May 2023 09:08:57 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4680C154D1;
 Fri, 26 May 2023 09:08:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Shaoqin Huang <shahuang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/15] machine: do not crash if default RAM backend name has
 been stolen
Date: Fri, 26 May 2023 11:08:38 +0200
Message-Id: <20230526090840.2225958-14-thuth@redhat.com>
In-Reply-To: <20230526090840.2225958-1-thuth@redhat.com>
References: <20230526090840.2225958-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

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

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2207886
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20230522131717.3780533-1-imammedo@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.31.1


