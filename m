Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC647F1F42
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:36:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Bta-0000su-Kr; Mon, 20 Nov 2023 16:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BtX-0000sA-Gm
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:33:27 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BtV-00038C-0R
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:33:27 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40839652b97so18294705e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516003; x=1701120803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yy1snK9B+SCgWiCxmQTHuCxjH+9ISs/0CoWZHoMFEnQ=;
 b=nBb/tg7vnqbGh4qi0HIlSVpJFdSijMscvVO5AeDmwK9EtEwD1XMFB2FHFA8C0msjNz
 QMUXEDuqMQs6de49qxwMW6sH/+Y3/wqm95tMX8dKKSYtg2Q0mj5wOPU/dWM9vxl0TJMz
 dDIHvxplGtKyyXBvEV+X7eUxdTjRa7UxwRczhAii9OpXfUpLiga1tyvmBMfdNQB8UD+B
 nJdy8Ty9b5UIAJArKxC84DiQUq5fLsN4G6hwCx8r2zJO0ijcZs9IJcwvMqEZrp11+a8d
 QnFvC50goDhyyybdecjtSMmop3UkE6t3STiZ1WZTP7gu3UrFtFkm2KBRaYY+wnXwZbo/
 zY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516003; x=1701120803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yy1snK9B+SCgWiCxmQTHuCxjH+9ISs/0CoWZHoMFEnQ=;
 b=YhlGm+c00NCKAym/thZDOC2t+/Oluz46r8p+9g7r5NAqD7Oo4qVKmYvO+glZpc6H9S
 queSdrSBLWGOZrbkpq0thS93qZiAYEOspRETD9XuOwLOvcA3xFwY/8W6q9vBTHr+xVnu
 WAwy01Nj+M+ATmj99eQvJAfgCDJAuLoBQDgbc7ZBPYolEwY4WuKuOc2oLtKuP0JHBHGt
 JGZdq00h6XyqTUBWfaX4chtFPXYaJubd37YBb2CPUo8oziBWbnsPX7EMhQVSOeqJCjz+
 1RQsuzUIcQMVEgvNsGyYQYYxXhDDJ2qOSCoInC0KDGiT5hvRw4eLLyBFODr3U+b4jBWm
 7mgw==
X-Gm-Message-State: AOJu0Yzjuj5Y3Z/9lh+KEkWelyWKS43Lccor0fZQYS2Gi1Bj691FVkNP
 D2151NYnQUD6cVEzXTFqx7Ew508VOz4jvozY8sE=
X-Google-Smtp-Source: AGHT+IEkr26kiTb0vYXxIqK3/wBlqfrekq6CRZlLvz+0+kUPl7IXjrSmAPlwz1l/ysLWkRuBzcmP7A==
X-Received: by 2002:a05:6000:18a2:b0:32f:a3fb:835b with SMTP id
 b2-20020a05600018a200b0032fa3fb835bmr7271877wri.44.1700516003375; 
 Mon, 20 Nov 2023 13:33:23 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a5d518f000000b00332cba50ac3sm1859981wrv.45.2023.11.20.13.33.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:33:23 -0800 (PST)
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
Subject: [PATCH-for-9.0 01/25] memory: Have
 memory_region_init_ram_flags_nomigrate() return a boolean
Date: Mon, 20 Nov 2023 22:32:35 +0100
Message-ID: <20231120213301.24349-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
index 831f7c996d..f038a7e5cf 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1310,8 +1310,10 @@ void memory_region_init_ram_nomigrate(MemoryRegion *mr,
  *
  * Note that this function does not do anything to cause the data in the
  * RAM memory region to be migrated; that is the responsibility of the caller.
+ *
+ * Return: true on success, else false setting @errp with error.
  */
-void memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
+bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
                                             Object *owner,
                                             const char *name,
                                             uint64_t size,
diff --git a/system/memory.c b/system/memory.c
index 4d9cb0a7ff..313dbb2544 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1583,7 +1583,7 @@ void memory_region_init_ram_nomigrate(MemoryRegion *mr,
     memory_region_init_ram_flags_nomigrate(mr, owner, name, size, 0, errp);
 }
 
-void memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
+bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
                                             Object *owner,
                                             const char *name,
                                             uint64_t size,
@@ -1600,7 +1600,9 @@ void memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
         mr->size = int128_zero();
         object_unparent(OBJECT(mr));
         error_propagate(errp, err);
+        return false;
     }
+    return true;
 }
 
 void memory_region_init_resizeable_ram(MemoryRegion *mr,
-- 
2.41.0


