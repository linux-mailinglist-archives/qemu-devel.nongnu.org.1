Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F50711367
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:14:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQK-0008QJ-Nn; Thu, 25 May 2023 14:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQH-0008Ou-VA
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:50 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQG-0005tz-E3
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:49 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ae454844edso12664085ad.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038247; x=1687630247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4eRrB/YLKSQzVfKVxSy8PAe4EeBLzt+yH82sZfIehHU=;
 b=hiHFQeRtHzJ7a42LoGLjs3aq9gwpnOLYamUKZ7l0Vvxxv5+e4HKzWEq3LsIJRUO/Ej
 /DjNVb1bencKDN2SbuBLluJQ76XPhAIiP3GqEOnLcQI4usMndiY4P3kh8WGWAUI8QEY/
 hQkjLs1aZB8mPwEh1TawxNAJzsGgxbXdk/cpQsfNdgkkQdO8v6n6cmln8oA3mq3V372i
 Dbmv5BcBfIqD0wyPqQYPUdmgWpKlWNlLPZeWKZypQ2nvugYGZVtb+kDwq7jKkWDtatnP
 CBEjOiHGoxYzIrcrYLJkIxrqREs7Wll+x9MZQP8gPDi0um0FhuRlQC/a/og9t+muXjiy
 VrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038247; x=1687630247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4eRrB/YLKSQzVfKVxSy8PAe4EeBLzt+yH82sZfIehHU=;
 b=PHrw4i6qvqxfW2vB7YQYVZYK5tRXono1m4aaSyScQGeGR+6S9fqd9q6VBlUB7sTr/w
 n3GickOzGK1VeDri+00Pg2gjzkyuuApjfaW4Vzf6iP9dM+8G36YzO9YWf+VOy1EfKfrJ
 o9t7ZyhJpyLVOmc9wkdn61XfQTGhwl+2NTj73WR3xKpZXYWLqt4GJwp5zG4w4mzvZgL3
 dhpctsq8SRyme+jCafYjgHBmnt3bbo/Jnc7bNbWL2Gy9ac9Y5XIrGTLjpMNgE28AhhTJ
 mKIYQlwzYrpErol4gK6+WV6q2nqppfYizFFQ3eue/oHYRJuQDIXFlsDMZJ8GT+abNaL9
 1eZg==
X-Gm-Message-State: AC+VfDz6bIzjdX7jrQiuJnfd11UsOHliIVP+1pgTdTRwMWBLPF5GHCo9
 ZrIgj+Dxv9T4MObMviaZMAN9u5L0S+cDByG5lKs=
X-Google-Smtp-Source: ACHHUZ5PFU4klIEnJzFFqkTEyR+IsdBc7n3SifFbDAbBMSpQx1mk1+VHuzeH69TUyF710rybanOPTQ==
X-Received: by 2002:a17:902:c94e:b0:1af:e999:a070 with SMTP id
 i14-20020a170902c94e00b001afe999a070mr3130658pla.14.1685038247166; 
 Thu, 25 May 2023 11:10:47 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/23] tcg/mips: Use qemu_build_not_reached for LO/HI_OFF
Date: Thu, 25 May 2023 11:10:24 -0700
Message-Id: <20230525181036.1559435-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

The new(ish) macro produces a compile-time error instead
of a link-time error.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index b86a0679af..fd92cc30ca 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -37,11 +37,9 @@
 # define LO_OFF  (MIPS_BE * 4)
 # define HI_OFF  (4 - LO_OFF)
 #else
-/* To assert at compile-time that these values are never used
-   for TCG_TARGET_REG_BITS == 64.  */
-int link_error(void);
-# define LO_OFF  link_error()
-# define HI_OFF  link_error()
+/* Assert at compile-time that these values are never used for 64-bit. */
+# define LO_OFF  ({ qemu_build_not_reached(); 0; })
+# define HI_OFF  ({ qemu_build_not_reached(); 0; })
 #endif
 
 #ifdef CONFIG_DEBUG_TCG
-- 
2.34.1


