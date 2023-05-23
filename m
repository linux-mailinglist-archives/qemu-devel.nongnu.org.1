Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1988570E929
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 00:40:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1aeZ-0007Ak-MF; Tue, 23 May 2023 18:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1aeX-0007A2-AR
 for qemu-devel@nongnu.org; Tue, 23 May 2023 18:38:49 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1aeV-0003HG-Qu
 for qemu-devel@nongnu.org; Tue, 23 May 2023 18:38:49 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-25367154308so205736a91.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 15:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684881526; x=1687473526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qGpeX+BWJFtZgsJXkM8eCm9o68YYox29rk4GWeNIAbA=;
 b=SQKD5OmmWm1uQ2SNrNSzd9OmpuJWbF7BFXlJNJZRD+nSX3ixRGB5WNIua46jrllgN7
 9bvjUpOMBoWo2eF7V5L8/aZmJvP5qnxcFlvRSso14vePatzGwxuYCE4VDyqrsJnJz14x
 zaAKBufF70Yn7zj72Uio0eUN4Ga74ey7gxotsJwnPvUuIAd9S9MzTADw9cRP6/YD9up2
 M7+0fg6kQXilaX+lxtOTmXuhpIv4F4aKUYn/TDDsnwU7V689aEK/13VZjzLLpydMTo3x
 GpYVtR9XJSLdkhZnLJrxwulru8bkJDjvBN8xtok7OQRQf2fJW9+TXi8EVSmQ1TPpalmq
 ovQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684881526; x=1687473526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qGpeX+BWJFtZgsJXkM8eCm9o68YYox29rk4GWeNIAbA=;
 b=DamDHy5ZJkmk2yxVeY1oyAnqul9ajBB9jHnYhLfEgsORvL/QjVCW7iYkvW+2hgJX0T
 hu9RjwmNa0BQdXFMz2xF+lhi79hul75BA3a95Goexp0d+iq+Bxy6FaOHzdv32qiMXPAq
 hC3Eua67LRQe02PJOjXGez8CYmqdFqJOEji4tLfeIqhnNgMsP7vsWV3M5gZDZ4xC9Ssa
 7M6xG+KcO1OZzUSKKuCItf28I73ZLrkEYWF+HZ2ewUq/ots2V+Ftyen8bHcbqX8JRZri
 TXzKFTTaIFuVTKTVlMGZh43tTiWeU9QBdA5zyAwdBDBUXaIvP++zFVq28mVM4Z1AatP3
 2pMA==
X-Gm-Message-State: AC+VfDyeYeMh4jl2dtR3iiaLTcgbSXeM4wnRXBkdx4p8yxQaqRvCQHwt
 kD822ZaYEF5EeiMEsL1eSUDazGv2FLVhS7E4tfU=
X-Google-Smtp-Source: ACHHUZ4QFzb5WbVxyt572yNHuyLVGttGVf3A7tTyf+I5j+AWlN02Vik8wG8bJPcQndlau4YlPTjP0Q==
X-Received: by 2002:a17:90a:4d86:b0:24d:fb8f:6c16 with SMTP id
 m6-20020a17090a4d8600b0024dfb8f6c16mr14997245pjh.16.1684881525584; 
 Tue, 23 May 2023 15:38:45 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a17090aa59600b0023b3d80c76csm75824pjq.4.2023.05.23.15.38.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 15:38:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: Adjust check for __int128_t
Date: Tue, 23 May 2023 15:38:44 -0700
Message-Id: <20230523223844.719056-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Remove the signed * signed check, leaving the signed * unsigned check.
This link test runs foul of -fsanitize=undefined, where clang-11 has
an undefined reference to __muloti4 to check for signed overflow.

This failure prevents us properly detecting atomic128 support.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/meson.build b/meson.build
index ef181ff2df..865bdd8d11 100644
--- a/meson.build
+++ b/meson.build
@@ -2542,10 +2542,8 @@ has_int128 = cc.links('''
   int main (void) {
     a = a + b;
     b = a * b;
-    a = a * a;
     return 0;
   }''')
-
 config_host_data.set('CONFIG_INT128', has_int128)
 
 if has_int128
-- 
2.34.1


