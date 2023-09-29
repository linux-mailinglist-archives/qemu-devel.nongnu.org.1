Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D8D7B2965
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 02:09:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm13r-0002dI-TY; Thu, 28 Sep 2023 20:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ixUWZQYKCj4hwfzjwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--crauer.bounces.google.com>)
 id 1qm13o-0002d9-Bl
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 20:08:48 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ixUWZQYKCj4hwfzjwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--crauer.bounces.google.com>)
 id 1qm13m-0005WC-Ax
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 20:08:48 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-d8191a1d5acso20662468276.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 17:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695946124; x=1696550924; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gCUoWaUBrRFpXZN49O4CNx4kkok2AqXAjlMhH6h/pZo=;
 b=IrJxJ+WtmthT3295sVhv6Et4p6sFnAvuk0x5exRXeESxnlMQS9Mo1VuH3nb+vA6olV
 pHwX0StOi7uwQ1j0eq3vKnWvSL72ZblQStJIj7yTUCRvByvatfUDddpUvGdcqMgXgNAH
 ODd9UJcq1hN21Tsq8VHOV21DniC0Ufz6asfNKpXCw/Hqjhz0kS3iY5rwSkZWAiIAL24c
 iOJbVrzCdHvV2oIiqUyxnI1MmcjZ19mLbGII8oFwzcp49I3BVvBKq3utDUi/0iDiRGX0
 fSkZqcssbx9o8ektxUqoqRLK9qR10N3XVNLyCCk9C/9l+T1MwPZC4KlPKU3oOuGVVYt+
 s45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695946124; x=1696550924;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gCUoWaUBrRFpXZN49O4CNx4kkok2AqXAjlMhH6h/pZo=;
 b=KOKY5pmg99FGeyVYDyL9WBPoXeRv1ZjtxJtVu1aSQgTKcGzfoFa5QrTc20en8ooPbO
 k6sm0nQlYAFi38g9mIVib05WKZMP1F1HGmJiBvWwsg2rDOG1Nk0Uk7vbRN9kFwC7MKC2
 +Mz6KRpfS8n9KrLVI4YVqwldlvgBwnoIyHyWVG3hxYjNK6davOH7JA/ADg8IjCRlRUZs
 9IEJG9B65yhe3AVxqEeKRuf0TlWLNxVpvsh3qWAccMyaxxezNpujq01XxAM8OCmTETsg
 1DYwjtwAfxutNkhMi0w8EPmF2ExutoVzbkBNvtKNcBizny4jpB4UCF1vb3bzF23r99yz
 AY9g==
X-Gm-Message-State: AOJu0YzQHxSJAeM9vgstNASNr1IiYn3cl0JM4KcgHtegockGNpos+R5A
 xIz7j0JhSU6uzNVJ9OzLDLTB9zonVuY=
X-Google-Smtp-Source: AGHT+IEICAW1DES8NRbfp9nglbQEcVjrPQf5y2nKaSjaUTw2nEuBoK4T/dq1nt005NRAUX9BDXEi32rBMAQ=
X-Received: from crauer-cloudtop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:100f])
 (user=crauer job=sendgmr) by 2002:a25:694e:0:b0:d7b:9902:fb3d with SMTP id
 e75-20020a25694e000000b00d7b9902fb3dmr39652ybc.0.1695946123614; Thu, 28 Sep
 2023 17:08:43 -0700 (PDT)
Date: Fri, 29 Sep 2023 00:08:31 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230929000831.691559-1-crauer@google.com>
Subject: [PATCH v2] tests/qtest: Fix npcm7xx_timer-test.c flaky test
From: Chris Rauer <crauer@google.com>
To: kfting@nuvoton.com, wuhaotsh@google.com, thuth@redhat.com, 
 lvivier@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Chris Rauer <crauer@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3ixUWZQYKCj4hwfzjwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--crauer.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

npcm7xx_timer-test occasionally fails due to the state of the timers
from the previous test iteration.  Advancing the clock step after the
reset resolves this issue.

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


