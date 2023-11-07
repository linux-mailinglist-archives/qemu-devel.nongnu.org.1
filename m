Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EB77E47E7
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:10:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QX3-0003WO-Dp; Tue, 07 Nov 2023 13:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1r0QX0-0003UM-BV
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:10:30 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1r0QWr-0002ix-2P
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:10:30 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5aa481d53e5so4080429a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699380617; x=1699985417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogYJbqlkzS2Yd8saws9Occt0F7m6RWm2l0bkCCgcR3U=;
 b=F62o9/q2Mqu8GS0dfhOZyso7RT6hASuHOCoSBfoWochdmUNnR43aULGM+0aEMMVaZP
 wVd4+lz3sLFyilY67L46o3+lYvnDCV4Sc5Et5sR/8hniMvQsup2jMGkkqPNKOOt2P5ni
 GGeZunmaCbYrtmbI3pp5BXqHrSbVtbHqNIA8ymR34U1SQ9tCT6rk4OMZC7Pz6/Xz2k89
 II/kekCTdAE8QCwcYX+mJgCgV84ZcTov7eaEM7EqUM/Sh387MPpisSEvQRmpFbg+bsg0
 nkK1GMx2+QbSMxxHO99ujFur4uY7FPIu0kFQOIDkmgtr0wbX7xnK1yyJgvZPBxJb1FCZ
 p5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380617; x=1699985417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ogYJbqlkzS2Yd8saws9Occt0F7m6RWm2l0bkCCgcR3U=;
 b=BAz1oXcxEHD5gS81mkTkOEeA/MeZQpZMja/7oaAnVCn/kUSDxD+KM/KeSG4DSMjyKF
 hyAksOwA4WqWczyxsN0fZxhUwe7yTcQyJWRxy0ccnqmLTvOrI+xnsAyiiPmRQgI9CBuS
 P256TvsOMUsMDATUTIv5sL+ioWilO7qlOMQDuXbffLbcRJafPL3bBP+I95azxbvQN8Y/
 wcB17Ny+PMNSLiY0puwxu0UZua1wI+Ww9icqULAQDosJGh+c9yuVqp8MxPlLVliFlh7C
 bllIqtYm58UwGiIi2X61/CwOGRn4vZbX4YnJMi39vktiw5K0neILkHewNhBWAEpaePPo
 WgoQ==
X-Gm-Message-State: AOJu0Yz+hqxJpG6/pW9gJE/liyz9oWHgwotsEW1l73X8biRyUKOV/11N
 bH2Wrb6FGlokIPv/3WZWU/ArrWJx6B8=
X-Google-Smtp-Source: AGHT+IFWm9kgjVGfWor3OqA8aZVUBtUhbkrx5BtmA6zSu7sqrwDUHquMPZD7UdUq5z+wxXKrUcUVUg==
X-Received: by 2002:a17:90b:4acb:b0:280:3650:382a with SMTP id
 mh11-20020a17090b4acb00b002803650382amr22482838pjb.16.1699380617158; 
 Tue, 07 Nov 2023 10:10:17 -0800 (PST)
Received: from DT.local (c-71-202-158-162.hsd1.ca.comcast.net.
 [71.202.158.162]) by smtp.gmail.com with ESMTPSA id
 az10-20020a170902a58a00b001cc615e6850sm131924plb.90.2023.11.07.10.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:10:16 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan@outlook.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v3 1/9] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field
 to output payload of identify memory device command
Date: Tue,  7 Nov 2023 10:07:05 -0800
Message-ID: <20231107180907.553451-2-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107180907.553451-1-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Fan Ni <fan.ni@samsung.com>

Based on CXL spec 3.0 Table 8-94 (Identify Memory Device Output
Payload), dynamic capacity event log size should be part of
output of the Identify command.
Add dc_event_log_size to the output payload for the host to get the info.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f1145e9671..8eceedfa87 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -21,6 +21,7 @@
 #include "sysemu/hostmem.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
+#define CXL_DC_EVENT_LOG_SIZE 8
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -753,8 +754,9 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
         uint16_t inject_poison_limit;
         uint8_t poison_caps;
         uint8_t qos_telemetry_caps;
+        uint16_t dc_event_log_size;
     } QEMU_PACKED *id;
-    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x43);
+    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x45);
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
@@ -780,6 +782,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     st24_le_p(id->poison_list_max_mer, 256);
     /* No limit - so limited by main poison record limit */
     stw_le_p(&id->inject_poison_limit, 0);
+    stw_le_p(&id->dc_event_log_size, CXL_DC_EVENT_LOG_SIZE);
 
     *len_out = sizeof(*id);
     return CXL_MBOX_SUCCESS;
-- 
2.42.0


