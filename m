Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ADD791757
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:44:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8vu-0001lP-M2; Mon, 04 Sep 2023 08:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8vs-0001i0-Bn
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:43:56 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8vp-0004eM-43
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:43:56 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so220810266b.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693831431; x=1694436231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdbPeRb3rqucMV4G8DmJatCRkQTtO6zKzLYWXw0g6yM=;
 b=dWfNtNbki2/Zlt/y2OdYsxFGajq1Ih3AqV2bzLc2IHjHjEXl5U7M0naJEkts/MtRoj
 KADVM2tNtm/tvQXx+riLrju6AOakWTAlJdm3v5LBrkXSTsajYxNJSFeZ7bluGVDzzq0U
 /GVoj96gjvaukMRuvcsrEY0gy0xhTdIhauYj3HAYXT5L0MqLBQUZamgkD2WKl+T3hs2W
 08UZ2V06y8fDIAYev+UkTobenjHR60q9KFJFmjdm+ci3El5a1JaPGiAn+9Hf8fIjfprk
 yYAx4JWmO4y1aIwkeWuHaYCckINHHW9uNDkN5v3vlUZCgiGv6BLie09lSyU3IUO7Z4Rg
 IVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831431; x=1694436231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SdbPeRb3rqucMV4G8DmJatCRkQTtO6zKzLYWXw0g6yM=;
 b=C0EF3qlEC+BECjxs+YOrzgGq/+++d+Yw5ntBXD+bCSvAQDE749I+zyYhuGN8/980Nk
 sNUO2HnLSW/znFvs/nqpJK52LHMnFhNomiWSE7saEbF4xI4g+JpTW21wuxhF6If9Ozhd
 eBB7/FQ1/zrF3JW6Ov6gyOsHdEM0VLoo3fA1zcOR3Hq2PRvrHcZNzzjT+UBgmel1Eib3
 kJK6M9xdgnhMx9hMAlNwi5oSszEjCVVQhSBukOCvGtZLETTQiK6tKssMbVeGGcPh/gnO
 KlLDh3osAiVPUIXRmk1feeBfexpJjBuYYqOOyA/d21Q6pAeW9roMo7Y8JtMChmw/u3ym
 17fQ==
X-Gm-Message-State: AOJu0YzbQVTRpJqI3Rbf0Q/6Mgm+jnvlfSoNAuaA14mAZ8oyFdA7Js7H
 yrwlTxJKdh8LrkgKd6scg/KDFP9xHX8xXYS0oRY=
X-Google-Smtp-Source: AGHT+IEsBFqUtTTs6WqvZHff9CgEl9Cr75zp000xY/akplngwM5ibOARO4pqK/3xRP1h2a6+OrAUVw==
X-Received: by 2002:a17:906:cc5b:b0:99d:fd65:dbb2 with SMTP id
 mm27-20020a170906cc5b00b0099dfd65dbb2mr7528978ejb.33.1693831431480; 
 Mon, 04 Sep 2023 05:43:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a170906914800b00992f2befcbcsm6120980ejw.180.2023.09.04.05.43.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 05:43:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/13] target/i386/helper: Restrict KVM declarations to system
 emulation
Date: Mon,  4 Sep 2023 14:43:15 +0200
Message-ID: <20230904124325.79040-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904124325.79040-1-philmd@linaro.org>
References: <20230904124325.79040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

User emulation doesn't need any KVM declarations.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 89aa696c6d..2070dd0dda 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -22,10 +22,10 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "sysemu/runstate.h"
-#include "kvm/kvm_i386.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/hw_accel.h"
 #include "monitor/monitor.h"
+#include "kvm/kvm_i386.h"
 #endif
 #include "qemu/log.h"
 #ifdef CONFIG_TCG
-- 
2.41.0


