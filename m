Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C41734C8D
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:43:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB9Wq-0006f9-JW; Mon, 19 Jun 2023 03:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qB9Wn-0006ew-Vf
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:42:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qB9Wm-0004SJ-IA
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:42:21 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f90b51ab39so15593415e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687160539; x=1689752539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qnwofEvBkK7OFlWxUNT5Ph9UIp0ImxIpuwb9PIhQ0Pw=;
 b=EE51AOLwQ4vmbXoxwULbpzEAfT4nyAiurvU2yp39ByQgEXy0UKU7cnjCHdLEL0BvQP
 +6ReLwVlYfrLAZP9QUhirZaUU//1i1pJ5u5u3j49gbnHBSxe2mtVKwq3A0D3SQkyOQNQ
 2DhJXaFbkSpktv2h3yn4I0bChGkrqy7EOFFrAwH9eO41jBAoI+YS10X9Bsd682E9gk4c
 PLNGuCeS+Nx9h39sjMeOo2I0boySxK8xc08KTjdu4eSBFYlwJuMAe9YfOpTsVHDOhJaS
 YUicW8uWn0KYHl5xgQRX/sq+uflnQjGG8EZhzkuQVaGI1bNCIpl1NTHkBHYexPzWUTmD
 o0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687160539; x=1689752539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qnwofEvBkK7OFlWxUNT5Ph9UIp0ImxIpuwb9PIhQ0Pw=;
 b=OiGE52HsR/rrqOiXEAmzR55i+XXlIl+oithxbgN8/FQyHWIQApodFhlt5rHpJnbGzd
 mPYjcfeFFKiSGCcv+dyigB8CdS6CeEVXBeqVl+qtSg700tz0aGPIXj0tArF1PoqE0WhU
 ZFTcz//lUZbqQOC+h5hGNoB2d6FOOgt/SekSW1WGSUfbi/KXI9t7cc8WtXUyaRVDnXtH
 KUVt4OCaV04OE/3gShqnKpE3/KKv9yk9XHPqdT8StiKditdKhGW1eilNQOdSNdJBgtX4
 RXe4Uy1fRQ9rXn5NmK3XXdzKskyXmas/UV/QBdpivg6XIGtx59uXQEe0fmp5rlKpc88a
 DTiQ==
X-Gm-Message-State: AC+VfDwn3RcrZ7iRq7ImAqnMyqZzxIIQjlV+ErSe/r8HepaAq/q7vQo2
 HUiHgOR66lxBpRDb4ASiIdXmR/+fCRywITEDCCmBPQ==
X-Google-Smtp-Source: ACHHUZ74l0mQgAwXCVkwLZ5Afzwn5E6CYM4Voj1ipWGLnlMT4kTiUVCtJiWHbcPXZVDWm+SV7huC2A==
X-Received: by 2002:a7b:cc8d:0:b0:3f7:3937:f5f2 with SMTP id
 p13-20020a7bcc8d000000b003f73937f5f2mr9607638wma.22.1687160538850; 
 Mon, 19 Jun 2023 00:42:18 -0700 (PDT)
Received: from localhost.localdomain (194.red-95-127-33.staticip.rima-tde.net.
 [95.127.33.194]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d43d2000000b0030ae93bd196sm30567287wrr.21.2023.06.19.00.42.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 00:42:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] sysemu/kvm: Re-include "exec/memattrs.h" header
Date: Mon, 19 Jun 2023 09:41:53 +0200
Message-Id: <20230619074153.44268-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619074153.44268-1-philmd@linaro.org>
References: <20230619074153.44268-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Commit 1e05888ab5 ("sysemu/kvm: Remove unused headers") was
a bit overzealous while cleaning "sysemu/kvm.h" headers:
kvm_arch_post_run() returns a MemTxAttrs type, so depends on
"exec/memattrs.h" for its definition.

Fixes: 1e05888ab5 ("sysemu/kvm: Remove unused headers")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 88f5ccfbce..528966b5a8 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -14,6 +14,7 @@
 #ifndef QEMU_KVM_H
 #define QEMU_KVM_H
 
+#include "exec/memattrs.h"
 #include "qemu/accel.h"
 #include "qom/object.h"
 
-- 
2.38.1


