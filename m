Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFE77B6924
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:37:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnedn-0006t6-Nd; Tue, 03 Oct 2023 08:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnedk-0006rD-NG
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnedj-0000Mv-3j
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696336596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CvgWK1OCdtf04IF1Gguceuv0a9rcTqZNHJSEAT+LKpY=;
 b=Ny+1tGquqiuFps3a1Vst+27YHb+fqf0vCDbvymr9/EyLAOs82ueodL77+7Zz8XgRW6TZ4K
 Trzarjbd+7l3pSfZCqBcOap87G5Uw4wJpfSn+96kNeScFhBnedtsFo4QLvfAXeUGfMCCUM
 P0Xv9enS1toGXcPyhpfph0Vt1pf9VpM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-bh3xBrDLPfWIAOe_Ncwqng-1; Tue, 03 Oct 2023 08:36:31 -0400
X-MC-Unique: bh3xBrDLPfWIAOe_Ncwqng-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B666805B32;
 Tue,  3 Oct 2023 12:36:29 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2403D400E89;
 Tue,  3 Oct 2023 12:36:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 10/13] hw/core: remove needless includes
Date: Tue,  3 Oct 2023 16:35:39 +0400
Message-ID: <20231003123543.1360795-11-marcandre.lureau@redhat.com>
In-Reply-To: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
References: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The include list is large, make it smaller.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
---
 hw/core/machine.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index a232ae0bcd..df40f10dfa 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -11,32 +11,22 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/option.h"
 #include "qemu/accel.h"
 #include "sysemu/replay.h"
-#include "qemu/units.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-common.h"
 #include "qapi/qapi-visit-machine.h"
-#include "qapi/visitor.h"
 #include "qom/object_interfaces.h"
-#include "hw/sysbus.h"
 #include "sysemu/cpus.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
-#include "sysemu/numa.h"
 #include "sysemu/xen.h"
-#include "qemu/error-report.h"
 #include "sysemu/qtest.h"
-#include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 #include "migration/global_state.h"
-#include "migration/vmstate.h"
 #include "exec/confidential-guest-support.h"
-#include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-net.h"
 
-- 
2.41.0


