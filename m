Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D2976DDB2
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 03:55:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRNWc-0000fz-PN; Wed, 02 Aug 2023 21:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWY-0000e8-OM
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:10 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWX-0000kI-2y
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:10 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3a37909a64eso325452b6e.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 18:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691027587; x=1691632387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZjeFygd6IIkR9M2DIG513e5CPYAFIDSvTnL6qX1fRv4=;
 b=D2cL7cl0jhRcNMi7CBZSli4u5yGtIkTCqy1obOL+stzpF2Cs+q4l/IWa4yjzQlQpl6
 /+hjOKr80bEPmjQldonmTc8sgOhqecCOM++37nL3wwgDJkxDxOO5wO4g7iJCH+dTZcls
 dmxevF81TRZSbs4Emd8vv7zq52/rrm+zaGP6dQjtT0DcezQmrF8O8NrSD+jiIKymghUz
 smlUgXG0Wb71h55k4iQQWx0I2m8FXOX7aowvE+Kf7Kv+fIYTwXeDSNTgsjFkdah+1TQc
 fbAyt3jKtm3UoWpFT6atKAwypMZ4Psu1YVoRkEqQWVbpX+/+eb9MymQR1mhrvjyOnxgd
 70bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691027587; x=1691632387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjeFygd6IIkR9M2DIG513e5CPYAFIDSvTnL6qX1fRv4=;
 b=PYEvokaME63J/nzTVYAz/3hJOyLlPC2KkWuF2ennXDgG7etuNEcygbTc2bGAgsfzZe
 PPXGBHg5ol32E5/n6oplyFfHSew6mFMayirB1fIe2qDGc3cVstCilSpp1KTwHqG2X0WB
 I+CIniVzEYgCsGrMSuo1YD6LkveLq8/P1MSadqAzOiTm1umLMLwzw6yf5VyRdq5VUHwV
 HjLCPFoYcwQznvJZK9aupgVGQRJpUSRMlqupwR0W/CjtmBGS4KzeOJ9nnkiz7Mah0/PK
 7ujX37gb0rrndBsK6Dy+0oaXZCsDRJ7HMUVbvE9J7v/Dotz9hiLDHmBYtEYoHSTHWSZB
 Jy8A==
X-Gm-Message-State: ABy/qLZ64tOE+HHhQeNMShAZ2Ps50J68U32PDUzjaxx1pGXsXED4wVoZ
 5Rqb+EevFwF+aY6rfZNn+iyvdCtOsFTVy0h6VA4=
X-Google-Smtp-Source: APBJJlH2iOQ7D9qdecxyJCtqEe2zwKmtfYJXOWOybcUWsFvxwoKCOa5ruCVzJNBc0K0E8S52/nLmNA==
X-Received: by 2002:a05:6358:708:b0:139:d277:354d with SMTP id
 e8-20020a056358070800b00139d277354dmr10597854rwj.22.1691027587468; 
 Wed, 02 Aug 2023 18:53:07 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a63a319000000b005649cee408fsm157123pge.0.2023.08.02.18.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 18:53:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, laurent@vivier.eu, akihiko.odaki@daynix.com, joel@jms.id.au
Subject: [PATCH v7 04/14] linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
Date: Wed,  2 Aug 2023 18:52:52 -0700
Message-Id: <20230803015302.407219-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803015302.407219-1-richard.henderson@linaro.org>
References: <20230803015302.407219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

MAP_FIXED_NOREPLACE can ensure the mapped address is fixed without
concerning that the new mapping overwrites something else.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230802071754.14876-5-akihiko.odaki@daynix.com>
[rth: Pass -1 as fd for MAP_ANON]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b9d2ec02f9..f64024273f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -854,17 +854,12 @@ abi_long do_brk(abi_ulong brk_val)
         return target_brk;
     }
 
-    /* We need to allocate more memory after the brk... Note that
-     * we don't use MAP_FIXED because that will map over the top of
-     * any existing mapping (like the one with the host libc or qemu
-     * itself); instead we treat "mapped but at wrong address" as
-     * a failure and unmap again.
-     */
     if (new_host_brk_page > brk_page) {
         new_alloc_size = new_host_brk_page - brk_page;
         mapped_addr = target_mmap(brk_page, new_alloc_size,
-                                  PROT_READ|PROT_WRITE,
-                                  MAP_ANON|MAP_PRIVATE, 0, 0);
+                                  PROT_READ | PROT_WRITE,
+                                  MAP_FIXED_NOREPLACE | MAP_ANON | MAP_PRIVATE,
+                                  -1, 0);
     } else {
         new_alloc_size = 0;
         mapped_addr = brk_page;
@@ -883,12 +878,6 @@ abi_long do_brk(abi_ulong brk_val)
         target_brk = brk_val;
         brk_page = new_host_brk_page;
         return target_brk;
-    } else if (mapped_addr != -1) {
-        /* Mapped but at wrong address, meaning there wasn't actually
-         * enough space for this brk.
-         */
-        target_munmap(mapped_addr, new_alloc_size);
-        mapped_addr = -1;
     }
 
 #if defined(TARGET_ALPHA)
-- 
2.34.1


