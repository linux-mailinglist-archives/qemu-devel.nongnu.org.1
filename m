Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3E173CF90
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 10:58:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDLYG-0003N1-To; Sun, 25 Jun 2023 04:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qDLYE-0003MA-4l
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:56:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qDLYC-0006q7-41
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:56:53 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1b7f9d66812so2861925ad.0
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 01:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1687683410; x=1690275410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24YPfNosfleJuKPVRsv8yL1kyd9gmL1uJRfLV02ZmCM=;
 b=az3G1pdCNlYzaXB38/o4SQhNKBO1RpADI6rY60RwoMNYpP/4AOYyolO7zoAE/xzxeh
 KfdpLKnUi3aiQ9KFSqJSzuMINtXSYFEiHnXpLTCAicdoj1NCg+HRWuaNfvJf/UmG64i4
 mBCgCTeIgSf9VIL/Md2bEX05f7oc4nYEkTSd7v9uMQubQ9Y9t3QSO8N1hdRD26IheeXM
 DsmeSazKBsph6ReHd8irp01ateraCVWMY+WTvGaT28PrnaIPIKa7S/toeBjZ+N/hCBxE
 fRPrWL9YsOFVXwo/tgdmaqWV/cN7xf0P75NmfcKto0BDOhYN2DYsawiXAcWisGs+bEey
 kVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687683410; x=1690275410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24YPfNosfleJuKPVRsv8yL1kyd9gmL1uJRfLV02ZmCM=;
 b=fapGWg1oHuvTaq/VOW1juWusivZjm2VRqEI4TNQZcYMgl3jPwYU79cDNvVU+TzLr8b
 9AL5zXyBhTf4EUGCLvVQ5kLawS/Vwap/kezv5csR4YmdwDu9XK9p/Fvw0Go2g+3fgRJa
 wP2t4BZVRinHrZLtWy1dQz/RjSbHQFAwcGvbm/ApWRqqLVZ4aNz5AJ3B2liM/zStKTye
 ldTgJ7naBF29ybJuQaawZtU9/WxltwAA+oimvA7b2Mh+Ty7f4jf80upq2QJGLzRFGYW3
 e+9+0rZ8OzIrpbbmrvxc/AifSK0z4Vnxy0NI3TBL7gqfU5BqFTixiZVPMxX53B4IPYaN
 kzjw==
X-Gm-Message-State: AC+VfDxBKM6mYpO2Jkx/PaH3WxHbnV/qad/9sRvGqR+vDlzMm3udvlYT
 UNcQDmKafyzDVVgtJf/7BEOzCA==
X-Google-Smtp-Source: ACHHUZ4c2n8JGRo9YUxVXN3Fxs5Hn1VwnQn+vUcv+fB7KtWB1AYo5Hwq21TTclSTh1HyXJGxsGvSRg==
X-Received: by 2002:a17:902:b497:b0:1b7:f73d:524 with SMTP id
 y23-20020a170902b49700b001b7f73d0524mr1257026plr.43.1687683410389; 
 Sun, 25 Jun 2023 01:56:50 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 w9-20020a170902e88900b001b1f991a4d0sm2176308plg.108.2023.06.25.01.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 01:56:50 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 5/5] cryptodev: use NULL throttle timer cb for read direction
Date: Sun, 25 Jun 2023 16:56:31 +0800
Message-Id: <20230625085631.372238-6-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625085631.372238-1-pizhenwei@bytedance.com>
References: <20230625085631.372238-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x631.google.com
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
index 94ca393cee..19c24ccfad 100644
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


