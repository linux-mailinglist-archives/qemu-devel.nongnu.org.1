Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C53AD7E28CC
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:34:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01bE-0000E3-2u; Mon, 06 Nov 2023 10:33:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01b0-00087T-KY
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:33:01 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01ap-0004Oe-HD
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:58 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32f737deedfso2826003f8f.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284765; x=1699889565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vMqWcAj2Ns99kW52JXRa7w6ZQQ9Cpo0DKoDdAGV1Fl4=;
 b=ncWML9QgcMHQKelEjBHOGRai69dEE5dcVj5k2xhRgeR/z7DwjQobSRo0KJaQtwui3k
 hjzjTXrWAUAr2ePP9Lql4wRha+8mFPjyJaS1ZRjECa3SKbLM+Mmu2FHrpxSsURRQ+sZ8
 YZm6kPxSnFekPoerY5ucIKGGgalQpWviixyzqQBYkmhnRJP2YirfDZl4m7552fEBki8A
 GCBROjf2+DljqGi7xMzTlmxlmvygQiFiq7hxyvc+7GAKQa9eSkwIWZuid1FDCb7nm6qu
 6vs8vDOpVeQNCvWYcn/kv6kDomfmWDaBP2df0pD/AyFojFcNXXSFu+KRsIpynr6URwC+
 ClYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284765; x=1699889565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vMqWcAj2Ns99kW52JXRa7w6ZQQ9Cpo0DKoDdAGV1Fl4=;
 b=hGRcxDuNOdBDlFRtXAQa9N6e4RaC+8FCmodWiSV/gaLDoD1zYjbZIfdYQPJegKdUH6
 amBQ6gq2BUTL7VUnmjj88vaJSgYDyB9pWLanyE89tDnULcT9hxtkpbfF8HeCmZ/BrEBS
 uBVq4uRrVp3YWwgIgOLh6qIw3rjX8nqRCGVc/VTIW4lj1U7LyTks9tui2k/F13/SDZXI
 691QDcBmbT4H5dZFJqlh3baikVyNg/Mx99l0gk4dO9zzNbtkSg4vpCrgx41kFTXCcisq
 cqA8tY+YAeV/PTL1a8FE9SDOam6bgk+99F0pD3KFzGie3Nc71e1e76ioMpTZng8cxzXU
 t5Fw==
X-Gm-Message-State: AOJu0YwclXzVe1be01NwwwY53m7Rpilxt5QAp4nRIkn+yfXBnPi3Q5mE
 LqIPirxWfV8T1SuvKXLWtYLHwuQDKsXnLNbLrOw=
X-Google-Smtp-Source: AGHT+IGRvmL3t1PiVfQHcHo2UTRgoYiEvMB3ML9g+kfEoL4j79hdjDPS0+zqTwPosK1KwYuSS7E4Wg==
X-Received: by 2002:a5d:64ad:0:b0:32f:7b89:2675 with SMTP id
 m13-20020a5d64ad000000b0032f7b892675mr27928233wrp.65.1699284765363; 
 Mon, 06 Nov 2023 07:32:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adff2c5000000b0032da6f17ffdsm9752176wrp.38.2023.11.06.07.32.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:32:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/12] target/arm: Fix A64 LDRA immediate decode
Date: Mon,  6 Nov 2023 15:32:38 +0000
Message-Id: <20231106153238.1426649-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106153238.1426649-1-peter.maydell@linaro.org>
References: <20231106153238.1426649-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In commit be23a049 in the conversion to decodetree we broke the
decoding of the immediate value in the LDRA instruction.  This should
be a 10 bit signed value that is scaled by 8, but in the conversion
we incorrectly ended up scaling it only by 2.  Fix the scaling
factor.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1970
Fixes: be23a049 ("target/arm: Convert load (pointer auth) insns to decodetree")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231106113445.1163063-1-peter.maydell@linaro.org
---
 target/arm/tcg/translate.h | 5 +++++
 target/arm/tcg/a64.decode  | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 9efe00cf6ca..3c3bb3431ad 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -205,6 +205,11 @@ static inline int times_4(DisasContext *s, int x)
     return x * 4;
 }
 
+static inline int times_8(DisasContext *s, int x)
+{
+    return x * 8;
+}
+
 static inline int times_2_plus_1(DisasContext *s, int x)
 {
     return x * 2 + 1;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 0cf11470741..8a20dce3c8f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -462,7 +462,7 @@ LDAPR           sz:2 111 0 00 1 0 1 11111 1100 00 rn:5 rt:5
 # Load/store register (pointer authentication)
 
 # LDRA immediate is 10 bits signed and scaled, but the bits aren't all contiguous
-%ldra_imm       22:s1 12:9 !function=times_2
+%ldra_imm       22:s1 12:9 !function=times_8
 
 LDRA            11 111 0 00 m:1 . 1 ......... w:1 1 rn:5 rt:5 imm=%ldra_imm
 
-- 
2.34.1


