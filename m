Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA00F7F1F3D
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:35:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Bv1-0001zd-1K; Mon, 20 Nov 2023 16:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BuU-0001mB-RC
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:34:27 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BuS-0003Uc-90
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:34:25 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40a5a444c3eso16884195e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516053; x=1701120853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WK6ixy1lWz865bxFpaXwaNdgjrdvugwCVDt1SZLip8M=;
 b=OfYtZD1hwOiGO2WrGPlQ1/u8tmVk9ydezkCv6qz3eIaDsWxT+Jr1Rn8PcThTcdLttr
 eUS2e4fzYbP5qovO5GzP90cn19YkyE2Fxo2dwVthZwd23OXvqubyNxJW4NIuycs4N2kq
 LDTCcQ4L3M8ydyrsUkB9+4sRpmMeLg0+A8pbh/7Y5rXK7h/OzK7sK38h+J0rt9HqkmAf
 HB5s4NTVSoaDvHDCO9VUcrpP81N4FRF4w262PM8ZY/pLpRkFBPL4oWy59E6ML/21zC0L
 e8BXkV/wk1IeFcLqR23/8wtgYeRIA5WMV0nkMi5eDijW9l72H6xUuqZsifUHSkGGhYJi
 6OmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516053; x=1701120853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WK6ixy1lWz865bxFpaXwaNdgjrdvugwCVDt1SZLip8M=;
 b=RJPSVhLdFqsh3leY7FXfB2Uz935kuMmzEEbJfoUxOHQUZ4EjEKhd1Mg0UnUYc4uCr4
 UI5hIN97GXU9iDqqUHpn4zFJSe+ket9aBEMG7hmbsBhP7eZ6dEPlrmyZnc2SF6EpUG9e
 rDiA7/uJPfi0rlzdNEApa0rbZznnDQdPONw+t8ctnc/TwYlIl8T6bQzQIGYN2ertyXzj
 wVFhAsUCy5UVXjuQzHbBN9cA69jvjto4rFs6B9tvZQyo0hCV+n4a1EuURBAkRgN0B5kh
 vaH1fs1QCg07L1BfGmtJeuf2lOzC3sbarLfCiP25W2pQ/Gelj+Wmy789OyXmse+2FPcU
 5Cxw==
X-Gm-Message-State: AOJu0Yyb/TpF9Gt4MYQlW0fIv17NAYwAX+zr4JDXNkov0d55XnA5Xxne
 Ik+Hm/onnhREIXSLXfTx2oUlgKSVFfVgPT+gBhY=
X-Google-Smtp-Source: AGHT+IEeFFU1fX7WoADlosMCv+szb4F8TKJeBk0nZaKMtXyIxhdIWJOPUQL8I7pzqRwYibVwRa+KDg==
X-Received: by 2002:a05:600c:3b05:b0:408:5a1c:9de7 with SMTP id
 m5-20020a05600c3b0500b004085a1c9de7mr7663702wms.7.1700516053245; 
 Mon, 20 Nov 2023 13:34:13 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a05600c348300b0040a5e69482esm19352313wmq.11.2023.11.20.13.34.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:34:12 -0800 (PST)
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
Subject: [PATCH-for-9.0 07/25] memory: Have memory_region_init_rom() handler
 return a boolean
Date: Mon, 20 Nov 2023 22:32:41 +0100
Message-ID: <20231120213301.24349-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
index 788872e4a4..9d9798a527 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1611,8 +1611,10 @@ bool memory_region_init_ram(MemoryRegion *mr,
  *        must be unique within any device
  * @size: size of the region.
  * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Return: true on success, else false setting @errp with error.
  */
-void memory_region_init_rom(MemoryRegion *mr,
+bool memory_region_init_rom(MemoryRegion *mr,
                             Object *owner,
                             const char *name,
                             uint64_t size,
diff --git a/system/memory.c b/system/memory.c
index 4142eac498..2c764947fa 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3620,7 +3620,7 @@ bool memory_region_init_ram(MemoryRegion *mr,
     return true;
 }
 
-void memory_region_init_rom(MemoryRegion *mr,
+bool memory_region_init_rom(MemoryRegion *mr,
                             Object *owner,
                             const char *name,
                             uint64_t size,
@@ -3629,7 +3629,7 @@ void memory_region_init_rom(MemoryRegion *mr,
     DeviceState *owner_dev;
 
     if (!memory_region_init_rom_nomigrate(mr, owner, name, size, errp)) {
-        return;
+        return false;
     }
     /* This will assert if owner is neither NULL nor a DeviceState.
      * We only want the owner here for the purposes of defining a
@@ -3639,6 +3639,8 @@ void memory_region_init_rom(MemoryRegion *mr,
      */
     owner_dev = DEVICE(owner);
     vmstate_register_ram(mr, owner_dev);
+
+    return true;
 }
 
 void memory_region_init_rom_device(MemoryRegion *mr,
-- 
2.41.0


