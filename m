Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1819B80DD0E
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:28:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCnhq-0000nI-Tv; Mon, 11 Dec 2023 16:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnhp-0000lp-JU
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:20:49 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnhm-0005KL-TM
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:20:49 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54cd8f5bb5cso6624245a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702329645; x=1702934445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+33Nr6gIzIhUPCwLsBvRZhZAyU1ywCj1cKlsVdoDYyo=;
 b=ftUd12mjmFTl43AZEzXIcubicgtde6/Pf5CzFUGGu5UAJsve+mGuFGtLAq472EZXG+
 +FkxiwZZtbNPxYGgeiShxZtszh+g5rINUGArZOip3nQqP+Lym/umoiArT7UO7Qe2LVZE
 gTW7GoB0DdwaqJSIYkfwXtRv/1Ft2ABkPsaAQGU1pg6dh4Sln6dqEoAwgJ3gZfoJNTba
 UD9c76Ao5g2CRJuv87HA+cbE0A++l4jMMoIF5J8qnygXjpwWK1TlNpPXmC+y2Jdq85VO
 dVfLEsn1DwwBkpfficmOVChqaL5Qh23/FuC6gspFytjuf5lGVKBH1KV5uJ0gNtfM13eH
 UP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702329645; x=1702934445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+33Nr6gIzIhUPCwLsBvRZhZAyU1ywCj1cKlsVdoDYyo=;
 b=qPBvnFXHOqo9TxmqcGGFMOUVuT9w4xIOxBtgX3MUDpTdh/Vhhvvo9Kfbrr4aHcob/6
 RtC798Bn9TYlumX3Cplxu9y8rjgwxKAoPiTJ6qO0iUyW5lZlGcklrkfhpwGQafXQQ/gw
 m+joq71lTrm5FMeDJnJwmVSq5YK8ysAWz0OnfQzfcbjLF9I3+nm/1AtnzUbq3mvx0w6K
 vvHJgtIzjG/Lk0p3X3oVoUmh4UJtODBzvFt0D6MqXodOssGbkyVDZFSkW4/Of2HQJKKs
 mYawKVjq859+A7zh2VQpMQ8mc/qsU0cJ1f7SDr4YgTDvd1AG7Hnj2/ov0ygldTYmdOny
 MxiA==
X-Gm-Message-State: AOJu0Yxq9p/lrFxbl6QM6VNWR54RYa6zYMwQb4qIbiqRTtbXPKg5mc41
 q4Y6U5CsRFj/QUZhIEuh+iA9VbSY/1HmQ0lqT7xjvg==
X-Google-Smtp-Source: AGHT+IGP260sklW8SrHdq22yOUtbknlqztMe93MGgqTfX8ATVzXMGH+5zD2rskJoqWCw5Df+cqNKpA==
X-Received: by 2002:a17:906:20d0:b0:a1f:b493:f725 with SMTP id
 c16-20020a17090620d000b00a1fb493f725mr773668ejc.106.1702329645408; 
 Mon, 11 Dec 2023 13:20:45 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 rf20-20020a1709076a1400b00a1d1b8a088esm5331661ejc.92.2023.12.11.13.20.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Dec 2023 13:20:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Claudio Fontana <cfontana@suse.de>,
 Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH 04/24] accel: Include missing 'exec/cpu_ldst.h' header
Date: Mon, 11 Dec 2023 22:19:41 +0100
Message-ID: <20231211212003.21686-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211212003.21686-1-philmd@linaro.org>
References: <20231211212003.21686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Theses files call cpu_ldl_code() which is declared
in "exec/cpu_ldst.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/translator.c        | 1 +
 target/hexagon/translate.c    | 1 +
 target/microblaze/cpu.c       | 1 +
 target/microblaze/translate.c | 1 +
 target/nios2/translate.c      | 1 +
 5 files changed, 5 insertions(+)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 38c34009a5..5b019a0852 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -12,6 +12,7 @@
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
 #include "exec/translator.h"
+#include "exec/cpu_ldst.h"
 #include "exec/plugin-gen.h"
 #include "tcg/tcg-op-common.h"
 #include "internal-target.h"
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 666c061180..744dc4fc3f 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -23,6 +23,7 @@
 #include "exec/helper-gen.h"
 #include "exec/helper-proto.h"
 #include "exec/translation-block.h"
+#include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "internal.h"
 #include "attribs.h"
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index bbb3335cad..91d7cd9061 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "exec/gdbstub.h"
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 49bfb4a0ea..1c9a364c2b 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index e806623594..a74eb6909f 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "tcg/tcg-op.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "disas/disas.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-- 
2.41.0


