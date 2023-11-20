Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFF07F1F40
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:35:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5BvX-0003Gu-DH; Mon, 20 Nov 2023 16:35:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bub-0001vm-Ke
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:34:36 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BuZ-0003Xx-13
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:34:33 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-332cb136335so701285f8f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516060; x=1701120860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Db5rVC7IYaMSjFIzhw37gGhb/kt8tXVyhffbU+sslQ=;
 b=eqWZvHHqCa+ofTZ70YtFMAOY0fivaadnc9qLJjDhm3HkjFL5+MlNTSvtwFqp96aNaK
 Qq8rryfyVDyjXvBO0D+eVYZJzefV5lcUcaN9DC1YFh96BdXWTkIUF4tk6hFg8cDlja8o
 ZogAmQfa9BD3FbQqwCsUqQUmOYhTsqO+3ofWpUYlMIJoc6CZsr+sqnW1LcFP8+VVHMNQ
 xXGDPPgAseDn3wZ/nOWSmJrELLEwSxBcaFbWlh8/a+gVBN4e00cxRULX7cdqnBurmnWv
 VtmxQSU05l5LJorhE7IMgw0IZ/CW9xf57yhIF3E8CLDmxK/9JuiyItcMEmMl/Wy6Wfmo
 140g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516060; x=1701120860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Db5rVC7IYaMSjFIzhw37gGhb/kt8tXVyhffbU+sslQ=;
 b=ciu9q+6DmBnu6VCpDfLHy9HEc3x8qXm+mMYG9lOX46h0bRioJrdRgZftkm8GEeFTe0
 b+DU+sKMUBZpgRpEh0kthAIfKV76aXiEU+NpX0zKZkwwiJd4nL+khui73Kfjz0axBlO2
 ky0a2rWlv+QuHmKCoUG6jwKrj4FaYDKkqJtj42KTlDY20YvoBfsbXQIGFqcpvvvWKUFt
 aPu+kidoK8mFZZdoLOFpkrkwwn3rO4YgAxKH5SPjTeInu8kqCev9FSYzzK5vHJ8AMUEQ
 uNZSXDSpbRHZ66RxLnb3ICWVokuT5FASBoBDGy6xuE6YLx8p7nJHlP5y+ufco9yglvO7
 kTUw==
X-Gm-Message-State: AOJu0YwEKF1sc/xMabZnMerP/ntikbCOwUgU42IALFnjLvNNXVeEGwnJ
 6M475+BXC8L/YSXFhcNj8LqRruLcoUF7pzrqRao=
X-Google-Smtp-Source: AGHT+IE1dcMRs4ITuaIZlmOY5WENAknRhBAUic/LtnF0eF7kmZeG4TCNmWJoEfpiR+DzZrkd4guCFQ==
X-Received: by 2002:a05:6000:1acd:b0:332:c2ae:ca4f with SMTP id
 i13-20020a0560001acd00b00332c2aeca4fmr4041008wry.46.1700516059836; 
 Mon, 20 Nov 2023 13:34:19 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a5d5381000000b0032f7f4d008dsm12298763wrv.20.2023.11.20.13.34.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:34:19 -0800 (PST)
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
Subject: [PATCH-for-9.0 08/25] memory: Have
 memory_region_init_rom_device_nomigrate() return a boolean
Date: Mon, 20 Nov 2023 22:32:42 +0100
Message-ID: <20231120213301.24349-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
 system/memory.c       | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9d9798a527..e2cf3e58de 100644
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
index 2c764947fa..1cccc4b755 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1743,7 +1743,7 @@ bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
     return rv;
 }
 
-void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
+bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
                                              Object *owner,
                                              const MemoryRegionOps *ops,
                                              void *opaque,
@@ -1764,7 +1764,9 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
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


