Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D0C7EB2A1
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:41:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2uZ2-0002op-JM; Tue, 14 Nov 2023 09:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uZ0-0002mQ-LF
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:38:50 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uYy-0007mk-Lm
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:38:50 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5409bc907edso8777422a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972727; x=1700577527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVR+oDiuZU+TW6PLxAmD0Xj/DK6BF5fQU92EHH5K3Z4=;
 b=JtPFJ4+4J08D0DASGvuioqMBeFkK8i3XPEJMBBbC5CxYOyvL8Aq/hQtCeros6JJLQL
 uSHNOBitNMf9G4cQTWYEH937u/tRnc3MC66YFioPkgiHmbpG4QksFLUXdTZ7IUru9bz+
 B3Tay7xCt5Gm209BdXc3f0dDMoU2BzS6WtQrjflHnrsMSo+6QRd1WzuoLaTwEB5HWqD+
 Jyh3qmjwwK5pkJnaM86w2h14fGtZ2ho0YBvYUqLJ0/Ea5patz99hVOYKFkHjF9NQfNoY
 YkVRfEmau+eJO0YF9DlAi16b4jZnGUvZ16Axulr7jFrZUXbpJN7dkNqtSYammtDqHoYM
 N5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972727; x=1700577527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UVR+oDiuZU+TW6PLxAmD0Xj/DK6BF5fQU92EHH5K3Z4=;
 b=cmQPkfyX0jWR6UkXRzt3GxEp26ctU6xe7Gj3FqQKH1Q/4ygJLoebA16MFS88SESiAZ
 7+LbwZPMtTMdrKAnScY1OR0bNhrTXvIJIE784O570w2idPMiMAPGveiFeQydexgTpCAK
 09Mx6cIZHdug3tSmTcxMxofeoD/ArIrwuFbTjTVPe660OSxFHAY9QeSOABBp00iPitdj
 dUioQMPDnq+ius2SOqvVF44wnJLGD9N/fjnl9aTVz7YT9AR88LRAUYVi1fpcRa7VEIc7
 K6es7w8JAThYAaKkSMiANBGwP0TEFxyS3JT8d5q4VdKyghD28K0hpjj4Kh1K0dFwdOwT
 mffQ==
X-Gm-Message-State: AOJu0Yz90jRFQDgq/sHR/28cBYj8+AA4aCsCJ57Iz7XNkd8oJpthPlEP
 dGmuJiOKQfZTSHAZVoJL6Ef7Iw==
X-Google-Smtp-Source: AGHT+IFU6fMqnyRTdYcaSZcZeeOvXEQ5/pqyJPjwVu+SyaMG1cEZXv2HxBOf7hgBnVZ045SVB8RX8Q==
X-Received: by 2002:aa7:c759:0:b0:543:5a91:a8b2 with SMTP id
 c25-20020aa7c759000000b005435a91a8b2mr7512514eds.19.1699972727421; 
 Tue, 14 Nov 2023 06:38:47 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 m13-20020a50930d000000b0053e3d8f1d9fsm5267242eda.67.2023.11.14.06.38.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:38:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH-for-9.0 v2 04/19] system/physmem: Do not include
 'hw/xen/xen.h' but 'sysemu/xen.h'
Date: Tue, 14 Nov 2023 15:38:00 +0100
Message-ID: <20231114143816.71079-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114143816.71079-1-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

physmem.c doesn't use any declaration from "hw/xen/xen.h",
it only requires "sysemu/xen.h" and "system/xen-mapcache.h".

Suggested-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index fc2b0fee01..04630711d2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -35,7 +35,7 @@
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/boards.h"
-#include "hw/xen/xen.h"
+#include "sysemu/xen.h"
 #include "sysemu/kvm.h"
 #include "sysemu/tcg.h"
 #include "sysemu/qtest.h"
-- 
2.41.0


