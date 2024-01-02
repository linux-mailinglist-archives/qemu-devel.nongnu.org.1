Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93248821635
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:00:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3J-0003KY-A3; Mon, 01 Jan 2024 20:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3I-0003K5-9y
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:44 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3G-00071g-RW
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:44 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3bbd6e377ceso3057820b6e.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160721; x=1704765521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SjN83cVYCiop/vN+SdqqhBrpQ2lAiZ7szn5smiP5b+Q=;
 b=sbaovuYRX985LPidP+U2lfMs8Y5PZ9ZgvqEEWAFQtNbaFIBlS1YS0y6odAF/kWEOuF
 fOqyMJXg2y3xyjYyVe3vYdmph/44jF7l0wUPvmEUPBc3c9YEjXYMp24jt1rMu2k0g3fy
 V9zxY3lu1YvivS3ltdousGJEl0gc+QUwmikZ1sn69b+8tPwfk4bIUwDW/mxiP+LLiuR+
 hFzH2ONXIGom9exAaVO6Asulzk+1O5gC1B+WC/5V1NwKSCC/RJ+RdfAmxU2u7D/MIi0n
 uh2CnF00BDgMPwethy1x4aILx1dZQSx/3gYede5VzVGpNFd1d/H+65+DNmbkglUb1Nul
 HDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160721; x=1704765521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SjN83cVYCiop/vN+SdqqhBrpQ2lAiZ7szn5smiP5b+Q=;
 b=FgEOi3yembWsQ17O5NdJYnEQPq+VnJseG/iwp92rEcBeuPHPtTLvuu5eY8+FY4s/24
 t/Rg+iFzB6BCaEpd/RYSTwFMICbucObL4stpfEM4BuQ9als8dda6H9QEkivIOQC0otd4
 xrg82cc1K8nNGtGTH16JFtEHKO1fu7I70B0ZhwgDN6xFWmsZoWYdV/5/wFy06+sojwjh
 86RNzhvU8l3fvnifap+fSSik3ZhOkUi+Gk0vfOFe3ZLpm/qPtdTa3ghhD96n95hfLtAY
 6Lq/sUSLWt3Phb/UnZVMfFJfk26UaBbOI5p0CORjjJoEAS0HrJmdSRvyukqBzXVKkdwG
 z8Hg==
X-Gm-Message-State: AOJu0YzD5zATeToHwptX2R3Y0P0uyFGz0EN0BKxS3R+fnkVPlqTbvp8A
 r4zrDlKb4oBDtD0CSu2P11GtlBT50Ea5WSOcNjjI4ai4CDs=
X-Google-Smtp-Source: AGHT+IHSAkNQIUF9l/OvgwFEI9CCyA655dCGDJQx1UepLwuAqHCzcmzVD6cVpvpmTZ7xvPvJdcPbnw==
X-Received: by 2002:a05:6808:208e:b0:3bb:f5f4:e5ce with SMTP id
 s14-20020a056808208e00b003bbf5f4e5cemr4818747oiw.41.1704160721692; 
 Mon, 01 Jan 2024 17:58:41 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/33] softmmu/physmem: Remove HOST_PAGE_ALIGN
Date: Tue,  2 Jan 2024 12:57:49 +1100
Message-Id: <20240102015808.132373-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

Align allocation sizes to the maximum of host and target page sizes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/physmem.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index c09953270f..c1e48dfb6a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1680,7 +1680,8 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
 
     assert(block);
 
-    newsize = HOST_PAGE_ALIGN(newsize);
+    newsize = TARGET_PAGE_ALIGN(newsize);
+    newsize = REAL_HOST_PAGE_ALIGN(newsize);
 
     if (block->used_length == newsize) {
         /*
@@ -1916,7 +1917,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    size = HOST_PAGE_ALIGN(size);
+    size = TARGET_PAGE_ALIGN(size);
+    size = REAL_HOST_PAGE_ALIGN(size);
+
     file_size = get_file_size(fd);
     if (file_size > offset && file_size < (offset + size)) {
         error_setg(errp, "backing store size 0x%" PRIx64
@@ -2014,13 +2017,17 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
 {
     RAMBlock *new_block;
     Error *local_err = NULL;
+    int align;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
                           RAM_NORESERVE)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
 
-    size = HOST_PAGE_ALIGN(size);
-    max_size = HOST_PAGE_ALIGN(max_size);
+    align = qemu_real_host_page_size();
+    align = MAX(align, TARGET_PAGE_SIZE);
+    size = ROUND_UP(size, align);
+    max_size = ROUND_UP(max_size, align);
+
     new_block = g_malloc0(sizeof(*new_block));
     new_block->mr = mr;
     new_block->resized = resized;
-- 
2.34.1


