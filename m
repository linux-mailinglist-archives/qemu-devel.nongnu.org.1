Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8706680DD19
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:29:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCnjn-0004j5-0j; Mon, 11 Dec 2023 16:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnjk-0004ed-Mv
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:22:48 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnjg-0005nf-7t
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:22:48 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a00f67f120aso651291966b.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702329762; x=1702934562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rlfqSYrNkjFSxwUTlcye06DjNA4hjvTlO8ldGCK0b6M=;
 b=fPgTO2pY0D/7gfJfs+R9DqIenW2vUWujCvS5BT4R/So6IYLjfG2FVuJk39XuHWW6Jc
 B0PkKTv72/Vx8CE/lhFLytuvA66453Nu9PTVb0Yjj+Dqww+3KP7ZYQJYaL2r0ZkQMid4
 hs8mw9Br4LKYurbFKSWYua72qgxa5vg4qpkFrCh8u8QNQt2jeqvYtHFClEaDEviq+HGc
 6f+7xfON06uHE9Oy3vCr3G/RQKRDl+76MRkIZiuNXOFkrXYv5Nq8g+xL3GFO0ELVhnQA
 XsAfTGM/9VBEA3B5EzTdywqVF++Nb3gw1ZdJZyHt4cRGcU3jmr1MjCwYSNLP+k9yx4Nt
 WSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702329762; x=1702934562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rlfqSYrNkjFSxwUTlcye06DjNA4hjvTlO8ldGCK0b6M=;
 b=psSFqeoN2fHyUEWDcNJ4gaJrghxxATJ6i+u+1U4Zq9KLaIFYqQ0Jn1q9UxmZwoGvPS
 RKeq/c7p4nV/24/R8CeP0e37gGLliqEC+PUyASZMwu9tHNMJD7v3o9aTQPrCoESkRJ0r
 NTd/6ARLBCStYkYJ9RuF2noyTjSiXfAwWhffU10pexDl72opUvnHwCa2L/dGtPpwupM5
 CdX314GFldIVfJhAReMdeJa6kEybx+1aEprCB//XDKYs2I7GCDyn8bqgXqrU8dcHdStX
 vCYcqsuMyd9PeJpiSkwURvXrqq4DrLKeSazkp1Hu/Fl/aZaMn/scFa/Oy3CWjJage+hJ
 856g==
X-Gm-Message-State: AOJu0YyRH6727oG/8qKPMCb7vk7PlfEWT/vVsYHfbLVqC7iT6CjPChaF
 y+I3plqvrwp8HM1zL2qpwwvax1F8vrA3j3DGwASPvA==
X-Google-Smtp-Source: AGHT+IH6UZZbtd9VX4mMgUEM45N0Ecs0qtLqZAswEvZJyd3ESyVjTRZHXsO4ZqciVy4gf+vf9Z5ROw==
X-Received: by 2002:a17:907:503:b0:a19:a19b:55f5 with SMTP id
 wj3-20020a170907050300b00a19a19b55f5mr2102238ejb.133.1702329762813; 
 Mon, 11 Dec 2023 13:22:42 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 fj15-20020a1709069c8f00b00a1f6c2c3928sm5093354ejc.175.2023.12.11.13.22.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Dec 2023 13:22:42 -0800 (PST)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 19/24] exec/user: Do not include 'cpu.h' in 'abitypes.h'
Date: Mon, 11 Dec 2023 22:19:56 +0100
Message-ID: <20231211212003.21686-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211212003.21686-1-philmd@linaro.org>
References: <20231211212003.21686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

First, "exec/user/abitypes.h" is missing the following
includes (they are included by "cpu.h"):
 - "exec/target_long.h"
 - "exec/cpu-all.h"
 - "exec/tswap.h"
Second, it only requires the definitions from "cpu-param.h",
not the huge "cpu.h".

In order to avoid "cpu.h", pick the minimum required headers.

Assert this user-specific header is only included from user
emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/user/abitypes.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
index 6178453d94..1a8cd1ac74 100644
--- a/include/exec/user/abitypes.h
+++ b/include/exec/user/abitypes.h
@@ -1,7 +1,14 @@
 #ifndef EXEC_USER_ABITYPES_H
 #define EXEC_USER_ABITYPES_H
 
-#include "cpu.h"
+#ifndef CONFIG_USER_ONLY
+#error Cannot include this header from system emulation
+#endif
+
+#include "cpu-param.h"
+#include "exec/target_long.h"
+#include "exec/cpu-all.h"
+#include "exec/tswap.h"
 
 #ifdef TARGET_ABI32
 #define TARGET_ABI_BITS 32
-- 
2.41.0


