Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CF8796DB9
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 01:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe2Fl-0006BS-4y; Wed, 06 Sep 2023 19:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qe2Fh-0006BJ-1Z
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 19:48:05 -0400
Received: from mail-yw1-x1143.google.com ([2607:f8b0:4864:20::1143])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qe2Fe-0006ab-Qs
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 19:48:04 -0400
Received: by mail-yw1-x1143.google.com with SMTP id
 00721157ae682-59288c68eb8so4560417b3.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 16:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694044081; x=1694648881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pq4K1DRMCsdduEbuGuJ200122U1I+V8+TOdtq9hf9Q=;
 b=GBmv1XSkLCSk58eQtyQWGP8VnxCoicbB6KK6a/mSgmApPFqHtzl9zihOiOpW5F+Cp6
 s5L24t69tQkewPmjfSJHmltxln9f3FsORD2c7SWb+vq5tVO237cMd2gZXs5yWqWIMMyN
 aN3DCfWTUzaqS0yKjR3wsu+wFbikvggXssP8i9vQsEIrnKXFrp3cr32sK9dmhpfSX70/
 hSgL0h7dphBawG09gPloKDFEYkwBfgrwux5uCC1X9nhMOR5KWrvrRzMsGCNSDJ9hWUqH
 ygLZuAOoWeqOrB5PLQo/oyDBHBiJZ8RuNZ4Vy74nTs9UtI9DMtp2jSbPjRHomFa9Eua2
 mpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694044081; x=1694648881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6pq4K1DRMCsdduEbuGuJ200122U1I+V8+TOdtq9hf9Q=;
 b=LjdeoWHWrLBLE4HJE2rLcaatYQ+wXzcshpxcJzwTc4ji5eUfDDja33olhO//cO5Jr+
 PSt95OaP9MWH679K3L+twc1zCQIh1X049e2D6T06VCcoYtOIdeXPePT2+f0biF8YxgBn
 zGNpm2K17jidSFcH7aB3UXk2rPKegHw2XKcj9iQsOnALOHRCA5z3/PWUiszqB9F+WujN
 nFd4nywTFE0pfTeOxUKrmFGeA54/TLKdm9ixs0bGHa2oPE68KWQfW75eUHtuQlsHUFG5
 +hSLApvy6OmIz6swfmeJNK+VZeBZgCCGU1x3ynQYDD1bonTfw1t/0Ypez2e/18jnrZ3u
 DNfw==
X-Gm-Message-State: AOJu0Yxo9+rxtGAhZbiGsyXOEzr7nC5JBtdl5JOoVFe0rCqZdjp3y96C
 bZC2BrGXgVyV8qtzJoRZ/NeqJWzQ9hrt
X-Google-Smtp-Source: AGHT+IH/ubpKztgn1qDvJM/VkrWOg2yBzVO3CflsLQdbMmkZBe+KAhcEoIrZzMeoczKFrs8vbymL6Q==
X-Received: by 2002:a0d:d685:0:b0:589:db22:bfd6 with SMTP id
 y127-20020a0dd685000000b00589db22bfd6mr19575436ywd.40.1694044081583; 
 Wed, 06 Sep 2023 16:48:01 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 v191-20020a8148c8000000b005832fe29034sm332107ywa.89.2023.09.06.16.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 16:48:01 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org, junhee.ryu@sk.com,
 kwangjin.ko@sk.com, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v3 2/6] cxl/type3: Cleanup multiple CXL_TYPE3() calls in
 read/write functions
Date: Tue,  5 Sep 2023 20:15:13 -0400
Message-Id: <20230906001517.324380-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230906001517.324380-1-gregory.price@memverge.com>
References: <20230906001517.324380-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1143;
 envelope-from=gourry.memverge@gmail.com; helo=mail-yw1-x1143.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


