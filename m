Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E35687E027F
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 13:06:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qysvA-0007O6-Ea; Fri, 03 Nov 2023 08:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qysv3-0007LR-S8
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 08:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qysv1-0001U3-Kq
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 08:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699013094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zv6h0toate0j1Uvf9e0Pm8QwR7BudAmn5Vz4Z5ik9m4=;
 b=dT/9qh4VISbrsmsZSwHhuKPn+9w0CijG2g1ufXKI9uHndIiej/zobE/BpnSS4nwQ3g62Kj
 lfj4Z4iadE8zqeo6gg2AbGnT0F4hD5+Vgz+A8nrP4lZCVQEs20sXYyogoWaYfW+hkmd+K8
 ESUM8KmdtpPPJl0hH6TFmaZk1wUeWqQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-1P9iJ9BTPIaSmNWezdmb8Q-1; Fri,
 03 Nov 2023 08:04:53 -0400
X-MC-Unique: 1P9iJ9BTPIaSmNWezdmb8Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 560893C025BE;
 Fri,  3 Nov 2023 12:04:53 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C975F492BE0;
 Fri,  3 Nov 2023 12:04:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>, Thomas Huth <thuth@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PULL 1/7] system/dirtylimit: Fix a race situation
Date: Fri,  3 Nov 2023 13:04:42 +0100
Message-ID: <20231103120448.58428-2-quintela@redhat.com>
In-Reply-To: <20231103120448.58428-1-quintela@redhat.com>
References: <20231103120448.58428-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

Fix a race situation for global variable dirtylimit_state.

Also, replace usleep by g_usleep to increase platform
accessibility to the sleep function.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <27c86239e21eda03d11ce5a3d07da3c229f562e3.1698847223.git.yong.huang@smartx.com>
---
 system/dirtylimit.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index fa959d7743..3666c4cb7c 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -411,12 +411,20 @@ void dirtylimit_set_all(uint64_t quota,
 
 void dirtylimit_vcpu_execute(CPUState *cpu)
 {
-    if (dirtylimit_in_service() &&
-        dirtylimit_vcpu_get_state(cpu->cpu_index)->enabled &&
-        cpu->throttle_us_per_full) {
-        trace_dirtylimit_vcpu_execute(cpu->cpu_index,
-                cpu->throttle_us_per_full);
-        usleep(cpu->throttle_us_per_full);
+    if (cpu->throttle_us_per_full) {
+        dirtylimit_state_lock();
+
+        if (dirtylimit_in_service() &&
+            dirtylimit_vcpu_get_state(cpu->cpu_index)->enabled) {
+            dirtylimit_state_unlock();
+            trace_dirtylimit_vcpu_execute(cpu->cpu_index,
+                    cpu->throttle_us_per_full);
+
+            g_usleep(cpu->throttle_us_per_full);
+            return;
+        }
+
+        dirtylimit_state_unlock();
     }
 }
 
-- 
2.41.0


