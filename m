Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9717478F6BE
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 03:30:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbsyd-0002to-7H; Thu, 31 Aug 2023 21:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qbsyV-0002qq-UG
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 21:29:27 -0400
Received: from mail-yw1-x1144.google.com ([2607:f8b0:4864:20::1144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qbsyS-0007WW-Oq
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 21:29:27 -0400
Received: by mail-yw1-x1144.google.com with SMTP id
 00721157ae682-59234aaca15so16504687b3.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 18:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693531763; x=1694136563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pq4K1DRMCsdduEbuGuJ200122U1I+V8+TOdtq9hf9Q=;
 b=f91O3TNaW208+8uAJJuN4045Wj7XbKrpC4GBuiwdGWeLdXuZrqn/jMhBce2XblWb0Z
 ugCk4Q9dlZgnYcN8iOWByRg1D7Qa8VGCRiq06anz1D7q5BP6zAkIhGcfaC2Cfci244Kx
 Nsn7l5ejqu0Fzcj2Wd8JTLg1jF1rTfq18l6tk/obPRPLP2iTlZu0o4v7n4o7pR1Vcm4Z
 ei4RQKowGQYhcGXF7Q1Ux4caXih9ymaS3gyKPxeBgzOvYwWMjFEWR5fPF7+KyJEi5+Yd
 QEWn5xkiukIP2C+1+/Rz/ZVaH49+oD3p5QypsDzKZ2CvcBhwcRM9lIVJDdEylg3X8LCE
 HHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693531763; x=1694136563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6pq4K1DRMCsdduEbuGuJ200122U1I+V8+TOdtq9hf9Q=;
 b=SXvk2bhbF4juhRsZ3aXSinmfKV6Cdzv+UrVbzV8+9Y0bcqqYVpOAE9d2rSRLSiNxzm
 jQtg8TCe3Mi8e4Ec8CxinYlOoa/TO5zMyNWdCcKii/bP+xpOcFE3VdM59VQucsJ2T3Jj
 uczOoGixzYDflxJCLOjlY9VpLNKro5RmZ8meCPKX8ZCvI33mujrqW5DYmVE4Vfni4qmz
 9Jj5uPSNuJIX15axpJdlO+RqwMf/UQ2mTnhHY+pFNKnjxmtcqxQp9uUnU3iZd/ronOKv
 aurBw/9UBi+GPa5+INschj4vjSzPQXnkO1utUwIbvz++TZXmY2oftxcaW9gSQeHjIoyE
 z0Fw==
X-Gm-Message-State: AOJu0YzwxWK6Jtajx/d0zOJErasKFCqQq1lFNf/CZi60GMz5Byf9mrhN
 88jymd/BjnC/Z9iT1qcXRivXprvZFLrn
X-Google-Smtp-Source: AGHT+IEJPgTPHVRYS7i4yrvWXex07bwZ3MY3D94Tlo3IEKDVY/laIV/4Ngd3nqRkijMM4+JN86bGYg==
X-Received: by 2002:a81:9141:0:b0:586:6a71:b018 with SMTP id
 i62-20020a819141000000b005866a71b018mr1181617ywg.20.1693531763637; 
 Thu, 31 Aug 2023 18:29:23 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 g186-20020a0df6c3000000b00559fb950d9fsm810447ywf.45.2023.08.31.18.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:29:23 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org, junhee.ryu@sk.com,
 kwangjin.ko@sk.com, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 2/5] cxl/type3: Cleanup multiple CXL_TYPE3() calls in
 read/write functions
Date: Thu, 31 Aug 2023 21:29:11 -0400
Message-Id: <20230901012914.226527-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230901012914.226527-1-gregory.price@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1144;
 envelope-from=gourry.memverge@gmail.com; helo=mail-yw1-x1144.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Call CXL_TYPE3 once at top of function to avoid multiple invocations.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/mem/cxl_type3.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index fd9d134d46..80d596ee10 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1248,17 +1248,18 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
 MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
                            unsigned size, MemTxAttrs attrs)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
     uint64_t dpa_offset = 0;
     AddressSpace *as = NULL;
     int res;
 
-    res = cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
+    res = cxl_type3_hpa_to_as_and_dpa(ct3d, host_addr, size,
                                       &as, &dpa_offset);
     if (res) {
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
+    if (sanitize_running(&ct3d->cci)) {
         qemu_guest_getrandom_nofail(data, size);
         return MEMTX_OK;
     }
@@ -1268,16 +1269,17 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
     uint64_t dpa_offset = 0;
     AddressSpace *as = NULL;
     int res;
 
-    res = cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
+    res = cxl_type3_hpa_to_as_and_dpa(ct3d, host_addr, size,
                                       &as, &dpa_offset);
     if (res) {
         return MEMTX_ERROR;
     }
-    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
+    if (sanitize_running(&ct3d->cci)) {
         return MEMTX_OK;
     }
     return address_space_write(as, dpa_offset, attrs, &data, size);
-- 
2.39.1


