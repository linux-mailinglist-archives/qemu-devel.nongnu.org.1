Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D277F1F50
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:39:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Bvi-0004UF-FU; Mon, 20 Nov 2023 16:35:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BvG-0002zn-1O
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:35:18 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bv8-0003qi-NB
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:35:08 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40b23aeb9d9so10477815e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516104; x=1701120904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srROQw79PZz9736kD+JTLPR9CRLssrTQx2X8yf5dBJc=;
 b=mr7IOdsdVySBB/BP4JNC+BDBPVNVCm23iLT1u1qfvgHWPg8cSpqhAo4cEbdwC5BrYc
 QUAJuxAoIysb4Seu1JyuRZNK3JrDQ1viRpyqmae1gnXM2eAOgerkoNfq6JZ8iX7Z4ZTP
 R9tAdKzHX48PYM6ctr705yceQzsTrBHXWe864V98FOOzfTDhB+stUj3rjW0k5+m3v8pc
 L6mJ9XIc9lHHlzZXoxzoKCROjBFMXDSnnV7tdmJYS2pAFPsGxWVOEG8tX30z8vKCZVPT
 vRVIrZ5eujv6eMfPrjAa0QHUgMrfnuKrGfMZKenLCve/rg0ZpUUS+t26CIer9z5c3BNJ
 t6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516104; x=1701120904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=srROQw79PZz9736kD+JTLPR9CRLssrTQx2X8yf5dBJc=;
 b=nMRAB2VdaWyIGvlCzNXQFbbPEmrcTYLxS9q2LKHJh61bDBBHG5QS3r9lHgp4tg6kb3
 AFpxoqjIzUWcX0nj74Ctso5oCvmIVYb6Uj/VveUW2jOBxGi4UCWQMEGAJ7THD6k4Lxro
 X8YIZYaeyB3ulgjYpaW4tEH9AheNn8XkcJeFUKB+V0X+bqvpLPIxWszs6+uFkhb+uI/l
 pITCW7hxowObiqQnHhTXMd3u1nmvdYj+bmKZP0Ui2IuGmktUCsdcMJ2AG48udaZGWvml
 LIZz1CWkkH72sEFnvMC/RNtpTasAaGfsew+6QeRKLF2qnBudGC+KXDOxJndeJREpBqQ5
 j2WQ==
X-Gm-Message-State: AOJu0YxLCgHx5lG/na09rq0ngWSdI/fUZj/EczzJDIzmid1c3RKKpLFu
 CQ8MjtLnnhec/H5TOhZVMoVYQvf6K7VAXV+9Mdc=
X-Google-Smtp-Source: AGHT+IEIZ+IFo2JacPAN1sUnLp/dq59vh8dOehkHkVB7GrmhKVzG+i0hdb/IjX5jwGgLeEfojsmKgQ==
X-Received: by 2002:a05:600c:548c:b0:409:325:e499 with SMTP id
 iv12-20020a05600c548c00b004090325e499mr7267468wmb.32.1700516104774; 
 Mon, 20 Nov 2023 13:35:04 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 k39-20020a05600c082700b004083729fc14sm18726935wmp.20.2023.11.20.13.34.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:35:04 -0800 (PST)
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
Subject: [PATCH-for-9.0 11/25] memory: Have
 memory_region_init_resizeable_ram() return a boolean
Date: Mon, 20 Nov 2023 22:32:45 +0100
Message-ID: <20231120213301.24349-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
index 92b0c0aa46..218b35a849 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1342,8 +1342,10 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
  *
  * Note that this function does not do anything to cause the data in the
  * RAM memory region to be migrated; that is the responsibility of the caller.
+ *
+ * Return: true on success, else false setting @errp with error.
  */
-void memory_region_init_resizeable_ram(MemoryRegion *mr,
+bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                        Object *owner,
                                        const char *name,
                                        uint64_t size,
diff --git a/system/memory.c b/system/memory.c
index 1b10e177f5..f424282526 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1606,7 +1606,7 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
     return true;
 }
 
-void memory_region_init_resizeable_ram(MemoryRegion *mr,
+bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                        Object *owner,
                                        const char *name,
                                        uint64_t size,
@@ -1627,7 +1627,9 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
         mr->size = int128_zero();
         object_unparent(OBJECT(mr));
         error_propagate(errp, err);
+        return false;
     }
+    return true;
 }
 
 #ifdef CONFIG_POSIX
-- 
2.41.0


