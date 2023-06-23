Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 021CF73B8A4
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:19:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgfK-0004Xd-QB; Fri, 23 Jun 2023 09:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfJ-0004XI-6o
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfH-0005ag-8l
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687526246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6EIU5XOd3nbA8G7SlRkIFwdHfD63tFeDL6PWodWJlqM=;
 b=ToHJ7iKhjfAr7M+etgCAKne3Vh3+Yt3GofW26rSLX98Y9b+IN6DqukF9pJdYOGzNwqqPdE
 wtXzYoe42fJOh0oBwum9D7z8H/GuA0PKZa/ExYZjBuaPo+kXD9CfuWS2NcVoQaoXvwlkVb
 DP5bKpdCRxr4oKuSUjby996lDh9iu9g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-wCXDx1O-OPCYoufBfZ3KjQ-1; Fri, 23 Jun 2023 09:17:25 -0400
X-MC-Unique: wCXDx1O-OPCYoufBfZ3KjQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a355cf318so45558966b.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687526243; x=1690118243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6EIU5XOd3nbA8G7SlRkIFwdHfD63tFeDL6PWodWJlqM=;
 b=Z+XTgxLjelQmPA7ZTnpLMYT7h8WRtNwfiFW5m8qwMzbZtsvOWc6nkxF+3yMdOBS1P/
 83pofsx+QJQaOz5g5tfE42mc3FEPBYm9eVt3nZr0OVEbd9z7BNpbVcR5ZItKCWftKKvQ
 TnKZOitVxq6+OzAdRAQA/hzHHeLmVwbhoY/q802T2ZBorCjfU9pmsgA8cwLaSCvnZJat
 oLJZsxs0IY5MlGsp+mEOIwyQkkw71IG6qOaspymjwol5oE3bu2JBEXsMZx9OQXFx1GH/
 32C1czSH1BbyGp5l6tjkycpzKgKE0S8szfT3UbEDjSn6RGa4Cqb0MyguXuFbPTxU4ybF
 Jnhg==
X-Gm-Message-State: AC+VfDy14600U9vgY/u6V7XjJ1LuOm97PfEG/E0HHIxkqbB0LekGT2H5
 uNFhWJMXvlmExEnh4z8jfmWkAkt5aoygDQ5xNdF99/J0tVv4vIRNAmvMtGV2Z1XPajlT4GruszH
 /8dso+mM3zxhce2wVu2g2afShDMxrJ3TL54qjm7pWiK0DwSWh50LlNM4ezGSet9Wcl0nF07dSAf
 c=
X-Received: by 2002:a17:907:268a:b0:987:7e6a:d239 with SMTP id
 bn10-20020a170907268a00b009877e6ad239mr16145044ejc.35.1687526243606; 
 Fri, 23 Jun 2023 06:17:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4D/yxQRsbZ8SC5c2KjRODvn74CfiGrRBpd84q87GpGEX5LYgOEDHXWxPvGrNVUFvfSB2DvHg==
X-Received: by 2002:a17:907:268a:b0:987:7e6a:d239 with SMTP id
 bn10-20020a170907268a00b009877e6ad239mr16145029ejc.35.1687526243300; 
 Fri, 23 Jun 2023 06:17:23 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090614cc00b0098951bb4dc3sm4958453ejc.184.2023.06.23.06.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 06:17:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 06/11] target/i386: TCG supports WBNOINVD
Date: Fri, 23 Jun 2023 15:17:06 +0200
Message-ID: <20230623131711.96775-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623131711.96775-1-pbonzini@redhat.com>
References: <20230623131711.96775-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

WBNOINVD is the same as INVD or WBINVD as far as TCG is concerned,
since there is no cache in TCG and therefore no invalidation side effect
in WBNOINVD.

With respect to SVM emulation, processors that do not support WBNOINVD
will ignore the prefix and treat it as WBINVD, while those that support
it will generate exactly the same vmexit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c           | 3 ++-
 target/i386/tcg/translate.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bce0cb73e85..695e01582bf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -678,7 +678,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
 
-#define TCG_8000_0008_EBX  CPUID_8000_0008_EBX_XSAVEERPTR
+#define TCG_8000_0008_EBX  (CPUID_8000_0008_EBX_XSAVEERPTR | \
+          CPUID_8000_0008_EBX_WBNOINVD)
 
 FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_1_EDX] = {
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 4ef45bbd71e..b2e2dccb84f 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -6125,7 +6125,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         break;
 
     case 0x108: /* invd */
-    case 0x109: /* wbinvd */
+    case 0x109: /* wbinvd; wbnoinvd with REPZ prefix */
         if (check_cpl0(s)) {
             gen_svm_check_intercept(s, (b & 1) ? SVM_EXIT_WBINVD : SVM_EXIT_INVD);
             /* nothing to do */
-- 
2.41.0


