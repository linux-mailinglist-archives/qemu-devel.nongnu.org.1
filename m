Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A713278EDE7
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:00:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhFI-0002tI-Im; Thu, 31 Aug 2023 08:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhEo-0002ef-1s
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:30 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhEg-0005CE-PT
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:29 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so6960775e9.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486639; x=1694091439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XdOtrub1S9PyK3Of9msYB/6KGqYXgpPYDD/KQybr13o=;
 b=aMhBDJp2m1IsfWWNidkZRakyhpS0YH5OC36yEBaEA+F7V8+YPTe0YaDey/LKO+n/Sp
 1PuX4AG++droWT+ElFFWh8S4EiZuCjNFHxkf10KWLxjqYFtvkdWvUxCy/TxFF672loaU
 AD9kCUZy+uQlv+YlE0uvp70ZgEXmcjNiu+nqcJT9EhAGA2jq9YUGrTsMTqvcOlmm+Ne5
 Fz9/tgH3exrDUGc6038YRDpwAy+YC4KJRiXjUFBBCMXmjjiVonsC6GG8Z9eB2JTY3HaG
 utHmGsOm7JZWX0cmTo0CoT/9BT4C+xae7Q7ngxzSJNJM6bKt0WMIb/up912jz4J/5SDW
 ng1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486639; x=1694091439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XdOtrub1S9PyK3Of9msYB/6KGqYXgpPYDD/KQybr13o=;
 b=RD2hu2g/JU/HPWdlMONSuEBYH6oBvMe7Chv/Xgjs1YXkn8Dr4A0pNJAvUZ6zgiEuy4
 /joGvsJirztDDkVid+ue32jhbz0/UzMsWylBhJnx/nXJwQfS5NxDzvuuuCviRzdqjR5Q
 +s2gYmtg8veT5gr6IwsxA5uweJWTflVLXYGChvcfaxtO3nieAFgVwH0qqo1nHDDYd2jA
 3ekd0qw4POdKyaJFjy/PdBVfvpR2UQRsgI7adgvBYQTrtkslPGpdgztdMyLkQinCIr/w
 rDA5PnRe0sE4FZPUsvNneeccfCiFmx9FZpRsOVz4C1PXFKVW/1xdin0iRMcRCnc+uN51
 avIw==
X-Gm-Message-State: AOJu0YwwzXgOM8Qy8cTk7JqE210YLuHn9tJLEbJZa1z/zi64VNl6XmtN
 I8QX1jMod2UXc8xqGymg6fQwwq7NJin8qfimmjg=
X-Google-Smtp-Source: AGHT+IGrbx+32RjExgCYs7rJg7g+9uNDElRySvLl5Qg3Vg6zTeFJ6YBwm2cT7ygOUZA+iXFgLkBiJA==
X-Received: by 2002:adf:dc8b:0:b0:31a:dd55:e69c with SMTP id
 r11-20020adfdc8b000000b0031add55e69cmr4260280wrj.60.1693486638982; 
 Thu, 31 Aug 2023 05:57:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a5d5945000000b003197a4b0f68sm2186305wri.7.2023.08.31.05.57.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 05:57:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 05/41] hw/net/i82596: Include missing 'exec/address-spaces.h'
 header
Date: Thu, 31 Aug 2023 14:56:07 +0200
Message-ID: <20230831125646.67855-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

hw/net/i82596.c access the global 'address_space_memory'
calling the ld/st_phys() API. address_space_memory is
declared in "exec/address-spaces.h". Currently this header
is indirectly pulled in via another header. Explicitly include
it to avoid when refactoring unrelated headers:

  hw/net/i82596.c:91:23: error: use of undeclared identifier 'address_space_memory'; did you mean 'address_space_destroy'?
    return ldub_phys(&address_space_memory, addr);
                      ^~~~~~~~~~~~~~~~~~~~
                      address_space_destroy

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230619074153.44268-2-philmd@linaro.org>
---
 hw/net/i82596.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index ab26f8bea1..6defa9d3a1 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -15,6 +15,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "exec/address-spaces.h"
 #include "qemu/module.h"
 #include "trace.h"
 #include "i82596.h"
-- 
2.41.0


