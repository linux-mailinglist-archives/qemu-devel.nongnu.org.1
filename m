Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 696DF825739
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:54:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmRZ-0006FX-NF; Fri, 05 Jan 2024 10:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmQi-0000Zw-Vf
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:48:19 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmQh-0005BX-Ag
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:48:16 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40d8902da73so12874145e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469694; x=1705074494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6o3ekhlfh/+CPANGecFeiASb4d6bBwdSECTd289TNhk=;
 b=DQ2QHVerxwTlhr1DqwDw79ObknnhCQxFTaaeZuBVVYMFATrYKkTM5ov94YvUVSbC+s
 r4OfWgetYJCN0rvRqkwXfpB/GFKjRN2PpVDvO3Jw7lACaRBlcJvahrqNexRnJ4fCcmVy
 hE6I99OAkXqylZ4Wyuma5VSqAD9t/bQOeOv/6vBLFQeNoIiaPXxFMphm6Bg4ZO3MOPy8
 v0gjaVImO96C8xzzUgDHWzZBCZmEdqwgCorsKJ/pDYBQekiuUNtAC2AyqQMS9u84LXtG
 7iG6x7g5lESq20caGsdyR4vvdThmeVmraLFKbGkImHhVuar87CANvafTDSgegrtmJTHH
 cdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469694; x=1705074494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6o3ekhlfh/+CPANGecFeiASb4d6bBwdSECTd289TNhk=;
 b=gA9hq1PfHfKPD3sjfNd/a1HuOP91EGiGIvebT2F93n4rD0AsRkblRY8c8C1y99Y2Nu
 FE1f/WPM9y6Ker7AEz4JsqWySOy/F+PxVdJhKCbHt7jaWA+VvmxKxdVHJYy0OsMpATek
 FBtGmQcK7BXMoGWnW+Z+hfplQX+hMvlNmDh874xLSVzKJML+D0WSvEumVR8GT6+DB4K/
 5ObVcDATkc81u7g+e3PNxUbXDL+iRZ4l/6Qoze7h/6YSsyWUK9NnIZdmHnHlsWQWui0X
 seqcGjyzjqHTEM+w27nmfSz5qSJ+sEcSFa1JgZ9SDFdxsKzL5eeyUItZMmNrg0I+Otyr
 +aJA==
X-Gm-Message-State: AOJu0Yz5F9Ii+tLBxYBUud1rJY2RGobrYO9E05GT62vu7Df+x3RwgCm9
 BA8sx/G4LBjfBQzGeiUX6lScB4HdedUzqRBpOZ2SJsrg4T0=
X-Google-Smtp-Source: AGHT+IEVGT+tdyoug5yxzjTjKQjcUaDiSAs47WQNs2RTCBbWWg2OgCTyf3aQofocalOeLeGM2MPLjg==
X-Received: by 2002:a05:600c:4f51:b0:40e:3a6f:9b1e with SMTP id
 m17-20020a05600c4f5100b0040e3a6f9b1emr370957wmq.109.1704469693840; 
 Fri, 05 Jan 2024 07:48:13 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 fc12-20020a05600c524c00b0040d5a9d6b68sm1952853wmb.6.2024.01.05.07.48.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:48:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 48/71] memory: Simplify memory_region_init_ram_from_fd() calls
Date: Fri,  5 Jan 2024 16:42:41 +0100
Message-ID: <20240105154307.21385-49-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Mechanical change using the following coccinelle script:

@@
expression mr, owner, arg3, arg4, arg5, arg6, arg7, errp;
@@
-   memory_region_init_ram_from_fd(mr, owner, arg3, arg4, arg5, arg6, arg7, &errp);
    if (
-       errp
+       !memory_region_init_ram_from_fd(mr, owner, arg3, arg4, arg5, arg6, arg7, &errp)
    ) {
        ...
        return;
    }

and removing the local Error variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-Id: <20231120213301.24349-6-philmd@linaro.org>
---
 system/memory.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 3997ac5928..c1374e9968 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3577,11 +3577,8 @@ void memory_region_init_ram(MemoryRegion *mr,
                             Error **errp)
 {
     DeviceState *owner_dev;
-    Error *err = NULL;
 
-    memory_region_init_ram_nomigrate(mr, owner, name, size, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_ram_nomigrate(mr, owner, name, size, errp)) {
         return;
     }
     /* This will assert if owner is neither NULL nor a DeviceState.
-- 
2.41.0


