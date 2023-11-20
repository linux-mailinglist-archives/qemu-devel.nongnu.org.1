Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F07D87F1F43
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:36:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Bve-0003l7-Qj; Mon, 20 Nov 2023 16:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bug-00027w-K8
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:34:42 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bue-0003bw-Fi
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:34:38 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-332ca7f95e1so696804f8f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516073; x=1701120873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fn2fBz5vRqFzHrFrTMPe8dy33731H5v7e4n8L1UYY2M=;
 b=efL7PO8rq9lBpiZBeOKhRxPOLIM5Hnx72MnzJYcL5tcyQVrjakFesBX1hWb6MwdIYC
 ONvz5Prcxhy24sYP6Bj3ucWDs96WPtHSGI+1eDRAY7EWdiXn00efMqaX3srtDCRuiJeK
 RlKR+CoBaSFrGNBCFJUXZwjFZx9dW9W73yg4KkwUzDAADfBUCGM7ByjQ4G1azr9i47YW
 +HNm3FRQ1SN2r8P0EA13tpwiQQ03oljdnE2s3IXiEMs0qkViV3Kjw2YL5D/Rp8/qWOLB
 bTZJLGU59iGgecCKfPPNtob/1hqpyyebLnYRsZNF+CwA2csuzP/Gee+yXG9+5w+lnZP1
 +EnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516073; x=1701120873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fn2fBz5vRqFzHrFrTMPe8dy33731H5v7e4n8L1UYY2M=;
 b=YOy2O0URfHn2Cna+roKUjREs0Ns8Fm0LB+GffVK+572IIVXz7bafhYMuRNqSGdnGBA
 b1sYu81D5yOM2TV4Hfikslev4onq8WtqUauBNRdpmL3vfpnqjdQITYPUrRLRxsROjhmB
 X/DC9Hd6/8/qOq7OayP9qLc3S+epw0dyyzzqBuzsIa17kZm9aK2LWONrxaFwjZa+ex3V
 ssflHQ9jydigKthrb625MWU1NQubFCxEWkygP8VMZMiopOGUS7zM4MdRuFdhIqadlt6t
 tvYptNbXblU+VYccf+3TC5saIhJ+P9K02pr/LNVjtPTF41uXkgtY6BzrxN2ccKhTqLHC
 9Upw==
X-Gm-Message-State: AOJu0YwUT4H+HcjlSjMs03JdYkbAij3jORA+zGD9jV0khEkayhavHNwO
 yV5wMakAdaZYwtK8mKvQE2phulj2T2u7t9Ml2bg=
X-Google-Smtp-Source: AGHT+IG0Aezfr6nY5g2si6cT8mAcH6q2jEW+ZAAAook2GU6LNsGqscsh5FvQHKnc1fDayuOPIcWOVg==
X-Received: by 2002:adf:e644:0:b0:32f:8214:5ba1 with SMTP id
 b4-20020adfe644000000b0032f82145ba1mr5772816wrn.45.1700516073513; 
 Mon, 20 Nov 2023 13:34:33 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a5d48d1000000b003316ad360c1sm11581303wrs.24.2023.11.20.13.34.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:34:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-9.0 10/25] memory: Have memory_region_init_rom_device()
 handler return a boolean
Date: Mon, 20 Nov 2023 22:32:44 +0100
Message-ID: <20231120213301.24349-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
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

Following the example documented since commit e3fe3988d7 ("error:
Document Error API usage rules"), have cpu_exec_realizefn()
return a boolean indicating whether an error is set or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/memory.h | 4 +++-
 system/memory.c       | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e2cf3e58de..92b0c0aa46 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1646,8 +1646,10 @@ bool memory_region_init_rom(MemoryRegion *mr,
  *        must be unique within any device
  * @size: size of the region.
  * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Return: true on success, else false setting @errp with error.
  */
-void memory_region_init_rom_device(MemoryRegion *mr,
+bool memory_region_init_rom_device(MemoryRegion *mr,
                                    Object *owner,
                                    const MemoryRegionOps *ops,
                                    void *opaque,
diff --git a/system/memory.c b/system/memory.c
index 6d1d315d0e..1b10e177f5 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3645,7 +3645,7 @@ bool memory_region_init_rom(MemoryRegion *mr,
     return true;
 }
 
-void memory_region_init_rom_device(MemoryRegion *mr,
+bool memory_region_init_rom_device(MemoryRegion *mr,
                                    Object *owner,
                                    const MemoryRegionOps *ops,
                                    void *opaque,
@@ -3657,7 +3657,7 @@ void memory_region_init_rom_device(MemoryRegion *mr,
 
     if (!memory_region_init_rom_device_nomigrate(mr, owner, ops, opaque,
                                                  name, size, errp)) {
-        return;
+        return false;
     }
     /* This will assert if owner is neither NULL nor a DeviceState.
      * We only want the owner here for the purposes of defining a
@@ -3667,6 +3667,8 @@ void memory_region_init_rom_device(MemoryRegion *mr,
      */
     owner_dev = DEVICE(owner);
     vmstate_register_ram(mr, owner_dev);
+
+    return true;
 }
 
 /*
-- 
2.41.0


