Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 246907B70E6
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:32:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkAv-000870-Dn; Tue, 03 Oct 2023 14:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAs-000851-VB
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:14 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAr-0001gl-4k
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:14 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c5ff5f858dso9834145ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696357871; x=1696962671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A7XCl0qp/obfnCpndkgxp3n8szX7HRfUMiRlfSbBwN0=;
 b=IZC+cuCPV9xju/wVWSzvrRQbflt5yNBkSfW2yuHVeznB2G+/NQX0AIi//0tDLdxK5R
 g0LIdWG2o9tPoqYezIVbaLJRP9WeLFTA3/DnerNSY1dHfRhHCnToI9grWm+JUIxe2YKo
 YFuQJMFE+X1wB2DOMgtrd0DhOeDBXjjm4I4HLGggUVQ0VI2AyscUhvzojjmQCdi0Jl4W
 5+UqolGtf6t6EFu5dNqLWKE0MTsD80wEQ25AKPu8lVmZ3pv3UJqsc7+3ApR7hnC8Ri1h
 vE93K2Gk2Oh0Lh84EVS916TBomLLXK7xsCeTNPBNftcIQ4jLUa7y5ddMNFSOnz4RH0xR
 w8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357871; x=1696962671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A7XCl0qp/obfnCpndkgxp3n8szX7HRfUMiRlfSbBwN0=;
 b=aeh4jXH1jZQKH+2NMaU3TXhkTJ5hVVopM+5i69iXh181Tls1K13iprerPw308qQomD
 5VJaUpDtd/36x6ZaQJy68ikRJJOJg2A3OKNtuPUSK66ehlhT3EyDu2FXZKeHIne+OwXQ
 DlxpaC+xLS3sFHlCO3VmEEDhdDqV0s3eoGVAeE8CEBe/MG+HSuR+LrHZU+5YuwsFLspi
 aAVPSYdM7BqhYXR0Mr2xe8O1nemk0P5G+crm6AXlqNTmd4TEHVJxjHZxSZINuYE6166X
 QrxEl9BiLeTSsxQGEclco9vJ5vlyAYfsNcFgYSwaLtox7m6BC6s1nYJ7VxqN4v8G6Bjj
 PRZg==
X-Gm-Message-State: AOJu0YyU8lgFGNTrSwn5SGDgWba4cQ3SJpZXcV6czxk/UlvkQBysmqse
 iU+AlJS34gtn/6YLNsmIoQbyAc7jVCTsGNdmej8=
X-Google-Smtp-Source: AGHT+IEocV43eVlzO9zg938TVFDfWHeph4NLOdOAceVTaoON+DRKh+D9gw3anJiEtFMZo3pxO4DPhA==
X-Received: by 2002:a17:903:187:b0:1c3:749f:6a5d with SMTP id
 z7-20020a170903018700b001c3749f6a5dmr430295plg.4.1696357871395; 
 Tue, 03 Oct 2023 11:31:11 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b7cbc5871csm1920432plp.53.2023.10.03.11.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:31:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fei2.wu@intel.com
Subject: [PATCH v17 12/16] softmmu: Export qemu_ram_ptr_length
Date: Tue,  3 Oct 2023 11:30:54 -0700
Message-Id: <20231003183058.1639121-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003183058.1639121-1-richard.henderson@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memory.h | 2 ++
 softmmu/physmem.c     | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index ef23d65afc..ebdecf64a6 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2874,6 +2874,8 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    hwaddr len, hwaddr addr1, hwaddr l,
                                    MemoryRegion *mr);
 void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
+void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
+                          hwaddr *size, bool lock);
 
 /* Internal functions, part of the implementation of address_space_read_cached
  * and address_space_write_cached.  */
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 309653c722..69a853c27a 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2182,8 +2182,8 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
  *
  * Called within RCU critical section.
  */
-static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
-                                 hwaddr *size, bool lock)
+void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
+                          hwaddr *size, bool lock)
 {
     RAMBlock *block = ram_block;
     if (*size == 0) {
-- 
2.34.1


