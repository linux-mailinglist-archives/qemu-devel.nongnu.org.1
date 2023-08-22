Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4F1783D01
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 11:38:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYNpg-0000W6-4c; Tue, 22 Aug 2023 05:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYNpd-0000Vr-O6
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:37:49 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYNpb-0001ig-JS
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:37:49 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3197b461bb5so3805512f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 02:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697065; x=1693301865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sU04/oy8W8gfiSCI2qoAJqVtytEmmI6vE5KNlHJUhf0=;
 b=FzF0HedSb556jDIcBe6YjWz6UqgJ2b8GKLh4iBap0t4DO/w2xUhTZPvIjAfM9pM018
 ve4agsbYg5gl3Iv19tEotRchSLDpZTQgVciRxA8tF8xLVV2/ugTCHl0hTzG7qAXpuvAf
 uplzfsYvCK5cTh/u2fPZrhFKHlXigEjYF9EDnvs6wAmwZYN9HPpFtQADomr9u1p283Bg
 YobpunRSEGlwGcNhDwSADKRy70yxxwkmjZ0ISGPx6RLSIwW4mWyvxqncDiF5gSQthetY
 eMvY9m2IskVSX3nbJOR8RytWhy+yDoXFet+R9xtXNxKuRQjbWvrFSyvjMwjRwQUm24xS
 7+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697065; x=1693301865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sU04/oy8W8gfiSCI2qoAJqVtytEmmI6vE5KNlHJUhf0=;
 b=RxzdZga0u2ovyhjWt4BCOHO1HQrxpWUd0cOvqTZOK1Q4SngAjehBF0EutcdfO/6sB2
 aRuQAEOtxXnHxtejk4GkVcA9jqPee9darad40JIlQ5lCw6vm5gu/LOfG84y/rVrUFnYf
 ccjzF5OK8cjcSQ5wq4XnDt5gydC5YOr9CL0ZDms2909ewSdsYKACCyV7gEBQX6KjBmcj
 PAG6+L9pXribEMIn5ncVA74DdFkIu9PnmCq9k9mqbES/KhSBl0Dq1Sldejqy/tRPSObK
 wC+0fsiZW+98HOCKIWiI31rW/cCUzTSTVJZQvvY/NBIVcYxiKuY+mojWe7IgvbOI6RB0
 EXnw==
X-Gm-Message-State: AOJu0YzyKgR6++TgtBvDe0/UySFIM0mJKZqaMdSJfXYaMk1mEBitgqQP
 3H77q7GZ78Av5k0kgm30DY/AYMzlcyV00VaXZhMFCQ==
X-Google-Smtp-Source: AGHT+IEc+z75SjBkr2dUwBqnfRJhanceCtIrmnVlnzo/w664ANUVFV/S8m29Rcyy5oZmgAEENYqt8A==
X-Received: by 2002:adf:ded1:0:b0:313:f395:f5a3 with SMTP id
 i17-20020adfded1000000b00313f395f5a3mr7040842wrn.38.1692697065383; 
 Tue, 22 Aug 2023 02:37:45 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a5d6749000000b003143867d2ebsm15438796wrw.63.2023.08.22.02.37.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 02:37:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/7] tcg/tcg-op: Document wswap() byte pattern
Date: Tue, 22 Aug 2023 11:37:10 +0200
Message-ID: <20230822093712.38922-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822093712.38922-1-philmd@linaro.org>
References: <20230822093712.38922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Document wswap_i64(), added in commit 46be8425ff
("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/tcg-ops.rst | 4 ++++
 tcg/tcg-op.c           | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index d9364effd2..306025ece7 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -490,6 +490,10 @@ Misc
 
      - | Swap 16-bit halfwords within a 32/64-bit value.
 
+   * - wswap_i64 *t0*, *t1*
+
+     - | Swap 32-bit words within a 64-bit value.
+
 
 Conditional moves
 -----------------
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index bb64326a1a..c436c5e263 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1908,6 +1908,11 @@ void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_temp_free_i64(t1);
 }
 
+/*
+ * wswap_i64: Swap 32-bit words within a 64-bit value.
+ *
+ * Byte pattern:  wswap_i64(abcdefgh) -> efghabcd
+ */
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     /* Swapping 2 32-bit elements is a rotate. */
-- 
2.41.0


