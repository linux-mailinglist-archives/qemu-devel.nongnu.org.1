Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AD976BFAB
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxKG-0003q1-I8; Tue, 01 Aug 2023 17:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKE-0003o7-7z
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:54:42 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKB-0004lM-4M
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:54:41 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so6271986f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926871; x=1691531671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3NPngvFxJx9HpwzOZ730KZECLvyMyLnhk8cJRf/tlQ=;
 b=apryb7d7TxDShJHIY+cCaXy6JQwZXoBmrkwFMRLeIVv5FGc/Z7vuDLQyoRZHJfYzwU
 mG1ZRXx7wKOr6W08Qau6PZfxMnyys0O5lQbTfRfJBlipPuo0Kq4af6HECNSbRTlH0A0F
 y1KfYOw+ne3DcnWcImcZkglzs3XFoQ6WNA5aq2GajzovthldW9QXCF5Fj3V5u/WCND0a
 3Lxirv69YrJ58DjnY9SP3g2Opw/7KXbxvLjqY+rQ77Ob5+q8ZPOpIkxmyQGo+9hp1WHU
 ZIIH8fVbLcQQxgpJa7Wc8C4xRXuBPRYHXedfakq904pvRFLsMCZ1TDzkmV+Vj8BW+/Gd
 9f1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926871; x=1691531671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M3NPngvFxJx9HpwzOZ730KZECLvyMyLnhk8cJRf/tlQ=;
 b=U4quWa171+w69vI+zoDY3WZ/N9NKhivhjVQy4soMu66U3792S3HAM+uilGpfLCVmhE
 Uqww47RNZD+wRnGNLbhXQTE/4Al/cw3Bp9QxbdDLjNWU/S3Q4wwC1Ypaxq7XhDra4Exn
 2M/k3oh/8QlWzMoALSjya1hWIo+PtAXtZZ8h3+rq0gDGQ8kpaRKSAspv/3lUUr4ti/f0
 rMUoOT1ajgOe1xAOWE+4vQimuQlDWLcaJSMjxs0DMfhw3h8pGr6Z3BHlLQ+lIWPOwISc
 /GUTiQI3m7EkqNU6fe5Bs9NibsJkwISg5QelsUAldhCqWjYQ/w4jtVQrvmY5QUV65XCd
 z2cQ==
X-Gm-Message-State: ABy/qLZkO+0oyupeyQ/0rIDjm8iuDurzIrMvyjcgiH4+2F/nOnpR1YNv
 hKfRLzeQ5YxW3NgdiM/+uzunFJPz4FyaWolougw=
X-Google-Smtp-Source: APBJJlE+gLqBohdJkWT+ELArtMenzfNzlgXFzr5xhrfnHMoPtOSXOSyUIDBjpVRux5TQBiWRo2lNCg==
X-Received: by 2002:adf:f204:0:b0:314:12c:4322 with SMTP id
 p4-20020adff204000000b00314012c4322mr3323325wro.4.1690926871535; 
 Tue, 01 Aug 2023 14:54:31 -0700 (PDT)
Received: from localhost.localdomain ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 m12-20020adff38c000000b00313f031876esm17181934wro.43.2023.08.01.14.54.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Aug 2023 14:54:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 David Woodhouse <dwmw@amazon.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/10] hw/xen: fix off-by-one in xen_evtchn_set_gsi()
Date: Tue,  1 Aug 2023 23:54:12 +0200
Message-Id: <20230801215421.60133-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230801215421.60133-1-philmd@linaro.org>
References: <20230801215421.60133-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: David Woodhouse <dwmw@amazon.co.uk>

Coverity points out (CID 1508128) a bounds checking error. We need to check
for gsi >= IOAPIC_NUM_PINS, not just greater-than.

Also fix up an assert() that has the same problem, that Coverity didn't see.

Fixes: 4f81baa33ed6 ("hw/xen: Support GSI mapping to PIRQ")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230801175747.145906-2-dwmw2@infradead.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/kvm/xen_evtchn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 3d810dbd59..0e9c108614 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1587,7 +1587,7 @@ static int allocate_pirq(XenEvtchnState *s, int type, int gsi)
  found:
     pirq_inuse_word(s, pirq) |= pirq_inuse_bit(pirq);
     if (gsi >= 0) {
-        assert(gsi <= IOAPIC_NUM_PINS);
+        assert(gsi < IOAPIC_NUM_PINS);
         s->gsi_pirq[gsi] = pirq;
     }
     s->pirq[pirq].gsi = gsi;
@@ -1601,7 +1601,7 @@ bool xen_evtchn_set_gsi(int gsi, int level)
 
     assert(qemu_mutex_iothread_locked());
 
-    if (!s || gsi < 0 || gsi > IOAPIC_NUM_PINS) {
+    if (!s || gsi < 0 || gsi >= IOAPIC_NUM_PINS) {
         return false;
     }
 
-- 
2.38.1


