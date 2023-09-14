Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F227A0DA1
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:59:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgrXz-0000bo-Lf; Thu, 14 Sep 2023 14:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrXx-0000Pp-Aj
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:58:37 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrXs-0007lg-DJ
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:58:36 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-530196c780dso1187510a12.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 11:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694717903; x=1695322703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59t4hOromC/PDn0NFeyyItwZmRcWGVlgWyhUfZ1MliI=;
 b=vmguf1ROAShC9f8ytMNAw2gQTfah2flbi7pR9qCw8/2DBUnjJoClJQNbUbXUtolIhc
 33Apm5CD5BqrP1tm1v9rckseBCcdvJtPVSi87Ch+muRzGqgzQSio3VLmUl62RqymhYD/
 vkukEAOhXu+kF1366/3nL1YmEoAEEd+Pk0NeVHdCiYLiYBPWPB1XAflo0K0QjW2pH3ai
 5tRJ/Ms2k27r9gkJhCPo4TjbkGy24zcHPfK6OCAOHGLRIVWR44pIh6BxncOOkf294j7V
 lAn1wTwRi+9altJkDizZUPpUNDZKX1mj1yEsDDw7HB4QBnJMn7KJoYo0KAUayOqngqwH
 O9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694717903; x=1695322703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=59t4hOromC/PDn0NFeyyItwZmRcWGVlgWyhUfZ1MliI=;
 b=BPRmrhnF/LxFYSijV5gswX45/oBedLofvQ8K/ggbKWmBB1vnbEhd38u7hxFFZv6yn4
 QCEaoszOQi+fKTqgqnDIdKtNJQ8tiFy0Tmz9I7u7y9UPGTlWQ+gGYVPC4MiLSOZZAqrP
 utx/bSXTOvOjYjyFP/oHzKs7EIxHOGJg4xGcmb0tMah1h3j6jm3SXnGcZUg4ezoYlD88
 G2qHBDJgAiIr6GGV/9WT94lWrdU1oy2U2nBzojoi9y2yS64gUw04aYKkz/t8sLXEqdKt
 4WZfEE8s02suEgZx71yt99is6nxPxyTftHqqgYvcVbcpEnZR6QMBWpgLKZerIsL3Z6+9
 hTLQ==
X-Gm-Message-State: AOJu0YwfUIGZv8i6oLSYWdimpBkum6vKx0Btjwg98RPbvudKQDpedZw9
 RfvLO4UsssMPEVsgA3OW0Uz8C0ki3kDkOx0cKvI=
X-Google-Smtp-Source: AGHT+IHZIaYFboZPt7VamwK55r3z9GjyanynqYAYesdJvbELELrbEi9DWL/PDnIzpVwjUxFy7xqViw==
X-Received: by 2002:a17:907:1de5:b0:9a5:d095:a8e4 with SMTP id
 og37-20020a1709071de500b009a5d095a8e4mr4920652ejc.1.1694717903459; 
 Thu, 14 Sep 2023 11:58:23 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a170906078d00b009a193a5acffsm1346112ejc.121.2023.09.14.11.58.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 11:58:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/11] accel/tcg: Make icount.o a target agnostic unit
Date: Thu, 14 Sep 2023 20:57:16 +0200
Message-ID: <20230914185718.76241-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914185718.76241-1-philmd@linaro.org>
References: <20230914185718.76241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

Remove the unused "exec/exec-all.h" header. There is
no more target specific code in it: make it target
agnostic (rename using the '-common' suffix). Since
it is TCG specific, move it to accel/tcg, updating
MAINTAINERS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.41.0


