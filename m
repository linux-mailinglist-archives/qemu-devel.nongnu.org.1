Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8683BB8A9D
	for <lists+qemu-devel@lfdr.de>; Sat, 04 Oct 2025 09:16:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wU3-00008T-9Q; Sat, 04 Oct 2025 03:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTx-0008H7-UR
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:06 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTv-00055F-5I
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:05 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e29d65728so17175645e9.3
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562098; x=1760166898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5XCoCyXCFO1hrc9SHjrdwUIKirve530sP38vJySwDjQ=;
 b=ONGbp9f35UHyDWRN7tA1iPv7vjgR2Li5ucO0Q4FvQSARRRETnD20dXLZIjb7GxNxA8
 Ip1bxx5PZtbL/gJ/cLm33GIt3IP3OMIl7Y/MDo8yMxcsUsJWj26baUyNLd134FPpbBs3
 fDgMf3vsyn0K/7PV9gpJ+hjZGwakL/Eo5NXRHlW4mopprZb3L9kzQABNq8HOlYDEFlaT
 mQiMpT80hcsc8mJ64pkKAqjQwFafi43d+aHbosXgE+nuvs85dQTfiUlC1h6wHD9P9Vva
 dXY/ozvGRRXPVghZSjFfaOa82kmbieYULZeFeImJKTjJS+aPA7WwGMN+YSXkF2rWkwjq
 gJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562098; x=1760166898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XCoCyXCFO1hrc9SHjrdwUIKirve530sP38vJySwDjQ=;
 b=UV60PZoEn3+3xsIxPB67ZnNJOCSxkOGYcu99hTRaQT3dM5pDk14mUs8HIjNTBGMTtI
 Y6ma49o58TBvpkzR+m1w30ngFDR7N8xM0f9kUUOTaOkyBjGMyib3c0XNmQUQNhDRdlM6
 DPYDgaDyoxpJ722aNTkOD8H3CkuErIeoeZZKs5hLqtABXM5eMXDPC4N2vP8cWibPs6VH
 FY86ybwa6uVLTL9DXzm+t5nh+tkvlsia7DIIwbS/n+gKnI+5NkL96QiwoNqstUuuXDA8
 rwaqQRLXPFA8Uj4iGW1icKqEowwuQJWlVjTzPPQYmzmStQZVrhSTco2c68apV8hbyaQJ
 4O0Q==
X-Gm-Message-State: AOJu0YwVuOtzF0XsoFeaWK2jZni1cjVLfDYR9V3HyDwETABjc1eNl7Qo
 WGwOgswJVkyuqLu5Os7l6rx5HqzWWUsS8l6CLcx98GTyYf9Z5qWOmfuzpoRhKJloXOXOzy5VWbR
 +1AjThKaTzQ==
X-Gm-Gg: ASbGnctE/VVwfCJqmrnU4MqNfFMQ2VOmjC3+l5eeHIDZMxB7P9/hHiGOAgHBTISSt7a
 JLb86RL1AYGw3wbUMyjSF5WLu0LphcwhC6TsAwhLyE62zMl3u4tBJZ1mJwnRMgutfSvFpONL1IV
 V/c8wAVOSCOELjiQlwAMpHeLyXfY/CrL95EKljNu51a28tmnP/xz9Itn13MvqSUbxxGO8warSOW
 sw5a02Z0q1FukvNbrWesoglhZ8qIN6Gd/U2IXY9vYBFcs8OJg4lUFGnPAaY7ej2OVurpCSO6Oid
 QuRep8saj8C5zCiyEATQ8BFn0fPRBXuclZGvCWTni62/rTFzCWsXgMTiD5bavGiB5HvNFDKtyDz
 Fn+Nm4IBMvK5aWBYBYo685RJubfIZ/d0zHXV5GRrT2pinSyfFvtSjVOP5YAOreZFqB9ug9TR9r9
 zeVNye+auG7ZYOVkDq04wyCueb
X-Google-Smtp-Source: AGHT+IHc4J+eHDDk7kYi1SmczNUbzXW7s5NIOQv46PjZ3v3qaV/X5Ec6jyNwvjtB80Kk9m4vpKtcRA==
X-Received: by 2002:a05:600c:34cd:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-46e711640f9mr33512995e9.19.1759562098412; 
 Sat, 04 Oct 2025 00:14:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7234e58asm60490235e9.7.2025.10.04.00.14.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:14:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/41] hw/virtio/virtio: Replace legacy
 cpu_physical_memory_map() call
Date: Sat,  4 Oct 2025 09:12:49 +0200
Message-ID: <20251004071307.37521-24-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Propagate VirtIODevice::dma_as to virtqueue_undo_map_desc()
in order to replace the legacy cpu_physical_memory_unmap()
call by address_space_unmap().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251002084203.63899-18-philmd@linaro.org>
---
 hw/virtio/virtio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9a81ad912e0..1ed3aa6abab 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -31,6 +31,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
 #include "system/dma.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "virtio-qmp.h"
 
@@ -1622,7 +1623,8 @@ out:
  * virtqueue_unmap_sg() can't be used).  Assumes buffers weren't written to
  * yet.
  */
-static void virtqueue_undo_map_desc(unsigned int out_num, unsigned int in_num,
+static void virtqueue_undo_map_desc(AddressSpace *as,
+                                    unsigned int out_num, unsigned int in_num,
                                     struct iovec *iov)
 {
     unsigned int i;
@@ -1630,7 +1632,7 @@ static void virtqueue_undo_map_desc(unsigned int out_num, unsigned int in_num,
     for (i = 0; i < out_num + in_num; i++) {
         int is_write = i >= out_num;
 
-        cpu_physical_memory_unmap(iov->iov_base, iov->iov_len, is_write, 0);
+        address_space_unmap(as, iov->iov_base, iov->iov_len, is_write, 0);
         iov++;
     }
 }
@@ -1832,7 +1834,7 @@ done:
     return elem;
 
 err_undo_map:
-    virtqueue_undo_map_desc(out_num, in_num, iov);
+    virtqueue_undo_map_desc(vdev->dma_as, out_num, in_num, iov);
     goto done;
 }
 
@@ -1982,7 +1984,7 @@ done:
     return elem;
 
 err_undo_map:
-    virtqueue_undo_map_desc(out_num, in_num, iov);
+    virtqueue_undo_map_desc(vdev->dma_as, out_num, in_num, iov);
     goto done;
 }
 
-- 
2.51.0


