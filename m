Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA047A9864
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:42:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcO-00021x-Bk; Thu, 21 Sep 2023 13:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcL-00020y-E1
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:34 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcG-0007fW-Lk
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:32 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31dd10c2b8bso1236103f8f.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317847; x=1695922647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xqicFx4SLmYdVA1B6BSjmTvNZt1hFvhyCtMsK7qBhx4=;
 b=f84o5UM0KDIGekTb8zd0rZbbXkmjKDbfOmXY418EdLidBqvt+pB3foiV8H3OkDg3mr
 Pl/VCIVMAGGhE1CKh9xXOTUaGaItLj9gcnBaIl4Gm1Xcm3EXXp9ftPXWAO2rqfRw7pbh
 ofwgeSnyC+k0VatK07X9UIwdyB+1DyDh6oQzQSdE6JtnAUsevsqEQopHfZsGRxTY3/SI
 6DuSe67A0RLyYC05lYCHeLZqXuSGq/FqVt8QfsAmODHMWBBvXqM9vsMjDrs9KCOA0j7P
 Tt0KtRowUgT63fsMkOGPoqdOePFtdhc3qe1YjnNb0RFJd/o0hehr7A1rjd4dyaGDlQBa
 tv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317847; x=1695922647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xqicFx4SLmYdVA1B6BSjmTvNZt1hFvhyCtMsK7qBhx4=;
 b=r/f/QC7ussEIg5bFcG3hnPG09hemXkjPzBLcrRZ54JLCTxmG2xWyYLA/+un2qaajeR
 htbLI1PplP+aWvopnMrxUP8r/lCswvQ8pQ/rwZrvK6+qX1poUypPHmn9OEev4fdRYeqb
 JBSag1AmkQ9DHgzGPh9JOQDg/h3mKGGsEuTbr1UgpgwuRCG4haiBmy5cxzYLQnlywKh2
 BumsQANStywY/k7TYqiuFRVF1zedL0FhJZmiqKrSUhtxsCYr4dNwkprvVODAB3I7THrb
 LRhrdXLO9I+Bi/PKaMF69lSvzVVYh0kEZU/RtHjfdu/Dd8vVQGZGsHcK8VWgUuQu94Ro
 XyQg==
X-Gm-Message-State: AOJu0YwDYbV3mTB5lUjps1at+z9E3dctYl+PByLY145pkT75F/a7sOTw
 oUkehUgXZI0HG8RdgCdXps7iwUiuUsZ7QtALb1E=
X-Google-Smtp-Source: AGHT+IGyNOTYNGM5G07ub1jpnJ7ggRyr+xIhIfbk+eBr3ZIYnhfuWg07JOm+mmjHBhyl9I9jncZm0g==
X-Received: by 2002:a5d:56c4:0:b0:31f:a277:4cde with SMTP id
 m4-20020a5d56c4000000b0031fa2774cdemr5786934wrw.43.1695317847365; 
 Thu, 21 Sep 2023 10:37:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/30] target/arm: Don't skip MTE checks for LDRT/STRT at EL0
Date: Thu, 21 Sep 2023 18:37:01 +0100
Message-Id: <20230921173720.3250581-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The LDRT/STRT "unprivileged load/store" instructions behave like
normal ones if executed at EL0. We handle this correctly for
the load/store semantics, but get the MTE checking wrong.

We always look at s->mte_active[is_unpriv] to see whether we should
be doing MTE checks, but in hflags.c when we set the TB flags that
will be used to fill the mte_active[] array we only set the
MTE0_ACTIVE bit if UNPRIV is true (i.e.  we are not at EL0).

This means that a LDRT at EL0 will see s->mte_active[1] as 0,
and will not do MTE checks even when MTE is enabled.

To avoid the translate-time code having to do an explicit check on
s->unpriv to see if it is OK to index into the mte_active[] array,
duplicate MTE_ACTIVE into MTE0_ACTIVE when UNPRIV is false.

(This isn't a very serious bug because generally nobody executes
LDRT/STRT at EL0, because they have no use there.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230912140434.1333369-2-peter.maydell@linaro.org
---
 target/arm/tcg/hflags.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 616c5fa7237..ea642384f5a 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -306,6 +306,15 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                 && !(env->pstate & PSTATE_TCO)
                 && (sctlr & (el == 0 ? SCTLR_TCF0 : SCTLR_TCF))) {
                 DP_TBFLAG_A64(flags, MTE_ACTIVE, 1);
+                if (!EX_TBFLAG_A64(flags, UNPRIV)) {
+                    /*
+                     * In non-unpriv contexts (eg EL0), unpriv load/stores
+                     * act like normal ones; duplicate the MTE info to
+                     * avoid translate-a64.c having to check UNPRIV to see
+                     * whether it is OK to index into MTE_ACTIVE[].
+                     */
+                    DP_TBFLAG_A64(flags, MTE0_ACTIVE, 1);
+                }
             }
         }
         /* And again for unprivileged accesses, if required.  */
-- 
2.34.1


