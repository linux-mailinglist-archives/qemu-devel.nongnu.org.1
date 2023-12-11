Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA5F80DCE8
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:24:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCnjC-0003d8-20; Mon, 11 Dec 2023 16:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnjA-0003Xw-5L
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:22:12 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCniw-0005ed-Uw
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:22:11 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50be58a751cso5664570e87.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702329717; x=1702934517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sxk2B1Wo2pXRo42/SYBVVIycoetyzxarj96J9gTlCqc=;
 b=PSIdCiEyGl+JOEJWqcEgbPqXz7U43FDIOWiJ8wNku7wJVrg6+PaFPkTfVB2iV7f0mS
 U/Cumm6EOxRSTkhhJdoIh1PmLaDic5DnNrpiXRYpQ547VbGOZ9KeHzux+xFLx653fSly
 kxISniXZjBYeAghvb01BVnOXsGTJyRp6Sm4b5Awim1NJxAMlGt3VcLz8IEQDCW2Ek/+O
 xVeFd9cj5hpF0YVyAPYUjg0eaov34N5i5W4oBEpmcdAzz5fA359FIYLmpoceCHMXHTGs
 LWhHkHpRrOwiz/WV/Ix4S9tL3cIdWiDczrz61qFmobKpGmWFPUjfEIuxWMy4isFHIQ2b
 LzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702329717; x=1702934517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sxk2B1Wo2pXRo42/SYBVVIycoetyzxarj96J9gTlCqc=;
 b=NrAeEmkkzW99be/RvZaIUg+RN6TxInrpBIDUT/JpcF7Tw2h3QWqh0ciH4mPE/xes8v
 5+cOdktSO7no3JRYi8N84HRR6JofWpc9OQVUrtKaPBsRxSn9jFhtRCVFe993Dldf4ep0
 kL9pw78TcnXpKyG/apSGGusqPFBv8TWSa0D9urMQ7EWpE3jb23lV+P7BqFixwwWTkLdG
 jrnw2Th7nxeblUIna+X5cwWQGyHDtCgvYiuSiRfeRYSOAfPkdCDf9SJjUFVofBsjZmi9
 OuJXvEV0lnj+dYX1QHIP/cD7x1nuFF78YcgFfDVOAt5YMp5jcqqUOi+/OIqIIP5x7pMO
 apvQ==
X-Gm-Message-State: AOJu0Yxj2CGYTs8EbwA9jV3o0zwe2uh9hBYOlxgTa6qkCvznhMh8/GaV
 cW7i7r+HfgtQwnSfwfEuXftTetvNiz7URr7QxNZ+4w==
X-Google-Smtp-Source: AGHT+IHDtXevlZvMNcceTNwUeCFzqJEEEwa7JQhvUomywLsfSZUsIRjfVyrIBQtVafs/CsiHw3FjpA==
X-Received: by 2002:a05:6512:b22:b0:50c:c8b8:6689 with SMTP id
 w34-20020a0565120b2200b0050cc8b86689mr2383978lfu.12.1702329717143; 
 Mon, 11 Dec 2023 13:21:57 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 vh2-20020a170907d38200b00a1be80a0b69sm5333806ejc.58.2023.12.11.13.21.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Dec 2023 13:21:56 -0800 (PST)
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
Subject: [PATCH 13/24] accel/tcg: Include missing 'hw/core/cpu.h' header
Date: Mon, 11 Dec 2023 22:19:50 +0100
Message-ID: <20231211212003.21686-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211212003.21686-1-philmd@linaro.org>
References: <20231211212003.21686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

tcg_cpu_init_cflags() accesses CPUState fields, so requires
"hw/core/cpu.h" to get its structure definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 1b57290682..58806e2d7f 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -37,6 +37,8 @@
 #include "exec/tb-flush.h"
 #include "exec/gdbstub.h"
 
+#include "hw/core/cpu.h"
+
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-mttcg.h"
 #include "tcg-accel-ops-rr.h"
-- 
2.41.0


