Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0047B1150
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 05:45:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlhxw-0007kH-MA; Wed, 27 Sep 2023 23:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3yfYUZQYKCjoYnWqanckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--crauer.bounces.google.com>)
 id 1qlhxu-0007hs-Ai
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 23:45:26 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3yfYUZQYKCjoYnWqanckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--crauer.bounces.google.com>)
 id 1qlhxp-0001H0-Dm
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 23:45:26 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-d816fa2404aso21287456276.0
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 20:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695872713; x=1696477513; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=u5EjZO0FSTo0z0F5HeuyqBSfkOQvotXueCY1QPBCd9A=;
 b=Ekz6yWK9rAmW5aluUGKaIAITYsG8bgP18wQs8PbYPTUsbDJ0qB21f5PUF37egFZ4K4
 k+A7vkUoPFLHW9iTdZoJ0hvQzfWfiHLOCY99zIVPJlP0FaySbSdRBXjzISBzWkx6xSyK
 BGUy6YBQOc25RbTzSmrR/zdAbbngDcP+ekafnzskF135qQxh+UMwJ3AnrqCyzOBUk/md
 kO0KNyxSvcksEcypyYHHbtkoZnY7/n+6+rIMfou5mdJ4LK8hMHv2U91g8MzqoZggvWDV
 bRidFWOAZLytr58mnVh/KESZr48SqRA87eVU2xBe0jcBzysbyR2WLAqqX0LJ+M9XtUSy
 iC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695872713; x=1696477513;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u5EjZO0FSTo0z0F5HeuyqBSfkOQvotXueCY1QPBCd9A=;
 b=Lm7mFanAqrxl/dszgg9EUJvXlZwKulXTf7USdrUkB3SYT5639Y4YO7MwkMQr2eB3bZ
 ePTkFkF3P8sTe/WaLoZhsxAPEmd/PgD595+RTizY/T0U8OGS/GfHkI4wXb0EjJ+GA58q
 mg53984IrtjTVLFk4lPpU3QXeMPKktV1tiD9sASBcIspNpKj1NDroj8s0TtDS3PhmeRb
 6p4n2+8xlf/PWSk1yTFQNaFlZiB/OSgc6zWty+9lQgBy55mHqw1Vu6qlJ0oXS/RxAZfr
 d81WeMwqQZtJshshCYWdCyuDB4pV/uQrz1CDm7Jzz1PfaUBCVlkfMbiCME8NYTOZHqsB
 oK1Q==
X-Gm-Message-State: AOJu0YwC+Ruj88TgEq6/1DAayrX+1OE4KVidkDFMpYW1+Q4uhNgluKhC
 6VuQ8HYK0bEXnAlGVVQikGHw0HBKkn4=
X-Google-Smtp-Source: AGHT+IEgcV6PfcDrQY6VhNnmqoYkxFsfSLrAUHdBA5QcHOfvrCHHcRVWVky1BmgyAlwWTCqTm9tYZigBslM=
X-Received: from crauer-cloudtop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:100f])
 (user=crauer job=sendgmr) by 2002:a25:cb03:0:b0:d77:f7c3:37db with SMTP id
 b3-20020a25cb03000000b00d77f7c337dbmr613ybg.8.1695872713127; Wed, 27 Sep 2023
 20:45:13 -0700 (PDT)
Date: Thu, 28 Sep 2023 03:45:05 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230928034505.255480-1-crauer@google.com>
Subject: [PATCH] tests/qtest: Fix npcm7xx_timer-test.c flaky test
From: Chris Rauer <crauer@google.com>
To: kfting@nuvoton.com, wuhaotsh@google.com, thuth@redhat.com, 
 lvivier@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Chris Rauer <crauer@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3yfYUZQYKCjoYnWqanckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--crauer.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1897
Signed-off-by: Chris Rauer <crauer@google.com>
---
 tests/qtest/npcm7xx_timer-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/npcm7xx_timer-test.c b/tests/qtest/npcm7xx_timer-test.c
index 43711049ca..58f58c2f71 100644
--- a/tests/qtest/npcm7xx_timer-test.c
+++ b/tests/qtest/npcm7xx_timer-test.c
@@ -465,6 +465,7 @@ static void test_periodic_interrupt(gconstpointer test_data)
     int i;
 
     tim_reset(td);
+    clock_step_next();
 
     tim_write_ticr(td, count);
     tim_write_tcsr(td, CEN | IE | MODE_PERIODIC | PRESCALE(ps));
-- 
2.42.0.515.g380fc7ccd1-goog


