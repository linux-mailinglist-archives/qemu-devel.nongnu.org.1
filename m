Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 384E373F597
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 09:26:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE34J-00083x-2L; Tue, 27 Jun 2023 03:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qE34I-00083h-3w
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:24:54 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qE34G-0005y8-Lh
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:24:53 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-666edfc50deso2742989b3a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 00:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1687850691; x=1690442691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FeC1jjF+q04RZdBsWPb+IClQRx3l8j/sIEwU9Sqjtc=;
 b=T3AopUNIbwwfuEcLs2R34+dGeVkTA3+OYnLVFo8AssEbdEowl9724QOXyMityRd4Un
 Ya61/nwfEcgiZ13BsL8cq/kgW9NjScvXeXkQwk0nep0dPPIcSoUVvrWKSRns1x2WOOk3
 +qj3glU4inZtyutCx04siXeOqLy1Hx1Q/kid7qMzuMtfoWUm+RWjdIMlz3ACUtyZUWgP
 LsN/8wFCPMIPR2e0SbLatQZH9POZp0Rq8Rc4GSpDb2b4IVEnyUkYHBE6Zdx3bL7DnfMz
 LVryELmuNaXGsx1p0Yx0bglnYmu+H5+ACLeZ1Wal7QuSBWmPMpMraJ41yqGju7lfhPwL
 Hwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687850691; x=1690442691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7FeC1jjF+q04RZdBsWPb+IClQRx3l8j/sIEwU9Sqjtc=;
 b=C4iu9hnyjxqr16SYUCMPOoYSiKfKTH7jtReQKnDuyD2YIbhvIWHi0KOCOBD/p/HRyD
 x4bDRNnMrUAElUt2UjYquoqU5Gx6W36KCyWSqwOGGm/rtG9/mMNRlqeBmmRg3/Iu2i9D
 GbS4p1X8rjJ38iC67He9ISEYTmoLJIzRI/1/Pf5RMXm4WZP4MgoS6GklXbHX+B35l2Kn
 SqnzsG3iYGWRQbLFoGGu9kCKZMjhyjPuFpOY0jt43wFrzy6AMNJIrwg47EdODgdS/Tyv
 XsKfU5jBw7eEp8wLXZOztmpMesSudvVRrwkY7kmo3Mclky0pg7joOL+5ljAOseuHuo0h
 t8Aw==
X-Gm-Message-State: AC+VfDy2tQr7zPC4m7Ouh91A93RaKFa0PakX2yWicGrKJHzd//E4W0cw
 nwuhmvifoywL1RMPtLrnNm880w==
X-Google-Smtp-Source: ACHHUZ6Occy9V5lI2I5EPzsQaPBfEGgBPBDWpThbFMgh1DB6M9OdECYnHNZAvNdWLQJaNYjSAOtOhg==
X-Received: by 2002:a05:6a00:300e:b0:67a:8ed:cec with SMTP id
 ay14-20020a056a00300e00b0067a08ed0cecmr4832331pfb.2.1687850691362; 
 Tue, 27 Jun 2023 00:24:51 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 u22-20020aa78496000000b00640f1e4a811sm3210915pfn.22.2023.06.27.00.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 00:24:50 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 5/5] cryptodev: use NULL throttle timer cb for read
 direction
Date: Tue, 27 Jun 2023 15:24:31 +0800
Message-Id: <20230627072431.449171-6-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230627072431.449171-1-pizhenwei@bytedance.com>
References: <20230627072431.449171-1-pizhenwei@bytedance.com>
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

Operations on a crytpodev are considered as *write* only, the callback
of read direction is never invoked. Use NULL instead of an unreachable
path(cryptodev_backend_throttle_timer_cb on read direction).

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


