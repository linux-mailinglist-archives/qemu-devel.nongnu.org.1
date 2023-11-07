Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F11727E47F3
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:12:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QXK-0004gN-Gu; Tue, 07 Nov 2023 13:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1r0QXI-0004e6-0P
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:10:48 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1r0QWs-0002jk-IT
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:10:47 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc0e78ec92so40281875ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699380620; x=1699985420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cIc7H0VDI7Su5JGUvQgueNQKhCP3W7elx90e94K+TnQ=;
 b=fvcr7i3Kkh4dEJmCJH+Ly8RhBOAJ+a83YOxm+frHUR6tlb0F2FSKubnFni8beDXK6J
 IgHEj+BnbLNjoMrYwhYlDTNvJpaOR1SLUAVkQnnWJaZ+rv1G47j6dURSXc3G64Zetl7m
 TsBmx6K5Y1QXLfUZlDTOQNLxEIuI0VB37McythsP4O0H8pgKj6d0/mcxhHQaqOtJxFj/
 6vQWKTMlQdiEHWiqPKJYd5BNQu5fcXzi+RH+AGhYjo7YyB3pffuYcUCqS84USEIfevMt
 6CWRKn+lSHfD59rpczEBAE4EXz4z4yqRFZSlpG1h0RgS3H/i9s+3o8qpzHXw58JKshJd
 d7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380620; x=1699985420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cIc7H0VDI7Su5JGUvQgueNQKhCP3W7elx90e94K+TnQ=;
 b=aR/Zf7NNZS7eOB2x+W9Cr3rvtrFPeb0P32bzac7O7uHXCKIxSmAdi/cticArgKJqzv
 HPP0fzc+RxZY0GdB/ueqU2U4YJSHvhbYE2df3DXC4Ld1DBIyO5mU0yd3fxYY4TJGkOX9
 3h/D4MQFFQqs9s9pD6rfOLQYBXg4UuryH65wxuhIf4mO6E9aWJUDNqbq7i+NEapyBUe7
 7PKza/jMHNxoyM3TUVCZWBrt/FFt+Bq5erV91GDgkOY1hPJb8t5VwVhDEIEl/kRIe+Nh
 wApQYnLnXWCKUqM53CrHjHPtFFxwsn50Yduzmsw5/t0Jx2xaf6A/tbEymML3GwewVIT6
 5vYQ==
X-Gm-Message-State: AOJu0YyZn7v2ccpuWJvz4Gwo1Abg8epWd+24oWDMSaZVk1j1K6rRARlb
 DIYN0K+yAuw0+pvrzJ7fdaQMT86sSz4=
X-Google-Smtp-Source: AGHT+IHGNH7ZWpcEDNR+g0tlYCx5gQyhkoR95XBku5YzVtfRDOD5hxW6GKGgVBtcG5+1BC6GyRPz2w==
X-Received: by 2002:a17:902:a418:b0:1cc:2eda:bde6 with SMTP id
 p24-20020a170902a41800b001cc2edabde6mr26518551plq.34.1699380619857; 
 Tue, 07 Nov 2023 10:10:19 -0800 (PST)
Received: from DT.local (c-71-202-158-162.hsd1.ca.comcast.net.
 [71.202.158.162]) by smtp.gmail.com with ESMTPSA id
 az10-20020a170902a58a00b001cc615e6850sm131924plb.90.2023.11.07.10.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:10:19 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan@outlook.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v3 4/9] hw/mem/cxl_type3: Add support to create DC regions to
 type3 memory devices
Date: Tue,  7 Nov 2023 10:07:08 -0800
Message-ID: <20231107180907.553451-5-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107180907.553451-1-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

With the change, when setting up memory for type3 memory device, we can
create DC regions.
A property 'num-dc-regions' is added to ct3_props to allow users to pass the
number of DC regions to create. To make it easier, other region parameters
like region base, length, and block size are hard coded. If needed,
these parameters can be added easily.

With the change, we can create DC regions with proper kernel side
support as below:

region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
echo 1 > /sys/bus/cxl/devices/$region/interleave_ways

echo "dc0" >/sys/bus/cxl/devices/decoder2.0/mode
echo 0x40000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size

echo 0x40000000 > /sys/bus/cxl/devices/$region/size
echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
echo 1 > /sys/bus/cxl/devices/$region/commit
echo $region > /sys/bus/cxl/drivers/cxl_region/bind

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 754c885cd1..2d67d2015c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -721,6 +721,36 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
     }
 }
 
+static int cxl_create_dc_regions(CXLType3Dev *ct3d)
+{
+    int i;
+    uint64_t region_base = 0;
+    uint64_t region_len =  2 * GiB;
+    uint64_t decode_len = 8; /* 8*256MB */
+    uint64_t blk_size = 2 * MiB;
+    CXLDCDRegion *region;
+
+    if (ct3d->hostvmem) {
+        region_base += ct3d->hostvmem->size;
+    }
+    if (ct3d->hostpmem) {
+        region_base += ct3d->hostpmem->size;
+    }
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        region->base = region_base;
+        region->decode_len = decode_len;
+        region->len = region_len;
+        region->block_size = blk_size;
+        /* dsmad_handle is set when creating cdat table entries */
+        region->flags = 0;
+
+        region_base += region->len;
+    }
+
+    return 0;
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
@@ -789,6 +819,10 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
+    if (cxl_create_dc_regions(ct3d)) {
+        return false;
+    }
+
     return true;
 }
 
@@ -1108,6 +1142,7 @@ static Property ct3_props[] = {
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
+    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.42.0


