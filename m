Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E84373754C
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:48:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhIg-0008Q2-F2; Tue, 20 Jun 2023 15:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7W-0004FT-2x
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:23 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7T-0006aw-6P
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:21 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5700401acbeso54068037b3.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687281965; x=1689873965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3GTOAuLDI6z5fvZex997bGzelIPl4ILau8aUNmxQkdY=;
 b=Qfba2NKb2ruKW0Nvf9HoTbktsp4p6+WiUaaNb6VqV1LZvNUFhieWQw/TX/GksKBkq4
 U+5q9yPcsjcZfV72yP7YfC5rIkXNK+qi5oXRL5ZU3h/QlP6koE0NZQHfiN1jGM7GIMwT
 V/bUq0T5gnTB/4CTVTuKu+zcPkkUR9p2MCy/iOWeZQ/zCkyXzJ0epm0L6SomaldAseMl
 G0z0blKuIUC06PT+8VtR3QJxBncMzFauacbh7njThlPUC+mpCx7Hv6v1VcsJIfyp9+i+
 qF1iktSOyyc4f6lDxIynUDIMOzkKb0D2E5cAkHDwnlKysxybWHWqSwcRfYnctNLa2VM6
 zXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687281965; x=1689873965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3GTOAuLDI6z5fvZex997bGzelIPl4ILau8aUNmxQkdY=;
 b=hV3WTBSoJohCh0qqPwmTdzxT11WFwed5AvfH94RQroZWTCgmmxrysXW0iDl3vemu4v
 TZpZpTij/ksBMhqKxfVXxjyqjONQdUc5rq6xDNpPl1NgHQRFE8N04z0OoMgaUprmM53l
 9+m3fwiItOg6LpHhmlEKrCwFJ79HTXEyc9kNGz+hxubkBqNcB+NPS/VimUewEhp+ekdq
 D5MeIqemTfFXGjHmEmipmKGpkUdr9AAog15Jon/YyTfdQoYLjLFTZhoFCTd5TSS5EuIf
 uUahFaKmUC8j56wamWg7IpD0H+j4j2MbnkWWsiFKKaG1nXPOpOZbHcVrswMWNLZsA7Av
 nEbQ==
X-Gm-Message-State: AC+VfDwP7RvFzBfT8EJXk8TJI5CIUSxk5UzaUfSnl0B6t25xb7F5OD6G
 UhMgWJzUs1w0GL1AhMuYJzvYor+xYCHI3g==
X-Google-Smtp-Source: ACHHUZ60GDUOgJdR5m8p6l5F34V+KX6uqQfN+fNym/QqisFgTLmNDJvZHpDJ6EEre2y2X0RMurRVWA==
X-Received: by 2002:a0d:f446:0:b0:56c:e52d:2886 with SMTP id
 d67-20020a0df446000000b0056ce52d2886mr12502688ywf.29.1687281965183; 
 Tue, 20 Jun 2023 10:26:05 -0700 (PDT)
Received: from joel-Precision-7920-Tower.. ([24.53.71.1])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a0dc244000000b0056cffe97a11sm604604ywd.13.2023.06.20.10.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:26:04 -0700 (PDT)
From: Joel Upham <jupham125@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Upham <jupham125@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v1 05/23] q35: Fix incorrect values for PCIEXBAR masks
Date: Tue, 20 Jun 2023 13:24:39 -0400
Message-Id: <8e756802c5ffd314051fe8be79c021a387ae0158.1687278381.git.jupham125@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=jupham125@gmail.com; helo=mail-yw1-x112d.google.com
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

There are two small issues in PCIEXBAR address mask handling:
- wrong bit positions for address mask bits (see PCIEXBAR description
  in Q35 datasheet)
- incorrect usage of 64ADR_MASK

Due to this, attempting to write a valid PCIEXBAR address may cause it to
shift to another address, causing memory layout corruption where emulated
MMIO regions may overlap real (passed through) MMIO ranges. Fix this
by providing correct values.

I included the xen_enabled() check as I did not want to impact current
use cases that are not xen related (if they are not seeing a problem).

Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
Signed-off-by: Joel Upham <jupham125@gmail.com>
---
 hw/pci-host/q35.c         | 16 +++++++++++++---
 include/hw/pci-host/q35.h |  4 ++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index fe5fc0f47c..1fe4e5a5c9 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -37,6 +37,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
+#include "sysemu/xen.h"
 
 /****************************************************************************
  * Q35 host
@@ -324,12 +325,21 @@ static void mch_update_pciexbar(MCHPCIState *mch)
         break;
     case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_128M:
         length = 128 * 1024 * 1024;
-        addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK |
-            MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
+	if (!xen_enabled()) {
+            addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK |
+                MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
+	} else {
+            addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK;
+        }
         break;
     case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_64M:
         length = 64 * 1024 * 1024;
-        addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
+	if (!xen_enabled()) {
+            addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
+	} else {
+            addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK |
+                MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK;
+        }
         break;
     case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_RVD:
         qemu_log_mask(LOG_GUEST_ERROR, "Q35: Reserved PCIEXBAR LENGTH\n");
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index e89329c51e..441cce6ccd 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -105,8 +105,8 @@ struct Q35PCIHost {
 #define MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT       0xb0000000
 #define MCH_HOST_BRIDGE_PCIEXBAR_MAX           (0x10000000) /* 256M */
 #define MCH_HOST_BRIDGE_PCIEXBAR_ADMSK         Q35_MASK(64, 35, 28)
-#define MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK      ((uint64_t)(1 << 26))
-#define MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK       ((uint64_t)(1 << 25))
+#define MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK      ((uint64_t)(1 << 27))
+#define MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK       ((uint64_t)(1 << 26))
 #define MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_MASK   ((uint64_t)(0x3 << 1))
 #define MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_256M   ((uint64_t)(0x0 << 1))
 #define MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_128M   ((uint64_t)(0x1 << 1))
-- 
2.34.1


