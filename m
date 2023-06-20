Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C59737544
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:47:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhIp-0000OB-LU; Tue, 20 Jun 2023 15:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7n-0004bK-PA
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:39 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7m-0006j7-DR
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:39 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-47151ee3fe6so1454714e0c.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687281997; x=1689873997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OA/WxFF2LjQwsusJe2ZEpybwtLFNNB6dL8Z37x5MiNA=;
 b=Gw/ePyPCZN6D3R1lWEpm9o7z/zkmsq5C1rmuygaCsoLkAVfyEB2INLuL4Q3dZ3eRvw
 M2U2UC838z71yX74m5WjScvJTVZAodbHCfcg5o1Dd6TWhksUBFgJJOxfxgIxE6S47L1G
 pOTQU8xgcuhfrCgn9bB4/VggimQCKWiOcMGICTs1n0qeH7cYpquX2hrU8MBZybMoDi3C
 ACKDJRBaCa967M0qH7wJ8nuxQnFE0kkQ6VQrucbr+q/6ae4YWtog6F5y3oB/6QtjhwET
 xmQPCQ5ROzWM1HJjut//n2STpO4dETYKelWRV8ex3U8VeHWtJFQyNRw7JBkVd6pDiDKi
 BFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687281997; x=1689873997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OA/WxFF2LjQwsusJe2ZEpybwtLFNNB6dL8Z37x5MiNA=;
 b=gydjc3dgVa4EVDSt75Gvb8Ss7xCtscpKOxt6HnYTh0L8QSnWe66+w2ngCmChcBh6pC
 qo9EJRWJRkk3S30+KbTos5mY8E1XtG/OuBtipMNQU8RfsNedvWdStWkqDhJ/73xu2V4S
 kECj58BgA5aY4BFGALRxqOZSmsI6yINz+0Ze/vxjJ7Fv7awYsmmrkTlnqKQeNiUm155p
 rAGklgdUbwq0GOXFAHVPf8lK1vREiOZiq5YL8pVySWl4l9j4g1TqAshR2H+H0AdhylQ+
 bdhan0TKpti9Fhld0PcYJvj4RnQgmpQbRt6RnOQmGi4LojOZt8phcmxsEyV/isGRfMtg
 x3Rg==
X-Gm-Message-State: AC+VfDwBzYgWCjz3ogJ2beQWe0TRae6xL92KYGl7ZNXrrhm+S2rSV6sB
 zMZfNQAmVZKCveUUxtnUyE79wq6GXULgiQ==
X-Google-Smtp-Source: ACHHUZ7L0oZpvP/sxYGy5/jli+O3tVyFSsDaBOmDeyl+UBkS9lXMKJXY5ZCB7QK5VML07xbsvEgtNQ==
X-Received: by 2002:a1f:c14e:0:b0:46e:8724:5dbb with SMTP id
 r75-20020a1fc14e000000b0046e87245dbbmr2957742vkf.2.1687281996916; 
 Tue, 20 Jun 2023 10:26:36 -0700 (PDT)
Received: from joel-Precision-7920-Tower.. ([24.53.71.1])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a0dc244000000b0056cffe97a11sm604604ywd.13.2023.06.20.10.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:26:36 -0700 (PDT)
From: Joel Upham <jupham125@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Upham <jupham125@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v1 22/23] qdev-monitor/pt: bypass root device check
Date: Tue, 20 Jun 2023 13:24:56 -0400
Message-Id: <6e4af8cf474a949609298e8536ee5f47f9017e5c.1687278381.git.jupham125@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=jupham125@gmail.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Jun 2023 15:45:55 -0400
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

On xen we need to be able to have hotpluggable root devices,
even on Q35 at the moment. Having this check disables PT of
devices, so lets turn it off for now.

Signed-off-by: Joel Upham <jupham125@gmail.com>
---
 softmmu/qdev-monitor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
index b8d2c4dadd..f57dfa1964 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
@@ -43,6 +43,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/clock.h"
 #include "hw/boards.h"
+#include "sysemu/xen.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -663,7 +664,8 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
         return NULL;
     }
 
-    if (phase_check(PHASE_MACHINE_READY) && bus && !qbus_is_hotpluggable(bus)) {
+    if (phase_check(PHASE_MACHINE_READY) && bus && !qbus_is_hotpluggable(bus)
+        && !xen_enabled()) {
         error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
         return NULL;
     }
-- 
2.34.1


