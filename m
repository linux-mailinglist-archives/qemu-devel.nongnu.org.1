Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC4174691A
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 07:43:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGYoI-0003WO-5N; Tue, 04 Jul 2023 01:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qGYo5-0003Tt-Q3; Tue, 04 Jul 2023 01:42:35 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qGYo3-0004A0-7e; Tue, 04 Jul 2023 01:42:32 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-55ae51a45deso2526617a12.3; 
 Mon, 03 Jul 2023 22:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688449349; x=1691041349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQ2U4ciqTykEMRLsEsLYlQMNeQfrUH1E23P+plpKsNY=;
 b=BPghNxnAqehzdurmVgZlj/ITN5orfMb6VMUxWHMu9rHOmchREG5a37UhEOCBH8q2NP
 dFWbretJw1KnuPwBTj65Oi1Iu8RIJWszIj9OLR9VFyes5FaUCXPgikSm/u1LRlJpc2MU
 u9fX7IXBvS9NLbnX079PcIwYZtT0xZM/9luaQobIP5XBEASBeOFDeN4Kcu2i666WMEDN
 WohleA4wL8iw2J99QEQ4fnLDpQn2Amx3LipCFhOOKo+yzsYLiRh5cas6zo0rf30GsT7e
 CurVrkAZP31K24YpW86UZXxpoWauuOO+EGePZOCCOGFnC6WXTeMLAe2KqvUqVTmEKw8k
 zUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688449349; x=1691041349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jQ2U4ciqTykEMRLsEsLYlQMNeQfrUH1E23P+plpKsNY=;
 b=F65Fsy98nCz45Uv724kGDnQyX+MJtyTsNq6QPcNXmFtDBbuM+kF/teHx/PNwgBojOm
 GR2u4UH9s8k9gwuV0eKX4ifs358NnzMa99Y0sOZMLDAGym08AZ3YUoJNhBel9mQeh39M
 OQ+eOYMaYIqdRsXllugoNedX0D1NjREBhOcwSoLEQsRAm7myn1AXR/KCmZJK0t8jdm43
 0RsAFrOsMMCf8qTgRw3fqeot67BLRg5CA4TnAWZDHHK2HWMVSYYGgk7PMR//YgB/+0uU
 0evQj+OL3OifPZzCItYfqxw12DOfOTc+bnWqBOazQV4n89TIRkz3eMYjEgmnjvxyb/SS
 ElSg==
X-Gm-Message-State: AC+VfDyhXcmUCa9nRNFboymFpVkMLvK4OCf2p4ErjaF10BP/v+ut8Zn+
 EdSJ2AkRyEIoVfDPfhme4O34LQ+nwGY=
X-Google-Smtp-Source: ACHHUZ5M4nyxS5WjduqZhWcQlwHqVcpZRWeVESmAaGDzpDkSoYhdv4f/XKKpBm1gfa3pF+96FTXSFw==
X-Received: by 2002:a05:6a20:488:b0:103:d538:5ea6 with SMTP id
 8-20020a056a20048800b00103d5385ea6mr9189255pzc.48.1688449348946; 
 Mon, 03 Jul 2023 22:42:28 -0700 (PDT)
Received: from localhost.localdomain
 (2403-5808-8af8-0-7926-51ea-3ff2-71dd.ip6.aussiebb.net.
 [2403:5808:8af8:0:7926:51ea:3ff2:71dd])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a17090311c900b001ae59169f05sm16261879plh.182.2023.07.03.22.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 22:42:28 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 4/5] ppc/pnv: Add P10 core xscom model
Date: Tue,  4 Jul 2023 15:12:03 +0930
Message-Id: <20230704054204.168547-5-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230704054204.168547-1-joel@jms.id.au>
References: <20230704054204.168547-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Like the quad xscoms, add a core model for P10 to allow future
differentiation from P9.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/ppc/pnv_core.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index e4df435b15e9..1eec28c88c41 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -167,6 +167,47 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+/*
+ * POWER10 core controls
+ */
+
+static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
+                                           unsigned int width)
+{
+    uint32_t offset = addr >> 3;
+    uint64_t val = 0;
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
+                  addr);
+    }
+
+    return val;
+}
+
+static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
+                                         uint64_t val, unsigned int width)
+{
+    uint32_t offset = addr >> 3;
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx "\n",
+                      addr);
+    }
+}
+
+static const MemoryRegionOps pnv_core_power10_xscom_ops = {
+    .read = pnv_core_power10_xscom_read,
+    .write = pnv_core_power10_xscom_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
 static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp)
 {
     CPUPPCState *env = &cpu->env;
@@ -315,8 +356,7 @@ static void pnv_core_power10_class_init(ObjectClass *oc, void *data)
 {
     PnvCoreClass *pcc = PNV_CORE_CLASS(oc);
 
-    /* TODO: Use the P9 XSCOMs for now on P10 */
-    pcc->xscom_ops = &pnv_core_power9_xscom_ops;
+    pcc->xscom_ops = &pnv_core_power10_xscom_ops;
 }
 
 static void pnv_core_class_init(ObjectClass *oc, void *data)
-- 
2.40.1


