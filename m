Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E61761E6B
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 18:24:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOKp7-0003Pk-7O; Tue, 25 Jul 2023 12:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOKp4-0003PT-P1
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOKp2-0003oK-Go
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690302220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LMXfBf1yGEGrg1GRgnwijit3howRq6lfN/+tpMD6+80=;
 b=CJK5saXqK6kFgtj67N4MxQJ+fgTcUINn90tnhAmL5Uhg4HXIdBbO6phblvMUPdYDP44bax
 o2WvrrsTlRO0MBt+ayHslZvqXn+d6W3B1wHRKknrIP8UEypM8Amo/u9LUQT2acXjwdJwf9
 EC7C6SYTkINN7N45u8aiXaiQdHiAnvo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-DYrD0aNSObe53nYw9lNBpQ-1; Tue, 25 Jul 2023 12:23:36 -0400
X-MC-Unique: DYrD0aNSObe53nYw9lNBpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CFEF185A7A4;
 Tue, 25 Jul 2023 16:23:36 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10581145414A;
 Tue, 25 Jul 2023 16:23:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Canokeys.org" <contact@canokeys.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Hongren (Zenithal) Zheng" <i@zenithal.me>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 YuanYang Meng <mkfssion@mkfssion.com>
Subject: [PULL 2/2] hw/usb/canokey: change license to GPLv2+
Date: Tue, 25 Jul 2023 17:23:02 +0100
Message-ID: <20230725162304.156157-3-berrange@redhat.com>
In-Reply-To: <20230725162304.156157-1-berrange@redhat.com>
References: <20230725162304.156157-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: "Hongren (Zenithal) Zheng" <i@zenithal.me>

Apache license is considered by some to be not compatible
with GPLv2+. Since QEMU as combined work is GPLv2-only,
these two files should be made compatible.

Reported-by: "Daniel P. Berrangé" <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/ZEpKXncC%2Fe6FKRe9@redhat.com/
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-By: canokeys.org<http://canokeys.org><contact@canokeys.org>
Acked-by: YuanYang Meng <mkfssion@mkfssion.com>
Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/usb/canokey.c | 2 +-
 hw/usb/canokey.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/canokey.c b/hw/usb/canokey.c
index bbc5da07b5..b306eeb20e 100644
--- a/hw/usb/canokey.c
+++ b/hw/usb/canokey.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2021-2022 Canokeys.org <contact@canokeys.org>
  * Written by Hongren (Zenithal) Zheng <i@zenithal.me>
  *
- * This code is licensed under the Apache-2.0.
+ * This code is licensed under the GPL v2 or later.
  */
 
 #include "qemu/osdep.h"
diff --git a/hw/usb/canokey.h b/hw/usb/canokey.h
index 24cf304203..e528889d33 100644
--- a/hw/usb/canokey.h
+++ b/hw/usb/canokey.h
@@ -4,7 +4,7 @@
  * Copyright (c) 2021-2022 Canokeys.org <contact@canokeys.org>
  * Written by Hongren (Zenithal) Zheng <i@zenithal.me>
  *
- * This code is licensed under the Apache-2.0.
+ * This code is licensed under the GPL v2 or later.
  */
 
 #ifndef CANOKEY_H
-- 
2.41.0


