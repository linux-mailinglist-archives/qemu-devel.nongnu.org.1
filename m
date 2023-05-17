Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA0E706FF1
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:50:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLDW-0006sx-TQ; Wed, 17 May 2023 13:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDP-0006jw-Vm
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDM-0003yp-QS
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GITj+Z9gCB+Vro48aLKzM2p8bxrlRde0LfE7vxRAVLM=;
 b=a5GhvQNX8j7WmyCNWskjDism5/AxkastbpoGRy1wCY9ztOOQnHrC0WRWrYNLBDLDhkcrlv
 BWDHKnyAovDnXmWEkrzzlQ4EmL/oOCF8MYLl+ltAR8EAJ1RidJn8pnDKcrRpzSKmA4g7X1
 Ng3G1lAlobfaHCbWtGNL7weV80Wk+Qc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-ebneM5wtNPymTykwwgmb_A-1; Wed, 17 May 2023 13:45:26 -0400
X-MC-Unique: ebneM5wtNPymTykwwgmb_A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f429072212so4935355e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345524; x=1686937524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GITj+Z9gCB+Vro48aLKzM2p8bxrlRde0LfE7vxRAVLM=;
 b=SJAzLYu3kH5VjwyN2m4MZdVLnJuT499DHwgWTWGJ2+Pt/XrNDgsUPEmkfGSI2wiKla
 oUQJ/rxDNPwzBEH5LeEt+0x//OVGNVYh7TUbnWAoVWtr4G9Dbktjj+UJ16fYrMJ2BP+6
 TFc4NjQgG+GnsglYVZPFCEpz87JL1KhqlKI0gJijxy+aHP494QINxBUXmm0/kIu+Zxai
 cjoyne3oDXtkIB/VA7/vjFR5kEx5yiol0E0BePDTwMTwcNe6PaqrW8NCqMyyIbKFF8EU
 wx8lAcLcI/YaEbInNYkgWpCeq1c6zPi1BCM4Y/0DFY3XdZRGwRk3zXqQZ4FLtMLaTc1W
 NcfA==
X-Gm-Message-State: AC+VfDyqUg1Tqgm0hdt2GQy2Gp4ask0SqH/1QFxTkpOwBQzMXOWax2U2
 EiniqsVqPQOTb05/s9CRJzjvSWPVjabYBxebtEjLpscOtVQBLY3XKGuwbETW3tJxkx0+pmvr2cy
 UDNqSSVLWuJw7fxJKRNl5eDYYSKkFzrQFGuFa9D2zQ9MlI0snw2fdBBBSzeJdm+PdkMTQ8xJDO2
 A=
X-Received: by 2002:a7b:cd11:0:b0:3f4:b6bc:bd93 with SMTP id
 f17-20020a7bcd11000000b003f4b6bcbd93mr18643366wmj.35.1684345524743; 
 Wed, 17 May 2023 10:45:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ioTLsRi0ZFm9Ruhg5D1NbpHKq2QcAt+R2LWtSR7bivIdBfW3H4LEjKhlOS76t+21HSO3gzw==
X-Received: by 2002:a7b:cd11:0:b0:3f4:b6bc:bd93 with SMTP id
 f17-20020a7bcd11000000b003f4b6bcbd93mr18643353wmj.35.1684345524347; 
 Wed, 17 May 2023 10:45:24 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 m39-20020a05600c3b2700b003f07ef4e3e0sm5339482wms.0.2023.05.17.10.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PULL 01/68] target/i386: add support for FLUSH_L1D feature
Date: Wed, 17 May 2023 19:44:13 +0200
Message-Id: <20230517174520.887405-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Emanuele Giuseppe Esposito <eesposit@redhat.com>

As reported by Intel's doc:
"L1D_FLUSH: Writeback and invalidate the L1 data cache"

If this cpu feature is present in host, allow QEMU to choose whether to
show it to the guest too.
One disadvantage of not exposing it is that the guest will report
a non existing vulnerability in
/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
because the mitigation is present only when the cpu has
	(FLUSH_L1D and MD_CLEAR) or FB_CLEAR
features enabled.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-Id: <20230201135759.555607-2-eesposit@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4187759f106f..e5c813199a0d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -863,7 +863,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "tsx-ldtrk", NULL, NULL /* pconfig */, "arch-lbr",
             NULL, NULL, "amx-bf16", "avx512-fp16",
             "amx-tile", "amx-int8", "spec-ctrl", "stibp",
-            NULL, "arch-capabilities", "core-capability", "ssbd",
+            "flush-l1d", "arch-capabilities", "core-capability", "ssbd",
         },
         .cpuid = {
             .eax = 7,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8ade71ab555d..3c6f9226e1f1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -899,6 +899,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_7_0_EDX_SPEC_CTRL         (1U << 26)
 /* Single Thread Indirect Branch Predictors */
 #define CPUID_7_0_EDX_STIBP             (1U << 27)
+/* Flush L1D cache */
+#define CPUID_7_0_EDX_FLUSH_L1D         (1U << 28)
 /* Arch Capabilities */
 #define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)
 /* Core Capability */
-- 
2.40.1


