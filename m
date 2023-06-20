Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F98C736C4C
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:49:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBais-0001ZA-4K; Tue, 20 Jun 2023 08:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaio-0001VU-Dq
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:34 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBail-0001x2-G3
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:34 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51a2160a271so5888082a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687265069; x=1689857069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oYM1MGsrvUKsckHAPaAPGoH4M7K9gyTZzZ7Te/btT8c=;
 b=SPEhzb+AdollQEdp3HX3JQng19/ma3XyjwJu/ePJtiDKhVTRacJ6/IdiRWMmq7MBQS
 8dJxjPl5dntKq9/RKDy5u+jxkbxUVZD0yjUrag1fhz4PpMoiEDzIc2h1tqfEtOaw4y1k
 BLrRKX+q/rpqmRur/b43tKby7fEvfYoJgNNmMX2aY/Mk/CNSfiK0gmvaggfsmg7csMsb
 Dh74wMgm9LAIrsUAO0El4YiB9l7KJ/X496LD2S66hx3utVPznB77ZY9RLxW2dGoz0dw3
 hDUMCWeYBKZT33If0FObhaue+nYHgmXNlav3QZ+YXbWxpYpM+qYOXkNbrBYC/3ZJYm+z
 t3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687265069; x=1689857069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oYM1MGsrvUKsckHAPaAPGoH4M7K9gyTZzZ7Te/btT8c=;
 b=CwvLrgyvXafQMUhQc3ngJNqyKulzKDao38nDwfRJ3NggBcEwft/4qpDAEq3N6+7rO3
 fa+a2/jMx5su/PU12a3lGiEzBW2joT7wL941u9UzoQA+FgV09GZZqY/CqrX0jzYMSAz7
 Pkky4YXwzKuB1+hvSdhw4Y5mMSb1M8nj0t6UmyGP9cj1xMf78BFzsVRtbWEBRnYva2Vn
 1Jrd7BykLJAGYeYN/eZtAWA+3y51NCuQbgtdoLS4OArcoXNty+Ys7WEIXA3H+tcJzufP
 mzE7Uhug7VW8jSEOxF7B6Lu3P8cvgwv9/TnLThXTWSwhufBgexhFJONtWBzoEvYgvhaH
 Nruw==
X-Gm-Message-State: AC+VfDyiWDhGXZpwrx5BIzSWgy3lIi1p3NA6nRztDfdTDj4nOaZiK+Nf
 72bz/xbb3J2zurW+pOdgpdD5DJGbTChEnEAJxcuY3I9c
X-Google-Smtp-Source: ACHHUZ6CCf3zKcIOWVrwRMS1pm96gQDJmE746TDQblrCz7qCjAXZlvB9+qxNr1rFFwrB4IKsFI/qEw==
X-Received: by 2002:a05:6402:1b0e:b0:514:9df0:e3f3 with SMTP id
 by14-20020a0564021b0e00b005149df0e3f3mr9365963edb.0.1687265068932; 
 Tue, 20 Jun 2023 05:44:28 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 w9-20020aa7dcc9000000b0051a313a66e8sm1142541edu.45.2023.06.20.05.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:44:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 09/20] target/arm: Remove __attribute__((nonnull)) from
 ptw.c
Date: Tue, 20 Jun 2023 14:44:07 +0200
Message-Id: <20230620124418.805717-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620124418.805717-1-richard.henderson@linaro.org>
References: <20230620124418.805717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x532.google.com
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

This was added in 7e98e21c098 as part of a reorg in which
one of the argument had been legally NULL, and this caught
actual instances.  Now that the reorg is complete, this
serves little purpose.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index a742bc1826..f7cbb984f9 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -34,15 +34,13 @@ typedef struct S1Translate {
 static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
                                uint64_t address,
                                MMUAccessType access_type, bool s1_is_el0,
-                               GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
-    __attribute__((nonnull));
+                               GetPhysAddrResult *result, ARMMMUFaultInfo *fi);
 
 static bool get_phys_addr_with_struct(CPUARMState *env, S1Translate *ptw,
                                       target_ulong address,
                                       MMUAccessType access_type,
                                       GetPhysAddrResult *result,
-                                      ARMMMUFaultInfo *fi)
-    __attribute__((nonnull));
+                                      ARMMMUFaultInfo *fi);
 
 /* This mapping is common between ID_AA64MMFR0.PARANGE and TCR_ELx.{I}PS. */
 static const uint8_t pamax_map[] = {
-- 
2.34.1


