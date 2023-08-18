Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E35878116F
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:16:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX322-0008LV-A3; Fri, 18 Aug 2023 13:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31w-0008Hw-Cc
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:00 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31u-000842-67
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:00 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bf48546ccfso4262025ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378776; x=1692983576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7kaLhwLbHzHqv/PeQXejQChX9nX84J3A2xjA5ly6h/g=;
 b=f05l70vvYRnhP6y8m0P6u93FGTrUdJXkBcUtMGA8dicHwjrgjt2KocZ7vBUDREeKEs
 7YH/bin0vbLa5Y+1RJsBUnLSEm3Y6+JmZ+lnqsnXpWCgQ80i3QfEh3PLI1lYLpMPi8s2
 dhkkQzEGl4pJ+/xkDIIx1EVu+akQBBmOkuIQiyJ1RzhzkKHIjIBkAbEpe7/Y3/ZL3Qjm
 NmUoqACjgD4G88F+LdmPOEo9lu/qXbMHBvmacdlmVauYhWUzrdPBApUW8uPL1eVmEB3c
 CQOuxjcl1jNuQSpCcLkMRkWtLw5xS+33rHMQzODC/hcRZ7cCPGm7iaxoFA/qcVhH3K4O
 RoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378776; x=1692983576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7kaLhwLbHzHqv/PeQXejQChX9nX84J3A2xjA5ly6h/g=;
 b=QOcpHFn2ep6H/bmwBuK6Qsoe3rO26FdQD39bV/nJTpd2MQRUw3KMyByVfnwvBdqtk+
 Pw27OBzHD5v9J/5k/vHV2IqyCO1+J1wyv3CURUHzrezG6KhrQXuImIeX9/QqSEPY5E95
 4pRIyLuHxQfBhP1UmeYePjJuDdabntA0Liyvd3O1AkUSS26yxn+++YCaB3xOmJ7jH51I
 Gqwi9N7Ku90iS+sysnSWksHaW6Om8IevSBm9OevA6xKn/FB0w0dioOrPFsRwFcpQFwQo
 AQMk0U11+63Dxc6kR2NitCF5AwySHMypjj/P6v62kZmw9q6NP6Xx53eV4zeJVGZbXKbs
 L9Tg==
X-Gm-Message-State: AOJu0Yx3S4JXA8wkZ2RyRbES8bLmwbdbDLAG+1ucdWY9vEZ6Jw/WGf6I
 PzII3TrB+xnIBslOtZikx6U0869jWafixlYaekE=
X-Google-Smtp-Source: AGHT+IEjyFut8uvaCW+cu1FZKXXVcOX/01CABdoQzzbHY90GElmZTVYsZYV9z4pGtxwclSriD4czmg==
X-Received: by 2002:a17:903:449:b0:1be:f76e:7664 with SMTP id
 iw9-20020a170903044900b001bef76e7664mr2650251plb.29.1692378776321; 
 Fri, 18 Aug 2023 10:12:56 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/33] linux-user: Do early mmap placement only for reserved_va
Date: Fri, 18 Aug 2023 10:12:14 -0700
Message-Id: <20230818171227.141728-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For reserved_va, place all non-fixed maps then proceed
as for MAP_FIXED.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index caa76eb11a..7d482df06d 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -495,17 +495,19 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
     host_offset = offset & -host_page_size;
 
     /*
-     * If the user is asking for the kernel to find a location, do that
-     * before we truncate the length for mapping files below.
+     * For reserved_va, we are in full control of the allocation.
+     * Find a suitible hole and convert to MAP_FIXED.
      */
-    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
+    if (reserved_va && !(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         host_len = len + offset - host_offset;
-        host_len = ROUND_UP(host_len, host_page_size);
-        start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
+        start = mmap_find_vma(real_start, host_len,
+                              MAX(host_page_size, TARGET_PAGE_SIZE));
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
             return -1;
         }
+        start += offset - host_offset;
+        flags |= MAP_FIXED;
     }
 
     /*
-- 
2.34.1


