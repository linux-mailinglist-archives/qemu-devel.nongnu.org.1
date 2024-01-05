Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A86825759
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:59:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmRS-0005KD-IU; Fri, 05 Jan 2024 10:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmR8-000316-Fy
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:48:42 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmR3-0005zE-LI
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:48:41 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-336c8ab0b20so1479148f8f.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469716; x=1705074516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqhTmAjxaD/BTNoVLzXvd/YAl4zMVPKwo4ul47FACnE=;
 b=hG+QZSF0V851L7X8jojOvd9JZ4d5qjF9niXHq0p9KQj/BkYgySSeSx8M/nvxpE4D19
 nXa2lYEQnTb0aATCyaoj6yQzom6DfeFg2LpcysBT1A1ANiXPCknvfHs6tA9SaeYDF/f1
 U5g1gehpehK82xs48K3kz6+gZ5qhVFVlsf17Tka5pS4YxESQ9A5YmD55OUijQKeIkd3W
 n+BFve+c6BVfjZpdnS9aVeFZ8BUdjQcHKJhYQvRFfTJJFW9NeCJtylw/O9QXqkPLD1PS
 pTqkO/AqkpWGHoRJqxD+a8hRifOEdI83lS7BK27vfGfCFbyvY6iPZRSS59yM9kvI/lCr
 gN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469716; x=1705074516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EqhTmAjxaD/BTNoVLzXvd/YAl4zMVPKwo4ul47FACnE=;
 b=DkwlF2Zczp1iX/QwOCLmur4LL75XiKgHuzlHUzO0LPh5GHHTgN5lNJhIBaRAaavVjG
 o1prpSycECsFHSQRbbuim9WbqOHdi98WpKl33rHzZp07Sqp4cxBGj4sIheZJEIy/8r0a
 It9b0YYUr73QSt8XOhbplpXT0yJZvlfWl+NlFvxZXaNOL1NTdXu6wF4PgzF1Eq8LLlhj
 crgGANfcOXI9qq+w668Gfj3LCr1QaFl9ulS7FGJ9NNGWbOLaC5uy3wiKs8yAaHjH7eTE
 uXXVxovJseOOOm9kbSKf8REGVTY/+9uLMTSyj+x+ZDIcwa/C0dK1mSPVOPCI9SEKH3h9
 es0g==
X-Gm-Message-State: AOJu0Yys1tePBXM9FCZJBA1YiK8WrLk03HR+oCRLpIevsB5o0o9H3hRY
 Di5pMDW3EKsZD7biA+svBMQPiA/spP6QOrqDETonzqetxl0=
X-Google-Smtp-Source: AGHT+IHK2kFr48UQS0bqpJVz6a1E49DB73EV3GNpMskug7Jop80bPyFSPeLiiJHWQyevrricJnKzIg==
X-Received: by 2002:a5d:6e82:0:b0:336:7d12:caf3 with SMTP id
 k2-20020a5d6e82000000b003367d12caf3mr1547672wrz.44.1704469715876; 
 Fri, 05 Jan 2024 07:48:35 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 t1-20020adfd001000000b0033672971fabsm1602690wrh.115.2024.01.05.07.48.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:48:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 52/71] memory: Simplify
 memory_region_init_rom_device_nomigrate() calls
Date: Fri,  5 Jan 2024 16:42:45 +0100
Message-ID: <20240105154307.21385-53-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Mechanical change using the following coccinelle script:

@@
expression mr, owner, arg3, arg4, arg5, arg6, errp;
@@
-   memory_region_init_rom_device_nomigrate(mr, owner, arg3, arg4, arg5, arg6, &errp);
    if (
-       errp
+       !memory_region_init_rom_device_nomigrate(mr, owner, arg3, arg4, arg5, arg6, &errp)
    ) {
        ...
        return;
    }

and removing the local Error variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-Id: <20231120213301.24349-10-philmd@linaro.org>
---
 system/memory.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 8db271c19e..c6562f5e86 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3627,12 +3627,9 @@ void memory_region_init_rom_device(MemoryRegion *mr,
                                    Error **errp)
 {
     DeviceState *owner_dev;
-    Error *err = NULL;
 
-    memory_region_init_rom_device_nomigrate(mr, owner, ops, opaque,
-                                            name, size, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_rom_device_nomigrate(mr, owner, ops, opaque,
+                                                 name, size, errp)) {
         return;
     }
     /* This will assert if owner is neither NULL nor a DeviceState.
-- 
2.41.0


