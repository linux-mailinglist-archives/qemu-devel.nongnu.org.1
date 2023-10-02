Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 032807B50F9
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 13:15:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnGsz-0000em-2t; Mon, 02 Oct 2023 07:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnGsx-0000eY-Tb
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 07:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnGst-0002u0-6g
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 07:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696245282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NzrQc+Wfa/75M/PbLAuo3bKlbIBov2ly1tF4a27Ydi4=;
 b=Gvx3bf26Mfi29LCluwKLN1T9i/CQT0hcIqMTI+vYIqkcH4jVnquRZoL3Z+W4u4KkUnBVug
 xa37XlKntqrumAJVwPYsE2DKy6AIpqWLnbwEQVeQVQo0jbHOnKPkI1F0d6udGqBICA4z6D
 ea9tZy7yMu3iCclwRXyPW2I0fhYfCG4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-e8ICorXcMBGA7blc7Upt8A-1; Mon, 02 Oct 2023 07:14:39 -0400
X-MC-Unique: e8ICorXcMBGA7blc7Upt8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE9D7855432;
 Mon,  2 Oct 2023 11:12:02 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E11B52156701;
 Mon,  2 Oct 2023 11:12:01 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, lersek@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v2 1/5] hw: remove needless includes
Date: Mon,  2 Oct 2023 15:11:49 +0400
Message-ID: <20231002111154.1002655-2-marcandre.lureau@redhat.com>
In-Reply-To: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
References: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
---
 hw/core/machine.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index cb38b8cf4c..68cb556197 100644
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


