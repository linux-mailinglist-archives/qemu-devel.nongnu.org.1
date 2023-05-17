Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B12B706189
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 09:43:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzBnv-0005lz-4k; Wed, 17 May 2023 03:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pzBnt-0005lW-55
 for qemu-devel@nongnu.org; Wed, 17 May 2023 03:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pzBnr-0005Zh-5X
 for qemu-devel@nongnu.org; Wed, 17 May 2023 03:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684309350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lh3d8AKzcpUp8w4icgh0W8EI00eOhnO4qcdyULNmGTA=;
 b=B4bp0KoY3qWv71p6xj65KAeC76Tc605yyMv0H9/7dZ/6CjMXqO9YUrCdppjsKgHjSMTFo5
 I+3vzet4/39A+30g477AIFUsR3SXMqjN/ntOVnNCYhukTO1IZ7S7jq7mvGf45B6kg81HC1
 aGsgxB/pN+uBaxXE0R/YiGOATxtKMKM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-pZ592hOmPJ-MzdFTlvNCHQ-1; Wed, 17 May 2023 03:42:29 -0400
X-MC-Unique: pZ592hOmPJ-MzdFTlvNCHQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E78A61C05134;
 Wed, 17 May 2023 07:42:28 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94905492B00;
 Wed, 17 May 2023 07:42:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>
Subject: [PATCH 2/2] softmmu: Move ioport.c into the target-independent source
 set
Date: Wed, 17 May 2023 09:42:22 +0200
Message-Id: <20230517074222.766683-3-thuth@redhat.com>
In-Reply-To: <20230517074222.766683-1-thuth@redhat.com>
References: <20230517074222.766683-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

Now that the st*_p and ld*_p functions can be used from common code,
too, we can move ioport.c from specific_ss into softmmu_ss to avoid
that we have to compile it multiple times.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 softmmu/ioport.c    | 2 +-
 softmmu/meson.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/softmmu/ioport.c b/softmmu/ioport.c
index cb8adb0b93..8d9d1e5b40 100644
--- a/softmmu/ioport.c
+++ b/softmmu/ioport.c
@@ -26,10 +26,10 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
 #include "exec/ioport.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
+#include "exec/tswap.h"
 #include "trace.h"
 
 typedef struct MemoryRegionPortioList {
diff --git a/softmmu/meson.build b/softmmu/meson.build
index 974732b0f3..e572af54ab 100644
--- a/softmmu/meson.build
+++ b/softmmu/meson.build
@@ -1,6 +1,5 @@
 specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: [files(
   'arch_init.c',
-  'ioport.c',
   'memory.c',
   'physmem.c',
   'watchpoint.c',
@@ -20,6 +19,7 @@ softmmu_ss.add(files(
   'dirtylimit.c',
   'dma-helpers.c',
   'globals.c',
+  'ioport.c',
   'memory_mapping.c',
   'qdev-monitor.c',
   'qtest.c',
-- 
2.31.1


