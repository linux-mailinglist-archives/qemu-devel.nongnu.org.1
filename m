Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72070723167
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:28:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GgR-0007z6-RX; Mon, 05 Jun 2023 16:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfx-0006ve-Sn
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:38 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfu-0005mt-5Y
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:35 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1b00ffb4186so30783255ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996372; x=1688588372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yv/XPqbhv8nUeXb0hXO9bS/8b9QGtoWBmeHgg0dWk2g=;
 b=mceq8fazmj1BbFrJ9pyZSLyj+m8ta2LquCTzxzegQM2tTy3e+VvWiT1Qe6qI/6NCRq
 fbarwypNWfz30nYWIIu3y9O9XLEh4C5FDGoIbZHN6S+erzZiE/AM1/UTP8oySF+n05q2
 9L3jSgkJfvMYGD2w8yzQlR9siflu+O0J9P7EsdzkSgXkI1KVrOJpawhA+XPZIJ9OPLIr
 v2+9tmz0k+jGLc0lgYjKgGoNjGZnXizPbXqOLmjjjBYatCiX1RsV1fAo67LsTtHp6AM8
 qbhBVSoc6c+CABjxhWtXngo11Qokpq3EmuZD61y42n9JXdIkcDF09MSqYbGZXEKncFc7
 fi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996372; x=1688588372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yv/XPqbhv8nUeXb0hXO9bS/8b9QGtoWBmeHgg0dWk2g=;
 b=ZxrxpTQYsrOQsjntgFN3wAK73oX7r6ouoZ+3mhVnKKLiRPRySZ4m3GDCQK+6im1iC4
 pR0ovC1jF4Pm30e8Ui8b45tJYcCfbRPnuumLt8wT1r11MxoNgFP9I51LGWexdV2ZZ0p5
 LpVBeA3bKSRUOFSkyeTWwJK3ACIGa0ZgmxGZUxNvMq4lXePpNdcPfXrfaf4eriMdbOnv
 f0yFrrUhD57ybJqxjcstTd2Mim7Lh+Ejg5v5C85OZNutCXnZQOQAfX3n9YXYlrjXSyW0
 blkzMfffbr6qVHHIa4wi5zYw1M0t5gJwn8QOqfxVx7d0EPYm7abaQrTqwmKEJB0T+ZQn
 AtZw==
X-Gm-Message-State: AC+VfDyiPtp2WqVOeeJ3lqI5ECw9/qKveVhXjJ7GL65V3ZmLgzgKJVG0
 n94ZgpIPu40lSgwnGF73FNJqx7CYMHbWC+7/Sxk=
X-Google-Smtp-Source: ACHHUZ7VZEBdMGQHD/Q0ArQtGFe57sYRLoVBDfH12ZiiioIfI99z1Q7LMAGvZN9XZ8rPuP4HNj3Y7Q==
X-Received: by 2002:a17:902:f802:b0:1b1:8900:5211 with SMTP id
 ix2-20020a170902f80200b001b189005211mr42519plb.28.1685996372260; 
 Mon, 05 Jun 2023 13:19:32 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a170902c79400b001a980a23802sm7018184pla.111.2023.06.05.13.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:19:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 49/52] exec/poison: Do not poison CONFIG_SOFTMMU
Date: Mon,  5 Jun 2023 13:15:45 -0700
Message-Id: <20230605201548.1596865-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

If CONFIG_USER_ONLY is ok generically, so is CONFIG_SOFTMMU,
because they are exactly opposite.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/poison.h         | 1 -
 scripts/make-config-poison.sh | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 256736e11a..e94ee8dfef 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -85,7 +85,6 @@
 #pragma GCC poison CONFIG_HVF
 #pragma GCC poison CONFIG_LINUX_USER
 #pragma GCC poison CONFIG_KVM
-#pragma GCC poison CONFIG_SOFTMMU
 #pragma GCC poison CONFIG_WHPX
 #pragma GCC poison CONFIG_XEN
 
diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
index 1892854261..2b36907e23 100755
--- a/scripts/make-config-poison.sh
+++ b/scripts/make-config-poison.sh
@@ -4,11 +4,12 @@ if test $# = 0; then
   exit 0
 fi
 
-# Create list of config switches that should be poisoned in common code...
-# but filter out CONFIG_TCG and CONFIG_USER_ONLY which are special.
+# Create list of config switches that should be poisoned in common code,
+# but filter out several which are handled manually.
 exec sed -n \
   -e' /CONFIG_TCG/d' \
   -e '/CONFIG_USER_ONLY/d' \
+  -e '/CONFIG_SOFTMMU/d' \
   -e '/^#define / {' \
   -e    's///' \
   -e    's/ .*//' \
-- 
2.34.1


