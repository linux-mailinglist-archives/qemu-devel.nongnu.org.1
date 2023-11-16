Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB037EE54B
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 17:38:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3fMB-0004Pc-VA; Thu, 16 Nov 2023 11:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3FEVWZQcKCikaJSYZWJLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--venture.bounces.google.com>)
 id 1r3fMA-0004Ox-Ax
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 11:36:42 -0500
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3FEVWZQcKCikaJSYZWJLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--venture.bounces.google.com>)
 id 1r3fM7-0002Dx-4V
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 11:36:41 -0500
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-d9cb79eb417so1233642276.2
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 08:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1700152596; x=1700757396; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5CTn0KBxEijOlL5af+zRIi/ha7gH4yvTFUhlq3cejJo=;
 b=z4DXnRp6BpPBbodJVLHSCRvm+Nxeq436QcbRD97cwpYnfmm8zUn5obae9B2/Hluquz
 6UO+GRSJ/a7ECKHX10gyOv7kkDREEpog5MH6PL0kioSxauf+yKtrtnvajb0v1sx9yfUp
 l+Kb1zxq7194RdFuaMaafc+NkxuA9AtLd1PdFTgnKTv2w8Evph2D7/ARMjJyW/tjfdl/
 zsuTameQBzx0DhFkOX8grXL0B9uayoCXcIsReTLZEwiLO1pULiHZPTKxHjn+WEgsehGI
 2HHMb65uuLp62YBomaMsGDtNzXC01w8hdA7jLKl7kheNMlz/XZ4xzIuucj0BZAUHnN8p
 BPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700152596; x=1700757396;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5CTn0KBxEijOlL5af+zRIi/ha7gH4yvTFUhlq3cejJo=;
 b=dA1r6gJh4SIRxyr+q9DShWdKuDp0nOvwDS+DXGA14wrRw0qyR2XxK9mgu5z1QP0o8q
 1LlZwcXl85gwilVMLIm0Xydmg1LY8aTG7sO3QMNhvvPZv+HQzPI+r4Dc5Ld4p6M18+qc
 /WRLmngenYckcreIPpiKbIrQTL9Wac8lFItBctnQM+xozRRbIsuuBQKxtIyqFDKJBbBA
 eHNpUww0EmRTrwMC7ndyYS0zTCxsVMRY4VzICGuZ1ud8EtQzuKobnitYcgAmfk6dNc8r
 DoacS3XNh59UXoAmMFgpz+UACY2ATn0f99zxEvmGa7hb8lyLBpFcJD52Qbk28wF0HaCY
 plZw==
X-Gm-Message-State: AOJu0Yy+pmI2i4rxAW1A4ozQ9GrIOW/xR13cMZEQ8lzasHKY5Q0P3n3h
 UBNesqPEoGk8ORg5lp9bMOmCH0r3IBU9
X-Google-Smtp-Source: AGHT+IGh/SjmEekb+cIIgdZV4J0XNU+2nQji5iQRxwTj1L3JdDdJqNB3Nc0fCJGXP7Q6fNVniHCEaurU37eN
X-Received: from venture.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:5c34])
 (user=venture job=sendgmr) by 2002:a25:6cc2:0:b0:da0:c9a5:b529 with SMTP id
 h185-20020a256cc2000000b00da0c9a5b529mr422065ybc.12.1700152596214; Thu, 16
 Nov 2023 08:36:36 -0800 (PST)
Date: Thu, 16 Nov 2023 16:36:33 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231116163633.276671-1-venture@google.com>
Subject: [PATCH v2] system/memory: use ldn_he_p/stn_he_p
From: Patrick Venture <venture@google.com>
To: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, 
 philmd@linaro.org, peter.maydell@linaro.org, richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Patrick Venture <venture@google.com>, Chris Rauer <crauer@google.com>,
 Peter Foley <pefoley@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3FEVWZQcKCikaJSYZWJLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--venture.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Using direct pointer dereferencing can allow for unaligned accesses,
which was seen during execution with sanitizers enabled.

Reviewed-by: Chris Rauer <crauer@google.com>
Reviewed-by: Peter Foley <pefoley@google.com>
Signed-off-by: Patrick Venture <venture@google.com>
Cc: qemu-stable@nongnu.org
---
v2: changed commit mesage to be more accurate and switched from using
memcpy to using the endian appropriate assignment load and store.
---
 system/memory.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 304fa843ea..affc7ea83c 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1339,22 +1339,7 @@ static uint64_t memory_region_ram_device_read(void *opaque,
                                               hwaddr addr, unsigned size)
 {
     MemoryRegion *mr = opaque;
-    uint64_t data = (uint64_t)~0;
-
-    switch (size) {
-    case 1:
-        data = *(uint8_t *)(mr->ram_block->host + addr);
-        break;
-    case 2:
-        data = *(uint16_t *)(mr->ram_block->host + addr);
-        break;
-    case 4:
-        data = *(uint32_t *)(mr->ram_block->host + addr);
-        break;
-    case 8:
-        data = *(uint64_t *)(mr->ram_block->host + addr);
-        break;
-    }
+    uint64_t data = ldn_he_p(mr->ram_block->host + addr, size);
 
     trace_memory_region_ram_device_read(get_cpu_index(), mr, addr, data, size);
 
@@ -1368,20 +1353,7 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
 
     trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
 
-    switch (size) {
-    case 1:
-        *(uint8_t *)(mr->ram_block->host + addr) = (uint8_t)data;
-        break;
-    case 2:
-        *(uint16_t *)(mr->ram_block->host + addr) = (uint16_t)data;
-        break;
-    case 4:
-        *(uint32_t *)(mr->ram_block->host + addr) = (uint32_t)data;
-        break;
-    case 8:
-        *(uint64_t *)(mr->ram_block->host + addr) = data;
-        break;
-    }
+    stn_he_p(mr->ram_block->host + addr, size, data);
 }
 
 static const MemoryRegionOps ram_device_mem_ops = {
-- 
2.43.0.rc0.421.g78406f8d94-goog


