Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA55D833735
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Jan 2024 01:22:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRLaJ-0002XR-KL; Sat, 20 Jan 2024 19:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLaH-0002X0-6S
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:21:09 -0500
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLaF-0007Pj-8P
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:21:08 -0500
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-361ae51a4d9so5617515ab.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jan 2024 16:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705796465; x=1706401265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lU9aH7ZY0n7uAdgAxQsFLjxICAM1xx6kGJSgqsKuTsU=;
 b=Ju3VHi3YYiapsoWoAe9WLa2G13rKjQjHhckC23XlODTyXeG7CsqBgBvxOIy9tA3cIp
 ec45kYs0+aDEwpLKe7qcuQXWsMWPR+tAMVlwsgbYRSZ5UzejQarvE7VdvxE8r9hkQ2d5
 I9iKfS04DskQUO1Gp/7EStO3G+7eo3Z+rzyadSVxupS9PDx7TdeYX9IrekC9Pm2bSdXc
 7oBb+LfX5HRafrEtQDS2UoYV+FtWhpAWv3qCw7QS07sWbDRNeEnZlhiCMfSDipvEZ1Mq
 XGeCo61rfzTCJM6jJTPvZWux7JLtFTHCTctnCchNgBW2JS+V+KeL5ai4/YRQHhVpvo2z
 pxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705796465; x=1706401265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lU9aH7ZY0n7uAdgAxQsFLjxICAM1xx6kGJSgqsKuTsU=;
 b=S6ewddz4Hn7Wyd+NaCw2pa4GBIH9bT0LMr73nwVCkPM2F4JW2MJCCAnfC2TcKJ64+l
 CB54NPVyi93j96v2oj63x6nkN/aKvCI5u3StlrjDLRjbmz7L+kBf/qSdE00CTRSlsKWy
 XUojmyq6MHhoZ8LU7bu39IC9gYCyewyYocLdlGZZAIGhL0FoXY+QIj7Je657l5qqKc6G
 woPnzVdjkgIv6JewVge+Od/k71+GedfZ4eDyoxWhBRCSadjPZdZclGDbL+7t2aa8V0RU
 8XlmevUJQwJw3eWObqRpf9NNGLlt/Bfq/RfKsWndeRbQT7p5trsZL3Vn0Ht74HJq7r4Z
 1aLw==
X-Gm-Message-State: AOJu0YyqjsjWvBgGpsmfAf/qKE8IX3UoYetc9+Uz3HZ2IPEgPDxFCoJX
 Woob8itbEHHfBuj8Pv291HxMbieQyPF+ZTdwTmbcdEWAhRLOJu+pRltnivY0L9MO2YnrQGH6Bxe
 DOM0=
X-Google-Smtp-Source: AGHT+IFnCGNiLSxIKQIjulzY/IsK9QYvi2eMWQBcJd4wT71onI2IcJ88OoIlbNAcPevaWdYrzTfH8Q==
X-Received: by 2002:a92:c110:0:b0:361:a867:5881 with SMTP id
 p16-20020a92c110000000b00361a8675881mr3558335ile.14.1705796465565; 
 Sat, 20 Jan 2024 16:21:05 -0800 (PST)
Received: from stoup.net ([2001:8004:5170:1e39:1361:3840:4873:7990])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a17090276c400b001d5af7fbda0sm5023546plt.122.2024.01.20.16.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 16:21:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 4/8] tcg/s390x: Fix encoding of VRIc, VRSa, VRSc insns
Date: Sun, 21 Jan 2024 11:20:43 +1100
Message-Id: <20240121002047.89234-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240121002047.89234-1-richard.henderson@linaro.org>
References: <20240121002047.89234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

While the format names the second vector register 'v3',
it is still in the second position (bits 12-15) and
the argument to RXB must match.

Example error:
 -   e7 00 00 10 2a 33       verllf  %v16,%v0,16
 +   e7 00 00 10 2c 33       verllf  %v16,%v16,16

Cc: qemu-stable@nongnu.org
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Fixes: 22cb37b4172 ("tcg/s390x: Implement vector shift operations")
Fixes: 79cada8693d ("tcg/s390x: Implement tcg_out_dup*_vec")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2054
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20240117213646.159697-2-richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index fbee43d3b0..7f6b84aa2c 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -683,7 +683,7 @@ static void tcg_out_insn_VRIc(TCGContext *s, S390Opcode op,
     tcg_debug_assert(is_vector_reg(v3));
     tcg_out16(s, (op & 0xff00) | ((v1 & 0xf) << 4) | (v3 & 0xf));
     tcg_out16(s, i2);
-    tcg_out16(s, (op & 0x00ff) | RXB(v1, 0, v3, 0) | (m4 << 12));
+    tcg_out16(s, (op & 0x00ff) | RXB(v1, v3, 0, 0) | (m4 << 12));
 }
 
 static void tcg_out_insn_VRRa(TCGContext *s, S390Opcode op,
@@ -738,7 +738,7 @@ static void tcg_out_insn_VRSa(TCGContext *s, S390Opcode op, TCGReg v1,
     tcg_debug_assert(is_vector_reg(v3));
     tcg_out16(s, (op & 0xff00) | ((v1 & 0xf) << 4) | (v3 & 0xf));
     tcg_out16(s, b2 << 12 | d2);
-    tcg_out16(s, (op & 0x00ff) | RXB(v1, 0, v3, 0) | (m4 << 12));
+    tcg_out16(s, (op & 0x00ff) | RXB(v1, v3, 0, 0) | (m4 << 12));
 }
 
 static void tcg_out_insn_VRSb(TCGContext *s, S390Opcode op, TCGReg v1,
@@ -762,7 +762,7 @@ static void tcg_out_insn_VRSc(TCGContext *s, S390Opcode op, TCGReg r1,
     tcg_debug_assert(is_vector_reg(v3));
     tcg_out16(s, (op & 0xff00) | (r1 << 4) | (v3 & 0xf));
     tcg_out16(s, b2 << 12 | d2);
-    tcg_out16(s, (op & 0x00ff) | RXB(0, 0, v3, 0) | (m4 << 12));
+    tcg_out16(s, (op & 0x00ff) | RXB(0, v3, 0, 0) | (m4 << 12));
 }
 
 static void tcg_out_insn_VRX(TCGContext *s, S390Opcode op, TCGReg v1,
-- 
2.34.1


