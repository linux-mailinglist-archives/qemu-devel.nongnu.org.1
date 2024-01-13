Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A920C82C8BF
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 02:29:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOSp8-00069k-Ok; Fri, 12 Jan 2024 20:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <masscry@gmail.com>) id 1rOSp3-00069S-Vb
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 20:28:30 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <masscry@gmail.com>) id 1rOSp2-0007aN-CB
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 20:28:29 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50e5a9bcec9so8650980e87.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 17:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705109306; x=1705714106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ryL8zYr1fmCshYf9TkhZqXBOwBlQnctnbRgGcnkpfDk=;
 b=J83fuP7oyfSdGh+4n727Lfo8hJ4e+gVqN6uaKXZ8kObQpzFwetpbf4TPFU8kw7yuSs
 ubKeSeV3CjKrC5ita9JS+zdoCzykxFFdF8qnfif7+YRQqLlCfU9+sKsaqi4iPI4EXMTG
 XfLwfcQoH48gQHv7LAYpv7ew/HBvbw/xXAEt/UnO7KBcpDx8e6S2FBQLw+bUTAL9aC/r
 gggerM6Otsqd26jY4qP9Iu2kF4dU7dairN+XH6bGgypMDPDfUVZDFlIVI9Nd8uGxzim1
 enr/93Ay1fmxnudS/VskcXNjrWB8jC0arTnc5fG0o1m6CqpUWQ4c7SZALJpHiBjjA8Ya
 nchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705109306; x=1705714106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ryL8zYr1fmCshYf9TkhZqXBOwBlQnctnbRgGcnkpfDk=;
 b=aszGf49b8qB9WcDiEl01NvsA3ixgWYNnPx5AnLe96xW+29s0BAdmx3o+RSHbJFUoL9
 t6/Foi0ModHvCQI1uK0HcWcNBJBn6H6rtayDQjLtbuHeIn+xIEyKxJEeUbkrLMstO2Ct
 g6NPNC21hY/5kSqZje2oFkyQs340CX41jTX0zLywugpr8neDbVop1aCOGywEHBThCdAf
 ElugdUFjrfTIfiwWiekttwBjraIWZQ+vdZsDDKw+gK+o4F5vR3FOPl8oOUS0WEmHCZtU
 FgvbkubTMltZ4UFe6zcE6bLC74mA1cEt1X94rCemlkAAqeyZXx9ZQ6pJSSv49T29m2gP
 fmAA==
X-Gm-Message-State: AOJu0YzMR/75EK8mIjCFaCiHkdstELNH5EwX+nXvAqF9VOVJ7+Xg+z2m
 6KIysLWAwqb3q/epSwisH+FovpZhvDV5Escklug=
X-Google-Smtp-Source: AGHT+IGjd/ridfkC3uIDr4GYRSOEwrf56vXQf/kJcPoIYoLfE/OaZGZhjYjEAN6MlGZrmD/xgbP5VA==
X-Received: by 2002:a05:6512:3c3:b0:50e:50ee:f378 with SMTP id
 w3-20020a05651203c300b0050e50eef378mr1028351lfp.65.1705109306035; 
 Fri, 12 Jan 2024 17:28:26 -0800 (PST)
Received: from pc7.local (95-24-165-64.broadband.corbina.ru. [95.24.165.64])
 by smtp.gmail.com with ESMTPSA id
 d2-20020ac24c82000000b0050eab0f6a59sm669871lfl.84.2024.01.12.17.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 17:28:25 -0800 (PST)
From: Temir Zharaspayev <masscry@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Xie Yongji <xieyongji@bytedance.com>, Temir Zharaspayev <masscry@gmail.com>
Subject: [PATCH 1/2] libvhost-user: Fix pointer arithmetic in indirect read
Date: Sat, 13 Jan 2024 04:27:40 +0300
Message-Id: <20240113012741.54664-2-masscry@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240113012741.54664-1-masscry@gmail.com>
References: <20240113012741.54664-1-masscry@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=masscry@gmail.com; helo=mail-lf1-x130.google.com
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
 subprojects/libvhost-user/libvhost-user.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 6684057370..e952c098a3 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -2307,7 +2307,7 @@ static int
 virtqueue_read_indirect_desc(VuDev *dev, struct vring_desc *desc,
                              uint64_t addr, size_t len)
 {
-    struct vring_desc *ori_desc;
+    uint8_t *src_cursor, *dst_cursor;
     uint64_t read_len;
 
     if (len > (VIRTQUEUE_MAX_SIZE * sizeof(struct vring_desc))) {
@@ -2318,17 +2318,18 @@ virtqueue_read_indirect_desc(VuDev *dev, struct vring_desc *desc,
         return -1;
     }
 
+    dst_cursor = (uint8_t *) desc;
     while (len) {
         read_len = len;
-        ori_desc = vu_gpa_to_va(dev, &read_len, addr);
-        if (!ori_desc) {
+        src_cursor = vu_gpa_to_va(dev, &read_len, addr);
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


