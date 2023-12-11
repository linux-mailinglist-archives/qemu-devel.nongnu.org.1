Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5928980DCD5
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:23:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCnjB-0003Xr-0I; Mon, 11 Dec 2023 16:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnj7-0003Iz-KV
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:22:09 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnj5-0005hB-25
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:22:09 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a1c8512349dso660401766b.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702329725; x=1702934525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3EU22bNfiIc1b+ZyOtnWaIQVzLfNzz6gZyDB25Dnbs=;
 b=Y3wkVg3XNYjJIvA9dxOqQT23TFfDeKNAX4AYoe6SXSn7gY5l7j8HgGDtYSnBDI7LjY
 s9k19FUQFLsjKdpkCJ3D0rZs6oPmEZ6DfqijnVSmFxd4pY5K3YGO9eiBoWAvuKR739VY
 H8pbthaN/4bujicNaAX+iYD2AAGjK7uogsib7NCOpJy4v0AHam1qt9eQbuSxMjXUsIDP
 JQJSBbUCMg3yCC01DmwAvJITKWXRpsnGxO1uYKntvpgUBDODrjVOJ0rlocVHhr1r4sQW
 zrm+RFXLaLLWrV5uZkJ6CGN23/+ZtKVAJofbJEWCRNJX1itB1NkePPFgBwewfE1d+GA7
 ZN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702329725; x=1702934525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3EU22bNfiIc1b+ZyOtnWaIQVzLfNzz6gZyDB25Dnbs=;
 b=EB497vTZIxT9S0Wubusx0kts01uyqEZ1RpNKcuiZPlC68KGTWPUTOM0GW4g39QbeqS
 CNooODYCSUwIDyb7PpzLCQraNpU5DLsPRtn2I3SXDEOBz7D7RehOmQ/fmgS9Ao8stxA1
 2rYAotED1zp2iLv8wwSq5cINIypMqrVGusRa+qrcNVJw4kI6LVYLxcHPwHyk33sIUDke
 T36n1B/FLMDINELONOYudoDcshpLZiqtC6HcnWBO1UKTSg58mzpRA0zNkX6JH28LxB00
 N3iakbTZsZXnq+Sm2uafisNBKm5Ukx/CwxVzyTYfWG8rNdjRRknpDmrqeJmXnfc6ahNV
 jhlQ==
X-Gm-Message-State: AOJu0YzBaXZMUQ+vyEEsXvU/YCf/98CFz73qNBU0gqL1eZZzDicxCVeR
 D1fRJ74p9HxFi+DGGbaMY/7r9e0+fYVSm+04gMZoHA==
X-Google-Smtp-Source: AGHT+IGzl3xQjm7C+9LNWEf4YaTjOxsCCunkMYfPCy1U1wU+AE7F8A7uN4M+yUT3A/jdokc1MR9z5A==
X-Received: by 2002:a17:906:c2d6:b0:a1c:1f65:f4b6 with SMTP id
 ch22-20020a170906c2d600b00a1c1f65f4b6mr3223070ejb.144.1702329725658; 
 Mon, 11 Dec 2023 13:22:05 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 rm6-20020a1709076b0600b00a1db194b777sm5310183ejc.78.2023.12.11.13.22.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Dec 2023 13:22:05 -0800 (PST)
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
Subject: [PATCH 14/24] gdbstub: Include missing 'hw/core/cpu.h' header
Date: Mon, 11 Dec 2023 22:19:51 +0100
Message-ID: <20231211212003.21686-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211212003.21686-1-philmd@linaro.org>
References: <20231211212003.21686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

Functions such gdb_get_cpu_pid() dereference CPUState so
require the structure declaration from "hw/core/cpu.h":

  static uint32_t gdb_get_cpu_pid(CPUState *cpu)
  {
    ...
    return cpu->cluster_index + 1;
  }

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 gdbstub/gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 46d752bbc2..034a4ac211 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -37,6 +37,7 @@
 #include "hw/cpu/cluster.h"
 #include "hw/boards.h"
 #endif
+#include "hw/core/cpu.h"
 
 #include "sysemu/hw_accel.h"
 #include "sysemu/runstate.h"
-- 
2.41.0


