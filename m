Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FE875F23E
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:11:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNsWG-0007nq-6k; Mon, 24 Jul 2023 06:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsW3-0007iu-AT
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:11 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsVy-0000ay-9M
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:10 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b89d47ffb6so19759485ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 03:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690193405; x=1690798205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48meBdD6mTHtH2x/RIoONhW/lCpA4vlss4RgaZN1ubw=;
 b=B8kA0s8if2dmDpb7M3s+UuaHlYU+LTioLR8arpqUgwrQpfu3A53CQ6ST6GfcKspzEJ
 rehzRWBoWzeHZUDPwnAKE3xtiminG9qSGgHehBlsBByZHg44wrHowoKQ//94OUqsO3Gi
 DW3SG6ar7GJwZYywp0KrZSyeYKQeXixDR5fuItMgwxHhpTPp4H6mtKk/xNp8FzU76S0i
 tX9O8XVHQSeOJZv9faYwKx/r0Ix1MLrmzhmLEqQWUUP8p0R+P8Hu4Olj+uuf24lJztMP
 VVTgfzLQCuboaqX2RdYmWZ/HKo0Pd41rV527Y0LM+os3VI21JxVI4evkZw/EWwi5CbBb
 TeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690193405; x=1690798205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48meBdD6mTHtH2x/RIoONhW/lCpA4vlss4RgaZN1ubw=;
 b=KVwwfQA/b3VOti2kF6iMRgOnIv7op7anFU9nP36fA2DTBQfpL7KPp5MFcWKjRM/2/0
 TqVdTVpN3Li+9f9ZI83fxEnYQfyJb2j8Bx1me55p1UzowUyBmgdCrKB+2pRVC8jSXHWT
 ifXvRKqFopQaxouolHq3B/lEyQYwkJNdleW8ApSGOUC4/3unORzb2Vg4Ckj7KHpo2S6w
 GgNzrd+OXhs1PNJ31l9kaCOrsP6X+M4wZsk+UevgDDMv6CRbASoU9B76nCocV0ykT5qj
 uwCXrWE4KsjbH7lYOe/YU9TeCNSY45iFvsEH9ZUcpNiVvdV53NUgnbfbM6BXgeuSQ+M5
 VOQQ==
X-Gm-Message-State: ABy/qLa6NF0yxCqMLFQmnq9ZWiihrvJjWXihodD3fQaXvOlSVIQQdkgE
 ZF2zvsOsEeNrkRXPDj7HvTOPeA==
X-Google-Smtp-Source: APBJJlGPrW24zARdxGxhNApX2wQ10GYEuWdo7LsP1f3yqH+RCOqal33F5fvEM8b13VSQsEOln+ii2Q==
X-Received: by 2002:a17:903:22c1:b0:1b9:c207:1802 with SMTP id
 y1-20020a17090322c100b001b9c2071802mr8475947plg.0.1690193405012; 
 Mon, 24 Jul 2023 03:10:05 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 je2-20020a170903264200b001bb9d6b1baasm2419124plb.198.2023.07.24.03.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 03:10:04 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com, kwolf@redhat.com, groug@kaod.org, qemu_oss@crudebyte.com,
 hreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com,
 zhenwei pi <pizhenwei@bytedance.com>, Gonglei <arei.gonglei@huawei.com>
Subject: [PATCH v4 5/9] cryptodev: use NULL throttle timer cb for read
 direction
Date: Mon, 24 Jul 2023 18:09:35 +0800
Message-Id: <20230724100939.1022984-6-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724100939.1022984-1-pizhenwei@bytedance.com>
References: <20230724100939.1022984-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x634.google.com
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

Operations on a cryptodev are considered as *write* only, the callback
of read direction is never invoked. Use NULL instead of an unreachable
path(cryptodev_backend_throttle_timer_cb on read direction).

The dummy read timer(never invoked) is already removed here, it means
that the 'FIXME' tag is no longer needed.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
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


