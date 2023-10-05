Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4727B9A5C
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:48:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFIv-0007ij-2d; Wed, 04 Oct 2023 23:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFI8-0006rX-0q
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFI5-0000KO-Di
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AyBHZxgcznnd088YayNhukDWH1TlGZpm/MILwePdz9Q=;
 b=XDBJptQv9ixbgk81925gVyiR1vy0mPcolGmJV2i4J7IKyLi9eChMpNs3KPmACvxwEiyzNb
 eFxo6xpxsuPjlndKvnygffa6skzQWh/9vQltRIMDuBaX1VbqRawEt5LUA1LEgbzfhWPih/
 stszs4xTO2eL22BoK/d9tWeDiySx5Hw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-wCIeIze7NtSMLaKUAcPJNg-1; Wed, 04 Oct 2023 23:44:43 -0400
X-MC-Unique: wCIeIze7NtSMLaKUAcPJNg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4066e59840eso3190075e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477482; x=1697082282;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AyBHZxgcznnd088YayNhukDWH1TlGZpm/MILwePdz9Q=;
 b=SAZA3sITHGbVsmnB74+/Quhi89H7xf2Eto6cSQp6Hh89jBQTH1pRDQSl9bKzzNtBGt
 pUR7xj9FeMQM1eW0dgSc5po8/EJ61Bnw8RmMCY8qaxcdy2LBFqjBKMby1pXdz6HHLdOg
 SHFZTJN8sVj2VY4VPRDmc2Bn8K4Ja31X8g1KYiS+41dlBoMzXHZFmksF3shmzDROVk+u
 ngAsWlQ6J/nkM2Xe7OQasTcwlxK8Y004AhmHeZGE+JvYxFI1vcgskAuhVjxnx/G2WoBd
 dwiG0W+M3aURedfUkLANs1Cs9/a1+LOAmStfWImMORGf4DHI7ksuZ2VKUdGc022G5LcX
 WEvg==
X-Gm-Message-State: AOJu0Yzw0jqc+YTAGVWXw+2+iKdRnY3Z8HbB5mSW9KvshwyJ62uDTqNf
 uX39Wd3NAHkbgb6p6+8kE5ndHwqoPynXsolH3Waaw5oln4S0vmLIEs8t9VcBaYZvNDmJaf5jA/t
 Jb+5QUPaBuMCUKmudGpEMZ/umgfSPjkEIKjQlsNp6Dt+wwrTvkPuxldPK9lYVBWlF8y07
X-Received: by 2002:a05:600c:11cd:b0:406:5397:315d with SMTP id
 b13-20020a05600c11cd00b004065397315dmr3903612wmi.1.1696477481948; 
 Wed, 04 Oct 2023 20:44:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEomrvf3Tq4lDy4lEdgVlAM7rzqoX49r4zIs92kXJ7ywTPE3MeKsjXJQhrVe4usmsxia6V4mA==
X-Received: by 2002:a05:600c:11cd:b0:406:5397:315d with SMTP id
 b13-20020a05600c11cd00b004065397315dmr3903599wmi.1.1696477481576; 
 Wed, 04 Oct 2023 20:44:41 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 fl16-20020a05600c0b9000b00406847c988asm2728260wmb.12.2023.10.04.20.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:44:40 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:44:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 32/53] hw/acpi/core: Trace enable and status registers of
 GPE separately
Message-ID: <40a6b8935d5862840c602f977564d2ebbea60ed6.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

The bit positions of both registers are related. Tracing the registers
independently results in the same offsets across these registers which
eases debugging.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230908084234.17642-9-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/core.c       | 10 +++++++---
 hw/acpi/trace-events |  6 ++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index c561845a4a..ec5e127d17 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -687,13 +687,13 @@ void acpi_gpe_ioport_writeb(ACPIREGS *ar, uint32_t addr, uint32_t val)
 {
     uint8_t *cur;
 
-    trace_acpi_gpe_ioport_writeb(addr, val);
-
     cur = acpi_gpe_ioport_get_ptr(ar, addr);
     if (addr < ar->gpe.len / 2) {
+        trace_acpi_gpe_sts_ioport_writeb(addr, val);
         /* GPE_STS */
         *cur = (*cur) & ~val;
     } else if (addr < ar->gpe.len) {
+        trace_acpi_gpe_en_ioport_writeb(addr - (ar->gpe.len / 2), val);
         /* GPE_EN */
         *cur = val;
     } else {
@@ -712,7 +712,11 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr)
         val = *cur;
     }
 
-    trace_acpi_gpe_ioport_readb(addr, val);
+    if (addr < ar->gpe.len / 2) {
+        trace_acpi_gpe_sts_ioport_readb(addr, val);
+    } else {
+        trace_acpi_gpe_en_ioport_readb(addr - (ar->gpe.len / 2), val);
+    }
 
     return val;
 }
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index 159937ddb9..edc93e703c 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -18,8 +18,10 @@ mhp_acpi_pc_dimm_deleted(uint32_t slot) "slot[0x%"PRIx32"] pc-dimm deleted"
 mhp_acpi_pc_dimm_delete_failed(uint32_t slot) "slot[0x%"PRIx32"] pc-dimm delete failed"
 
 # core.c
-acpi_gpe_ioport_readb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " ==> 0x%" PRIx8
-acpi_gpe_ioport_writeb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " <== 0x%" PRIx8
+acpi_gpe_en_ioport_readb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " ==> 0x%02" PRIx8
+acpi_gpe_en_ioport_writeb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " <== 0x%02" PRIx8
+acpi_gpe_sts_ioport_readb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " ==> 0x%02" PRIx8
+acpi_gpe_sts_ioport_writeb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " <== 0x%02" PRIx8
 
 # cpu.c
 cpuhp_acpi_invalid_idx_selected(uint32_t idx) "0x%"PRIx32
-- 
MST


