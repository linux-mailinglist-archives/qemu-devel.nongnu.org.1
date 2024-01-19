Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FA7832D4C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:36:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQrpx-0000mC-JL; Fri, 19 Jan 2024 11:35:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrpu-0000kZ-RJ
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:35:18 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrps-0004lz-OQ
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:35:18 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e8801221cso8759375e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 08:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705682115; x=1706286915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLWOOCsvWKB0fq6rzd5QzssHwCuxhyOKho4Poa5gytE=;
 b=fuEGenAOd7SfKoknSV1TTyD9k1olsYyvQoVkKQn5XJTLgxLOoq9fh2Jqrw/w+waI+V
 zhyrhQbkg1e6noIgk4oyTAw7dzXwqK4uRNq548ggci5yEi88S+hbC/dAInyxCXtvDiMo
 NvE87ZbzfyXJ8VUfXJVI5NqWg8CVkuFVZjuJYcGwc9Oqxy0HG1xMasZHkAAul051lcGY
 g5aZQnVA/9tTiJ3juCbG+R+/cl0buS89XiJW/f7iXxmbY9cTw7ytWfPI7Ee401UHvcZx
 J03NQA73XquWm3CrV+eSEcPK3RGAGRlLmEL0C+vKdL3If/VDRPoy2tylEEEPX8rEW0Ne
 o14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705682115; x=1706286915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wLWOOCsvWKB0fq6rzd5QzssHwCuxhyOKho4Poa5gytE=;
 b=qcGf3t6552OutJ9RW1+nTJUJS+4e4tH7yAzXw7Q1x9D42v/fwNEJ/mkDDyB30m+KhP
 aEXu8CvGMKDOwVvpXtAAHU5lqG384/78w2AmcijTw6Y0dS4sy+vsQT2fNnq/KdJpEfVD
 eqORBLz2YEYwtH06+b1IAg+HAVy4nic7UbIAExA2HvEKVEdwkDriqxS5uAo6E++lYtQ8
 XW/XAGGL++R+3jUMnki5bJ9joog3urHjyO7wxJy9mecJOBGAhaB+cSnA3UNLGeXvZWkK
 X5UnBKWI45wlvEMBoHDCobc1PzxCg5oVMlbxFlClT3wLRbhDL47w+gUfNqG6iLQWXouc
 ZvpA==
X-Gm-Message-State: AOJu0YysRnxSSiqrBEEDuNpDJQU87HtQtXs2FgMb327DdNpb8c9ix16z
 wYkWb9JLx1yqz1iXD89vCEGNa08ngd1J+fYtiI0T0rZWY+L0V0VZm6G7xhwIQrmBvARkzS0o/oB
 G
X-Google-Smtp-Source: AGHT+IHtKgrlG2Hv2zZwgK2Kh6syHi8M6MSl4Dak5M0E52IkY5T1SJ2EIVWEwzA8fj2FbqV5BpHqrA==
X-Received: by 2002:a05:600c:1c06:b0:40e:88be:4ef0 with SMTP id
 j6-20020a05600c1c0600b0040e88be4ef0mr33004wms.0.1705682115282; 
 Fri, 19 Jan 2024 08:35:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fc11-20020a05600c524b00b0040e86fbd772sm10979260wmb.38.2024.01.19.08.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:35:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] vmbus: Switch bus reset to 3-phase-reset
Date: Fri, 19 Jan 2024 16:35:09 +0000
Message-Id: <20240119163512.3810301-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119163512.3810301-1-peter.maydell@linaro.org>
References: <20240119163512.3810301-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Switch vmbus from using BusClass::reset to the Resettable interface.

This has no behavioural change, because the BusClass code to support
subclasses that use the legacy BusClass::reset will call that method
in the hold phase of 3-phase reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/hyperv/vmbus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index c86d1895bae..380239af2c7 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -2453,9 +2453,9 @@ static void vmbus_unrealize(BusState *bus)
     qemu_mutex_destroy(&vmbus->rx_queue_lock);
 }
 
-static void vmbus_reset(BusState *bus)
+static void vmbus_reset_hold(Object *obj)
 {
-    vmbus_deinit(VMBUS(bus));
+    vmbus_deinit(VMBUS(obj));
 }
 
 static char *vmbus_get_dev_path(DeviceState *dev)
@@ -2476,12 +2476,13 @@ static char *vmbus_get_fw_dev_path(DeviceState *dev)
 static void vmbus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k = BUS_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     k->get_dev_path = vmbus_get_dev_path;
     k->get_fw_dev_path = vmbus_get_fw_dev_path;
     k->realize = vmbus_realize;
     k->unrealize = vmbus_unrealize;
-    k->reset = vmbus_reset;
+    rc->phases.hold = vmbus_reset_hold;
 }
 
 static int vmbus_pre_load(void *opaque)
-- 
2.34.1


