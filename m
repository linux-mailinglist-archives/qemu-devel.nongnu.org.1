Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 969DC786C0C
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:34:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6ev-0008Qk-Bl; Thu, 24 Aug 2023 05:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eR-0006JI-C8
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:15 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eA-0004yf-KC
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:06 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31c79850df5so259928f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869323; x=1693474123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L6YrIHhc5tInaHtSG+IOeZ7cliNEkq/9K95ncf5G8bg=;
 b=Lk/K0HDfYtX7U1L00Tqv5osJV5e6LS1wFakY6GDVh56/X0Sb1vvzugwnknAFXLkvVp
 LwF2WOoNWGZ0Fo45ztDGmDlGqP8/C+27aLPspBOhqpIK9VU5glr5rSbaVJdHg7aTUkId
 oSYsg7arshEoVnJMpA5zk25UKgCBPW46rsHUfpa3a96JaKaPf1oZcLEEtVYUCSTbq8lG
 ujPa2UzxZ68rJgOfLulRo2bvTMK5ygF7kpqBJCZBrPtboaKQN1/DHboFYr5lXBvbvpkV
 j0pRZ2W7rKOcAGe/besJ00/74LeeUVMhppyIpZwsC4RIo+zsQfAXCtS4Wb/40cejAMRU
 QNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869323; x=1693474123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L6YrIHhc5tInaHtSG+IOeZ7cliNEkq/9K95ncf5G8bg=;
 b=Ydit3eUbU2/Bfw/KFyCXkN3DPt3HDfesCMvLF30aB+UBm00GNzELL6Y/LHlCgij4Uh
 Od0dBeX2uEl2CpoiDm+kiqtDPF7MRvFTBh5tTPjz4ntEIHB/yQPLb2s4PNFt0q+ZDk7J
 OLvBeHF9av4jZAu6Aq8YsAN24QM0Z5ZP0siRKeD3u1GFKTaOUBcWQ6Ru5xwYGhOGfhtt
 sIH6Bbj1Z6QYn8Zl6T/KOZZ1wwQE87GsuAjGvrJbg9PGPFpPzBEHB3bODHqO5MyagDqY
 OMo6ilmF+JtYE1fIW37S0Y5IusCUE3dPKogSLKTGzj7BjePmZdw67MAyB372LsRZ6F5a
 VFwA==
X-Gm-Message-State: AOJu0YwuYzxgGuzWWviyKWTKYjkogaajntQWYaUA6hReM44O42Ni36DW
 07l4t8b8c4fw0rXzh50i7MUvF+28hb+9uI0l8wo=
X-Google-Smtp-Source: AGHT+IHUmGvNUp7sWOxW7bi0xaTcl4gyLY70V0nNWdjO3Pa9Jk3t8QF/fqC3N0BJo7fmqbNzr3g0ng==
X-Received: by 2002:adf:ec8a:0:b0:313:f61c:42ab with SMTP id
 z10-20020adfec8a000000b00313f61c42abmr11452569wrn.56.1692869323493; 
 Thu, 24 Aug 2023 02:28:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/35] accel/kvm: Make kvm_dirty_ring_reaper_init() void
Date: Thu, 24 Aug 2023 10:28:13 +0100
Message-Id: <20230824092836.2239644-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The returned value was always zero and had no meaning.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-id: 20230727073134.134102-7-akihiko.odaki@daynix.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/kvm/kvm-all.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ed30f4135b5..d07f1ecbd38 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1454,15 +1454,13 @@ static void *kvm_dirty_ring_reaper_thread(void *data)
     return NULL;
 }
 
-static int kvm_dirty_ring_reaper_init(KVMState *s)
+static void kvm_dirty_ring_reaper_init(KVMState *s)
 {
     struct KVMDirtyRingReaper *r = &s->reaper;
 
     qemu_thread_create(&r->reaper_thr, "kvm-reaper",
                        kvm_dirty_ring_reaper_thread,
                        s, QEMU_THREAD_JOINABLE);
-
-    return 0;
 }
 
 static int kvm_dirty_ring_init(KVMState *s)
@@ -2744,10 +2742,7 @@ static int kvm_init(MachineState *ms)
     }
 
     if (s->kvm_dirty_ring_size) {
-        ret = kvm_dirty_ring_reaper_init(s);
-        if (ret) {
-            goto err;
-        }
+        kvm_dirty_ring_reaper_init(s);
     }
 
     if (kvm_check_extension(kvm_state, KVM_CAP_BINARY_STATS_FD)) {
-- 
2.34.1


