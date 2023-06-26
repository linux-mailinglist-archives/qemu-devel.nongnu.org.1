Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F7B73DD12
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:16:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBu-0003GE-Jo; Mon, 26 Jun 2023 07:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBb-0002zd-RH
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBY-0000a8-20
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H6LzM46kJa48T3+aRvGvtOXkekp7mWniYMCf+e1S9DU=;
 b=DY+1FF8+qLnayCo7qOGKxvr50osDFWfPYpo7KtKMHqnBUae7C6l3cxMjy8amqgt+ri8iGu
 b7varon4vgAxfZ0owOwJUDIbpWWDK70v+NwsZrAnoUsdoc6NXtQ5R41/rE7MLLQzFuFOcX
 Yu0mzsD2aWmmCVx8TTsl+My0MYund94=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-kpBSrkCvM2qgU3NQaSN4wg-1; Mon, 26 Jun 2023 07:15:05 -0400
X-MC-Unique: kpBSrkCvM2qgU3NQaSN4wg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fa976b8b6fso4369505e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778103; x=1690370103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H6LzM46kJa48T3+aRvGvtOXkekp7mWniYMCf+e1S9DU=;
 b=Ah1+pdhlt3yC1zHhwPP3MAsMv1sBoyQVeDf4T8INYpbDBiZBbvlpp0FeflLpw0pnM9
 iSc5IE+b24EvZebdyea6z4DHY4ClvtgvIFQTRZUgdFBYblzH2wXQnBw9O4f/SDO2YDpN
 SbzUsOMl/EGMP425b30692U2sKoBsB8SIzKCNtUMQ72qDGYqvel5YfkZHFUHTQK1HAzr
 6spS6py+UJaw6ARhHtY+uBAdtjF0UBmVN7MEfkLtz1HrjI52JyN3sn6GeACqwJP8sWbn
 EoizvdZl9wdqzQukeMi04caZ/8inJ0DAfxDiSBgTb8uDWYT/k0up+LXuG1rEiUorIEal
 LD9w==
X-Gm-Message-State: AC+VfDy9Nwr/SX2N13hJJtGZOJaSAehHRVGhmULMyXGn5SfBb0y/ZrvK
 Ho4tG1JVZJrJNqvrdWYN/kjAn3heWR5v0yNOMGcK75Nk8vA7bXcs5Gm6W5ysK3SIMwmA6vsYDRi
 ON2jQYq/szOoXDZuwHqMrQzCRizBa3nIkuzW11Ql3zXlG2HD6Ijb0g2HjPIQ7kr7W3NwzB9ByMu
 E=
X-Received: by 2002:adf:ec0e:0:b0:309:44ed:ccff with SMTP id
 x14-20020adfec0e000000b0030944edccffmr24688035wrn.1.1687778103623; 
 Mon, 26 Jun 2023 04:15:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4mdkqKDaPAP/mUJaxMGePIrZLtmyfFLuptzUipHEtcmM0XxWxRLWEK8s5PYIOYV13CzRPC5g==
X-Received: by 2002:adf:ec0e:0:b0:309:44ed:ccff with SMTP id
 x14-20020adfec0e000000b0030944edccffmr24688025wrn.1.1687778103384; 
 Mon, 26 Jun 2023 04:15:03 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 a25-20020a5d4579000000b003048477729asm7065945wrc.81.2023.06.26.04.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:15:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/18] target/i386: TCG supports XSAVEERPTR
Date: Mon, 26 Jun 2023 13:14:38 +0200
Message-ID: <20230626111445.163573-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626111445.163573-1-pbonzini@redhat.com>
References: <20230626111445.163573-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

XSAVEERPTR is actually a fix for an errata; TCG does not have the issue.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fc4246223d4..bce0cb73e85 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -678,6 +678,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
 
+#define TCG_8000_0008_EBX  CPUID_8000_0008_EBX_XSAVEERPTR
+
 FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_1_EDX] = {
         .type = CPUID_FEATURE_WORD,
@@ -939,7 +941,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "amd-psfd", NULL, NULL, NULL,
         },
         .cpuid = { .eax = 0x80000008, .reg = R_EBX, },
-        .tcg_features = 0,
+        .tcg_features = TCG_8000_0008_EBX,
         .unmigratable_flags = 0,
     },
     [FEAT_8000_0021_EAX] = {
-- 
2.41.0


