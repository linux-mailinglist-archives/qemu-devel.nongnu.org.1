Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 170E07F9E0E
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 12:00:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ZKI-0003ln-Tn; Mon, 27 Nov 2023 05:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1r7ZKB-0003l9-TE
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 05:58:48 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1r7ZK8-00066N-NG
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 05:58:46 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6cd89f2af9dso928471b3a.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 02:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701082723; x=1701687523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LhYJOjXiM4Bj7KpsRd+A9qv7CrsEwzIsriCSWgcNzJc=;
 b=My2fX9ClIREDAqEJBZTUm+0jLv/YLLg3aaVug/4o1AVdSCXJZTMS3u7AWXVi8v6MPy
 rB5G5PvN8bvO6AxqMDFuG+9NjLoTiNzoPmv3btoqFSjdlAMkMKtKB0IkJ6i7NfC3e3G7
 cNhkyXUdpBtYYYCFUuGkqmJkySskxzjFWDhdEGh+TPTXh1/avk/49NtDnTKnsWajJ5ol
 GiGGjQvMqPB4TrpY6RUMuzsRW133WEgpL1/JCU8tUEk9Olx+yT7XJOBBbVLUo/y19C0G
 yTrr6BQqGzFQ3GDpVZt9MgLUNQP5jkajbnFykWNe6joeg/nMq/kNcmaaMFdp3EQBNmSG
 Hmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701082723; x=1701687523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LhYJOjXiM4Bj7KpsRd+A9qv7CrsEwzIsriCSWgcNzJc=;
 b=OIfSbxxRbhqTyqv0fUhoI5/9mAGLbyYvPgHEv+pa1V9M8/momnPqVqC/S3yf2m7d8i
 Hx+N8GoBvowEv/D7AxrKTZLvJfpp/pggMHlKh5H1lX8Ju/iyrOrfHtTMTf6o2AzyppbC
 17nlZQmPJIbJbCeee2SxLoe2FB+pq9dH0QoIDKoerVmgAaYYkjzMEKAhDCKUHgCB038u
 /aID8lQIZwr/VUEp39Wy+i/sJRjx3BzS02gNfNpFFaVdrusu6PqvlJ1NQa1py0mUx1Be
 XvlObZlCuxVMPGmyRi0I+w3gZnPNMO7G/LN9gE+3U3+KszFPIdIvCMv6XjH3Y/dZ1OEa
 ljNg==
X-Gm-Message-State: AOJu0YyhsG2/S5KbFCjwuLopXcs5UNsYPh/p5tSw2S59oCjloeA6qUv3
 Rw7QzSzQ4zQSxW2yYp4rTws=
X-Google-Smtp-Source: AGHT+IEZ+MwgU+VJjGDw3ojZ0RNPwD1DqexbUg9l57CLuDVl/j0HWa2VEjfzqfGtifj7lrGBzHcLqg==
X-Received: by 2002:a05:6a21:99a6:b0:18c:63cb:e86e with SMTP id
 ve38-20020a056a2199a600b0018c63cbe86emr7787487pzb.2.1701082723006; 
 Mon, 27 Nov 2023 02:58:43 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
 by smtp.gmail.com with ESMTPSA id
 mp21-20020a17090b191500b002801ca4fad2sm7508351pjb.10.2023.11.27.02.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 02:58:42 -0800 (PST)
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: linux-cxl@lore.kernel.org, qemu-devel@nongnu.org,
 Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH v1 1/2] hw/cxl/device: read from register values in
 mdev_reg_read()
Date: Mon, 27 Nov 2023 19:58:29 +0900
Message-Id: <20231127105830.2104954-2-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231127105830.2104954-1-42.hyeyoo@gmail.com>
References: <20231127105830.2104954-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=42.hyeyoo@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=1, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

In the current mdev_reg_read() implementation, it consistently returns
that the Media Status is Ready (01b). This was fine until commit
25a52959f99d ("hw/cxl: Add support for device sanitation") because the
media was presumed to be ready.

However, as per the CXL 3.0 spec "8.2.9.8.5.1 Sanitize (Opcode 4400h)",
during sanitation, the Media State should be set to Disabled (11b). The
mentioned commit correctly sets it to Disabled, but mdev_reg_read()
still returns Media Status as Ready.

To address this, update mdev_reg_read() to read register values instead
of returning dummy values.

Fixes: commit 25a52959f99d ("hw/cxl: Add support for device sanitation")
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 hw/cxl/cxl-device-utils.c   | 17 +++++++++++------
 include/hw/cxl/cxl_device.h |  4 +++-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 61a3c4dc2e..f1111eb20f 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -229,12 +229,9 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
 
 static uint64_t mdev_reg_read(void *opaque, hwaddr offset, unsigned size)
 {
-    uint64_t retval = 0;
-
-    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
-    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MBOX_READY, 1);
+    CXLDeviceState *cxl_dstate = opaque;
 
-    return retval;
+    return cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
 }
 
 static void ro_reg_write(void *opaque, hwaddr offset, uint64_t value,
@@ -371,7 +368,15 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
     cxl_dstate->mbox_msi_n = msi_n;
 }
 
-static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
+static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
+{
+    uint64_t memdev_status_reg;
+
+    memdev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
+    memdev_status_reg = FIELD_DP64(memdev_status_reg, CXL_MEM_DEV_STS,
+                                   MBOX_READY, 1);
+    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = memdev_status_reg;
+}
 
 void cxl_device_register_init_t3(CXLType3Dev *ct3d)
 {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index befb5f884b..873e6d6ab1 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -353,7 +353,9 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
 {
     uint64_t dev_status_reg;
 
-    dev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
+    dev_status_reg = cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
+    dev_status_reg = FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS,
+                                val);
     cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;
 }
 #define cxl_dev_disable_media(cxlds)                    \
-- 
2.39.1


