Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B331A73DD2F
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:20:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBn-0003Ej-QI; Mon, 26 Jun 2023 07:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBl-00037H-2S
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBj-0000mA-0a
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6EIU5XOd3nbA8G7SlRkIFwdHfD63tFeDL6PWodWJlqM=;
 b=ID5UlAae+8gymbh4rKp/XhezLWKCOG9rd/qEyQqRonerwGBeDeM19go/BFqQByIYc++QKd
 3xslzW4FKZQO9BsZYyQ/WnX0c1QsGolBLGYeaYdIim8vL34l5LRCsxd81eNyScgW+ws94Z
 bC4IVdhToy1321RBDl8eyDdWwR7qWi4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-PaM3cBY4ND64nr28BfQetw-1; Mon, 26 Jun 2023 07:15:07 -0400
X-MC-Unique: PaM3cBY4ND64nr28BfQetw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4edc7406cbaso2135699e87.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778105; x=1690370105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6EIU5XOd3nbA8G7SlRkIFwdHfD63tFeDL6PWodWJlqM=;
 b=chdT9BqskdEjwdgUgmSceRRxCHG6zL8YeJH0Qmx34PpqdqxSQI8gaIb+smdJ/4+M8o
 RXMzj4sNSXkeKXar5pTXkMlHa0LVq/PgBGP/YXnKbObr1QoLmypKgF2HN36qNQX1XooG
 SzqJi8jZG5HZp+7EU3ETEKIv9r4vv/Edh9HNdizHjq04ik8D/YCyQUZBN6bOSlaQpyre
 bBSXhWOYhkBat7zerKkZizgzdgC5N3hryg8XQDtHJ69RZuV+3iwXu0YyJwlD+OTunujj
 8MveD2RZd+wa2RbFOs8VxXQWJ6Cg5fAY3J2P/2lrGmRl0qatlvMkJCUNeGKXJRst1UwP
 jRrw==
X-Gm-Message-State: AC+VfDzp1MnVjgHOj453T+Cd5OwUsIDSU2lezHc+vL3EPTiQJU/2beKj
 dtpOW/1ZT35FgMYcCdtKDPAeYJUgnUq7ZAjxRHcp34EzAys3VHhhkJMIjAYEzir1uRs3e1EAG90
 C1wyqU3gYlvKJu8VnU6odihwsWjAY+Att9pEEq5/3+cUXV/e6YvW9p+z2nDyl4mjqvCA8eEHesZ
 Q=
X-Received: by 2002:a05:6512:31d1:b0:4fb:73b5:e1cf with SMTP id
 j17-20020a05651231d100b004fb73b5e1cfmr1822343lfe.64.1687778104931; 
 Mon, 26 Jun 2023 04:15:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ62QlkbYq2vjpuPQSh34YyrORSsA4nsxpa9bnCnuKRBoQSPz42/vf21wdzmc+Q9uGw4TmQE0Q==
X-Received: by 2002:a05:6512:31d1:b0:4fb:73b5:e1cf with SMTP id
 j17-20020a05651231d100b004fb73b5e1cfmr1822330lfe.64.1687778104703; 
 Mon, 26 Jun 2023 04:15:04 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a5d504a000000b00313e8dc7facsm5254413wrt.116.2023.06.26.04.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:15:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/18] target/i386: TCG supports WBNOINVD
Date: Mon, 26 Jun 2023 13:14:39 +0200
Message-ID: <20230626111445.163573-13-pbonzini@redhat.com>
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


