Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F91370DDD8
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:48:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SMl-0000YZ-Bo; Tue, 23 May 2023 09:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMe-0000FS-V1
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:48 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMd-00016k-G8
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:48 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d604cc0aaso2237385b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849665; x=1687441665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ga9z9BMWvgZJWDH0KgOQhGEvMXXMnmqA3xWrk5W7Afk=;
 b=L4hvI9bhaV/6tUzg9U3xkZcxFjslbo3GBhhHVrD56KYji0jPgFjhNknet2NUhLzIGG
 3qimuT8aZ78lzWCIvEOxjs9555K3oIOU+lQwU5DnhjWFVGvzc78i+P9qWpNX0sxS4lQ3
 ZreNyNzDksnu5d5h94fkiB3Da0GEVBSU/QoJH/gP6V0y3/lJCfqwbrbU4x6sOnhBHUep
 m9hw/gxjXomiafRlDr7235hqQ1ELLaH2uLs7yGjc9WRJ2cuaOBNxmv0jgfeKZ8gG7Q/n
 N5gYWDr267u+L9S8Agr4cbSvgXj87bqiUY+ur+TB6D+GQVqXvY7EHumqLJC67jfHXWHQ
 BRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849665; x=1687441665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ga9z9BMWvgZJWDH0KgOQhGEvMXXMnmqA3xWrk5W7Afk=;
 b=gv2GnM++3K2D1cHa8VZvKJEoxoFuSo8GYiVhHqDJETo1TfmDNPC9tPkiOsYauvaKAU
 pMxD63uaLug05OyC5m2kvFzlBan87Fsok/sEhoyS67ZVxYGfG0zDLg7dBlMidE5dddZd
 ZAI2NVRisQJb/4c+mwGipJdw9gaqswviac3qQAw4Xd6dVsCFm1OMVz7ERbXxWXiGedzC
 7VvfyDFVLDcu9rGRLE3yqZh2BDgdBJqGB+4fpgXBFxMG1nJTPLVGeo/1S5IOi9e+RjB5
 tx5TnK95ZGPmNdK+qpmjDCym3jXNep0htCFycwXAx2E/J5sXgkWStMNAsJnJKHLcknO3
 2SLw==
X-Gm-Message-State: AC+VfDzrcAM9z7zn71ttmGMTFNS0O772tXM0IxQtbMNV8FVbacXt6lxJ
 GxZ8euzQktvtA3PUAjGf8TCSZHHi37sp8Gm/c4o=
X-Google-Smtp-Source: ACHHUZ4g3VpDkXcGnKWNa7LxrhusJunJFRnIpDWo4NB4OMzao7FTvn+Sqk6LK3WBBFh456QBYdpXUg==
X-Received: by 2002:a05:6a20:3d07:b0:10b:1c98:59b2 with SMTP id
 y7-20020a056a203d0700b0010b1c9859b2mr10270054pzi.21.1684849665336; 
 Tue, 23 May 2023 06:47:45 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa79284000000b0064d1349dc31sm5737122pfa.199.2023.05.23.06.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:47:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 12/27] meson: Fix detect atomic128 support with optimization
Date: Tue, 23 May 2023 06:47:18 -0700
Message-Id: <20230523134733.678646-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523134733.678646-1-richard.henderson@linaro.org>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Silly typo: sizeof(16) != 16.

Fixes: e61f1efeb730 ("meson: Detect atomic128 support with optimization")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index c516b911d9..ef181ff2df 100644
--- a/meson.build
+++ b/meson.build
@@ -2557,7 +2557,7 @@ if has_int128
   # __alignof(unsigned __int128) for the host.
   atomic_test_128 = '''
     int main(int ac, char **av) {
-      unsigned __int128 *p = __builtin_assume_aligned(av[ac - 1], sizeof(16));
+      unsigned __int128 *p = __builtin_assume_aligned(av[ac - 1], 16);
       p[1] = __atomic_load_n(&p[0], __ATOMIC_RELAXED);
       __atomic_store_n(&p[2], p[3], __ATOMIC_RELAXED);
       __atomic_compare_exchange_n(&p[4], &p[5], p[6], 0, __ATOMIC_RELAXED, __ATOMIC_RELAXED);
-- 
2.34.1


