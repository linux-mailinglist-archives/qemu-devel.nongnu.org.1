Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD996825709
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:48:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmRC-0003Ev-AD; Fri, 05 Jan 2024 10:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmQV-0000F3-MX
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:48:06 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmQR-0004wM-Hx
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:48:02 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d5b89e2bfso16307005e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469677; x=1705074477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ts6/p06DbcZO3DzbdTMKNYyTx2gw5NVQT7hGpH+Yf50=;
 b=zEu7/IrGDpDeIr2dIyiR40b6RX7Rw5UhbZ6q/QeeQvsdv03PzLd3jldCm7pSJMuLLv
 SjmnKVdLeKEXJfesS3NLTJbhxto3zAlomPsnYD0Csd5QGfCbF7Evk1M8jLzGnKuEBqzS
 b6H8SKBm4DKSfFXyzxSHeUqiShDU1BZDb8QkYlw6QVwAlJqHw7wp2XtauZPqCLAB+FaK
 aZ/d8YmaWrm6yp9Nb58HzkmyvqEPN7b3Wkk7lQPHHJ4YT3lPxcFvYtTNa36QOzcDuIzC
 1Wvrc9TbagoepY2xHIdgxmQ8yuBBeeNRNWGypPlS1hr0mflAmRF2yUXN6tLyqYvIqeCl
 hFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469677; x=1705074477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ts6/p06DbcZO3DzbdTMKNYyTx2gw5NVQT7hGpH+Yf50=;
 b=rh9C9rVP5rRaEn/yHp9uzkg21+66K4W38qXuxIxzDK1h5xaplmmgnyfvPXyEXCLIH5
 AUOjaJ5i2cQSoJhGY+VNzRJPhBmffkvwyIj4sp/wHb3PdU3yTPHSl6uEq1uHQhzxAVaO
 bndDwSVoYXDXOONrYmvvFYBCMK9Q+alsWdA9BDZuOL3Haq9AeI5ZSzVcEX8GLJoWUlEH
 NN6uh3Vkv5kS+iyJobqCkUXpUrVo6ptMoAbu3DMphhupzNWtIJpS9sLAPatg3siQi2mG
 TMuELS4alZ8SrDok64DmvN3PFO/sWNLl23EHoaKLsA8jCp2Y7yZiXdEhg/ciGBMI/z5K
 IJUQ==
X-Gm-Message-State: AOJu0Yw8UsxHhmyQQj7X+b6kmTffPxdHrae/cqDVadKbvw2c8eMHlKeh
 h61WPu/s+kw/x9K6+47uFSiR/foq93VDXPh0JR9ocs6nX3s=
X-Google-Smtp-Source: AGHT+IHhV7/5t2tWHWEtXRwGQGY19G/nj2WV2pTsMSyTzhFkSw+Px430TLhVpOPFlJYhDK69W+N89A==
X-Received: by 2002:a05:600c:1c0d:b0:40d:7f71:3f4f with SMTP id
 j13-20020a05600c1c0d00b0040d7f713f4fmr1300112wms.176.1704469677641; 
 Fri, 05 Jan 2024 07:47:57 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 o16-20020adfcf10000000b003364a0e6983sm1601482wrj.62.2024.01.05.07.47.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:47:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Xu <peterx@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 45/71] memory: Have memory_region_init_ram_nomigrate() handler
 return a boolean
Date: Fri,  5 Jan 2024 16:42:38 +0100
Message-ID: <20240105154307.21385-46-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
Document Error API usage rules"), have memory_region_init_ram_nomigrate
return a boolean indicating whether an error is set or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-Id: <20231120213301.24349-3-philmd@linaro.org>
---
 include/exec/memory.h | 4 +++-
 system/memory.c       | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1df7fb0fed..413fbda089 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1288,8 +1288,10 @@ void memory_region_init_io(MemoryRegion *mr,
  *
  * Note that this function does not do anything to cause the data in the
  * RAM memory region to be migrated; that is the responsibility of the caller.
+ *
+ * Return: true on success, else false setting @errp with error.
  */
-void memory_region_init_ram_nomigrate(MemoryRegion *mr,
+bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
                                       Object *owner,
                                       const char *name,
                                       uint64_t size,
diff --git a/system/memory.c b/system/memory.c
index 6110e851f1..f9e5ae22d5 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1546,13 +1546,14 @@ void memory_region_init_io(MemoryRegion *mr,
     mr->terminates = true;
 }
 
-void memory_region_init_ram_nomigrate(MemoryRegion *mr,
+bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
                                       Object *owner,
                                       const char *name,
                                       uint64_t size,
                                       Error **errp)
 {
-    memory_region_init_ram_flags_nomigrate(mr, owner, name, size, 0, errp);
+    return memory_region_init_ram_flags_nomigrate(mr, owner, name,
+                                                  size, 0, errp);
 }
 
 bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
-- 
2.41.0


