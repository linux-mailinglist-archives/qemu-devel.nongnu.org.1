Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DCE7415B5
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:54:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXUA-0005yZ-F3; Wed, 28 Jun 2023 11:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXU8-0005yM-P6
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:53:36 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXU6-000813-UJ
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:53:36 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51d80c5c834so65786a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967613; x=1690559613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rx3juRm9DSQQdf3fbo1y63jeVZsFtgSyAd6m1Gt5FZs=;
 b=f0LuD9f3PLqbljgy5iQwSvR9TfNEzOT0QHag+J/8++ETR0Xk9i6CuDdRfr6kzJ/lak
 llbTtO05+U2KHZwP/yP2ZHCHPy99kJkZS3pTdARuuqNrnBdZy7IbTzY/O8H/zzfmYzz/
 fZkLd8Hr50XLHFhr5ZgGvIoticy6UDc3Jn1UXpa08Lby+2wcMOnOviZJWsC6ozcUBmIK
 ggIGZSBkE4uR/Ri3UCcntPrKShKTSjPR12uEuHownStgvkOmaq4UyvdxLg5Gh5Mcl6Nd
 8QnybAMod0EgEJz8b2f4uUBDeJjPLrS9im+kbZE+pvzgJ8sJfoU04KFgcFKFZXW/3/uz
 nsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967613; x=1690559613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rx3juRm9DSQQdf3fbo1y63jeVZsFtgSyAd6m1Gt5FZs=;
 b=HLyCc4aRR99axFSWWShuXjPJAUBdc9vVz9KI5IjewWRJfFPL9+H4vZcQVVHrzfF8OW
 o/6lFSdfUsX9WBj6KormqOtqc+23Bi8gCY8F6RTfczI7Dsi0T5boZGiimIU9twYByTgx
 RJMdWFfA4uesq26U8NxeW+Pcv8c6uK1doQgnaLNmRmMDMk6elsOP18QNkfGBCC0yhUOe
 wO/98iS3/ryuRFc5hm4Tn39D7BJzHs1z3zLgAD0TYXGk30TLyegoV/AG9GYg43Xrg7yt
 MyKhiO+3ZLyQxISpx5TYRVsTik9fnl6zZ8f7i59/EAW3qMFftVWaSBHl4wHvEH3bXt9U
 Uvfg==
X-Gm-Message-State: AC+VfDzjeh0O83UZ2lot7knfbaILxPHqgXNpTwsuWItXaaTQR3NnhyPK
 l5rTC2Nvxz3KCFqp44D20BItj+8SoFewGmzegI8=
X-Google-Smtp-Source: ACHHUZ46uN3RrjDh5u4P6k5BLqnW+9uomRBF+83u9D+MjXtWriMk7ZPIB3R1+g++UfsIWhdunaCLfw==
X-Received: by 2002:aa7:c6ca:0:b0:51d:cf7b:c9f0 with SMTP id
 b10-20020aa7c6ca000000b0051dcf7bc9f0mr1869952eds.12.1687967613240; 
 Wed, 28 Jun 2023 08:53:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 f25-20020aa7d859000000b0051d946ae298sm3789960eds.69.2023.06.28.08.53.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:53:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 03/30] accel: Re-enable WHPX cross-build on case sensitive
 filesystems
Date: Wed, 28 Jun 2023 17:52:46 +0200
Message-Id: <20230628155313.71594-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230624142211.8888-3-philmd@linaro.org>
---
 meson.build                      | 4 ++--
 target/i386/whpx/whpx-internal.h | 4 ++--
 target/i386/whpx/whpx-all.c      | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 1631e60a3b..a9ba0bfab3 100644
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
index 52af81683c..7fa68d49e5 100644
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


