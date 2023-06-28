Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2313E7415DF
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:57:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXWC-0002Pu-UG; Wed, 28 Jun 2023 11:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXVe-00027d-Pk
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:55:14 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXVd-0001T7-02
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:55:10 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fba5a8af2cso379575e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967707; x=1690559707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9ckCZXgNGhuTxOJv5GYa6oPwaWkms/CNLiXxlbZv/w=;
 b=v6tNW2c1WIDkixH0MPPE/S8OqbR1GpC0qZHflhyH4UBr5PEPPgMWkwYBr0tBesFOyn
 t1q9iOuct9fCUY5FTeCiAd7hAZqYHo8JPU1wYtESyakfTa2aUlO2BTABAm32Q6yKOWhS
 XxPqtXLMrqFpWm3elS/uVszz2fOpuXDz/a1Ja/sR0rkUk3k18pyK0E0HriTevzp5bXuO
 JSZ1NSeL6Ilekvfp3fRFvMVWuQrOC1gQqsbvg8xyEWd2xY0y6xY5b3AhrYY7Lsz3U6EO
 +GlVKj9ikOBgI5JyQqH/dWK37n9RMkGXQTsuQ6fkwTx/ZIe/E/iYkutNs7uEioI/ROf5
 SAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967707; x=1690559707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v9ckCZXgNGhuTxOJv5GYa6oPwaWkms/CNLiXxlbZv/w=;
 b=gWCZ7tkm4wyfDW7a6UzxdYCsCvCGXCM/LGebJXRXQ9BCO7zP+KuXJg2YpN2Icu250y
 Ed1yexsvCGRZJq6HBnZDSpnc7R0zyuUMIOJswcHPUa5qNFinMlxh2t6SXY4XIwoSCc0Y
 0xa3+PGGJo7nbIb4+BJIVgavrbkUixTP7jWpFoh3cBherKdrJPYz758ScpbtoEtM87b3
 y0RaGgNoFTHJjA059T+0CaaY42I49a6TsaYEygRZZQjYeNRe/UiPSxZqwfeXmgwZ2tzv
 63kjNvpnknnd6bTxEbU7ig1ZgKGw9crqxGwHVVlL02QKJcTkJ4hylej/QzxRKI3aaU2w
 3vWQ==
X-Gm-Message-State: AC+VfDx3H6t+BfRxWbUSkfh9L+WrmcIJr2raK7NxspHeJUKxMo4yfkfZ
 hql2eG9cu+PvqC43ZT6F3/Z0mqVW1djQtYsz0JU=
X-Google-Smtp-Source: ACHHUZ7IMh8R3+rRcjLrTFpHAPfRc1rMifezdqjF1yWsz1ip4kmJhkeEF9DF3UXSkRinKeBVcjyCbw==
X-Received: by 2002:a7b:cc0c:0:b0:3f8:fb7c:6793 with SMTP id
 f12-20020a7bcc0c000000b003f8fb7c6793mr23256693wmh.24.1687967707458; 
 Wed, 28 Jun 2023 08:55:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a7bc446000000b003fba137857esm5611916wmi.14.2023.06.28.08.55.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:55:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/30] accel/kvm: Re-include "exec/memattrs.h" header
Date: Wed, 28 Jun 2023 17:53:02 +0200
Message-Id: <20230628155313.71594-20-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230619074153.44268-5-philmd@linaro.org>
---
 include/sysemu/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 7902acdfd9..115f0cca79 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -16,6 +16,7 @@
 #ifndef QEMU_KVM_H
 #define QEMU_KVM_H
 
+#include "exec/memattrs.h"
 #include "qemu/accel.h"
 #include "qom/object.h"
 
-- 
2.38.1


