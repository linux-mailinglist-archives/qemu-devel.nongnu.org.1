Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69289719BD2
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:18:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hE7-0001wW-TY; Thu, 01 Jun 2023 08:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q4hCm-0000S7-DM
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q4hCk-0006P8-Fe
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685621697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T6lLbn4wAevaYNir88uHLSoS3ayt4mzOGJLEgmNI+xk=;
 b=b2ClcKIPb5uA3tKrZfcRWp6kwGAr6p6sw3H30BZ9R+Bsw3YS46kGB06WwjzqPD3RcuRayx
 TI0FtwUBGibCpiU2oi9oX4G8SNgAmjx2S1k+rescsfb6uaPdXZs/7XMnNe8b7v/XtQIHTo
 zD38qiBt+zr8KMkR5c6uclcbLPXkg94=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-TbANzeAqOWC94ln3IAJPJw-1; Thu, 01 Jun 2023 08:14:53 -0400
X-MC-Unique: TbANzeAqOWC94ln3IAJPJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AE312A59540;
 Thu,  1 Jun 2023 12:14:53 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.22.8.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E4402166B25;
 Thu,  1 Jun 2023 12:14:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 01/10] memory-device: Unify enabled vs. supported error
 messages
Date: Thu,  1 Jun 2023 14:14:38 +0200
Message-Id: <20230601121447.272487-3-david@redhat.com>
In-Reply-To: <20230601121447.272487-1-david@redhat.com>
References: <20230601121447.272487-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Let's unify the error messages, such that we can simply stop allocating
ms->device_memory if the size would be 0 (and there are no memory
devices ever).

The case of "not supported by the machine" should barely pop up either
way: if the machine doesn't support memory devices, it usually doesn't
call the pre_plug handler ...

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 1636db9679..49f86ec8a8 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -104,15 +104,10 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
     GSList *list = NULL, *item;
     Range as, new = range_empty;
 
-    if (!ms->device_memory) {
-        error_setg(errp, "memory devices (e.g. for memory hotplug) are not "
-                         "supported by the machine");
-        return 0;
-    }
-
-    if (!memory_region_size(&ms->device_memory->mr)) {
-        error_setg(errp, "memory devices (e.g. for memory hotplug) are not "
-                         "enabled, please specify the maxmem option");
+    if (!ms->device_memory || !memory_region_size(&ms->device_memory->mr)) {
+        error_setg(errp, "the configuration is not prepared for memory devices"
+                         " (e.g., for memory hotplug), consider specifying the"
+                         " maxmem option");
         return 0;
     }
     range_init_nofail(&as, ms->device_memory->base,
-- 
2.40.1


