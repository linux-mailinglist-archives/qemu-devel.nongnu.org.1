Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCA27F1F3A
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:34:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5BuG-0001RG-Jm; Mon, 20 Nov 2023 16:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BuC-0001ON-Gh
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:34:08 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BuA-0003PH-Ft
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:34:07 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-332cc1f176bso402325f8f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516044; x=1701120844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBwxNmvGLLiXqhul31X+YfHhcCHLwXIU2jAo+ECLv+g=;
 b=B9ioF4l86mJ2HmniwrgFW9kmnsIW/KovEavtrtHrjV5TtcuGMCIhRxnHgJ7eQxP0sC
 y+7g5oKDwqYoNcQKp5CeygIROOVB/LwCeS9G/awhb2j3wfqS+HcEcJOIU6JYK0L91Iif
 ybXbRB6efcajU4tCbFgNMGNOP+7F7fB8dEdupbtssNm9vCdH698GAQBRvk9CM2CBYrxx
 ltJTaTqeGTw7Ie9lLiiwgowK+w1iCzZFPXdkoJaBjfw84GtsQ5ofrq9jV0vrZgG5GwoR
 ycqKwFoQx9lBTozjxwZxvQM4T28IsapjhhvPqnUbDNujPQK7DFoSjsIMQqkY1iYDVKKM
 qV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516044; x=1701120844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QBwxNmvGLLiXqhul31X+YfHhcCHLwXIU2jAo+ECLv+g=;
 b=HigChOZZBGaWIuZ8oeK97hwNSYenLQ5lo8cF9iyraLMmS9fl4sVknF0EOSR5Wa7/C9
 SEAl/cJqMlg1uy3KykUcVNveUSN5sOcbXFl3U9SzIwB7lPWJLYnAgfwC3GuS7h3E2g0Y
 +kqOS64tsk7ulZ8r7Pwpq8eJRbfdO5TD8Paj2y3noZnE8dSsbSMtlPqJif3cEikUGQmV
 8ERuFWY0veh+ehlr9Wiz+jHqR1NfhGcFX4eOFIB+lT1th7mim/qqHKefOh+0Gge4GO2K
 TnyPcCc/11AeRvP7AbAX6HW5GXXkPTcTqFWDsci4+HdLrjlGhBzzBB2GgDV+ycdu6MGK
 nD7Q==
X-Gm-Message-State: AOJu0YyV34DxlVFZKHlAN5wGxGtw7nUwZ3buYTzKsoRk61JEtto9TbiF
 0koZiMECw84WVrXaiLijZySPoycLzTWuLtwpxKk=
X-Google-Smtp-Source: AGHT+IGhoeFxLVb1c8O/iSAw6YZEAiWFSVuYIYRW6k+270zx082Jw3NUxxEXlyAiLjU+Q41lF4Llog==
X-Received: by 2002:adf:a3c3:0:b0:332:c284:c3c7 with SMTP id
 m3-20020adfa3c3000000b00332c284c3c7mr3558809wrb.37.1700516044460; 
 Mon, 20 Nov 2023 13:34:04 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a5d6389000000b00332cc3e0817sm1072899wru.39.2023.11.20.13.34.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:34:04 -0800 (PST)
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
Subject: [PATCH-for-9.0 06/25] memory: Have memory_region_init_ram() handler
 return a boolean
Date: Mon, 20 Nov 2023 22:32:40 +0100
Message-ID: <20231120213301.24349-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Following the example documented since commit e3fe3988d7 ("error:
Document Error API usage rules"), have cpu_exec_realizefn()
return a boolean indicating whether an error is set or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/memory.h | 4 +++-
 system/memory.c       | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8e6fb55f59..788872e4a4 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1582,8 +1582,10 @@ void memory_region_init_iommu(void *_iommu_mr,
  * give the RAM block a unique name for migration purposes.
  * We should lift this restriction and allow arbitrary Objects.
  * If you pass a non-NULL non-device @owner then we will assert.
+ *
+ * Return: true on success, else false setting @errp with error.
  */
-void memory_region_init_ram(MemoryRegion *mr,
+bool memory_region_init_ram(MemoryRegion *mr,
                             Object *owner,
                             const char *name,
                             uint64_t size,
diff --git a/system/memory.c b/system/memory.c
index ca05c4defa..4142eac498 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3597,7 +3597,7 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled)
     }
 }
 
-void memory_region_init_ram(MemoryRegion *mr,
+bool memory_region_init_ram(MemoryRegion *mr,
                             Object *owner,
                             const char *name,
                             uint64_t size,
@@ -3606,7 +3606,7 @@ void memory_region_init_ram(MemoryRegion *mr,
     DeviceState *owner_dev;
 
     if (!memory_region_init_ram_nomigrate(mr, owner, name, size, errp)) {
-        return;
+        return false;
     }
     /* This will assert if owner is neither NULL nor a DeviceState.
      * We only want the owner here for the purposes of defining a
@@ -3616,6 +3616,8 @@ void memory_region_init_ram(MemoryRegion *mr,
      */
     owner_dev = DEVICE(owner);
     vmstate_register_ram(mr, owner_dev);
+
+    return true;
 }
 
 void memory_region_init_rom(MemoryRegion *mr,
-- 
2.41.0


