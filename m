Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C5A7244D4
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 15:49:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6X3q-0003CZ-Q4; Tue, 06 Jun 2023 09:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6X3o-0003BD-38
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:49:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6X3m-0000dh-C3
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:49:19 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f732d37d7bso26614405e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 06:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686059356; x=1688651356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QX7oEag8EHw5/rO2IwkanQ9xp1UV8fgADH4pyLkBN/8=;
 b=UAZudb/ce1jfJT6y/p6oZh1L0HpidMYjKNYv8HehaQ8ONYHk8enXhUpJCo4GaIiR0i
 gzkgLX2nspwglLewRAkQOgQQV8wc+3ykCdmjQNVJpxqV+zB7/j601xcHg2x5b5upIo5U
 5KA//U+4gmvlkvuJ75GNXWmNUxdE38DD4izgPCi0fbzTkC2xkK3SJNH+UjIEK6vdIyNw
 gKqGnOz666RYPkUpqW/6AXCMUaWTiNXHTq2SJmga5eex0XXSKDqnHqNbZmwW0mTUVUxO
 ewC16DGKPZzBscdzugy9HDqQENBgfdZoPW+EsvFtrdqDlE/4T7YMwcJpZSiKTkv2AxWW
 neIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686059356; x=1688651356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QX7oEag8EHw5/rO2IwkanQ9xp1UV8fgADH4pyLkBN/8=;
 b=TFX1XGOMpEmAAh6kUlw0xichonsT6SqsfPtOEcdZLSFKZma+8X81dWpxcbkhxYej9x
 xgtBa7Vtq09HLDHdUWJrNp6DJ0anQwGG5diUUdlL3PTfGlPB2kBwpx4qs2hQwcPMPE9e
 h4kHoZho9/X/JDXtUIp/LxQDLv3674gxOPAt1pdEKshACL/9DZHCsZCQ04SVAAQFKrWf
 fBg6NndNbBul/iZbCUgXIKhfHYTFkpOBhiu8/pC+G3eKf0A29ryeQnMsd8IzVtrF2hYH
 A7CVrq22BLXF8Mq6qt9nrY/oTbKqbLnFQdNComO72w8CFIlmGntdeNnc1njj6Vs8uJ+Q
 bVEw==
X-Gm-Message-State: AC+VfDzfD08PKIa+2qsTTwZjfTnm8dj+pbK/JdQ/JfiSvw7mJFA5w9u1
 zvPPzh8E5I+iPBGzEghWllZiLWnOAzX9yZCrqlQ=
X-Google-Smtp-Source: ACHHUZ7fnqjT13jGpLe5esp4lXtwn2JrLWeK8SEfG2FwDlLsLfXxMgRqjw65Uhd49dAjUf4hxMfQCw==
X-Received: by 2002:a7b:c3c7:0:b0:3f7:aad8:4e05 with SMTP id
 t7-20020a7bc3c7000000b003f7aad84e05mr2230914wmj.11.1686059356247; 
 Tue, 06 Jun 2023 06:49:16 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-104.dsl.sta.abo.bbox.fr. [176.184.50.104])
 by smtp.gmail.com with ESMTPSA id
 h4-20020adff4c4000000b0030647d1f34bsm12798620wrp.1.2023.06.06.06.49.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jun 2023 06:49:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/remote/proxy: Remove dubious 'event_notifier-posix.c'
 include
Date: Tue,  6 Jun 2023 15:49:13 +0200
Message-Id: <20230606134913.93724-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

event_notifier-posix.c is registered in meson's util_ss[] source
set, which is built as libqemuutil.a.p library. Both tools and
system emulation binaries are linked with qemuutil, so there is
no point in including this source file.

Introduced in commit bd36adb8df ("multi-process: create IOHUB
object to handle irq").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Note, --enable-multiprocess doesn't seem to be covered in CI.
---
 hw/remote/proxy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
index 1c7786b52c..2052d721e5 100644
--- a/hw/remote/proxy.c
+++ b/hw/remote/proxy.c
@@ -22,7 +22,6 @@
 #include "qom/object.h"
 #include "qemu/event_notifier.h"
 #include "sysemu/kvm.h"
-#include "util/event_notifier-posix.c"
 
 static void probe_pci_info(PCIDevice *dev, Error **errp);
 static void proxy_device_reset(DeviceState *dev);
-- 
2.38.1


