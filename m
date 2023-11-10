Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F013B7E7A89
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:18:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1NdB-0002Rm-Fk; Fri, 10 Nov 2023 04:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r1Nd9-0002QP-1z
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:16:47 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r1Nd7-0002mO-Du
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:16:46 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c6ed1b9a1cso22680281fa.3
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 01:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699607803; x=1700212603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mbp8XXdbG6B9pZBrryz1zASTDVDqNMiO4XNfxxKRD1M=;
 b=KGnPtAUug0Up+jmKSRCf8b1ZR2Nww37xUIIhF1BWTurKVgd+k1Zi/vRfKfN5K2Kamu
 WIbjY8kuFTj3yCs0I909TzTatrmCyNGpUMY6eZ/XPBjezg1fDwJgqAX6i3ArZ+Vaib6e
 CaIkO6sPtN57ougOAk/Kx6lLhpmPkOTjvLoYy8cov1tehDmI2GmV0bAYnRgFxyL7WB3F
 EC8OlK1me7ywog+VCymecWHvwZFHCSnZni0Y5MxXk1Ps7ZhhojiwBbbWIP4hdcv5KvQS
 RIw1Jj8qGRIOay9UxjMeJ/9KztHq9Qna+yEgzsAlquTs0vEnf8tjxEoiBvYQGVJkcxKX
 zr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699607803; x=1700212603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mbp8XXdbG6B9pZBrryz1zASTDVDqNMiO4XNfxxKRD1M=;
 b=YCI2B1wGHObJ8A12nJcfto3EZy/x/niiDxrxOXttgHZ8Hts6Ko4RhlpH2GqVm/yUqo
 6d4UkcrE+Ham0UnH/t72Tl60NyVPSp97s6BhgfOCm2c55ng3AxUeXWJvfQUrlwDdEbPm
 y9W1EGT002q0GBcyMd6MqfF/9s+JQ94fIE1VM/v5EGUG2zww0K44Su8kvpt5Rh36fDw7
 UOrHrP5tlyHei3KPPIrhE1Ymwu69C0WptLhqILsrlRqz/eQPDuCLvE/NtPeVlvsp7vbm
 8Xd6TKuKq/ARhCXtukyqNKF0Iy7TNKGPiPmjDsvmNo5IOlApsFQ76oGu/YUI/V4GQXlj
 85ug==
X-Gm-Message-State: AOJu0Yx0tXXp2PK1sQsiIRjnAZ3ylF3EL6X8g0yEpjtGRf9lLYwek7Q3
 FxzuqXH90GAOvQMLpv5fxWUP8rZrVIVvYJZ1+om7sw==
X-Google-Smtp-Source: AGHT+IEyvzD5cRGLe4v6eW6UL+vYFxGUg7RGlx6d8tKCAv9/eh/OdfWWc0ioXgDTi0p6qttGizkFXA==
X-Received: by 2002:a2e:9904:0:b0:2bc:f2d7:f6ce with SMTP id
 v4-20020a2e9904000000b002bcf2d7f6cemr6321992lji.49.1699607802968; 
 Fri, 10 Nov 2023 01:16:42 -0800 (PST)
Received: from localhost.localdomain (adsl-205.37.6.2.tellas.gr. [37.6.2.205])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a05600c359600b004080f0376a0sm4537493wmq.42.2023.11.10.01.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 01:16:42 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/2] Add QEMU_WARN_UNUSED_RESULT attribute
Date: Fri, 10 Nov 2023 11:16:38 +0200
Message-Id: <84781fce2c3145a86d043d4c6b3b463af40eeed0.1699606819.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1699606819.git.manos.pitsidianakis@linaro.org>
References: <cover.1699606819.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x231.google.com
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

This commit adds QEMU_WARN_UNUSED_RESULT, a macro for the gcc function
attribute `warn_unused_result`. The utility of this attribute is to
ensure functions that return values that need to be inspected are not
ignored by the caller.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/qemu/compiler.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index c797f0d457..7ddbf1f1cf 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -212,6 +212,20 @@
 # define QEMU_USED
 #endif
 
+/*
+ * From GCC documentation:
+ *
+ *   The warn_unused_result attribute causes a warning to be emitted if a
+ *   caller of the function with this attribute does not use its return value.
+ *   This is useful for functions where not checking the result is either a
+ *   security problem or always a bug, such as realloc.
+ */
+#if __has_attribute(warn_unused_result)
+# define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
+#else
+# define QEMU_WARN_UNUSED_RESULT
+#endif
+
 /*
  * Ugly CPP trick that is like "defined FOO", but also works in C
  * code.  Useful to replace #ifdef with "if" statements; assumes
-- 
2.39.2


