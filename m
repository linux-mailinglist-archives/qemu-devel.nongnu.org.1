Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6FA770BA3
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:02:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rN-00051l-Uz; Fri, 04 Aug 2023 18:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2ql-0004aS-0t
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:49 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qf-0001lJ-Bk
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bb84194bf3so18082695ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186440; x=1691791240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGlGyVbf5mAt3X+pirtJo2XZVAZPR2luQo7KvVPWG+g=;
 b=iy0946GlXWEe18CYgAJtMtv0NSdX8zxbn8Wr5IoVxCLyJd6AG7Ju1mlIsPZA5tfxkQ
 xtb1Q0x1LSKoP2/2rvr7lmxjM0OrCdsejTzd/Ll87x0+mFfwTrW/vapOeh4Y92bcGype
 abePKqxU2fQHhuzvpjRmpG4j07wlOhK+rCs18MnslMQM5Dm9DxvVO/CD5HXv7nkzQ4+w
 ECYZ5yxvML3weoL0cCRJLm34VMevcJxiR6jLpJ52JJQ/YeJEquY6dnwoanSKRrJEqFgZ
 T372vWWrLB/Up4w4jcOZHn7ZBYU1LdKFMWimeZi1SYL0ezDBL59o2uXjXr0um2XXETRS
 W4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186440; x=1691791240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zGlGyVbf5mAt3X+pirtJo2XZVAZPR2luQo7KvVPWG+g=;
 b=an64R7v7AO8xset82AIsPc/0Gr9fdEDjJGUS4Rb4TpoBqKvX3N7krflL1gIJ146dJG
 KF+FO4zezDnYog9SMmHpbsuqeuDY55MXH5N6ShGc1DgKJ+wVGgBlR3zn/2rCeVRtLbUk
 pLRHFaugoyQl1HJBwKTpDzakBWVXMe5Igc2u2kZ5AN2M65HVygQo46rJOBnFGdKnsTqZ
 6xv6tR7DC7M6GjsPHvJbJwPTdAuxuguSLJ5/qtSEObOtO4b8svuhl9Tyxywemgf5PYMA
 +Mty+nc0wlgeBE2whbeCDpUV33uutpeqQTmF5MVA0lQDD3RFoUiNZ3gRxpO6VAO0p5d5
 33uQ==
X-Gm-Message-State: AOJu0YyWIlal3iNjwgvZkrQbn/Ul6r7k4VFuRyQ9SPWBIccLR8snnCTA
 9NUPlrCxpvtEaiDopAgPFxdwlb4Y/BTFOdxd8rU=
X-Google-Smtp-Source: AGHT+IGj9gI8mN4y1WlD7trCMaij0y/nx+nuTFXe0rvvnqR+1fPrZK9/ku3zrEBtk2dJYDPXKEKsMw==
X-Received: by 2002:a17:902:c409:b0:1b8:7483:d488 with SMTP id
 k9-20020a170902c40900b001b87483d488mr3173704plk.57.1691186440118; 
 Fri, 04 Aug 2023 15:00:40 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v9 07/24] linux-user: Do not call get_errno() in do_brk()
Date: Fri,  4 Aug 2023 15:00:15 -0700
Message-Id: <20230804220032.295411-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Later the returned value is compared with -1, and negated errno is not
expected.

Fixes: 00faf08c95 ("linux-user: Don't use MAP_FIXED in do_brk()")
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230802071754.14876-4-akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 95727a816a..b9d2ec02f9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -862,9 +862,9 @@ abi_long do_brk(abi_ulong brk_val)
      */
     if (new_host_brk_page > brk_page) {
         new_alloc_size = new_host_brk_page - brk_page;
-        mapped_addr = get_errno(target_mmap(brk_page, new_alloc_size,
-                                        PROT_READ|PROT_WRITE,
-                                        MAP_ANON|MAP_PRIVATE, 0, 0));
+        mapped_addr = target_mmap(brk_page, new_alloc_size,
+                                  PROT_READ|PROT_WRITE,
+                                  MAP_ANON|MAP_PRIVATE, 0, 0);
     } else {
         new_alloc_size = 0;
         mapped_addr = brk_page;
-- 
2.34.1


