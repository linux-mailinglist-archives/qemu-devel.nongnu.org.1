Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AE579DC03
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:42:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgC4o-0002gf-5G; Tue, 12 Sep 2023 18:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4l-0002g9-Ry
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:43 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4j-0001BE-Nu
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c09673b006so42996535ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694558500; x=1695163300;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSSZHlR4v/0tPaKsbN/N18QMFmibLFOOUdSapeItbE0=;
 b=O9oYYnsjibvjGrHTnDjK+0Kk/zHB5FR0ARxsiB+e19vUPNNb/v3MW18GJGD9VCSvq5
 yPbsj8MbP11wZcJUoWwzUM2L2DxOliOdiZsJEajerONYiKbuuKF0yR8sNR5jeAEVKqVY
 QgEbK6tOQmBEVTBXWQJmiONj8HotyCa/lYUJTEW223Rs2SjJZ/LBbWC/4UN6HDFZdNMq
 qYgv832rRtt5Q1xHC3tT6bi8phvDTk4h5B3wCHbOoN7aU6uUQVXHLn4GYkGaz7uh4K0M
 owX09jObSc8VLvFKzWd+Wn6MLUTnuGARlpFT+NRWq67Kz0scsqOC1P8dtmauTrj7p//2
 54cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694558500; x=1695163300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSSZHlR4v/0tPaKsbN/N18QMFmibLFOOUdSapeItbE0=;
 b=kVrwyIwgdWQUocWlC1mWzgT1umHfj3SsfAxrZeRb/ReyVQUJBr1BxjC9eeGsSpeq5w
 TMtmket5WHYh1ogaakJOv35V1DCHmYBt/Ic18JOKas/RkypRhHmnmIWskQgGXYN9Z2JS
 YNDQFLOEdCgpyDmbN+v6EUsSm6QxAlyhnFWwl4QMltb6IH3lrXgDlBBd4gUpjHmpxG8k
 sjqyjv4BbkjJfpbXnq8rrtV4sZG/2mdd9MiNTHrRauF95UrYovWdJ7ceOr2AAd9vPk7v
 RVl6gThoAdVEQYq0I9Xhop0FxorP4T111qBMALUD5KevplG636PuWsos33+qoN5RQHSd
 egGw==
X-Gm-Message-State: AOJu0Yz31ju7A6oiOMISWKfULpBmpnwJbyWY/GToSiFPVu+gMeetXDXA
 YZpc/Oz4yp0lLoOKILpKjrc/8w==
X-Google-Smtp-Source: AGHT+IFoGv+RnFVkLzhpcKRdQ98dKiXfDtIinCGxU38X4CXqAhkPDtxczlGk+Bb+6f0cNbMDoAYWtg==
X-Received: by 2002:a17:902:eccd:b0:1b8:5aba:509d with SMTP id
 a13-20020a170902eccd00b001b85aba509dmr1141100plh.21.1694558500590; 
 Tue, 12 Sep 2023 15:41:40 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a170902d34d00b001bbbc655ca1sm8996977plk.219.2023.09.12.15.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:41:40 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PATCH v3 10/12] target/ppc: Remove references to gdb_has_xml
Date: Wed, 13 Sep 2023 07:40:59 +0900
Message-ID: <20230912224107.29669-11-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912224107.29669-1-akihiko.odaki@daynix.com>
References: <20230912224107.29669-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

GDB has XML support since 6.7 which was released in 2007.
It's time to remove support for old GDB versions without XML support.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/ppc/gdbstub.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 778ef73bd7..ec5731e5d6 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -54,12 +54,6 @@ static int ppc_gdb_register_len(int n)
     case 0 ... 31:
         /* gprs */
         return sizeof(target_ulong);
-    case 32 ... 63:
-        /* fprs */
-        if (gdb_has_xml()) {
-            return 0;
-        }
-        return 8;
     case 66:
         /* cr */
     case 69:
@@ -74,12 +68,6 @@ static int ppc_gdb_register_len(int n)
     case 68:
         /* ctr */
         return sizeof(target_ulong);
-    case 70:
-        /* fpscr */
-        if (gdb_has_xml()) {
-            return 0;
-        }
-        return sizeof(target_ulong);
     default:
         return 0;
     }
@@ -132,9 +120,6 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
     if (n < 32) {
         /* gprs */
         gdb_get_regl(buf, env->gpr[n]);
-    } else if (n < 64) {
-        /* fprs */
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
     } else {
         switch (n) {
         case 64:
@@ -158,9 +143,6 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
         case 69:
             gdb_get_reg32(buf, cpu_read_xer(env));
             break;
-        case 70:
-            gdb_get_reg32(buf, env->fpscr);
-            break;
         }
     }
     mem_buf = buf->data + buf->len - r;
-- 
2.42.0


