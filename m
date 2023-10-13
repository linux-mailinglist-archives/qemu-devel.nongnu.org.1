Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9EF7C800F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:24:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD61-0001lf-6T; Fri, 13 Oct 2023 04:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5i-000066-IA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:14 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5f-0007jR-90
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:14 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2bb9a063f26so22516791fa.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697184009; x=1697788809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlcBAVVpI5zLW6ERRQW4fO6lx6a7WWu7wrHNRYxo4sk=;
 b=CWF5ak3SGvvBGppUg6AwVGcTbZa5HEIhctdBehKhcchnvSpldyZhIlLxSi5NQXhL8E
 0sG1ehVzpBWpr2IjhlsjhXnQAFn17n0UgoVUuO+6RIunTx3qTJRvtvTMBH0RqX+RvH+7
 +3XE7Gjm6E7sVNgu0EcwDQscnPWL5FDdIhmXhMBbR6zZdPQHAlT3UAxzg70gighbSHo8
 r44B4dHGBlz+mpH8bq88mh86Vvn2Ujs2P4cNI+dv+OICRUJTxIukOYEM2wzEsqKy2nk1
 IjBudUv9ec6WRxB6Y6mXV3D4tPJseCxfDQ7351wW1ya9C6G7SeHpv8t4Guntxgme886M
 td0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184009; x=1697788809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xlcBAVVpI5zLW6ERRQW4fO6lx6a7WWu7wrHNRYxo4sk=;
 b=oq9x5D0kpBuGxuRp36dJRWZGK65cAH5ec9SUgQGcvaB6L1q50225VcjvcCkEe45PyS
 xwS8W67/u5xAc152604wr2aMttc7Dzhd7GtXIftEw8qua1rjLwLgltiJSUCNntsy+bk3
 h7N7t/1CEh5CPJsTlCKG3/ZDYRhLl+LkrrPltK1d69uJMgHGbt7ZMrhGSc0MKFF6p4vD
 y71ilyhXr31MI3cEmuN//KfWA6NX0MlNX0GsSsxqKLNM1T0vJcwm/85tvdAul0hVqC7J
 wOYE9Xbhqu+ekDhKWpCmyr2A0ihKU/BGsVUetoSE3dDG/7zoDfnC7tEVm4aaFg0g1yXK
 3OTQ==
X-Gm-Message-State: AOJu0YwLZhdFv7tmAE/TrMlY8orTtmFDFNT9mu8O7fRWNC2MzJuG8uHG
 lptbWHsJzLRNB4QOXsK3twLJLak3cUmS6cCwZYM=
X-Google-Smtp-Source: AGHT+IFtbtiosm3RlbE3WS9cb3sI1oa2dnHR/8nuYDsszjVJP5a/MIkz5fKG3WjOiRhwV3ckzWK4Cg==
X-Received: by 2002:a05:651c:2129:b0:2c5:50d:3fc3 with SMTP id
 a41-20020a05651c212900b002c5050d3fc3mr1243781ljq.7.1697184009168; 
 Fri, 13 Oct 2023 01:00:09 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.01.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:00:08 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [RFC PATCH v2 73/78] hw/watchdog/wdt_diag288.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:40 +0300
Message-Id: <c2d18ed386a50fafa9a29d86bbda06813281ca95.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x230.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/watchdog/wdt_diag288.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/watchdog/wdt_diag288.c b/hw/watchdog/wdt_diag288.c
index 76d89fbf78..24fb7fcb62 100644
--- a/hw/watchdog/wdt_diag288.c
+++ b/hw/watchdog/wdt_diag288.c
@@ -66,28 +66,28 @@ static void diag288_timer_expired(void *dev)
 static int wdt_diag288_handle_timer(DIAG288State *diag288,
                                      uint64_t func, uint64_t timeout)
 {
     switch (func) {
     case WDT_DIAG288_INIT:
         diag288->enabled = true;
-        /* fall through */
+        fallthrough;
     case WDT_DIAG288_CHANGE:
         if (!diag288->enabled) {
             return -1;
         }
         timer_mod(diag288->timer,
                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
                   timeout * NANOSECONDS_PER_SECOND);
         break;
     case WDT_DIAG288_CANCEL:
         if (!diag288->enabled) {
             return -1;
         }
         diag288->enabled = false;
         timer_del(diag288->timer);
         break;
     default:
         return -1;
     }
 
     return 0;
 }
-- 
2.39.2


