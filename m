Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A88C73DD1A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBj-0002zM-Ch; Mon, 26 Jun 2023 07:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBY-0002xA-C7
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBU-0000ZL-23
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M480NKZDd+FJKbtXpXl/j5rkv8yel0iAbn92O5C8mB0=;
 b=NqaW3LQtRGj9Ppm4Gc0z+zWSIVY6heer7EeAYENl1mwdv/xkv45+TEr+T9S4arSeu5AACe
 EAEsAvtzwSmCAbScCk988UHOsb2Hob8OHYdXWQ9ZX4FiMWSkoqUUeKAh1n2C3TxE25XCWS
 0fuFl2gZz88GGsyHOtFa/dCugUN22wA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-khKdxonAN_G6bwbVaP_ewQ-1; Mon, 26 Jun 2023 07:15:00 -0400
X-MC-Unique: khKdxonAN_G6bwbVaP_ewQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso1184893f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778099; x=1690370099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M480NKZDd+FJKbtXpXl/j5rkv8yel0iAbn92O5C8mB0=;
 b=Qrf6XygP5tnM/gWp8tJScDsIWuXEaHOLq3XbeDizCuNE2MWl01IfF3F2U9tvGzLL8t
 60lbaCW5nbFnB5ckTSlmoWYmameHJuxdSVQFH54c+D83VUiba6VffIEnDhbsXGN6jisA
 iOdeID0FQtgEVxXMtnPCyzVUH4YpG1IHZ5Um83OGWiDAfcAtAKdPgktvh7oVtSFgX2Xd
 ONbE8H0L8B2AJOmpFZ7tK3x2vy8zandox66095xy2sDZgL2005UpUiWXJpwU29EGoPyJ
 8JUDR5jqs0oEEd/utUAfVstocI3OYauOpeIQ8QjdMdWnoZ2oJ7bwJkHSE7lqDxBxT5ZQ
 8u/w==
X-Gm-Message-State: AC+VfDxHLl/nayFuYEwq35C7iGCLulD9Jc4TfnoqP8wG45p6OhkcB0rA
 AtGpaeqZOVstAmBsSaf9lBJz6nVXSQ2nxA6XuXFhuJf/iu64nCJ0arV2xs0/srmMJfidzvq01Q5
 bqkeoXiQnMPWgCw2qq7ER/T575hahfa4PIVhWQplhRbjd26p5vHt3XFNBOF/N2rWEdKsc7H1lrb
 M=
X-Received: by 2002:adf:ffce:0:b0:30f:b045:8b60 with SMTP id
 x14-20020adfffce000000b0030fb0458b60mr18551376wrs.69.1687778099466; 
 Mon, 26 Jun 2023 04:14:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5F8E0D/C7fm/e/ceYTcyh72DlhtYw06wdIam0JVPFv/7xE43ns9LB158oQPvJMcDzX6o1/Aw==
X-Received: by 2002:adf:ffce:0:b0:30f:b045:8b60 with SMTP id
 x14-20020adfffce000000b0030fb0458b60mr18551363wrs.69.1687778099195; 
 Mon, 26 Jun 2023 04:14:59 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a5d522d000000b003119633ecb5sm7100579wra.88.2023.06.26.04.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:14:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/18] target/i386: TCG supports 3DNow! prefetch(w)
Date: Mon, 26 Jun 2023 13:14:35 +0200
Message-ID: <20230626111445.163573-9-pbonzini@redhat.com>
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


