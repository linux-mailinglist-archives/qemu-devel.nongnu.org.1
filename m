Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D8D7EB802
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 21:56:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r30RJ-0003ig-Kb; Tue, 14 Nov 2023 15:55:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3rt5TZQcKCusiRagheRTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--venture.bounces.google.com>)
 id 1r30RF-0003iC-UU
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 15:55:13 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3rt5TZQcKCusiRagheRTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--venture.bounces.google.com>)
 id 1r30RE-0006yC-Cn
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 15:55:13 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-d9caf486775so7303397276.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 12:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1699995310; x=1700600110; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/0QyjxMBjq4pZ9tZszT8gz6oGvdNt3w7QoBxLLeZAqk=;
 b=aDVpT5JvqKfnVgDLjXgfyK43/ZEQfurdIsJMiS9jEGXuI0PNkoG9C2RCNVNuAIkM9F
 p1GRwjvYc7w2qZVOz3tBRytG6nKScAASakHqtoN9ecb7acVceTG/hrDP0Kdz1dE/+Zxb
 Ulwb78iX89HEPPcG26Lh2sMFPFDlx9IbTX//845QYMOXOKSmv4kOVO0hVj9xW+6Dn2rg
 zMxnmneGqgq7+uJujxZeTjy8LBk+4rNYFvRRvOTpV4mup3ogwtczrr3SCXC/ZxAyXJ5+
 6wyXM1BjoCOrjiK12mjUmsQdWVtSsasXxVEfTr3Ff7fd0RgjGiW5eaSQlc/2yZQNUDkF
 2OBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699995310; x=1700600110;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/0QyjxMBjq4pZ9tZszT8gz6oGvdNt3w7QoBxLLeZAqk=;
 b=WPBja2Ymdx+9mI+68GQv8fiV6rQHHM6jm4DMznMYh+vhvyvTBMstPGGlxFHDeVBy9Z
 RUXO4ZmYet4V5MUhGxGI8jPAHqocI8QoWznwf3i+KpS+sgQ8UMyPFjEhy2e2EHq15xVX
 uHpjMJZEDO8tS5XrqmdyqOicwIPXihKgdOwjXkIR46qkG+1vdY5BPKkJZH6d8gsTY76T
 Qu+WlZo79xrvI5wdvT9YfRovj1dqElaYoAqMxRwr8NzxFhb4cqZv0zaOf0+M/f2xfhBL
 c7pr0qJvTYPL4iGE+h1vt3eFzdJc3RvlwWtONmabzFrz4o/36Lan9CNZxJpQROs7gDSR
 23fw==
X-Gm-Message-State: AOJu0YzIRNzzrbqiXbnpmtzmR+O6UMYnox2DASBJpsBlfvrvNpF/2EGf
 A5mOB0Awy8bFLi9Ppf5x448CK2rJIMLB
X-Google-Smtp-Source: AGHT+IFIyZBOkTj52I/jZlTkv2haZ8DF+tVOGFZt82Coh1OSR/U4T5URDWYPYTRJ950IoEZxloOvpHYqMfG+
X-Received: from venture.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:5c34])
 (user=venture job=sendgmr) by 2002:a25:a284:0:b0:d9a:40ed:8d26 with SMTP id
 c4-20020a25a284000000b00d9a40ed8d26mr305694ybi.0.1699995310417; Tue, 14 Nov
 2023 12:55:10 -0800 (PST)
Date: Tue, 14 Nov 2023 20:55:07 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231114205507.3792947-1-venture@google.com>
Subject: [PATCH] softmmu/memory: use memcpy for multi-byte accesses
From: Patrick Venture <venture@google.com>
To: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, 
 philmd@linaro.org, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Patrick Venture <venture@google.com>, 
 Chris Rauer <crauer@google.com>, Peter Foley <pefoley@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3rt5TZQcKCusiRagheRTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--venture.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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

Avoids unaligned pointer issues.

Reviewed-by: Chris Rauer <crauer@google.com>
Reviewed-by: Peter Foley <pefoley@google.com>
Signed-off-by: Patrick Venture <venture@google.com>
---
 system/memory.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 304fa843ea..02c97d5187 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1343,16 +1343,16 @@ static uint64_t memory_region_ram_device_read(void *opaque,
 
     switch (size) {
     case 1:
-        data = *(uint8_t *)(mr->ram_block->host + addr);
+        memcpy(&data, mr->ram_block->host + addr, sizeof(uint8_t));
         break;
     case 2:
-        data = *(uint16_t *)(mr->ram_block->host + addr);
+        memcpy(&data, mr->ram_block->host + addr, sizeof(uint16_t));
         break;
     case 4:
-        data = *(uint32_t *)(mr->ram_block->host + addr);
+        memcpy(&data, mr->ram_block->host + addr, sizeof(uint32_t));
         break;
     case 8:
-        data = *(uint64_t *)(mr->ram_block->host + addr);
+        memcpy(&data, mr->ram_block->host + addr, sizeof(uint64_t));
         break;
     }
 
@@ -1370,16 +1370,16 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
 
     switch (size) {
     case 1:
-        *(uint8_t *)(mr->ram_block->host + addr) = (uint8_t)data;
+        memcpy(mr->ram_block->host + addr, &data, sizeof(uint8_t));
         break;
     case 2:
-        *(uint16_t *)(mr->ram_block->host + addr) = (uint16_t)data;
+        memcpy(mr->ram_block->host + addr, &data, sizeof(uint16_t));
         break;
     case 4:
-        *(uint32_t *)(mr->ram_block->host + addr) = (uint32_t)data;
+        memcpy(mr->ram_block->host + addr, &data, sizeof(uint32_t));
         break;
     case 8:
-        *(uint64_t *)(mr->ram_block->host + addr) = data;
+        memcpy(mr->ram_block->host + addr, &data, sizeof(uint64_t));
         break;
     }
 }
-- 
2.43.0.rc0.421.g78406f8d94-goog


