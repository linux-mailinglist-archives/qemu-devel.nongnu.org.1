Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA41A1C492
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Jan 2025 18:07:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjYI-0007lm-BT; Sat, 25 Jan 2025 12:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXo-0007BC-Im
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:04 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXn-0000S0-2e
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:04 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso21975075e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824521; x=1738429321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OeHo9c/VM1KSl2EsYkHb7Xalf2iVdr+8YiL4SXj3SsQ=;
 b=VFmYUg38jmF1TBUogO9Xxe/A4h3xM4IWJXlSsauLI2mOg04DA9jhLPA0LeDDArj/sJ
 EPLyJUar/HsmYBmb2BUHDC+1iu5/esXMNottn6bVNAkAARTIuEu8CStkb1C3TkInoiw+
 OUGzW8cbgTVQI2CzPXu6W8sRy+o81Qp3z8bwtp3VuWs9EaF7xERaSPVW+/3VYglSseib
 WwFmHKlU6xcM9hQFNoljcQbz58RabZ2L/PEq5f8FNgphyffxtiH38g4dMYGHMgIQIQ0r
 3+771QHNuXT+leNSxB5j6ykNVHEW4HtfZgmnCRcYwtODzEc7LGGDJpfE/T4ZkA5IgbAk
 eDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824521; x=1738429321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OeHo9c/VM1KSl2EsYkHb7Xalf2iVdr+8YiL4SXj3SsQ=;
 b=RxsDpYG3ElvBuBIg/eh7lolUzWu0sm/TmuzBsURrcqcIPoB+MxwCQz+f9Max9ygAAi
 aOw1ZzZ3UBZU0Qyslh/xwV/LUNoBsSctJHnf5zr6dAWNT7ju84le0p1kB1Q8YrFK5/by
 L/TuMdEKMsK0Nf455t4ZW0N3QdccbSuGbzwJvxCJrH8Hybl/wAYYix64L9HPTxdTnfLs
 AvhgkqKZe3Nhqcwx7ypIcr7aA+zM+OduOZ3Blok6ISC1lc+I0csHJ7KkhkLZgQgA9oY2
 2RHqG3MacQduZP+0nzvCqRd1+fweeUZOyr32z8g+EuODXe/ePiX0+fAEAjIzsGpt1FJV
 xZ4A==
X-Gm-Message-State: AOJu0YzFtJWW7q3IhGDEgdYNYoRBREFkQa1KwKlMmgYZw4tw9ZnF1CCF
 JYx7bvci+vIWV7EEQYjOZKjjPOQIqvqsQ5WG5+K2gb+d+jNOeENQfNYJRBhjx2DmKpz5ateqJQA
 mqRE=
X-Gm-Gg: ASbGncvKQUU2Q2yRb6HGD4Yl4bcbIp/YHcpbOJmmOIH3mMk05XZn9eKCQGyXNJj2jTu
 Uhj8rWoDBjtI0UZUtl/DF+NqaFIrGbQ/Wt/lhZ1Thsn0A8oQztF2RLSGgjDWSU/bF2RRe2GcFb7
 rHxG90rR/EdaqXMCQY5XnvkLEQJfL9scllbRLhgf9NabEEwvZ0kTffvqyFCKQrwV6yLP7QWN5nN
 AaHrk0ztdehIu1PId/XP7tPJHtEspmmexzEjd2oKUZqY5U4P3sxjX9DxuPlxClGGGjBE3G0m9To
 c3lnUGQTDJC/S2gBQB6/HjAIRLqLzpPqbizCTzw0GBEIdf1Q9skEpEU=
X-Google-Smtp-Source: AGHT+IGNU5OAXU7/y+YME9zagO14ZjDoMpuWCj1GmFsZ8mnfu8ywQLxH3/47Wa1FmMHzYn5nJxBfng==
X-Received: by 2002:a05:600c:3593:b0:431:55c1:f440 with SMTP id
 5b1f17b1804b1-4389144eea8mr387781635e9.30.1737824521412; 
 Sat, 25 Jan 2025 09:02:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b16ff48esm93486685e9.0.2025.01.25.09.01.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:02:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 07/24] target/hexagon: Remove CPUClass:has_work() handler
Date: Sat, 25 Jan 2025 18:01:08 +0100
Message-ID: <20250125170125.32855-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Remove as unreachable code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 0b7fc98f6ce..f77e305d611 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -262,11 +262,6 @@ static void hexagon_cpu_synchronize_from_tb(CPUState *cs,
     cpu_env(cs)->gpr[HEX_REG_PC] = tb->pc;
 }
 
-static bool hexagon_cpu_has_work(CPUState *cs)
-{
-    return true;
-}
-
 static void hexagon_restore_state_to_opc(CPUState *cs,
                                          const TranslationBlock *tb,
                                          const uint64_t *data)
@@ -345,7 +340,6 @@ static void hexagon_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = hexagon_cpu_class_by_name;
-    cc->has_work = hexagon_cpu_has_work;
     cc->dump_state = hexagon_dump_state;
     cc->set_pc = hexagon_cpu_set_pc;
     cc->get_pc = hexagon_cpu_get_pc;
-- 
2.47.1


