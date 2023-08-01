Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E7D76BFB0
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxKt-00044D-S2; Tue, 01 Aug 2023 17:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKf-00040T-9S
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:55:13 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKa-0004rA-0t
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:55:07 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31759e6a4a1so5487383f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926902; x=1691531702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALlzvSCMcoLc+e3yixiSCFGQuR+9t3b/espKpIxx4ew=;
 b=uYbf0s9WN0ipyLKflCDoHxPmIntche6P/fpIS7B/wGnmbOo++Z7kyh4BnVvQB78V7Q
 ZhmTDGjcr0HDAWvaInHE/odx7BMzR+Drye0HAahwY9aUVDtflezTj0YOkT3rKi+NFJaK
 Yzd4zFLzSaYCZ5Eo1d+f51DfQXUFD112Lql6tQgL9/MyvZGmIrSnOe6lylsWRd1kfFEx
 ItwDHoIiMDeYsSDRdkcpVl8kXqyCr4gXoCkkXaad2e/DosYW/raJyonVfw9fQivywD0j
 GrbZDkOohWfrQBDPK59VM2wg26Xng41gJ1hEozaBfnnfHw157vAgTLAV7Ga8LDl1xELd
 Tx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926902; x=1691531702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALlzvSCMcoLc+e3yixiSCFGQuR+9t3b/espKpIxx4ew=;
 b=Q22q3ps4jpMoqqpCZ7ypp/NlvtT8ArGrg757nW0k/ulC5nfPusLgkvgL7pohsC3J60
 R/vNbNQawHcHuaTHTpUDt6kdStLLf2dieQwUrodMsoj64XBxY84BI69zWUOjKkYEvY8l
 3RXnVbfgCOqOflX0WI+I3qkAFB+i2mDfSFFJKv8Zl/bspaDLUN4Gg5yVn7zVRWcRTjbz
 u5p6T8xEXzn8XBELX5QYzNsyFdqYlQHcyxpcmR3/n6ztBBeydM5qhQVzNHu4hl4jg1Tw
 Ekd8udQjcc98LoHVExhvJgyUTQ6JrX+6NeXYXiSRw2UPcNKiO70tHKOetTeAhhtQb73f
 t7uA==
X-Gm-Message-State: ABy/qLYw6wv84GZc0JDFgMP/k5Hjb6fvjrWEs6IolFf0kwybSk5xH60E
 tjElVI8b2+5VbBxTmT66OdjfqJYFUQ7Us7CpPWY=
X-Google-Smtp-Source: APBJJlHKADm8ENjuvNI1UFXHVMTyXCt1mISNtFkmMAMGCpaV7JDDQKMPBxraXx9mWbMt2d/TwnVvOA==
X-Received: by 2002:adf:ef42:0:b0:317:5b5f:2328 with SMTP id
 c2-20020adfef42000000b003175b5f2328mr3157781wrp.24.1690926901746; 
 Tue, 01 Aug 2023 14:55:01 -0700 (PDT)
Received: from localhost.localdomain ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a05600c114f00b003fbb5506e54sm14800593wmz.29.2023.08.01.14.55.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Aug 2023 14:55:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-s390x@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/10] misc: Fix some typos in documentation and comments
Date: Tue,  1 Aug 2023 23:54:17 +0200
Message-Id: <20230801215421.60133-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230801215421.60133-1-philmd@linaro.org>
References: <20230801215421.60133-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230730180329.851576-1-sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst    | 2 +-
 docs/devel/qom.rst           | 2 +-
 docs/system/devices/nvme.rst | 2 +-
 include/exec/memory.h        | 2 +-
 hw/core/loader.c             | 4 ++--
 ui/vnc-enc-tight.c           | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 1c35f55666..92a2bafd2b 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -369,7 +369,7 @@ mapping permissions et al by using its 'mapped' security model option.
 Nowadays it would make sense to reimplement the ``proxy`` backend by using
 QEMU's ``vhost`` feature, which would eliminate the high latency costs under
 which the 9p ``proxy`` backend currently suffers. However as of to date nobody
-has indicated plans for such kind of reimplemention unfortunately.
+has indicated plans for such kind of reimplementation unfortunately.
 
 
 Block device options
diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 0b506426d7..9918fac7f2 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -30,7 +30,7 @@ user configuration.
 Creating a QOM class
 ====================
 
-A simple minimal device implementation may look something like bellow:
+A simple minimal device implementation may look something like below:
 
 .. code-block:: c
    :caption: Creating a minimal type
diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index a8bb8d729c..2a3af268f7 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -232,7 +232,7 @@ parameters:
   Set the number of Reclaim Groups.
 
 ``fdp.nruh`` (default: ``0``)
-  Set the number of Reclaim Unit Handles. This is a mandatory paramater and
+  Set the number of Reclaim Unit Handles. This is a mandatory parameter and
   must be non-zero.
 
 ``fdp.runs`` (default: ``96M``)
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 7f5c11a0cc..68284428f8 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -942,7 +942,7 @@ struct MemoryListener {
      *
      * @listener: The #MemoryListener.
      * @last_stage: The last stage to synchronize the log during migration.
-     * The caller should gurantee that the synchronization with true for
+     * The caller should guarantee that the synchronization with true for
      * @last_stage is triggered for once after all VCPUs have been stopped.
      */
     void (*log_sync_global)(MemoryListener *listener, bool last_stage);
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 8b7fd9e9e5..4dd5a71fb7 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -863,7 +863,7 @@ ssize_t load_image_gzipped(const char *filename, hwaddr addr, uint64_t max_sz)
 
 /*
  * The Linux header magic number for a EFI PE/COFF
- * image targetting an unspecified architecture.
+ * image targeting an unspecified architecture.
  */
 #define EFI_PE_LINUX_MAGIC        "\xcd\x23\x82\x81"
 
@@ -1492,7 +1492,7 @@ RomGap rom_find_largest_gap_between(hwaddr base, size_t size)
         if (rom->mr || rom->fw_file) {
             continue;
         }
-        /* ignore anything finishing bellow base */
+        /* ignore anything finishing below base */
         if (rom->addr + rom->romsize <= base) {
             continue;
         }
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 09200d71b8..ee853dcfcb 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -77,7 +77,7 @@ static int tight_send_framebuffer_update(VncState *vs, int x, int y,
 
 #ifdef CONFIG_VNC_JPEG
 static const struct {
-    double jpeg_freq_min;       /* Don't send JPEG if the freq is bellow */
+    double jpeg_freq_min;       /* Don't send JPEG if the freq is below */
     double jpeg_freq_threshold; /* Always send JPEG if the freq is above */
     int jpeg_idx;               /* Allow indexed JPEG */
     int jpeg_full;              /* Allow full color JPEG */
-- 
2.38.1


