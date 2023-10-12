Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E337A7C7379
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:52:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqyuG-0004tu-Mh; Thu, 12 Oct 2023 12:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqyuE-0004tV-0Z
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqyu7-0005c7-HB
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697129479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0cL032qx0uwK9oS0aZTK5/sP9aT/OuguJqPKSYkOKr8=;
 b=IG1wHMwvuI3XSHycvgDowNKa4b+8vF+BMUjOnDvZ7kPD7Q7FtZQzrHwLSUjLWxTjXCGVO8
 7rD/pPjxCgWusoRZKz3PKL4u/BGeBWatvaPlGgvM0xekO0bybZN3ILeCdOO7jwg0RYaC1f
 lqVqZSnEWkDbJ64jmUyBbNbVwQ7QZqk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-S83pYH2NNZKkEaRIj-QEKQ-1; Thu, 12 Oct 2023 12:51:17 -0400
X-MC-Unique: S83pYH2NNZKkEaRIj-QEKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1F901029F44;
 Thu, 12 Oct 2023 16:51:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B886225C0;
 Thu, 12 Oct 2023 16:51:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 4/7] hw/misc/i2c-echo: add copyright/license note
Date: Thu, 12 Oct 2023 18:51:05 +0200
Message-ID: <20231012165108.913443-5-thuth@redhat.com>
In-Reply-To: <20231012165108.913443-1-thuth@redhat.com>
References: <20231012165108.913443-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Klaus Jensen <k.jensen@samsung.com>

Add missing copyright and license notice. Also add a short description
of the device.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Message-ID: <20230823-i2c-echo-fixes-v1-1-ccc05a6028f0@samsung.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/misc/i2c-echo.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/misc/i2c-echo.c b/hw/misc/i2c-echo.c
index 5705ab5d73..5ae3d0817e 100644
--- a/hw/misc/i2c-echo.c
+++ b/hw/misc/i2c-echo.c
@@ -1,3 +1,13 @@
+/*
+ * Example I2C device using asynchronous I2C send.
+ *
+ * Copyright (C) 2023 Samsung Electronics Co., Ltd. All Rights Reserved.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
-- 
2.41.0


