Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E6A80EBF8
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:37:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD20x-0005I7-Jr; Tue, 12 Dec 2023 07:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1zs-0003C0-I1
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:36:26 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1zq-0000Tp-Sp
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:36:24 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54dca2a3f16so10297828a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702384580; x=1702989380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EgOgJWBHHDbLNzyjR5V9GijCj9jUXCNUrJoD+ikNXAY=;
 b=Jdj7ahpnwo5JreuHaKBzeVItX4XhBuzllMXEVhBsr5BS6v6V/caosMOAGemSMPle+C
 oMHYUsjXAx1K1P9QbZ3cd9ORFwqAeY+uB1WNE9o2BYnYNKREUQ83q3EHz4g77AI9b3TD
 cXS8KAGVSO2+RxjRjYzJKCmm5c/RmQoafAUQlb2eu2UGGfWGmib83qE5VzBfz2mhbVTc
 7eyRHEsLCCwN/5GRc3NbiRlNHGPUF9Tj5zy3OweZXjClAWyN0ux3eiMlWbYI+HPwkBxn
 I14WfgbEjLOFVqf0DytVIYk7VuNibuRTT8vz6j/fMlafJRZC4+9WsWjVZWs3L8vPz0xZ
 x/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384580; x=1702989380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EgOgJWBHHDbLNzyjR5V9GijCj9jUXCNUrJoD+ikNXAY=;
 b=VbiMmEUapptrVMDLa+0XvhPXGtdDMCq/himFq4eC9eytqO0DYVvYielw/kF8dpsP37
 WY1RZjEmDLe2zYwEhDizUE5vC8pNG4OXDTPGMjNmOOrmvi5lWVpuTvd+nlXW/adrOo8m
 22L2yqLCF4VmaPf94j+b8BolE40YXXWiGJp2UVgZ4jCIMHBOHKGlG0HHR168Qi7Ux0Zz
 o2vU5ixtb+86Ls0d3TnIRai64s3AG8nPFr5gjnA1Fe/oKe0dPF0DIzJdb8NEaMRNLYXZ
 mTMp6jmi1XwUS1pFM4mnh86NhiBadINzSKwimgvB8VzHDPr63QaNCH0i7WpUjUZ6uUCn
 6UXA==
X-Gm-Message-State: AOJu0YwKEl4V9nZa73sMjyjl/GbyI1kwLKd6LgImZ77CppLUBldR9AAw
 FtK6cApEkF9acNfyYqoq6vpC7nE27NQCIgUd4u8LRw==
X-Google-Smtp-Source: AGHT+IFSlK8zlLL9+s+RxG7rRJsvN3NU7AOmbuINOJQ/1pFD/8QvhHBSZ6sriXNGzhXOnLahHlG0/A==
X-Received: by 2002:a17:906:6a27:b0:a1f:6551:6405 with SMTP id
 qw39-20020a1709066a2700b00a1f65516405mr7283292ejc.37.1702384579791; 
 Tue, 12 Dec 2023 04:36:19 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 ti7-20020a170907c20700b00a1caa50feb3sm6146677ejc.40.2023.12.12.04.36.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 04:36:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Claudio Fontana <cfontana@suse.de>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, Brian Cain <bcain@quicinc.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 19/23] exec/user: Do not include 'cpu.h' in 'abitypes.h'
Date: Tue, 12 Dec 2023 13:33:55 +0100
Message-ID: <20231212123401.37493-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212123401.37493-1-philmd@linaro.org>
References: <20231212123401.37493-1-philmd@linaro.org>
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

"exec/user/abitypes.h" requires:

 - "exec/cpu-defs.h"           (TARGET_LONG_BITS)
 - "exec/tswap.h"              (tswap32)

In order to avoid "cpu.h", pick the minimum required headers.

Assert this user-specific header is only included from user
emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/user/abitypes.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
index ed10d5fe7e..fbb55684d3 100644
--- a/include/exec/user/abitypes.h
+++ b/include/exec/user/abitypes.h
@@ -1,7 +1,12 @@
 #ifndef EXEC_USER_ABITYPES_H
 #define EXEC_USER_ABITYPES_H
 
-#include "cpu.h"
+#ifndef CONFIG_USER_ONLY
+#error Cannot include this header from system emulation
+#endif
+
+#include "exec/cpu-defs.h"
+#include "exec/tswap.h"
 #include "exec/user/tswap-target.h"
 
 #ifdef TARGET_ABI32
-- 
2.41.0


