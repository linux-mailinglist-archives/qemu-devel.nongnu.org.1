Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB00819B88
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 10:42:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFt5B-0002Xv-00; Wed, 20 Dec 2023 04:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt52-0002Uy-0Y
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt4x-0005iy-Eb
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703065286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5Rj5vxaisYTsKEHNr8ldrOuDw0mlAuAsnUJ+tlF8tM=;
 b=TRhlCPwiDHkgFiNWl6Ar/pn6j2pkdQmy3VcLSkVqsKSfmK7VtenPCZIB6mANHiadBIDY6q
 Vs3/JragnIHQyZSeVmMomcy8nak0amkZQhC46S2Y2ssRyMQU43CG8yXytVm3oQj45a+gLn
 e9iZ0nNaD/F5iveNXkMby1bnjC9K0XQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-egeNNwSvPCKAQaGo4PCsSg-1; Wed, 20 Dec 2023 04:41:25 -0500
X-MC-Unique: egeNNwSvPCKAQaGo4PCsSg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84D9483DE2A;
 Wed, 20 Dec 2023 09:41:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F7FF2166B31;
 Wed, 20 Dec 2023 09:41:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Song Gao <gaosong@loongson.cn>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 08/19] target: Restrict 'sysemu/reset.h' to system emulation
Date: Wed, 20 Dec 2023 10:40:54 +0100
Message-ID: <20231220094105.6588-9-thuth@redhat.com>
In-Reply-To: <20231220094105.6588-1-thuth@redhat.com>
References: <20231220094105.6588-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

vCPU "reset" is only possible with system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20231212113640.30287-5-philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/i386/cpu.c      | 2 +-
 target/loongarch/cpu.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cd16cb893d..95d5f16cd5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -24,7 +24,6 @@
 #include "qemu/hw-version.h"
 #include "cpu.h"
 #include "tcg/helper-tcg.h"
-#include "sysemu/reset.h"
 #include "sysemu/hvf.h"
 #include "hvf/hvf-i386.h"
 #include "kvm/kvm_i386.h"
@@ -37,6 +36,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/i386/topology.h"
 #ifndef CONFIG_USER_ONLY
+#include "sysemu/reset.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index fc075952e6..b26187dfde 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -17,7 +17,9 @@
 #include "internals.h"
 #include "fpu/softfloat-helpers.h"
 #include "cpu-csr.h"
+#ifndef CONFIG_USER_ONLY
 #include "sysemu/reset.h"
+#endif
 #include "tcg/tcg.h"
 #include "vec.h"
 
-- 
2.43.0


