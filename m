Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 253FA766261
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 05:26:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPD5r-0007wz-Vh; Thu, 27 Jul 2023 22:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5i-0007vl-Vz
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:32 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5h-00070Q-LK
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:30 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-686fa3fc860so868939b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 19:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690510828; x=1691115628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jsfS6gGno2BOtGoWmduTdiYdaH87lQQ6CJY7M9PeK50=;
 b=UqzFMGFVTj+tn0qR0mc9WITus+aDL5vJSaAKKqQVUopw9ZBhABMDyzvSiiUaIXjgFf
 6VUtW4nPJiAhIOmrsqGd5nn+iY4vpHEAPc+Jgc4F1RzAh4aKdrtM5ksfElNiWExZf0uM
 G93eApVxkwExTilRoH8xCqAg+XGQZ2sFF6fxeaSrxGMSA7ondo9p03mnGMehWRKzAHbf
 lkxIQi2oNjSI81/Ewjq/9JP8N+y6V0TNwJw2lw6CxiDAYebA1r3z4FRXakggm15VLJ82
 VgkJ3PLUxFhAQhbkMYpk70E3bS9m3ieWgRQUBxl/+Up5R2/b+SRRDWaO/VTVPE22TbWE
 2tsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690510828; x=1691115628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jsfS6gGno2BOtGoWmduTdiYdaH87lQQ6CJY7M9PeK50=;
 b=A/YbxG7l0EBxm84t/3Oj9eFSMcW0GE9UbUDk83occsg83SphPV9ZGnNuYABdHPTtkL
 GC/jvOIl138rPE4+OO4X1if7SVMC8FBxg7dlC+8koI7DeHCDiCMdhw8sHKe5vZHBOqkQ
 RFCAqAygcXs44Groaj3CDsdJaHEM31gggVn7JRJYBWc684GP4ZOUfhKVnTFXxAX27ElX
 Xhc+bDKzityq5VCbaQZkqHqJ8GsmcnSW116e9bHa6bVQ/nKGf441vHpQO/+9iLZIfBPS
 +qO/Wv+ax1t+JyLakS8bxmtK2ZBMOwrm9dDQY8hHhB6yf1gWrS7ZUw9622AzMzuP/Zu5
 3DHg==
X-Gm-Message-State: ABy/qLZQ2cw3lS1lZmStIHnL5220bh4/rsrvA4+H/apqfgsb3M04i71c
 50ibFKEY5a6UzxsRvm/Nlw4VVw==
X-Google-Smtp-Source: APBJJlG2cZx+NmOpnBUeKklGEgd9UTHsVLMI3xun/tXbH1zZ7KZvMtpGIPTIDH7jG6wwfYyL7E7Dtw==
X-Received: by 2002:a05:6a21:7888:b0:121:ca90:df01 with SMTP id
 bf8-20020a056a21788800b00121ca90df01mr430252pzc.40.1690510827825; 
 Thu, 27 Jul 2023 19:20:27 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a170902d31500b001bb9f104328sm2312947plc.146.2023.07.27.19.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 19:20:27 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: qemu_oss@crudebyte.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v5 5/9] cryptodev: use NULL throttle timer cb for read
 direction
Date: Fri, 28 Jul 2023 10:20:02 +0800
Message-Id: <20230728022006.1098509-6-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728022006.1098509-1-pizhenwei@bytedance.com>
References: <20230728022006.1098509-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Operations on a cryptodev are considered as *write* only, the callback
of read direction is never invoked. Use NULL instead of an unreachable
path(cryptodev_backend_throttle_timer_cb on read direction).

The dummy read timer(never invoked) is already removed here, it means
that the 'FIXME' tag is no longer needed.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 backends/cryptodev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 7d29517843..5cfa25c61c 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -331,8 +331,7 @@ static void cryptodev_backend_set_throttle(CryptoDevBackend *backend, int field,
     if (!enabled) {
         throttle_init(&backend->ts);
         throttle_timers_init(&backend->tt, qemu_get_aio_context(),
-                             QEMU_CLOCK_REALTIME,
-                             cryptodev_backend_throttle_timer_cb, /* FIXME */
+                             QEMU_CLOCK_REALTIME, NULL,
                              cryptodev_backend_throttle_timer_cb, backend);
     }
 
-- 
2.34.1


