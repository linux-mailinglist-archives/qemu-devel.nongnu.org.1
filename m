Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D86D73703B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:19:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBd6O-0003TK-Gm; Tue, 20 Jun 2023 11:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6E-0003Pl-3K
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6C-0007Q8-4L
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687274211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I3Ol5b5iKH3J6dMVfSqD+k03rVm2RMmAKOxLd5QGS24=;
 b=U7v4uI3DHBgGh8Cq8x14QqXADIfOI5CQPJylbgkyXTfSwZRf8SgOlCszfuZrRGPUth0aTd
 hbxTWHvVGI8Pk5GTKufb7PANEP7fo3Mwm/pjJBkhnGm31hBtYGRLzJCW0NPSuRr9t7Qg2w
 9ua9yTiGwHY5HandD0CfSN0o9ZCz67Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-pNzObSJ7Pbqnj6fX69Cdsw-1; Tue, 20 Jun 2023 11:16:48 -0400
X-MC-Unique: pNzObSJ7Pbqnj6fX69Cdsw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9885a936d01so221664666b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274205; x=1689866205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I3Ol5b5iKH3J6dMVfSqD+k03rVm2RMmAKOxLd5QGS24=;
 b=ZRuuKkUVG2WIMqqeY2SZOE0q5F8gUyB3ZgtTKpSBOEOqcl5GfW3Ogyqmh08+Nq4ySV
 06XtwXR7+csO/6jZnmtonwn36PTWPgjuQbRxJjCYO7raWwu3RXtVg+TNt1WAN7bFdfZU
 HdM9nY/He/lY2gJIRwXnfmCgpFdebpSv8YL04Rp7y1tBw3kR4RlW5Cn7uG+AmGglYWr5
 oiLi34E0AeNHxN/gYEvbu8wawJhqzFRoRp4XhyBL124ksbMpjtFx3xITGIuf8t3l3vk3
 1hLmLIclzY7uGTkQB94eDCIulfLBxSs5yp+WeOZybbui5rpvYBFkwgzfTPV0DTten9bp
 kVew==
X-Gm-Message-State: AC+VfDzfTp79kDcfI+wsXRvWrfrsS/MtJQKWOmSpge+Oj8Ufn+qP/bYy
 TB7sMJNxdirwUOk8ac6jJVUrt69dvapjK49oTAuxufZ0USKCfFnmt01+I4gyXAhcB/Vl5Hiali+
 rt8o7uKKwK0jaVIH3CAcfWDXmG1M7ebjk9dXO3A+hhff0qadY0mxVU4tF8c32x8a4jZmCkF3MDZ
 I=
X-Received: by 2002:a17:906:58ce:b0:988:ffb9:b944 with SMTP id
 e14-20020a17090658ce00b00988ffb9b944mr3177126ejs.29.1687274205348; 
 Tue, 20 Jun 2023 08:16:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5coLYDxszaHpIc0oz1izN2HA5uKySr+qWFcDgA+kNZUMC3MpqauZ98bMchSlhBcXydl+oZfg==
X-Received: by 2002:a17:906:58ce:b0:988:ffb9:b944 with SMTP id
 e14-20020a17090658ce00b00988ffb9b944mr3177113ejs.29.1687274205046; 
 Tue, 20 Jun 2023 08:16:45 -0700 (PDT)
Received: from [192.168.1.72] ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a170906360d00b009827b97c89csm1519265ejb.102.2023.06.20.08.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:16:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 05/10] target/i386: TCG supports WBNOINVD
Date: Tue, 20 Jun 2023 17:16:29 +0200
Message-Id: <20230620151634.21053-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620151634.21053-1-pbonzini@redhat.com>
References: <20230620151634.21053-1-pbonzini@redhat.com>
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
index 0ef4d98ce79..89df7bb528a 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -6117,7 +6117,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         break;
 
     case 0x108: /* invd */
-    case 0x109: /* wbinvd */
+    case 0x109: /* wbinvd; wbnoinvd with REPZ prefix */
         if (check_cpl0(s)) {
             gen_svm_check_intercept(s, (b & 1) ? SVM_EXIT_WBINVD : SVM_EXIT_INVD);
             /* nothing to do */
-- 
2.40.1


