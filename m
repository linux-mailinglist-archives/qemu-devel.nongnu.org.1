Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0093388A3D9
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Mar 2024 15:13:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rol4G-00034E-7c; Mon, 25 Mar 2024 10:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rol47-00032i-La
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rol46-0005nS-4A
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711375961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hSBKxzfQGIXmvWUvXlWhdYTTE+D3xnVPdnyercmVvxo=;
 b=NH7GcbRF832F4Tz6DQtJ/3H+HLCj7nKt1UmffEqaF/ei4/ktQG8KURbuQQeT7vpy4VBx0s
 QD/gMsyS7so4D94AgkxsjL9J+M5hgurrabMm5cdCVZ2MSfBP7JiVIKSYg7qzEaeH1BnKIt
 MTCnq4okvyvRfAHP39+mdJjxgbMSVGI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-18KdrlPVPGioAW7iaBc8lQ-1; Mon,
 25 Mar 2024 10:12:37 -0400
X-MC-Unique: 18KdrlPVPGioAW7iaBc8lQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 016281C0152A;
 Mon, 25 Mar 2024 14:12:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DFF748D9;
 Mon, 25 Mar 2024 14:12:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/9] hw/microblaze: Do not allow xlnx-zynqmp-pmu-soc to be
 created by the user
Date: Mon, 25 Mar 2024 15:12:04 +0100
Message-ID: <20240325141210.788356-4-thuth@redhat.com>
In-Reply-To: <20240325141210.788356-1-thuth@redhat.com>
References: <20240325141210.788356-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

Using xlnx-zynqmp-pmu-soc on the command line causes QEMU to crash:

 ./qemu-system-microblazeel -M petalogix-ml605 -device xlnx-zynqmp-pmu-soc
 **
 ERROR:tcg/tcg.c:813:tcg_register_thread: assertion failed: (n < tcg_max_ctxs)
 Bail out!
 Aborted (core dumped)

Mark the device with "user_creatable = false" to avoid that this can happen.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2229
Message-ID: <20240322183153.1023359-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/microblaze/xlnx-zynqmp-pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 5a2016672a..1bfc9641d2 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -125,6 +125,8 @@ static void xlnx_zynqmp_pmu_soc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    /* xlnx-zynqmp-pmu-soc causes crashes when cold-plugged twice */
+    dc->user_creatable = false;
     dc->realize = xlnx_zynqmp_pmu_soc_realize;
 }
 
-- 
2.44.0


