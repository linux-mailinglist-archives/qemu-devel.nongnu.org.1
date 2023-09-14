Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAA57A0D9E
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:58:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgrX7-0007ru-3k; Thu, 14 Sep 2023 14:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrX5-0007rR-6J
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:57:43 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrX3-0007bt-GZ
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:57:42 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-401b0d97850so13488665e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 11:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694717860; x=1695322660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zKv/AFUEShTVcBgdcujYDWfR46YFV/IRpKp0NuzD1I=;
 b=HNjGM8AcEJEyYaFv9ELrtim5YO2zMU/Rsz6I1aHW2F38CvT6QXCVbQnXV1uiscL1E8
 4WFlvroD9MY55Iuf0kwHIaw/f1DWXW/cvFAd20eoMETVw9weOurvsNXG3/ysNaQThxr6
 mbnkh+sYHjkkQw/jMC+TPbamsxUi1oQU0S/tsYVJxVAZgjAisag+bnegcrtUHz914xuN
 Gc434icm8QDBpCzLrPOFVNrqW9OAXSdLVllmgc8nZ/nWiUPo87feKtp7w0UjKpZxU5fl
 T8yHdY/zlWU7ZSYehiNNfVsb4pZuMu4UQlU47cj2gWeWGCiqzITX2iAZULBsgjHE2/Zx
 mj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694717860; x=1695322660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9zKv/AFUEShTVcBgdcujYDWfR46YFV/IRpKp0NuzD1I=;
 b=pQVIyXaVY1Nz16iaZ052VZ3WgPJNWcrfmU+nnpWBEbbLCsWXgJ1OIO1sZIoG3blXS+
 lt2bUBI9sb3sR2Ru60AT895XEBe0ovn+n4HR5wbInvvsuP1YmYtAM0GkFEblSJ/V+Ofa
 WljXJdg6pveBeZwZrqy2VDRIhITmv5P5pE9H+/h+ZdcybGjpMMwS56lxqbPHeEON79EN
 bN1fCPL2lDH+sa0rn6dXNGtuq8Gla9wJlV5F6uMkLo3mYZ/0D+aHRWA2BRkDGPY4ukhN
 /UOmG1p2nWjmfpt07W7SFhXJYsp6Vj0hW9g8koSOfvRz2noLEHTyrQtPu2DSlmAA/6u3
 nbbg==
X-Gm-Message-State: AOJu0YylJt/u/xyuKBkqGb329EmROkDzHNWG1ymonKdsmnFxM98Zb8mG
 E3n9UW9aPaui7jgyJqTwwoOuKiHUouANNkaNaDA=
X-Google-Smtp-Source: AGHT+IEHFtbFmNTS8niehLXaXXrkhluRaMDyOB98q1d86LQhOmgI9PXQC4RcZMY3IeN0e/LtUxlpGQ==
X-Received: by 2002:a5d:518f:0:b0:31f:a9db:b838 with SMTP id
 k15-20020a5d518f000000b0031fa9dbb838mr5850535wrv.15.1694717859697; 
 Thu, 14 Sep 2023 11:57:39 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a50ec8a000000b0052565298bedsm1262703edr.34.2023.09.14.11.57.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 11:57:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/11] accel/tcg: Restrict dump_exec_info() declaration
Date: Thu, 14 Sep 2023 20:57:09 +0200
Message-ID: <20230914185718.76241-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914185718.76241-1-philmd@linaro.org>
References: <20230914185718.76241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

In commit 00c9a5c2c3 ("accel/tcg: Restrict 'qapi-commands-machine.h'
to system emulation") we moved the definition to accel/tcg/ which is
where this function is called. No need to expose it outside.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal.h   | 2 ++
 include/exec/cpu-all.h | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/internal.h b/accel/tcg/internal.h
index e8cbbde581..cd6b9eb7f0 100644
--- a/accel/tcg/internal.h
+++ b/accel/tcg/internal.h
@@ -102,6 +102,8 @@ static inline bool cpu_in_serial_context(CPUState *cs)
 extern int64_t max_delay;
 extern int64_t max_advance;
 
+void dump_exec_info(GString *buf);
+
 extern bool one_insn_per_tb;
 
 /**
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 71efc2d404..221ada2b6d 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -406,11 +406,6 @@ static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
     return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
 }
 
-#ifdef CONFIG_TCG
-/* accel/tcg/translate-all.c */
-void dump_exec_info(GString *buf);
-#endif /* CONFIG_TCG */
-
 #endif /* !CONFIG_USER_ONLY */
 
 /* accel/tcg/cpu-exec.c */
-- 
2.41.0


