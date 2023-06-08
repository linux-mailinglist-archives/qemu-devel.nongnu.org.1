Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EDE72816A
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:33:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Fje-0001Mq-Nt; Thu, 08 Jun 2023 09:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7FjZ-0001GG-9h
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:31:25 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7FjT-0005it-Bs
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:31:24 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30e412a852dso442172f8f.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686231077; x=1688823077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QX7oEag8EHw5/rO2IwkanQ9xp1UV8fgADH4pyLkBN/8=;
 b=Yty491Tz/CLkQDSwq+5sZgxbDG7fw7qXKqg0I2+qqFNlYiT0oe+BLvr1I9fRtno99Y
 3wm+0fYUFbVJNzXFKo6oW+bpOF2rTcqGWoL2W9HqvNeeLIyDQy8LmSb2wCUSvpJFPxl9
 m0JFSV7phvOItASvAbXPHx+PrnsLtMkKiHbbLs0du3kluYxjMYsdIImMf89tg6QCtlV6
 TCoKwMQpYqT9s3iCVMvKQ6XtLoO0jNlqKWhSA1Ai5Q4JIgoiEImHDYM+F14RpKAjgH+u
 wiBvGPy/6F/Jds5Jwkr+gGCy1YuJi44biORmwvI/BzEAdLRatA59FiZST2qsTno6FOdW
 Ze4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686231077; x=1688823077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QX7oEag8EHw5/rO2IwkanQ9xp1UV8fgADH4pyLkBN/8=;
 b=Dlf7CFneUfmda3aq2F+rej5esGHqat7hsdlTgI2e6YkYzJkfzgvORWy0jjNsXgLK/e
 RcU/Xb/y+G6jG4lXSRQtAY/v2qzJeNvmez2GpkDeg5Jg2Mktu4mLXNCwtIsklF4CiB4F
 qQQhqoHtQMvW79Mw6N15tCH8K+3aEEIsYmB8AcyTrMhc2n2Z/J25kSuq9EjBVPuj9aeW
 g7hmKbfjdpdvY8daSdmVYmWYLSlhzJnHSKOV4dAm2MGrrx4qB7972AJn9+Bnn+h/+oPd
 7QPmnvi2NplYXv+LDaKuf2qw/WPsLPmD7UzIHe58CVHy2V40bVB8TG482uB8dXtz412Y
 Glsw==
X-Gm-Message-State: AC+VfDzh5/5oxpYpguR/gymhcNPOhE3p2sSFyQA8dqteH5KjRvAKrxCj
 6qFEAsamgcptbRleAePU9krfTCZSnExBt09g55Q=
X-Google-Smtp-Source: ACHHUZ61tn6vHEAKVl/Vp8pTCAPiqntWPPZLSlOp6Lcuf5M8SqY3aUUWqSkuekw2FlRNU1IkN5xc/g==
X-Received: by 2002:adf:dd46:0:b0:30a:e9cb:1a2e with SMTP id
 u6-20020adfdd46000000b0030ae9cb1a2emr6312547wrm.65.1686231077545; 
 Thu, 08 Jun 2023 06:31:17 -0700 (PDT)
Received: from localhost.localdomain ([176.176.169.168])
 by smtp.gmail.com with ESMTPSA id
 cr5-20020a05600004e500b0030c6751a49dsm1596961wrb.115.2023.06.08.06.31.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Jun 2023 06:31:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/5] hw/remote/proxy: Remove dubious
 'event_notifier-posix.c' include
Date: Thu,  8 Jun 2023 15:31:04 +0200
Message-Id: <20230608133108.72655-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608133108.72655-1-philmd@linaro.org>
References: <20230608133108.72655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


