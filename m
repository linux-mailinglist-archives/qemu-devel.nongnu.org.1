Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB7A7F1F37
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:34:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Btq-00018c-Ry; Mon, 20 Nov 2023 16:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bto-00016F-S7
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:33:44 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Btm-0003BQ-AZ
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:33:44 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4083f61312eso22408275e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516021; x=1701120821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LbDA9YGRe7qNIe50oT0Ny26RZPp0o8gVGjIEnbyILZM=;
 b=cAxnqNxGWqekkN92GLQ8zKXsAL5t26rbEEO/cjQITi6I/0iv2iMR0CCdu6mTHnApur
 7/bppD+qcmdr58agvZ27FQMBH8ot648OuHSjwlHSXnrDfgyFDDaDdTxP9kQtT5b3e9r6
 c364UHE/lPI9C1jbs9TlF9HAkMQQHFrpozOd9mIn8kz/rphv90aUL0LYJzOnyrLshkBR
 xmdEP+INbq+jiHPFGZweskQOrCD4ivCfkIbvKIZ4t9UwXV2n2WqOynxRtCS8/I2GkJ0R
 Rsx28Sr6PGMUPPzzWeKLqBwmyHaOvCt24S5rHVqGCx7d91t3+sRA/fvja+BxsPyVkGG/
 mIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516021; x=1701120821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LbDA9YGRe7qNIe50oT0Ny26RZPp0o8gVGjIEnbyILZM=;
 b=ChlJx/sfcH2zFnTi6483RnlilYAXqdt61onBnuMOA2Sdz1LH8zvcDM35BVhVRONU+3
 aedLFTc42VlYYnbbbl2AdwLe74VGurXvCQQwqX1+sgu17iQg91koHUBj6t+uO7FmtxG6
 znSaF1o7diu4vvB3rJyKCa5fuMNIfKqNxLFU56OnZRPkTtN6zySLdnUIsgK8UtpOoAZn
 3a49tIn1zJEG81045oadhey3c5fzsHjJpjM0k0u9qEdO6o3uQLyQMVxpkSnupqEPT9dM
 GArsU/Zw3N0Zic9DvYadKJsuxuTmmY+s/XHxHd2avc/M9xihy8r0bPmJAD4vNBLnBdsQ
 /RQw==
X-Gm-Message-State: AOJu0YwhdyJRR5xZqPuQ6zMaDTxSeGVsgcrPoTAR8/WUU/vOZ5pCi7RO
 AweZA1/2lQnwnN+Ol6dhxODkqKuG1vdAog4VfMc=
X-Google-Smtp-Source: AGHT+IGV4DlNWGMbTD3xq4BBT3E729eZTiGtQ1hohduWzUYFvKfsGB15/8I9/AEUED0Q+S8SHsYNkQ==
X-Received: by 2002:a05:600c:1994:b0:405:40ec:415d with SMTP id
 t20-20020a05600c199400b0040540ec415dmr6998432wmq.39.1700516020706; 
 Mon, 20 Nov 2023 13:33:40 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 j32-20020a05600c1c2000b004094c5d929asm14891734wms.10.2023.11.20.13.33.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:33:40 -0800 (PST)
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
Subject: [PATCH-for-9.0 03/25] memory: Have memory_region_init_rom_nomigrate()
 handler return a boolean
Date: Mon, 20 Nov 2023 22:32:37 +0100
Message-ID: <20231120213301.24349-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
 system/memory.c       | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 4140eb0c95..8e6fb55f59 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1498,8 +1498,10 @@ void memory_region_init_alias(MemoryRegion *mr,
  *        must be unique within any device
  * @size: size of the region.
  * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Return: true on success, else false setting @errp with error.
  */
-void memory_region_init_rom_nomigrate(MemoryRegion *mr,
+bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
                                       Object *owner,
                                       const char *name,
                                       uint64_t size,
diff --git a/system/memory.c b/system/memory.c
index 337b12a674..bfe0b62d59 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1729,14 +1729,18 @@ void memory_region_init_alias(MemoryRegion *mr,
     mr->alias_offset = offset;
 }
 
-void memory_region_init_rom_nomigrate(MemoryRegion *mr,
+bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
                                       Object *owner,
                                       const char *name,
                                       uint64_t size,
                                       Error **errp)
 {
-    memory_region_init_ram_flags_nomigrate(mr, owner, name, size, 0, errp);
+    bool rv;
+
+    rv = memory_region_init_ram_flags_nomigrate(mr, owner, name, size, 0, errp);
     mr->readonly = true;
+
+    return rv;
 }
 
 void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
-- 
2.41.0


