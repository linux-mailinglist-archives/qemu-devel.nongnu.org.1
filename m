Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9DE825741
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:55:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmRO-0004cq-Dd; Fri, 05 Jan 2024 10:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmR0-0001wL-0R
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:48:34 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmQy-0005lV-5U
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:48:33 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40d76fefd6bso14855215e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469710; x=1705074510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxeB5JHPsloAIkHe9tjmngVFFPhZ7Tzq56PtI31mi5A=;
 b=r/UI2DJI7ZXzSJoq9WxifR9U6Q0kDtzHeIEO4eFalKxCvKsetcZBrrG8C8Xl1PvAxY
 PkLUOCC9Qxh4DZP5ekaR1OmqNthHK4ujNKtyYYp8SNRJm6e5dtXkgixgO06obNkEXpKt
 GvdzOvgv8W+O82NNCcKBNI+msaac663by9A/Su3gweaAyWPpWMKSwYCGfpLOQmJ6DSxx
 g6hJUUm2LbuVn76IuCAC96y2FJ0/bE1qDaJYRQ9w/cBDFxBxF0dAOkUYZe3xEXaFITZa
 KCSC9j9tQgirrP3mMA8O2shq5PWonkQMgLLKmc4Tj7Thnq3U9UHsiVT9gD1hHd30aUXJ
 kUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469710; x=1705074510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pxeB5JHPsloAIkHe9tjmngVFFPhZ7Tzq56PtI31mi5A=;
 b=imvySgr9gUk3jtIoTMEJ9Tk4lmDYvg0dsM6M1knjsNBoKezAdVEpOLAXcYtEYxfZrk
 sdtO5cdEi61vK8Y0cWb+DijFQXc5/UqlqZfT6fhAad8rnGMtYDMZQeP39XgOYLH/zQlF
 adDdKaAKB9Gyvs2jMQRGkYTxOCOCliTH+699HSiZHcShI9hAWVS0kyHusr9TXeCNLikZ
 5RAElaqXub/T4CRk+1+7xSejjWexNH8jpxQ6BnMPh8RijTiGNdvkieM/pLPi+T+G5LLS
 OoCur4LwGm6ZhsXesDR05pBSrcYXUw+V47Q5yITMwZ/IKIWR9M0PIK+qiHPXDeSE72Ct
 EDTg==
X-Gm-Message-State: AOJu0YyPGUQoTVEzEuPaF7Q01UM5NxZyXMsArGfZ4e1fa0UCs+FK0ABh
 6F+mz3DoJphTc1ldBh9zVDUtHRg6/oXBj7j8Vb90xNMF5WU=
X-Google-Smtp-Source: AGHT+IGGmNlvX+5XEyFN41Jq0pCpjhFubR2VsuO+YfPUoop45ZA6QI8jot/WJJTvWFoNWF4EwwAJAg==
X-Received: by 2002:a05:600c:34c1:b0:40d:880f:4876 with SMTP id
 d1-20020a05600c34c100b0040d880f4876mr630692wmq.152.1704469710540; 
 Fri, 05 Jan 2024 07:48:30 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 e9-20020a05600c4e4900b0040e38859c47sm1959505wmq.16.2024.01.05.07.48.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:48:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 51/71] memory: Have memory_region_init_rom_device_nomigrate()
 return a boolean
Date: Fri,  5 Jan 2024 16:42:44 +0100
Message-ID: <20240105154307.21385-52-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Following the example documented since commit e3fe3988d7
("error: Document Error API usage rules"), have
memory_region_init_rom_device_nomigrate() return a boolean
indicating whether an error is set or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-Id: <20231120213301.24349-9-philmd@linaro.org>
---
 include/exec/memory.h | 4 +++-
 system/memory.c       | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9f54bc4af8..6d7b49b735 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1523,8 +1523,10 @@ bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
  *        must be unique within any device
  * @size: size of the region.
  * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Return: true on success, else false setting @errp with error.
  */
-void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
+bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
                                              Object *owner,
                                              const MemoryRegionOps *ops,
                                              void *opaque,
diff --git a/system/memory.c b/system/memory.c
index 069aa5ee08..8db271c19e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1716,7 +1716,7 @@ bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
     return true;
 }
 
-void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
+bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
                                              Object *owner,
                                              const MemoryRegionOps *ops,
                                              void *opaque,
@@ -1737,7 +1737,9 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
         mr->size = int128_zero();
         object_unparent(OBJECT(mr));
         error_propagate(errp, err);
+        return false;
     }
+    return true;
 }
 
 void memory_region_init_iommu(void *_iommu_mr,
-- 
2.41.0


