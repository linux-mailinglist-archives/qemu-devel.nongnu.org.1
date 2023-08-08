Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D6D773B91
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:52:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTP0G-0000gM-3t; Tue, 08 Aug 2023 11:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qTP0D-0000fu-L1
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:52:09 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qTP0C-00035S-8i
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:52:09 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4476a9e8812so2402655137.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691509927; x=1692114727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KyBKpY1sWkkjVeGiFnRVCoxm8adBYs+Vcpu4+GQwtPA=;
 b=DYurZkNXJyWHQ1uYfj/W1PbwEg267l6S1TEmtx4M0EEDGDYloedHB0MgAeyCEw8s0x
 UrNQYh2G2I35paRdO35Pa5wuTaQvIPKzJ7rYztuheLj8iShJQ2V4ZJI+lYxQc65u2pxo
 rDNMCDqbVg11rHH4JpB/mLOlkH7SwzJTgeuX9oOeo0IbEFBrdXrGQxlLVxJFOhdJqAGd
 MBS1Pc6rGliMu15Z1s28jOs0rHeJ4Y/1WaZSF2+mv+YSU2oHE4jFbWYueV5pZVyAG3wl
 4dNUCI8zemiGFnRF7SZVM5jlmJP13zN/XsfWqtlrMueIVQkuqwA51VKR6g7O1ySlD9AU
 ulnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691509927; x=1692114727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KyBKpY1sWkkjVeGiFnRVCoxm8adBYs+Vcpu4+GQwtPA=;
 b=ENPcCBQocmH6UdZcxacUxkW/MVQ3weRBy4OjvgFO9ekZD3dIAWm5Xbsv9Isb5ht1wa
 rjhA5xM93h9DAehUrNh6LPOcu3TVn+kzHnPUtTDrb4CowV5T8xBmgof7JHJ7NjqOy0m5
 7I5jsOBfbavHjOAYkVNRIvnIl414vTVx7eAeCDBIADNifeEkC7nu/CGiXg3x43vfVc/n
 qyLiLKXKoZrLhHjDDeygc36IxTWefrXAJmVzGDtfVG9kpPtpwPET/bmL+cXeAWuMF30Q
 cVKQuK4FguoZshu9kzj1pSKixeY6uYi65WDBgkbHzqKbTTuQxHMqYmmY6K0Jg66dZLwx
 3A3g==
X-Gm-Message-State: AOJu0YyCH9a64orR4Dc5PjOjxCpQ1cPeFjjzoRTyAofwQBSZQuNsqgv1
 baQK7EzrYRaff4W5ATEA7Z60FXvb/GJ/8fSVcfCqGA==
X-Google-Smtp-Source: AGHT+IGZwsrAGVGgWu3UDtJ6XPiAu2yLmWXLbUUaRzYnYbU5ru5lgs4PR3QDOgfvU8aIQtLmVxTaMQ==
X-Received: by 2002:a67:de06:0:b0:447:46e7:1343 with SMTP id
 q6-20020a67de06000000b0044746e71343mr207986vsk.23.1691509927254; 
 Tue, 08 Aug 2023 08:52:07 -0700 (PDT)
Received: from localhost.localdomain ([146.70.187.10])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a67ca11000000b004409e21cf23sm2013324vsk.6.2023.08.08.08.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 08:52:06 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org, hchkuo@avery-design.com.tw, cbrowy@avery-design.com
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC v1 3/3] hw: nvme: ctrl: Process SPDM requests
Date: Tue,  8 Aug 2023 11:51:24 -0400
Message-ID: <fea8ec3096bd72a651d6f1d353e5d54d0bd61c5c.1691509717.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691509717.git.alistair.francis@wdc.com>
References: <cover.1691509717.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/nvme/ctrl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index ec3d5d3c29..a299dc7175 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -206,6 +206,11 @@
 #include "hw/pci/pcie_sriov.h"
 #include "migration/vmstate.h"
 
+#ifdef CONFIG_LIBSPDM
+#include "library/spdm_common_lib.h"
+#include "library/spdm_responder_lib.h"
+#endif
+
 #include "nvme.h"
 #include "dif.h"
 #include "trace.h"
@@ -8092,6 +8097,16 @@ static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
 #ifdef CONFIG_LIBSPDM
 static bool nvme_doe_spdm_rsp(DOECap *doe_cap)
 {
+    void *context = (void *)malloc(libspdm_get_context_size());
+    uint32_t *session_id;
+    bool is_app_message;
+
+    libspdm_init_context(context);
+
+    libspdm_process_request(context, &session_id, &is_app_message,
+                            doe_cap->write_mbox_len,
+                            doe_cap->write_mbox);
+
     return false;
 }
 #endif
-- 
2.41.0


