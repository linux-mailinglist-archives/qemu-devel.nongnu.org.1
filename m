Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBD473B89F
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:18:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgfJ-0004Wu-Fo; Fri, 23 Jun 2023 09:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfH-0004We-R3
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfD-0005aG-Ck
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687526242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M480NKZDd+FJKbtXpXl/j5rkv8yel0iAbn92O5C8mB0=;
 b=S00QsNahDT5VQvyubXg7DolU9kfamtWyQdjyKOLGZW5PEFjdvygAIGegd7L4OL/Zk87uL5
 UxIyuD4GPCzlq+TS+PslYqciGb9+uW61KGAS5AK8iD7po0cBeY9ocxpGns5BTZAEmOkmtE
 HJLu7sZlCaLvAoQvA8JGE/KLYLy9A2Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-FBw3wtotMpSRnqUY0zv4kQ-1; Fri, 23 Jun 2023 09:17:18 -0400
X-MC-Unique: FBw3wtotMpSRnqUY0zv4kQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-514b3b99882so404184a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687526237; x=1690118237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M480NKZDd+FJKbtXpXl/j5rkv8yel0iAbn92O5C8mB0=;
 b=jNBNw6r4oMNwfXHx2hIWXXlOaj07aK4Gkl0BUoKUGSunPLGr0qhOJjd3HF0OhA8gYR
 210bGH91UFgC2oHeAIuT+Ra9n8TXKmyxVBvxPelukWUGl4dz4vtoUeYAztPSS4blXVjz
 z2yphsD1luv+t5yv9me0qiiDYbpDTiuPFTjKJnIgLHWqe1ED0/JR1T7YL+r/o4Q03j50
 +ZzpuT/GBHahgIGs0CitJ7Hz8TamOmh46Npg8y9RBCs/RLI3U2k0wbBt+cPedsEZm4PY
 UFtTDZo86XdeGUtDSnCUBGb7yMHTpxkoUZW6fSrfoLiUYWm4aqwB4mmxtGtM/BjimKYM
 AXog==
X-Gm-Message-State: AC+VfDwyyMxex8R3BasyDefL9GuQJCsDV4cSbvKQWQJSH/ERQNPkpET8
 LPbf90W2Z/Fzl1mduwG+0mfek/5xHZBI0uhdGfd8w4wAxXQ7/P3ReY3YcKWRoypU3b91SoWBX8/
 hOsO4idQOrPrZ8LckQd9msz4U19CflJ8VoZitMRCV/WjOtjjXCg5c9FCXtHW0SEPY/bCTyLZPJr
 g=
X-Received: by 2002:a05:6402:6d8:b0:514:9e2c:90c6 with SMTP id
 n24-20020a05640206d800b005149e2c90c6mr14588501edy.38.1687526237043; 
 Fri, 23 Jun 2023 06:17:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/y20V4VssR1wkil+vclqOwP82Ctu1bTsLbLRmX3oJi7G5UuZe6bmTPTFptmva/X8B+0Xyeg==
X-Received: by 2002:a05:6402:6d8:b0:514:9e2c:90c6 with SMTP id
 n24-20020a05640206d800b005149e2c90c6mr14588489edy.38.1687526236791; 
 Fri, 23 Jun 2023 06:17:16 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 d16-20020aa7d5d0000000b0051a358a76c9sm5261710eds.72.2023.06.23.06.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 06:17:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 02/11] target/i386: TCG supports 3DNow! prefetch(w)
Date: Fri, 23 Jun 2023 15:17:02 +0200
Message-ID: <20230623131711.96775-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623131711.96775-1-pbonzini@redhat.com>
References: <20230623131711.96775-1-pbonzini@redhat.com>
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

The AMD prefetch(w) instructions have not been deprecated together with the rest
of 3DNow!, and in fact are even supported by newer Intel processor.  Mark them
as supported by TCG, as it supports all of 3DNow!.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1242bd541a5..ff3dcd02dcb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -647,7 +647,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_EXT2_3DNOW | CPUID_EXT2_3DNOWEXT | CPUID_EXT2_PDPE1GB | \
           TCG_EXT2_X86_64_FEATURES)
 #define TCG_EXT3_FEATURES (CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM | \
-          CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A)
+          CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A | \
+          CPUID_EXT3_3DNOWPREFETCH)
 #define TCG_EXT4_FEATURES 0
 #define TCG_SVM_FEATURES (CPUID_SVM_NPT | CPUID_SVM_VGIF | \
           CPUID_SVM_SVME_ADDR_CHK)
-- 
2.41.0


