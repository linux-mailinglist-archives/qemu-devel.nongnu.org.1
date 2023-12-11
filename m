Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D17880DCFE
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:26:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCnhj-0000hx-7C; Mon, 11 Dec 2023 16:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnhg-0000gj-88
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:20:40 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnhM-0005CC-Nl
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:20:36 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3333b46f26aso4702582f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702329618; x=1702934418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+O6qsD4iSikKX7LlQ9zhnH8XNtR1+Zg+F3UQkLugJvM=;
 b=xjhepvAcZyeTjITanX2UP/ql6SdyZHBfxcRYpFDCCwFrcIiS1g6UVzpcO6pm2LFJ8k
 EnJpjOsVK8Pfqn+Gv8YloNi1nVkiWgmgmPRSjyTqtk75r+2QTF7rXfU5SQWulO88yqJf
 +r1xtiGWBVu9KM/+cTA35W7DucBMJhuRmWh5fLplDpc0kWKa2msuCjqSUbJD9y72CR62
 mRTPZpfE4y6b1tqMG3KkxKSGko6cKr8ynIcSxlinWZlOfx7fehmYxpvZgeVWZnUFVgXu
 E9koTyumZ11/MlBWtCOzJxpBVnAeOoTLdzrXsmhios/hfTHAStdLjVJjTXIF4TJCb/l4
 dcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702329618; x=1702934418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+O6qsD4iSikKX7LlQ9zhnH8XNtR1+Zg+F3UQkLugJvM=;
 b=vIN0jQ+k/qDCunXUce3OYubq0OKtrBnkZpXjQbJnTTAMYb+e0OZ22of2uk2w6IUG98
 HSzmANKO3jWR1orjQX4SzEclhpnLUMVA9Kpd8yRdlYTdWL2QCRUrulvC6fUvDCb6Tq9y
 Z9QpsyC8nuaILA6e6LVRv5mCvFYyEPR4ZIWfWrws+eoVhBqXRchmK7ElH5ebegkbwFbg
 x9ZhGuB0qlUV9bSYBWVVprYv5EDtR+nMroWlsfzjNaWMQWj3OWsLUMHAgota10k0trCb
 UNZ2gI0b4KQwoZMP5bRjtxi2VDtWrrJdjm2jnjzmrxe7Jfg1iNXaHvH8uYx9UA/Blgfq
 kIJw==
X-Gm-Message-State: AOJu0Ywp0tCZyOPxhDkDeG/P0iWvcYTNhlQ3bSmCxuo4a5hauxBZqrDV
 M5tG9a9ac4kVuDyryn6IjkmUsXTFs3PCnNuWRYIdzQ==
X-Google-Smtp-Source: AGHT+IEGytrQy7Ystfv6RnhfSOauiZ+iRUKsQm3VCDpsIUm30ILiQ4RfEMueOEJ4nTVHKHcn3ji8CQ==
X-Received: by 2002:a5d:4d8e:0:b0:334:b24d:c18 with SMTP id
 b14-20020a5d4d8e000000b00334b24d0c18mr2975705wru.2.1702329617610; 
 Mon, 11 Dec 2023 13:20:17 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 le9-20020a170907170900b00a1e2aa3d090sm5264476ejc.206.2023.12.11.13.20.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Dec 2023 13:20:17 -0800 (PST)
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
Subject: [PATCH 01/24] exec: Include 'cpu.h' before validating CPUArchState
 placement
Date: Mon, 11 Dec 2023 22:19:38 +0100
Message-ID: <20231211212003.21686-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211212003.21686-1-philmd@linaro.org>
References: <20231211212003.21686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

CPUArchState 'env' field is defined within the ArchCPU structure,
so we need to include each target "cpu.h" header which defines it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-all.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 5340907cfd..9a7b5737d3 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -411,10 +411,6 @@ static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
 /* accel/tcg/cpu-exec.c */
 int cpu_exec(CPUState *cpu);
 
-/* Validate correct placement of CPUArchState. */
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
-
 /**
  * env_archcpu(env)
  * @env: The architecture environment
@@ -437,4 +433,9 @@ static inline CPUState *env_cpu(CPUArchState *env)
     return (void *)env - sizeof(CPUState);
 }
 
+/* Validate correct placement of CPUArchState. */
+#include "cpu.h"
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
+
 #endif /* CPU_ALL_H */
-- 
2.41.0


