Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB8D73DD13
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:16:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBY-0002x3-Ps; Mon, 26 Jun 2023 07:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBW-0002wn-Ke
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBU-0000Yw-24
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjZaffAPekSpjEfjZNu7ZflGZlFUHtqN1AICwh62mv0=;
 b=CsHddD+/nbJiXqvN7SIWIXEGIhKufyBIywcn2BRjd7kRKtXNVX6X9qc8go4U803WEcV/8y
 4UKKiHjjtjAo2AfZYXLV/YoZ6t9NJ/mw8hGPMkNt5j0wLWgCgILfDpthexn9pcQ/F2CtZa
 nc/uejDGr4nbK8Rdp+4+K4qNKbBZkLA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-Tj8Z1JDONcOm0P4ow2QbuA-1; Mon, 26 Jun 2023 07:14:59 -0400
X-MC-Unique: Tj8Z1JDONcOm0P4ow2QbuA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f3932e595dso2444342e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778097; x=1690370097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NjZaffAPekSpjEfjZNu7ZflGZlFUHtqN1AICwh62mv0=;
 b=MMrD+XGC8rvdgkqiverSj7Pvf+r62+4EvN/oFFy46bbnmCP3weGba27i7wEJAkvXda
 4zGB/o4O3Hh581pgI2M3Kp/1Y4HZ9hMBq0clamCnZsJlknnxHUPFbTzrs6u9oqq2NNIV
 PJwTEihPjgpm/fQf+TeLHClh1JJzio55V585hTDVD2/9c0jtmsHsZ9mKIb/CeBQJmE13
 +J1sg5Yem5aRb+P8hxcJWypswSzIAMy31RPTnao7OSqjPA2tE/m8ac46iQpKDJQQXiLe
 IQWojrWXNpxB+KY5Qe1LO1FiS8Wnhz3gxc3cm1swsLbPnQG35x0AkoKgQLYgxPY0fNqs
 e82Q==
X-Gm-Message-State: AC+VfDyUAAPoRKdK5lGCRieosnMvpDwvZB4GbP8GY6mM2EZarQUK6bbE
 diElgrGQ5ZtjjXOcYl+bqd8gm1mRxZAbs0jhm8lu1JX3dLZD++lIWpyt5JNgq6kDvDl7gczWUNe
 aX/htU8j5v0zmuGjDkgXJDPWwTP+mGUJiKW6SznO+iFN74AqM36Ha+pyC7pr1dtJUm/2Bhb4b+p
 I=
X-Received: by 2002:ac2:465b:0:b0:4f8:692c:74cd with SMTP id
 s27-20020ac2465b000000b004f8692c74cdmr13676485lfo.22.1687778097785; 
 Mon, 26 Jun 2023 04:14:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5na58EPtt9QS2R9hA3+acWvRsMZoqfC9yOcQ18eQCU+kixjFmyNOYYW86anNf7RYEiuQoITw==
X-Received: by 2002:ac2:465b:0:b0:4f8:692c:74cd with SMTP id
 s27-20020ac2465b000000b004f8692c74cdmr13676468lfo.22.1687778097361; 
 Mon, 26 Jun 2023 04:14:57 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a5d468e000000b00312780bedc3sm7090774wrq.56.2023.06.26.04.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:14:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/18] target/i386: fix INVD vmexit
Date: Mon, 26 Jun 2023 13:14:34 +0200
Message-ID: <20230626111445.163573-8-pbonzini@redhat.com>
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


