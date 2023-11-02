Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 982717DEA2B
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:37:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMbz-0007JS-Jq; Wed, 01 Nov 2023 21:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb1-0006Qv-8R
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:07 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMaz-0001wc-Oh
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:07 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc2f17ab26so3324855ad.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888844; x=1699493644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCnWYkK+U1pZwjN+BpVp2KIVyq7cUxKa4TKDY4mlg8c=;
 b=WSMzlmBFWbaTNiHJpJ7az+9GYY/XDjW1VJR3IywlMO9hFRs4rVocdD9rxw9CfZn3f6
 1OwYYnYKkMzALn9ZNzR93zVBkQTH/9tGiKdEH3bzXzQeQ3VJ5pSKDxzdWmjGS6IhAlOd
 Xaqk1awhB1Rf0rQltculmD39bmwf30M3VYgveCmGHSfwFfyts31kKTkHBhirB+wN15df
 C7pk6Lddbj536sAucBIGkUeb4BVQFDadxtygUqDRR8Xp2YOw3V0WioH8jaeGiWqAIKkU
 Rgr1Jy6VPSVVNGi68FswAKPcIbYcudOsx+vIn8hwxy4b0gc0DWlBmGspt1EXq/IWFq/S
 rPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888844; x=1699493644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZCnWYkK+U1pZwjN+BpVp2KIVyq7cUxKa4TKDY4mlg8c=;
 b=wwRlvduEq6pml9ErbtGSkq5NLmMUoQyRfeFWSjvus0h/6o6gnC5CU3H7aZR28HRLwx
 kxsCm8nHNj/AqZAQAiCUXTDFY7nqae3EDezhJ+rxTnazu2lBDX5KrOsVlj6/D3ZO7swT
 1kQv3XjOLRTrgdV5A6RPph5WI3hyyPm4GQCQyHYSC++O9WJjiHduO/2im0mAfscPNqaK
 M6ZIC9IBq46OKmU+92oJK9rFkbgdHfPMIgGksa48T8RyKEpNi2Wgw9pOITX9/6EbBBk/
 2aw/jONnlei13qeVAnnBTsUFSosuZM94hnK/AM9HQIzC8TYNI9l/j4UGAlzgI++lAdWE
 xF9w==
X-Gm-Message-State: AOJu0YxXRySAzYwbvqMyjAR4pjaOGdjyLwnANxc0mf4rGNBb2XgMfuGj
 SJV5fsbtU5/dL36pJmPjp/aJfiRv+c3dYmTNXGc=
X-Google-Smtp-Source: AGHT+IGdsr/5RGpe1U39yOJh8mNgnzRI5jYnoQLr3GXhGYiaAGQw/mASeHdgMOx3AwOYmubEqRyCvA==
X-Received: by 2002:a17:902:e809:b0:1cc:6d2c:fb59 with SMTP id
 u9-20020a170902e80900b001cc6d2cfb59mr6171084plg.28.1698888844257; 
 Wed, 01 Nov 2023 18:34:04 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 53/88] target/hppa: Implement CLRBTS, POPBTS, PUSHBTS,
 PUSHNOM
Date: Wed,  1 Nov 2023 18:29:41 -0700
Message-Id: <20231102013016.369010-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode | 2 ++
 target/hppa/translate.c  | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 6f0c3f6ea5..ba7731b517 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -381,6 +381,8 @@ bl              111010 ..... ..... 101 ........... n:1 .        &BL l=2 \
                 disp=%assemble_22
 b_gate          111010 ..... ..... 001 ........... .   .        @bl
 blr             111010 l:5   x:5   010 00000000000 n:1 0
+nopbts          111010 00000 00000 010 0---------1   0 1    # clrbts/popbts
+nopbts          111010 00000 ----- 010 00000000000   0 1    # pushbts/pushnom
 bv              111010 b:5   x:5   110 00000000000 n:1 0
 bve             111010 b:5   00000 110 10000000000 n:1 -        l=0
 bve             111010 b:5   00000 111 10000000000 n:1 -        l=2
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 897b44d7e3..91249d89ca 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3782,6 +3782,12 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
 #endif
 }
 
+static bool trans_nopbts(DisasContext *ctx, arg_nopbts *a)
+{
+    /* All branch target stack instructions implement as nop. */
+    return ctx->is_pa20;
+}
+
 /*
  * Float class 0
  */
-- 
2.34.1


