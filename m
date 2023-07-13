Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 039207518F6
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 08:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJq1G-0004e4-IZ; Thu, 13 Jul 2023 02:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qJq1D-0004cm-Mx
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 02:41:39 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qJq1A-0007pT-GX
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 02:41:39 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-66c729f5618so410576b3a.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 23:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1689230495; x=1691822495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S33JWaL5Ut8IU49sA03uYQs6qNZeMPjhvpHxuQfR6ds=;
 b=LiTUc2oK+SnNsFV75V0tMvWg1MBL+YIAH7m3LZD5+jz4FX52Qp6paxsIAe7beMdi0n
 56pC6oS5rF96GqCAgTJ9f4CYAxXSxjT7u+tt4Z714b8r57oA6ImCOIBSO6gOdDGNSjGu
 DpiUhAiyEQ7QXIOO2mvdUTGdy7xhKmiLj5Uy2B8cebhmIZT7HiDM+5/uYEVj8J1oaJqt
 hxomR2jlXyAJrJi4XrHsD0jjBoOTpd/b84IyTE3wltxQJO650O+QEcMbwN45b4Epj0M8
 hD369LdKkJb+SXzovI7bH+ZEthAqEkMbuX0kfGZHXddnd0FSFRkw8nJpm/JdSUB8Yw44
 YfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689230495; x=1691822495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S33JWaL5Ut8IU49sA03uYQs6qNZeMPjhvpHxuQfR6ds=;
 b=EYgdIlRPFFG/aly/cEoYV2bHsKS3DeYImOh2lrz1JWvrnnOy2CV0md6502sYW+5xwG
 2Y9zNR3rSDm7nlPR/p34HrZ1wenT98Pc7/UKTfTzS5aBJ18yENKaUDZaUW8KP0JOzd9A
 FdGnOo0vY5vnczcl+o354gtdk1LpD22PBaBJtsf3k0Qwi56I2NfE43v3ApKookNQ+Je3
 8OB4zE6wuCaPMnA9+r/ZkfMt4p7OM6YikdJPqb4gK8qrLTZYHgJyaOVWaHgqZIKQN5E0
 SrE8sKG32JQxVciO6czDlkQqVR3SBDJj9DfEshCPx1yGq4axQGHLJrXF3aLpMp7CtFcz
 uOvw==
X-Gm-Message-State: ABy/qLaUHBtkUOh2DtGQhPbKrNPCQlP8lA0iri1fFO3qApToZ+t/f/2Q
 R930JsDzKLi7ZbOCUiG9XbjtE7EkLxGlabaaXWk=
X-Google-Smtp-Source: APBJJlGyH6GksLmcWRKgpDl7wNqo3KrflzIF1PRoUVUSH+Osajejj0pKl2TTm69wlSArUtpT+JSACw==
X-Received: by 2002:a05:6a20:9482:b0:131:5b6f:ccb6 with SMTP id
 hs2-20020a056a20948200b001315b6fccb6mr646802pzb.19.1689230495139; 
 Wed, 12 Jul 2023 23:41:35 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a170902680d00b001ac2be26340sm5144966plk.222.2023.07.12.23.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 23:41:34 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com, kwolf@redhat.com, groug@kaod.org, qemu_oss@crudebyte.com,
 hreitz@redhat.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v3 2/6] test-throttle: use enum ThrottleType
Date: Thu, 13 Jul 2023 14:41:07 +0800
Message-Id: <20230713064111.558652-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713064111.558652-1-pizhenwei@bytedance.com>
References: <20230713064111.558652-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x435.google.com
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

Use enum ThrottleType instead in the throttle test codes.

Reviewed-by: Alberto Garcia <berto@igalia.com>
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


