Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBDC73B8A2
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:18:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgfL-0004Xf-BP; Fri, 23 Jun 2023 09:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfJ-0004X2-1x
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfF-0005aS-SR
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687526245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0W8NdMue2w0PHMCwCzmpD+VGR+2VHcU3d8NE23hGmkY=;
 b=CcP6bAxygtuUYQ8X4rVVL/LmTwJ5P7kb1HLNsiml6B/58XwlxIVdjcH3LoMGZ80gaEwHXQ
 Beo4FMyhA5kpKVshBGYHFMIOCl0EGQrK6ADMBIqoaJpO+A1P7poo4IlTh9RDgtbqoOBwm4
 HONwjSnqM9lEK2BFijX+aihkPrjEgOs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-0n2qrj_WOcCuamJ-Nb0LJw-1; Fri, 23 Jun 2023 09:17:20 -0400
X-MC-Unique: 0n2qrj_WOcCuamJ-Nb0LJw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-987accb96dbso42086766b.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687526238; x=1690118238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0W8NdMue2w0PHMCwCzmpD+VGR+2VHcU3d8NE23hGmkY=;
 b=aiTN/fJ7KTmHAFF/0EvDW2MNCsQpb8HTYm/rQ2rZ9B4x6ikePwzr87xhCeEtlUiwtR
 vntoj+UME7WCNec3t5dBoskpUYJOADTUTLdbSEAvDEU4bwfmPlu8NN6QOKRLfFJxfuXC
 /k0FxA32yqiSseDeH0WWjUfbR/ZBoo5Deq+OuyNMOfg9uXPLveSXndvtZuuU1I+ye0gx
 O6KVC+6WAY9m7wULxYio+OXr5X23y8tI7yeS1+95KpWccxKNQm7Uz0yCIkdz9gxbR4HF
 KDxSxx5Jx99ParXCl+WmoUygBrSiipQ3o4cJ8N5zngPQIXSNGEdJepCsKwaG+sGW6MK/
 p+Dg==
X-Gm-Message-State: AC+VfDznjHfX1hB72KpWePFGIg1pk4kdmBvTBguY0Vj947JiBpP7vjdM
 pITWIyJa2gwYLVT8eqYF7UNoPyQdBaJtfpxsn1LpPUBZlrccXiNNIU4YWHz51hXlgHesHEjGxuF
 99HFRjBs9kJRGFGW6EEPjH3phdQeTHLJBPoSV1mVkIuFjzsq8JGiouJMl6xzBuXEUminW7Eckh7
 I=
X-Received: by 2002:a17:907:a04:b0:988:8fce:17ba with SMTP id
 bb4-20020a1709070a0400b009888fce17bamr10382288ejc.31.1687526238528; 
 Fri, 23 Jun 2023 06:17:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7EWOtDaLMIM8ZIVvs87zUEKopIZSr9OGqFvc/Q3DBkkvyVaeKVgYKlFhe+6Y51IrOfogRZKQ==
X-Received: by 2002:a17:907:a04:b0:988:8fce:17ba with SMTP id
 bb4-20020a1709070a0400b009888fce17bamr10382279ejc.31.1687526238260; 
 Fri, 23 Jun 2023 06:17:18 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 g10-20020a170906348a00b00988d47b731fsm5897032ejb.88.2023.06.23.06.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 06:17:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 03/11] target/i386: TCG supports RDSEED
Date: Fri, 23 Jun 2023 15:17:03 +0200
Message-ID: <20230623131711.96775-4-pbonzini@redhat.com>
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

TCG implements RDSEED, and in fact uses qcrypto_random_bytes which is
secure enough to match hardware behavior.  Expose it to guests.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ff3dcd02dcb..fc4246223d4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -657,11 +657,10 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ADX | \
           CPUID_7_0_EBX_PCOMMIT | CPUID_7_0_EBX_CLFLUSHOPT |            \
           CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_FSGSBASE | \
-          CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2)
+          CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_RDSEED)
           /* missing:
           CPUID_7_0_EBX_HLE
-          CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM,
-          CPUID_7_0_EBX_RDSEED */
+          CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM */
 #define TCG_7_0_ECX_FEATURES (CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU | \
           /* CPUID_7_0_ECX_OSPKE is dynamic */ \
           CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_PKS | CPUID_7_0_ECX_VAES)
-- 
2.41.0


