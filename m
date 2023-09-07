Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4327972A3
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:10:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEck-0002hq-CB; Thu, 07 Sep 2023 09:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEch-0002gh-BF
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcZ-000780-T5
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q6ODDnQNN/yca4TsH5pqpBUjMw+REKkxizVyjE0ZBfg=;
 b=dqAnlUDrZu0xQ7S26WveNFvKPSRvIXHqx4lTTUQAtatTzmwioIc1F2T0XU4k4ERLTdD8mj
 trj2xBkgyZfCx+tAxyO5Wn4pYvQjsnCPnotwXri/ST74/heNUrBqrvP8+R5Iitfr+pcdFa
 qqEynu3GAYtFZUkYMXToleARhL9MS/4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-AqLoWeLrOZmS0wwOPbakNg-1; Thu, 07 Sep 2023 09:00:27 -0400
X-MC-Unique: AqLoWeLrOZmS0wwOPbakNg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31aca0c0d63so565076f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091619; x=1694696419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q6ODDnQNN/yca4TsH5pqpBUjMw+REKkxizVyjE0ZBfg=;
 b=JUOqDfvdkmktJoAc/JeC+GYn0PLqSJ5YulWGkfDH9Sffa8UY89trlemoAJLXR8NaBG
 94WSXISfYxCAi0g8+KO6PPpxa5m0KydBlAxNcytUROAvYw5F2dBX/IhirrZ0wgp47Qif
 BthlGzGjdgk7qEBVXI98RG+5OPWXmTrba7n6EbZKINiPpscbspqO5GgkKtxmcQbkLnVW
 gy2p8qIJkqvLKac4DaAn/UnoAgveyLNUZtSctpLYYAbMfgXxJ2dydCYqn+vKo6xvLLyT
 0D1NMWMVvQXnOVjaR6gdYrqpM7YG31S9Pq4koot83KzH5kcINUtSPdV8pu7azBDQz51M
 rgIw==
X-Gm-Message-State: AOJu0YxHaNmG9Ms677phHGcl5B0yn+mh/34Yd60eEsJoNEu8W+ZeP2cr
 muI+QjFeR+nLLBmJgl1TEzvZGjlznSjznMcKFq3Zt+x42ms3iDsboqYgKm914aBIytPtQPXl0ke
 vu1yRkAyibNBSAM6b4zMAc3MoBpxIcUFBxS1MPsqZ+mcaqq6JwKik0OS6tfsJ1Th14ZZ5fSDvVV
 w=
X-Received: by 2002:adf:fd06:0:b0:315:ad1a:5abc with SMTP id
 e6-20020adffd06000000b00315ad1a5abcmr5561411wrr.5.1694091619286; 
 Thu, 07 Sep 2023 06:00:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHze0OkGh7yu4Q8mO+r0q0bX8hz+yoprXIGinl4dTrhZs8QoUFeSnQrjS2YHUVNSoeAa43Pg==
X-Received: by 2002:adf:fd06:0:b0:315:ad1a:5abc with SMTP id
 e6-20020adffd06000000b00315ad1a5abcmr5561388wrr.5.1694091618859; 
 Thu, 07 Sep 2023 06:00:18 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a5d4ecc000000b0031423a8f4f7sm23466471wrv.56.2023.09.07.06.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 05/51] target/i386: Add support for AMX-COMPLEX in CPUID
 enumeration
Date: Thu,  7 Sep 2023 14:59:14 +0200
Message-ID: <20230907130004.500601-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Tao Su <tao1.su@linux.intel.com>

Latest Intel platform GraniteRapids-D introduces AMX-COMPLEX, which adds
two instructions to perform matrix multiplication of two tiles containing
complex elements and accumulate the results into a packed single precision
tile.

AMX-COMPLEX is enumerated via CPUID.(EAX=7,ECX=1):EDX[bit 8]. Add the CPUID
definition for AMX-COMPLEX, AMX-COMPLEX will be enabled automatically when
using '-cpu host' and KVM advertises AMX-COMPLEX to userspace.

Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20230830074324.84059-1-tao1.su@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 00f913b6382..24ee67b42d0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -980,7 +980,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             NULL, NULL, NULL, NULL,
             "avx-vnni-int8", "avx-ne-convert", NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            "amx-complex", NULL, NULL, NULL,
             NULL, NULL, "prefetchiti", NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a6000e93bd8..fbb05eace57 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -930,6 +930,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_7_1_EDX_AVX_VNNI_INT8     (1U << 4)
 /* AVX NE CONVERT Instructions */
 #define CPUID_7_1_EDX_AVX_NE_CONVERT    (1U << 5)
+/* AMX COMPLEX Instructions */
+#define CPUID_7_1_EDX_AMX_COMPLEX       (1U << 8)
 /* PREFETCHIT0/1 Instructions */
 #define CPUID_7_1_EDX_PREFETCHITI       (1U << 14)
 
-- 
2.41.0


