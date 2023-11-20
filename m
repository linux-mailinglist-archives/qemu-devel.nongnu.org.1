Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 008777F1F3E
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:35:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Bve-0003vP-RP; Mon, 20 Nov 2023 16:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BvS-00039q-Bz
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:35:27 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BvQ-00041t-Lb
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:35:26 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40b27726369so1511505e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516121; x=1701120921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7/Bz5MtMeHpeaKi/bqx4so110l8AvikzKIx6tOl8A8=;
 b=nh8AX2v4N0slJSKx3A746qNCDQIZXckN0yTyQJP/BsvILBlGSTi1I8UD9jWHqRlp/X
 vfB9hDkXJiJsZJ6VvURwGzcplFGnJgkCTgY/5vImDdHR2QXKHyoswm1q1Us8cnoPY3dC
 7gVMZTxPFJxYPTe4C55vZtqgS2EXpUHU33LhPnT0W0AtouuZoBHdeSTvAV2mN8Cf1XRE
 mR35db0paKsnBMi3uShHByY8eTXZH6RxcpLUSnDWRtsOGowSuW5WxaruR4CGuhSwEEf7
 lpmyqkIwqrSFqq/c0f5GPMVZA52bZmFbF8elObMXB2FgZDTs5s5/6yFkkJ0GcNy5ttVP
 KPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516121; x=1701120921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7/Bz5MtMeHpeaKi/bqx4so110l8AvikzKIx6tOl8A8=;
 b=HsDIhUbVImom6CjzZ2OHPW4TBvTmql0JrBBd3+SQfNWcVmbGbnkKukmjd1H33GR9wR
 L1yzgvXC2fcvNkMWdXihS/WiI5g16iug/kWtaHRDoMlADYxBU2WL7ooUwxup5ec7WHy/
 zf/IjJKFiRRFuSR0SJNVfKdqHLaVeoJ4n/GEGptBXAD6dNS3SmyURNhnRwsbihcdfPQL
 2tA0lJjqKo4CIfh328xEnwM4fzaRAg20TLDSLctFo/4TXe0ZNr9AZu2IXB6gesCj+Jtv
 1CF6oX7BMTpUFPakjaeFvP6m512pln4O+lK+bOTTPbAQvYNBVEsu9uvW0Y94T1yHbXLr
 aJwA==
X-Gm-Message-State: AOJu0YxHrJvTdFlMb46oAoQbgF9Lz33bK9tyQSHt1s8Scn+wr8xrH1L9
 Ea5Zi02ZpUZZA/j5sG1ZDkmPe/Z/fLtWIWoL2jI=
X-Google-Smtp-Source: AGHT+IGaf4RaD2Uhn0xo8hDQEg/NMe2xKILXRUs6IGBmGf9HM0Hy+38NF3wmAg1VdJxGo0IYaxyevQ==
X-Received: by 2002:a5d:5b0d:0:b0:32f:7c6c:aa13 with SMTP id
 bx13-20020a5d5b0d000000b0032f7c6caa13mr8626935wrb.24.1700516121465; 
 Mon, 20 Nov 2023 13:35:21 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 q12-20020adff50c000000b003296b488961sm12377965wro.31.2023.11.20.13.35.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:35:21 -0800 (PST)
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
Subject: [PATCH-for-9.0 13/25] memory: Have memory_region_init_ram_from_fd()
 handler return a boolean
Date: Mon, 20 Nov 2023 22:32:47 +0100
Message-ID: <20231120213301.24349-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
index 2034a48544..f81b48499a 100644
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
index 4a36779ba1..e55fe3dfdf 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1661,7 +1661,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
     return true;
 }
 
-void memory_region_init_ram_from_fd(MemoryRegion *mr,
+bool memory_region_init_ram_from_fd(MemoryRegion *mr,
                                     Object *owner,
                                     const char *name,
                                     uint64_t size,
@@ -1682,7 +1682,9 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
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


