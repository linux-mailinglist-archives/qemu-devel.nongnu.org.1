Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A28825748
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:56:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmTJ-0001mb-04; Fri, 05 Jan 2024 10:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmRg-00076c-81
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:49:17 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmRO-00075k-OG
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:49:14 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40d8902da73so12882625e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469737; x=1705074537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9DCMj7pY2pO17D+FqBvL8kwEDleUW00T3E/JGiYz/k=;
 b=U54if9m0B4jYXM4rDTogAYwijQfmaWRbyeNV7pFxhFHddn9l0IDHgqC9Cilhz5VgDl
 bQn7UZX+V4CFJNfZFyhm7isRTf7+aIu9AXB1alsa3icILbPnLv1oyhOXMhzZlLSgi9Z4
 BOIBinMngYba1t1jnPZP805CP73T5tad2dPqgWOzkksGNGezv2eUco/wmNgY5R9a5+Uf
 Mw9BuSBNuYOTc3qGMWOsOFjZwi/mP8UC7zcUgSnJnKoRS9LWQdnr5npbPDzoa6j4EkLG
 x32opXu7JdXwIg70Uivz7cchEEeQIGslAjeCFyDb0zRXUTRYb6/WZszJ0vKSj10N1atN
 ouFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469737; x=1705074537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9DCMj7pY2pO17D+FqBvL8kwEDleUW00T3E/JGiYz/k=;
 b=l9viSW/ap+y1D8WleuMeROaMG8xcMNKJ6p4BAn/GMO8S5HvS5r2KX4s11WbfMrWe+1
 I4hsjBra6G5hmZGszb1Mg8Ye+3802BgakXM45Zx4Xz440sLt77/NBDUY2M9v/0AvBxiF
 IlKKxZUB33FKoBNVRU4iVvxzYzzuqWtCEwkGYwks8x76uw5201kzluz2dM3RqhSA+gkf
 dsWgyh1CKQdAVa17bj5/x5Udbql+5ewjPbN3cJvgkzvTEkfk5hvDe0yq10O++7bv9Fzv
 HF+w0h1TyNyuPGHT32Dnsxe/HDoJUN3KqUw/STvGCdgqGkBc1uTJkPydBFQar7NnSOxJ
 KEaA==
X-Gm-Message-State: AOJu0Yxmyqh6hxQP8cy1GzTgjWVfGpnX82pSH5K+4aPx+QneG0bI7gMm
 dNu4wU/TPMHWiXtF2FTsRKSU2guukRHIgYTABDWgRtY1pR0=
X-Google-Smtp-Source: AGHT+IFr3rjevgUO39MMi9bFJ/ZWecNNIqMe1MrKSODaM+cLKa+lPF7yzj6ex1uolFUngYScxhl9Vw==
X-Received: by 2002:a05:600c:4a13:b0:40d:8ddc:b443 with SMTP id
 c19-20020a05600c4a1300b0040d8ddcb443mr1540873wmp.50.1704469737001; 
 Fri, 05 Jan 2024 07:48:57 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 az29-20020a05600c601d00b0040d87b5a87csm1965144wmb.48.2024.01.05.07.48.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:48:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 56/71] memory: Have memory_region_init_ram_from_fd() handler
 return a boolean
Date: Fri,  5 Jan 2024 16:42:49 +0100
Message-ID: <20240105154307.21385-57-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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
Document Error API usage rules"), have memory_region_init_ram_from_fd
return a boolean indicating whether an error is set or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-Id: <20231120213301.24349-14-philmd@linaro.org>
---
 include/exec/memory.h | 4 +++-
 system/memory.c       | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index c39819ec75..48c11ca743 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1406,8 +1406,10 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
  *
  * Note that this function does not do anything to cause the data in the
  * RAM memory region to be migrated; that is the responsibility of the caller.
+ *
+ * Return: true on success, else false setting @errp with error.
  */
-void memory_region_init_ram_from_fd(MemoryRegion *mr,
+bool memory_region_init_ram_from_fd(MemoryRegion *mr,
                                     Object *owner,
                                     const char *name,
                                     uint64_t size,
diff --git a/system/memory.c b/system/memory.c
index e05d88aa67..9ceb229d28 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1633,7 +1633,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
     return true;
 }
 
-void memory_region_init_ram_from_fd(MemoryRegion *mr,
+bool memory_region_init_ram_from_fd(MemoryRegion *mr,
                                     Object *owner,
                                     const char *name,
                                     uint64_t size,
@@ -1654,7 +1654,9 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
         mr->size = int128_zero();
         object_unparent(OBJECT(mr));
         error_propagate(errp, err);
+        return false;
     }
+    return true;
 }
 #endif
 
-- 
2.41.0


