Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D33C3771372
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:40:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUa7-0003ej-Uu; Sat, 05 Aug 2023 23:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa5-0003di-R0
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:25 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa4-0007XJ-9W
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:25 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-26813478800so1955245a91.1
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293042; x=1691897842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGlGyVbf5mAt3X+pirtJo2XZVAZPR2luQo7KvVPWG+g=;
 b=efPZlL53myMCIQE9tVKG0whB4O+nv6ewJYmCie8Xi8+I5rB2wtoqo3VE2SD2adP+Bz
 WUylhQpxkBvwiPliKQhN68r/EWuiszIdvM7I05h27floRwf2LPoiTlvvwQnGs/8KlYRD
 vNJnnoprxoDegqMjQl+GKYEmlqCljbqjVTcigLBo63zvANzczhH2RG/xOalksdewjYed
 zjZN8pQjFQmpt9MJn1c6nmPWWvhXqrUjcPihy9dQM4IA6+bb7z78E/3KlWvCeGGhyAo3
 1ewBZHwXwfvggwwmPOvsQeJI5ae7F4JfD4NYGhCQlx5PLXE4Uq1FM/sbO5d0vRWwQyso
 f91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293042; x=1691897842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zGlGyVbf5mAt3X+pirtJo2XZVAZPR2luQo7KvVPWG+g=;
 b=EdL0fY2f8QW/jaRj01Z5Uf1J+UshMZbJmNDBRMUvT9l2LovzCMWUlNuVNzgt60InOt
 Sj1ejXPpOVwE1LOinvnhqh2AGyFdtskq6vdvX2sLzFhkkBXDEYH7Dl3Hc5EqOpZz3Rrf
 9kJJbO50+G7ZXp97nli1Ca0jkbCWsinnwJiDQHNfs6AaUT7fJPZGZe6qqaIl+VRpNfTd
 4iy5Q/W+Ccx5lyJ7ZWnCGMy+BlktvX6PZoTDD4y52T/S8REt0/l2qYnbowjs0ozt1hnO
 4Q5zsA3TVSAwc1aJ6XLP9KiUv0f8o2NYy/pc+PCHf2TShLpk6DQfB2F5+/EUtfRh8uRl
 vAFA==
X-Gm-Message-State: AOJu0YzL3yHaJehbEE2vAso2+HCDl+ysIixTuuJVJFgVrC4Nhcerdjr+
 0DFcY8dyiBRiqLb6hb+lsUuaiNuM87+zbwfjjqE=
X-Google-Smtp-Source: AGHT+IEBe2QJWs2HHe2uc939UkQ9PIdLSwujwCfzmRiEZDcuQXsL+24xbcXTU2Z2fXpUzMcFVA60ow==
X-Received: by 2002:a17:90a:ce96:b0:262:e564:3ecb with SMTP id
 g22-20020a17090ace9600b00262e5643ecbmr5154812pju.36.1691293042111; 
 Sat, 05 Aug 2023 20:37:22 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 07/24] linux-user: Do not call get_errno() in do_brk()
Date: Sat,  5 Aug 2023 20:36:58 -0700
Message-Id: <20230806033715.244648-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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


