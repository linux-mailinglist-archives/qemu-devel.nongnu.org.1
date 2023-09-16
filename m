Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 822BA7A32BB
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:45:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3t-0007AF-3B; Sat, 16 Sep 2023 17:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd3A-0005ES-8j
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:42:01 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd37-0000Vv-KR
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:42:00 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-57128297bd7so2090803eaf.0
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900516; x=1695505316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pwAW1yDMAGo64PQxKFedXSqZpiMNes3r170GM9uSE/0=;
 b=TmMM4lZS//FNpzkbjnsTUjN9QfgIiZJhQ8sgtbV7BDohwgxN6qwS5Fh0XaPGvVKT6J
 DsG9zKaIvE4DZgbVtyJusuIHiXNUn8TL7yUnsPxACiiJ9JkO62ov4yiCI06Ldgdgz+mo
 m/zLt3qzsP5qQE455TcOWXJGUriM6OUjlAHrDhB9NnIqeWOKfCRJuyDXkFJvTvoOrOzZ
 qgNGuLh2XsZMElGp8tEBJD8CYCqzuM0B48CTDSlQJdns96bo9Ut6w9Wpw2JiW9n27UtB
 hU0nzrx8Okzw2pQrSWwfeMtJUj9VNDIuO6iRcb21yAXCcJiFVW/ZetPkB2i8469cVTgI
 QENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900516; x=1695505316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwAW1yDMAGo64PQxKFedXSqZpiMNes3r170GM9uSE/0=;
 b=GeoUMBRfFtIizyiHgrwJIVlCBI07I3QIaNvIPX05PXTPpVA2ZOWrcJ+8RKhwOAbcEX
 x+dLO9oq9FxoavC+YBbRQGfmUtEpe6EBPIj87h5cZTODhAJNg2/CqxvGOEiVcV9Vz5L8
 YiVkM+0HE8ZhCErrkc2Q0mvxv2C+tt3OhryUQigRSTqyGeQo8+G+cfIkRQUQ3pyTNk8l
 bDiyfrICfZxUczg83tcKGqYnlNNPc+fBNJswwwxvXhyAPJfS8tjAPBuZH/qHplasMvNF
 r8wzGpvaLwgdx6QwQD6nuB0Knylmxvu9RtSTIBLyUxdD5lpBraWDxZSJatT2Ub9Gl29s
 fOLg==
X-Gm-Message-State: AOJu0Yw3IjZPzcDH4ytkM1oTfxaHIIiG3GIiUETyfg9MgYqqP0cAU+L7
 EaXrRZC/9sQI/jIcDloj0+sFibFSGrr/ar2gm/w=
X-Google-Smtp-Source: AGHT+IFfb8T50wfHGcCeNUcBrunri+MckzdQmUnL+Ivfri/AbKIIpLIz2sVELD3FnuoaFqJPutJ5sQ==
X-Received: by 2002:a05:6870:e30f:b0:1d6:57ab:433e with SMTP id
 z15-20020a056870e30f00b001d657ab433emr6247855oad.47.1694900516561; 
 Sat, 16 Sep 2023 14:41:56 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 33/39] accel/tcg: Make icount.o a target agnostic unit
Date: Sat, 16 Sep 2023 14:41:17 -0700
Message-Id: <20230916214123.525796-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Remove the unused "exec/exec-all.h" header. There is
no more target specific code in it: make it target
agnostic (rename using the '-common' suffix). Since
it is TCG specific, move it to accel/tcg, updating
MAINTAINERS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-11-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                                   | 1 -
 softmmu/icount.c => accel/tcg/icount-common.c | 3 +--
 accel/tcg/meson.build                         | 1 +
 softmmu/meson.build                           | 4 ----
 4 files changed, 2 insertions(+), 7 deletions(-)
 rename softmmu/icount.c => accel/tcg/icount-common.c (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ff436dbf21..047d143b9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2912,7 +2912,6 @@ F: softmmu/main.c
 F: softmmu/cpus.c
 F: softmmu/cpu-throttle.c
 F: softmmu/cpu-timers.c
-F: softmmu/icount.c
 F: softmmu/runstate*
 F: qapi/run-state.json
 
diff --git a/softmmu/icount.c b/accel/tcg/icount-common.c
similarity index 99%
rename from softmmu/icount.c
rename to accel/tcg/icount-common.c
index 4527bfbd6e..0bf5bb5e21 100644
--- a/softmmu/icount.c
+++ b/accel/tcg/icount-common.c
@@ -27,7 +27,6 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "exec/exec-all.h"
 #include "sysemu/cpus.h"
 #include "sysemu/qtest.h"
 #include "qemu/main-loop.h"
@@ -38,7 +37,7 @@
 #include "hw/core/cpu.h"
 #include "sysemu/cpu-timers.h"
 #include "sysemu/cpu-throttle.h"
-#include "timers-state.h"
+#include "softmmu/timers-state.h"
 
 /*
  * ICOUNT: Instruction Counter
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 0fb03bd7d3..4633a34d28 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -23,6 +23,7 @@ specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
 ))
 
 system_ss.add(when: ['CONFIG_TCG'], if_true: files(
+  'icount-common.c',
   'monitor.c',
 ))
 
diff --git a/softmmu/meson.build b/softmmu/meson.build
index c18b7ad738..3a64dd89de 100644
--- a/softmmu/meson.build
+++ b/softmmu/meson.build
@@ -6,10 +6,6 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'watchpoint.c',
 )])
 
-specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: [files(
-  'icount.c',
-)])
-
 system_ss.add(files(
   'balloon.c',
   'bootdevice.c',
-- 
2.34.1


