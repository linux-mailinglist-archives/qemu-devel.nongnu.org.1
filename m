Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C5E76629A
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 05:45:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPD5k-0007vP-Ta; Thu, 27 Jul 2023 22:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5a-0007sr-DW
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:22 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5Y-0006vY-49
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:22 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bb775625e2so10429955ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 19:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690510819; x=1691115619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Po0gAxAU3dnysaVx2B26/6HXOapX1SQhA8vH8XAjSZc=;
 b=MreQ7FUhcIKjf+CqukObOMxWJSsc+na7SHQiDn7W7RyCwr3iXzegqx1IY2bu3U1/yp
 sNkiR6vX3oyMTO+vxWDIECnWzaDNTjX3uaKMuaODV0PPACjnje9QISOcqHbVEWdbgxLe
 hb0JDZvYHioat15hUWNA5ZKl+BqxWcdJwmgmTGU3MhojTkdgnS3s6OdqAamrdHM3pRHx
 GhZD+FYkZGN7WirHWhweSJE1r+qlzNCa3f67pbpTbQu213853YktpztkeiIfmk0EXufL
 nkfN4BFpUYz9N+NG0x76CxlEAo6tP3w1qqKVqDqYx3S4YrAIytJsx8kHJW0Ep3Y4JC3b
 JSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690510819; x=1691115619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Po0gAxAU3dnysaVx2B26/6HXOapX1SQhA8vH8XAjSZc=;
 b=PCMkbLlQ0DoPMb5a6gaLZyKjN5i/UONCkvtQLDHB6CcB642xgZdIJLYmb2Vq1Pr5wZ
 SNd5bFUmZeoPZ6cIFrDheX0KxrPBxlbmF2T0c4Uc//crGyRRxrjx+sUCkK73o+8dkexZ
 0cysRLGVEQaHjGoPpZKj9de8B2xl3PxcpkgNzKaTDM5WBnEVP7tOt5YFmSBwtC4xFb2w
 X0OXDLgsLfslaFnyZowNWsqk2YIgXUZd1wowjL3bsGN+Yg7pynKVcaHDPnGoewRhP6Fm
 Z+6xIi5JPXISGBXX3SEJDqKl1snvmUYKZXQmrv+n2rihYaiVjm4aGUu7x6X4AhWwcd2L
 j6Hg==
X-Gm-Message-State: ABy/qLbg0sbaF59Zyy1Pb6WIljo07C9K/7/xMAwxXrmcAc1mXsgBRhqf
 NTKI+f+mh8uYr8SYg+q/069cJw==
X-Google-Smtp-Source: APBJJlHgr1Vn/vL1KLbCeWbW/yumSwzG1RU1lnzBdjTJ7cnS382yLcR17lMWliVB3LLZXRGeypDp3A==
X-Received: by 2002:a17:902:d506:b0:1b8:c8bc:c81b with SMTP id
 b6-20020a170902d50600b001b8c8bcc81bmr627535plg.21.1690510818893; 
 Thu, 27 Jul 2023 19:20:18 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a170902d31500b001bb9f104328sm2312947plc.146.2023.07.27.19.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 19:20:18 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: qemu_oss@crudebyte.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v5 2/9] test-throttle: use enum ThrottleDirection
Date: Fri, 28 Jul 2023 10:19:59 +0800
Message-Id: <20230728022006.1098509-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728022006.1098509-1-pizhenwei@bytedance.com>
References: <20230728022006.1098509-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x62e.google.com
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

Use enum ThrottleDirection instead in the throttle test codes.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 tests/unit/test-throttle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
index 7adb5e6652..a60b5fe22e 100644
--- a/tests/unit/test-throttle.c
+++ b/tests/unit/test-throttle.c
@@ -169,8 +169,8 @@ static void test_init(void)
 
     /* check initialized fields */
     g_assert(tt->clock_type == QEMU_CLOCK_VIRTUAL);
-    g_assert(tt->timers[0]);
-    g_assert(tt->timers[1]);
+    g_assert(tt->timers[THROTTLE_READ]);
+    g_assert(tt->timers[THROTTLE_WRITE]);
 
     /* check other fields where cleared */
     g_assert(!ts.previous_leak);
@@ -191,7 +191,7 @@ static void test_destroy(void)
     throttle_timers_init(tt, ctx, QEMU_CLOCK_VIRTUAL,
                          read_timer_cb, write_timer_cb, &ts);
     throttle_timers_destroy(tt);
-    for (i = 0; i < 2; i++) {
+    for (i = 0; i < THROTTLE_MAX; i++) {
         g_assert(!tt->timers[i]);
     }
 }
-- 
2.34.1


