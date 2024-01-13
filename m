Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9843482C8BD
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 02:29:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOSpB-0006A7-HS; Fri, 12 Jan 2024 20:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <masscry@gmail.com>) id 1rOSp6-00069a-1t
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 20:28:32 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <masscry@gmail.com>) id 1rOSp4-0007bG-Dl
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 20:28:31 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50e7e55c0f6so8574277e87.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 17:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705109308; x=1705714108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwDL3ncThkJ8lqlwFLwDxgUkxyiHEPohNrjP4DVlXY8=;
 b=bhU1ejoPq/MkXGLpV0965mH1HFMEnfUmDJVWYDcE1W0lcgGu0DgtIvXW+Ld+HM5jye
 FHgfLNyxKInI4h1Rf/9denUDtqQ6isEgl45USr/ijt42KK95gLmz1hBKuygzYmfIAita
 ujaBYaKCth5PCwWFWM5O5Yzzx6KDkZKCGx5Citu3+iDgkLnomfbdMblvBMY4fmIG29vg
 oRViJBGi4qxHYHdMG6KAAq+KulrskkIpJKiRgV2VH0Do7z+xX/JRPbFGEFknfo2n3VHn
 D1//u5C6lygcPI1EAWXACreevIM6fTlgxxIoHJznwiQvTS9KdF3TLRk0B3GHHN4abHUz
 /0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705109308; x=1705714108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OwDL3ncThkJ8lqlwFLwDxgUkxyiHEPohNrjP4DVlXY8=;
 b=W2XD5fF26SFsHrWz4bwVYSqFt8f572m0RJmd+LH/xV8yqr7A2S0qLsXlMALretw2rQ
 BDxjvAMQ0RhqbWVM9heZBcSeH+xhat0fwztvY3WCy0YStXFDtN5pq4VwK8X16Ap8Sm7l
 14xgHKjA5hHB3Xl1MrSRbB+kS9Ivo/BZ+yEXUDdkVjXcw26xNgDTQ3qDvr8e6Gxj5ABA
 v2BgLhOxWm/hFsL7RKn1vPhS80so4x315iJK5TkDLa0LzWLfyMERamfG7eNdKARUoV0p
 bC+oEyHiT7hTrxInQGlBo0fjE2y3XwRjWXYXdrX/9svLQy1TmOPIrfBxFGOeO960YxPt
 tN5Q==
X-Gm-Message-State: AOJu0YwqZ8yijl3RGozFIYG57O3teBwq2/1LCpUcoP7udiQkKpkIyR2w
 nrlOyUtfhzVLid3P9GHKVAEwl5wp0FMxzfIzYGw=
X-Google-Smtp-Source: AGHT+IFoJArofEi2TKw2mXCujhJY2t1XINC//jMpkFAQIOUeMmAYOdp76qvrLUzupaQLILyH6QM8RA==
X-Received: by 2002:ac2:5a01:0:b0:50e:7736:a96c with SMTP id
 q1-20020ac25a01000000b0050e7736a96cmr442441lfn.172.1705109308374; 
 Fri, 12 Jan 2024 17:28:28 -0800 (PST)
Received: from pc7.local (95-24-165-64.broadband.corbina.ru. [95.24.165.64])
 by smtp.gmail.com with ESMTPSA id
 d2-20020ac24c82000000b0050eab0f6a59sm669871lfl.84.2024.01.12.17.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 17:28:28 -0800 (PST)
From: Temir Zharaspayev <masscry@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Xie Yongji <xieyongji@bytedance.com>, Temir Zharaspayev <masscry@gmail.com>
Subject: [PATCH 2/2] libvduse: Fix pointer arithmetic in indirect read
Date: Sat, 13 Jan 2024 04:27:41 +0300
Message-Id: <20240113012741.54664-3-masscry@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240113012741.54664-1-masscry@gmail.com>
References: <20240113012741.54664-1-masscry@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=masscry@gmail.com; helo=mail-lf1-x135.google.com
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

When zero-copy usage of indirect descriptors buffer table isn't
possible, library gather scattered memory chunks in a local copy.
This commit fixes the issue with pointer arithmetic for the local copy
buffer.

Signed-off-by: Temir Zharaspayev <masscry@gmail.com>
---
 subprojects/libvduse/libvduse.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/subprojects/libvduse/libvduse.c b/subprojects/libvduse/libvduse.c
index 21ffbb5b8d..0b445fbc76 100644
--- a/subprojects/libvduse/libvduse.c
+++ b/subprojects/libvduse/libvduse.c
@@ -465,7 +465,7 @@ static int
 vduse_queue_read_indirect_desc(VduseDev *dev, struct vring_desc *desc,
                                uint64_t addr, size_t len)
 {
-    struct vring_desc *ori_desc;
+    uint8_t *src_cursor, *dst_cursor;
     uint64_t read_len;
 
     if (len > (VIRTQUEUE_MAX_SIZE * sizeof(struct vring_desc))) {
@@ -476,17 +476,18 @@ vduse_queue_read_indirect_desc(VduseDev *dev, struct vring_desc *desc,
         return -1;
     }
 
+    dst_cursor = (uint8_t *) desc;
     while (len) {
         read_len = len;
-        ori_desc = iova_to_va(dev, &read_len, addr);
-        if (!ori_desc) {
+        src_cursor = iova_to_va(dev, &read_len, addr);
+        if (!src_cursor) {
             return -1;
         }
 
-        memcpy(desc, ori_desc, read_len);
+        memcpy(dst_cursor, src_cursor, read_len);
         len -= read_len;
         addr += read_len;
-        desc += read_len;
+        dst_cursor += read_len;
     }
 
     return 0;
-- 
2.34.1


