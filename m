Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0FB73B89E
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:18:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgfC-0004UN-Ht; Fri, 23 Jun 2023 09:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfA-0004Qn-Iq
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgf9-0005Z9-50
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687526238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjZaffAPekSpjEfjZNu7ZflGZlFUHtqN1AICwh62mv0=;
 b=a2gYNyeAqPxh2jD3+r3Tlqre1P2R/2blSIs1DfP3qzlwMF1OVhEUEFasNESenQl5Ylab2E
 QXRTWVcJtVz52bK8JmK9Snp69wMq1SdIRhNgQdtgL6lssCY3bPUPXUOAhXGlCobNovI4QO
 Ay5eRJdy2a3YGk5yM83lys18DX1w4bc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-vH6sr8qrOmmx03hHs2ad8A-1; Fri, 23 Jun 2023 09:17:16 -0400
X-MC-Unique: vH6sr8qrOmmx03hHs2ad8A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9715654aba1so84120166b.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687526235; x=1690118235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NjZaffAPekSpjEfjZNu7ZflGZlFUHtqN1AICwh62mv0=;
 b=gChy9MEtYmX3u5WraMzx7FJmBRaYYf1TF8St/3iBHfqeWlZsVtcus+miCsylmLmBA8
 or+iBVL57o9LmGCl/LdEDyK61yl48XDETFUfgjsEG5hziMqb6/rb7lwO4Wh89AkcYYda
 35WEOVl4qUEkKiicaLzIUREhd9mgxanNRbvgWlSuCsBxTMr4UOYgUHSloFxrAGvbyORL
 GUa1ZXIWY29HqtrH5bvAgStLSDWoG9Vkt/d9D8qLb7+xQFH2WfYTRcV9vimRVmub2RkQ
 X+0e9fPFiY1dHgdY05sLvJcG+8Oxa4sZHgTiOEaOPe9qeNKiy9gaeF2sgmN4usmwlKuR
 w9FA==
X-Gm-Message-State: AC+VfDzsr+Mpp7tYVOQnxj1JPl+F0pjqxn+4m7JqhaGcFlb0WRlTwFhn
 B1N6e8rqgN2FaEwkh53it4Hke1NALhocLt2B8aEc1BRdPQLC/cj/TPNnux+fYo82cHV5nSvPrGH
 dyRwH8NNt6gCQ14DhRqU5ssp3GOb0NrKETxEmWsgNH9ErzIAjaKDtfIQo2nNXpQ7Mj8xfcpdwIv
 4=
X-Received: by 2002:a17:907:7ba0:b0:989:4b:e69e with SMTP id
 ne32-20020a1709077ba000b00989004be69emr11146522ejc.4.1687526235227; 
 Fri, 23 Jun 2023 06:17:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6kqTbPvUOBt5qe49hRYIF4WnBf7Y+ppBA57SRyKHfmh13bocEVogG07ZCoG3WF2IpqsJG2CA==
X-Received: by 2002:a17:907:7ba0:b0:989:4b:e69e with SMTP id
 ne32-20020a1709077ba000b00989004be69emr11146505ejc.4.1687526234907; 
 Fri, 23 Jun 2023 06:17:14 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 by19-20020a170906a2d300b00982bf866f9esm5969051ejb.66.2023.06.23.06.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 06:17:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 01/11] target/i386: fix INVD vmexit
Date: Fri, 23 Jun 2023 15:17:01 +0200
Message-ID: <20230623131711.96775-2-pbonzini@redhat.com>
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

Due to a typo or perhaps a brain fart, the INVD vmexit was never generated.
Fix it (but not that fixing just the typo would break both INVD and WBINVD,
due to a case of two wrongs making a right).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 08c4cab73f1..0de068d4b79 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -6119,7 +6119,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0x108: /* invd */
     case 0x109: /* wbinvd */
         if (check_cpl0(s)) {
-            gen_svm_check_intercept(s, (b & 2) ? SVM_EXIT_INVD : SVM_EXIT_WBINVD);
+            gen_svm_check_intercept(s, (b & 1) ? SVM_EXIT_WBINVD : SVM_EXIT_INVD);
             /* nothing to do */
         }
         break;
-- 
2.41.0


