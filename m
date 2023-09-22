Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 070AC7AB8F3
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 20:15:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjkgF-0000Ii-5s; Fri, 22 Sep 2023 14:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ldkNZQYKCq4QfOiSfUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--crauer.bounces.google.com>)
 id 1qjkfx-0000Dc-Sz
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:14:50 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ldkNZQYKCq4QfOiSfUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--crauer.bounces.google.com>)
 id 1qjkfw-0007bo-E7
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:14:49 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-cf4cb742715so3310083276.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695406486; x=1696011286; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CpxQY1zQQfP+B92PZ/Ew3AvAau2WsZR51iMdTH0L4fk=;
 b=2ldPONTtwhGtutIlpzBe8CCc80zI0cHwiJAkDtCsVnKxQNxKX/h4XFk0ZGpd5gscYS
 VDNxdBlauseGCXlc6XYjMBLusSaL4FcRvIHX/uIuofA5WEDR1rmT4iYhpO5P0lXVB+yp
 nIquUpCpmfAw1aHx4KsaNYFyiVG20VjDdVHiagB0tuWbc8eaGU6Nt7w/soQwn9qGSFXI
 vqEC2nLYElGch8LmZYA6zk6tCw3j4FwmER2I+R1Lm+VrzdCFyWj5is4C0mUXUP7dfCEb
 zggixbGDM0z/W1zTYX3S4JvrJyQCjFU9Nq9aNmNsp3EYv8/PNkg0gtWlPQ3sizE1vRdn
 cGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695406486; x=1696011286;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CpxQY1zQQfP+B92PZ/Ew3AvAau2WsZR51iMdTH0L4fk=;
 b=Ky7CzzEDQWuuWmfA2LsOyJw4o+XHYjxsXdjFOZaIHjGFrnFNmwM//XsPilcBZ7iDDN
 msOKFRu+jomYnsVC9L8LjQzGx75Ne0TKY/O0ajcXh2bPp+WIEq7e5sDdL0AJK0o54Cip
 TYZtAu/x55KOB2u9Vu17cSUApIzyvBa1WLF8WDvcC1iYDQFZWVg2LUPye9i3VXQRdDHM
 fV0hxXJnyBWmzUZPCdBWkJfwueXmSCkZPlicf98QaTpmiXgOTwu3g2eXCUvZlRvd0wBl
 Ol8EvydchB8EGDoHYUv4k96c9RNcYZ2W35kjPHiFAt7CzqXsZEAfpO1HzkvL34RTzwa9
 Hnjw==
X-Gm-Message-State: AOJu0YxqkiEaXzdvW8TIywYqPh1tuusN2l+PAVNeV1pbXJosQUPCsKx0
 dujUJf2y3C7FRRtAHo7aK8IbvjoNaqY=
X-Google-Smtp-Source: AGHT+IEoc0swtCAp5VaPafolrfaOn4V07hJMimSsipP+2/xbdXVJ7vVauQoZbsLrA6mvoXp/xW4QL/SHSO8=
X-Received: from crauer-cloudtop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:100f])
 (user=crauer job=sendgmr) by 2002:a05:6902:1689:b0:d7b:9902:fb3d with SMTP id
 bx9-20020a056902168900b00d7b9902fb3dmr1469ybb.0.1695406485945; Fri, 22 Sep
 2023 11:14:45 -0700 (PDT)
Date: Fri, 22 Sep 2023 18:14:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922181411.2697135-1-crauer@google.com>
Subject: [PATCH] hw/timer/npcm7xx_timer: Prevent timer from counting down past
 zero
From: Chris Rauer <crauer@google.com>
To: peter.maydell@linaro.org, kfting@nuvoton.com, wuhaotsh@google.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Chris Rauer <crauer@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3ldkNZQYKCq4QfOiSfUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--crauer.bounces.google.com;
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

The counter register is only 24-bits and counts down.  If the timer is
running but the qtimer to reset it hasn't fired off yet, there is a chance
the regster read can return an invalid result.

Signed-off-by: Chris Rauer <crauer@google.com>
---
 hw/timer/npcm7xx_timer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/timer/npcm7xx_timer.c b/hw/timer/npcm7xx_timer.c
index 32f5e021f8..a8bd93aeb2 100644
--- a/hw/timer/npcm7xx_timer.c
+++ b/hw/timer/npcm7xx_timer.c
@@ -138,6 +138,9 @@ static int64_t npcm7xx_timer_count_to_ns(NPCM7xxTimer *t, uint32_t count)
 /* Convert a time interval in nanoseconds to a timer cycle count. */
 static uint32_t npcm7xx_timer_ns_to_count(NPCM7xxTimer *t, int64_t ns)
 {
+    if (ns < 0) {
+        return 0;
+    }
     return clock_ns_to_ticks(t->ctrl->clock, ns) /
         npcm7xx_tcsr_prescaler(t->tcsr);
 }
-- 
2.42.0.515.g380fc7ccd1-goog


