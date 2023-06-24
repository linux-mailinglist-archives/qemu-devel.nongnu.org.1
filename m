Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAE173CB5A
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 16:23:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD49t-00020V-Ii; Sat, 24 Jun 2023 10:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD49r-00020M-GL
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 10:22:35 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD49p-0007D9-SO
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 10:22:35 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31272fcedf6so1498139f8f.2
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687616552; x=1690208552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K7EMtxFF9Wpxu9VU5qA4LydL//qFFaOHuvM5w/0z3TE=;
 b=HTc22k8Dy9heu4HAjuh+ZE0w6E4r8l1lO6BG98vvIH9vSyjzTiagteRGqR7P5wigQw
 yLWnsu6Nol6XFAP1UcIWeMq/EJMYqP0fXB0HXWgpt+u5KgmsfTVIW4HitvQoIVcBJ7Vy
 jAGbECvkrikgNXyDSs6y3QLGagM0zi93DoGHtOuAwobPg8Jd78uch/ddaHZTTimLcdyI
 6JxvITVSwK7Vd59V5KyOkdxAjrzM/gDh0dr+xFWddQBpzaP5DOmZ5+cW3eSRhAUCMjid
 i5dg5vczrHshQlZQSa0tgUiRfCWDQBxMzoIhwTkgYeBm91hrUqfvZxCC6o4m8vbrF8Cn
 cEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687616552; x=1690208552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K7EMtxFF9Wpxu9VU5qA4LydL//qFFaOHuvM5w/0z3TE=;
 b=ZSbD1btHi08EFYlamt56fNR6o2w9wOehPA9787fy5itS8957TNwvLhn74JLxBBs9tE
 P7Z/7kUXIo0NFqFsAmUtmB0FhV4YsJXwDHexpOhev2l3PYb7PD4BPqVTaze8hVoPGhwu
 VCwkxKDYth7+J1TKdodvBsulTQ0ERAGQa0AEDb9zzXDlqj1S/j+8oOexdThaqNxvT/WV
 WiM5aivVaxAR5O6xEiCsDwkDjLatYBPax2MzKI4B7fqA193pZtTA5TGckqG5/+a/Urxn
 E7v38UBvCpCiHwFFzK8wMrnEnEUCHe0Pax6rp2pjCESUgzWwb32XZ96sawj/WR8OuU0c
 aQCQ==
X-Gm-Message-State: AC+VfDz9PFxYmumADpALwR4yzeKyiZbHKgjITegMwkBdj2m5TC9cus7y
 HUDmDoxMO6JJNZT9FqOeSdwAiHsVIJbw3gcqjNxjng==
X-Google-Smtp-Source: ACHHUZ7hNwaDIoA0SkyzCOHWjm+Y8Non70XLffIjVuKgAjoL1v7R8ZLnmu0gCFIEF6lBvCDqQtD0Hw==
X-Received: by 2002:a05:6000:184:b0:309:1532:8287 with SMTP id
 p4-20020a056000018400b0030915328287mr5342847wrx.19.1687616552185; 
 Sat, 24 Jun 2023 07:22:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.150])
 by smtp.gmail.com with ESMTPSA id
 w7-20020a5d4047000000b003063772a55bsm2225964wrp.61.2023.06.24.07.22.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 24 Jun 2023 07:22:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 2/2] accel: Re-enable WHPX cross-build on case sensitive
 filesystems
Date: Sat, 24 Jun 2023 16:22:11 +0200
Message-Id: <20230624142211.8888-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230624142211.8888-1-philmd@linaro.org>
References: <20230624142211.8888-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Since MinGW commit 395dcfdea ("rename hyper-v headers and def
files to lower case") [*], WinHvPlatform.h and WinHvEmulation.h
got respectively renamed as winhvplatform.h / winhvemulation.h.

The mingw64-headers package included in the Fedora version we
use for CI does include this commit; and meson fails to detect
these present-but-renamed headers while cross-building (on
case-sensitive filesystems).

Use the renamed header in order to detect and successfully
cross-build with the WHPX accelerator.

Note, on Windows hosts, the libraries are still named as
WinHvPlatform.dll and WinHvEmulation.dll, so we don't bother
renaming the definitions used by load_whp_dispatch_fns() in
target/i386/whpx/whpx-all.c.

[*] https://sourceforge.net/p/mingw-w64/mingw-w64/ci/395dcfdea

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                      | 4 ++--
 target/i386/whpx/whpx-internal.h | 4 ++--
 target/i386/whpx/whpx-all.c      | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 6ef78ea278..fc3c14a810 100644
--- a/meson.build
+++ b/meson.build
@@ -661,8 +661,8 @@ endif
 if get_option('whpx').allowed() and targetos == 'windows'
   if get_option('whpx').enabled() and host_machine.cpu() != 'x86_64'
     error('WHPX requires 64-bit host')
-  elif cc.has_header('WinHvPlatform.h', required: get_option('whpx')) and \
-       cc.has_header('WinHvEmulation.h', required: get_option('whpx'))
+  elif cc.has_header('winhvplatform.h', required: get_option('whpx')) and \
+       cc.has_header('winhvemulation.h', required: get_option('whpx'))
     accelerators += 'CONFIG_WHPX'
   endif
 endif
diff --git a/target/i386/whpx/whpx-internal.h b/target/i386/whpx/whpx-internal.h
index 06429d8ccd..6633e9c4ca 100644
--- a/target/i386/whpx/whpx-internal.h
+++ b/target/i386/whpx/whpx-internal.h
@@ -2,8 +2,8 @@
 #define TARGET_I386_WHPX_INTERNAL_H
 
 #include <windows.h>
-#include <WinHvPlatform.h>
-#include <WinHvEmulation.h>
+#include <winhvplatform.h>
+#include <winhvemulation.h>
 
 typedef enum WhpxBreakpointState {
     WHPX_BP_CLEARED = 0,
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 0903327ac5..9ee04ee650 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -31,8 +31,8 @@
 #include "whpx-internal.h"
 #include "whpx-accel-ops.h"
 
-#include <WinHvPlatform.h>
-#include <WinHvEmulation.h>
+#include <winhvplatform.h>
+#include <winhvemulation.h>
 
 #define HYPERV_APIC_BUS_FREQUENCY      (200000000ULL)
 
-- 
2.38.1


