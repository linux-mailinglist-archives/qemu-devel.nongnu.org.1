Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A637F13E0
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 14:02:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r53tJ-0000O4-FL; Mon, 20 Nov 2023 08:00:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r53t5-0000Md-NK
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 08:00:31 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r53t1-0001Rj-R2
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 08:00:26 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4083740f92dso15652575e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 05:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700485220; x=1701090020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nUH6aadPR7V8diSKlF1PKzoGVdko20H3FoFOmC9kKJk=;
 b=jQVZcq30gMEh/XSZ902XIFzJzsjG4X83FeJR1AzS7WVHR27rwqZNEe2hJ1t1Pln8Rw
 9rCJwamqVikhEAb6VuxivGEHRJndl9yvJYnKRto3nVu30Og81OfJ1yPLnHnIBU31N5/M
 y+lXnH2amJTXH7TnBKbn5AQ0HCfSGlQZxf4ZaYSH/H+LzTMCfT5Ww5tBnvci5m5+w8/B
 4HUIMVKTgQukzeaRkRubuK0Z64sDALNqBMFS4B85nayLZxhHQUpaF4EWzadI2Oup1LZf
 YPHKJhZzuW47t1F1vWGKGgcsaykDx+8phklFMzC1os9wM5W2zaEnWvrOX4M6u4t899ov
 OeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700485220; x=1701090020;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nUH6aadPR7V8diSKlF1PKzoGVdko20H3FoFOmC9kKJk=;
 b=NW41brlZHVrsdYEUVIv+QMpcz+PsYpBko6GSFtc8ObVBu1Piw6czGGt50p/V5Nzw71
 xkE99HwTYq4bqS+zZaWyVoMErR7496sRyzKkHeEEPbQiBtHKsKbF5tQLuTIWx+AXCuVH
 LDZwHcaWxKwxlgXQN1ANf8fQqNGFTYG87sZfSEveVty+tZVcfFob8yUkEKbyDHn/FAof
 skfU5+/T6SwWNzd4ec05SqHbpkiUQbt+SUwudVJhOu8gLbkl89zZDN3uethXkraLDz53
 qlF5tmpky59wLXcJz7Tv/ndyBrkBtyQn3PVNXzGWs2UpYFmu8wUAVM3blyiIyjNVn6Ad
 5A9Q==
X-Gm-Message-State: AOJu0YxejivLmVPkCf8Pr6X+0V4VOH9IT7p/+Q52OARrkPHVsXDCMf5R
 Z3PLAfjROoTRfzME202pb2Q5fT1OxLL7DpNLoDY=
X-Google-Smtp-Source: AGHT+IFZk4bBXOAX6UQz39M+DAbBBgsTFyZc/Z9iq0XpniZjhpAiDWzwLKS4XYeUFe+b8+2ofFIOkA==
X-Received: by 2002:a05:600c:4f56:b0:3fe:d71a:d84e with SMTP id
 m22-20020a05600c4f5600b003fed71ad84emr5693257wmq.1.1700485220100; 
 Mon, 20 Nov 2023 05:00:20 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 r14-20020a05600c35ce00b004094d4292aesm13327370wmq.18.2023.11.20.05.00.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 05:00:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric DeVolder <eric.devolder@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-8.2?] hw/acpi/erst: Do not ignore Error* in realize handler
Date: Mon, 20 Nov 2023 14:00:17 +0100
Message-ID: <20231120130017.81286-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

erst_realizefn() calls functions which could update the 'errp'
argument, but then ignores it. Use the ERRP_GUARD() macro and
check *errp, as suggested in commit ae7c80a7bd ("error: New macro
ERRP_GUARD()").

Cc: qemu-stable@nongnu.org
Fixes: f7e26ffa59 ("ACPI ERST: support for ACPI ERST feature")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/acpi/erst.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
index 35007d8017..ba751dc60e 100644
--- a/hw/acpi/erst.c
+++ b/hw/acpi/erst.c
@@ -947,6 +947,7 @@ static const VMStateDescription erst_vmstate  = {
 
 static void erst_realizefn(PCIDevice *pci_dev, Error **errp)
 {
+    ERRP_GUARD();
     ERSTDeviceState *s = ACPIERST(pci_dev);
 
     trace_acpi_erst_realizefn_in();
@@ -964,9 +965,15 @@ static void erst_realizefn(PCIDevice *pci_dev, Error **errp)
 
     /* HostMemoryBackend size will be multiple of PAGE_SIZE */
     s->storage_size = object_property_get_int(OBJECT(s->hostmem), "size", errp);
+    if (*errp) {
+        return;
+    }
 
     /* Initialize backend storage and record_count */
     check_erst_backend_storage(s, errp);
+    if (*errp) {
+        return;
+    }
 
     /* BAR 0: Programming registers */
     memory_region_init_io(&s->iomem_mr, OBJECT(pci_dev), &erst_reg_ops, s,
@@ -977,6 +984,9 @@ static void erst_realizefn(PCIDevice *pci_dev, Error **errp)
     memory_region_init_ram(&s->exchange_mr, OBJECT(pci_dev),
                             "erst.exchange",
                             le32_to_cpu(s->header->record_size), errp);
+    if (*errp) {
+        return;
+    }
     pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY,
                         &s->exchange_mr);
 
-- 
2.41.0


