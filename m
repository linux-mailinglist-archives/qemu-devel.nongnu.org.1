Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 606F479C76A
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:01:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxMS-00015a-7R; Tue, 12 Sep 2023 02:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxMF-0000ll-IA
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:49 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxMD-0007Zs-BF
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:47 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-273d10d3df3so3305399a91.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 23:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694501924; x=1695106724;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSSZHlR4v/0tPaKsbN/N18QMFmibLFOOUdSapeItbE0=;
 b=fspo7+cZefvEd7edNeH1AZKuMyv2Svk6uIulDCigG/0NHuKhPFbUzDY1y8ZMNaWb+J
 4KqY7XuVEMMdj8+4osU6UBQ/2nv4KZp/SW7XjPHHwMLwPFahacz4DMnRbArmQZk9i0pe
 WM/+ENV0/b4d+gVQWJVVg+vy2R88OA7GArtCOCasWXrydmGnnL8N2/ZtBTfWTGOMA7xY
 ljXzvj3wMtNeLn/i1zTLCcHJIW8qk500E9O2T27wjVRGXd2IHEAHhC5/+xkSA0ehCkBl
 hBbVJAjhynMqh2zciBW5QiY4iolnTtcqV/QbAMOwiYh/Hbz0DllU58zD7iVEcUAJmswv
 6t0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694501924; x=1695106724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSSZHlR4v/0tPaKsbN/N18QMFmibLFOOUdSapeItbE0=;
 b=WVBdOe7quHDqcPsuSbMi3JvptCk3lsGjk0moTcNqGsYEu1ISIawPlpuiXIUhZEkKL7
 jjBtZ0j+V7cN7zxZ9nMpY7WAgNrgxXdz4SN3YqER4lKly/fViuL2uHG+T6VLBxilmIow
 sKZigfgS2dwsyneYv9sxiSVStBtZ3psJrYaL7osoF7Nw41qgaOcYvwSsDHKjh3mcEfWP
 mDOUdfHBS2lZCGKgiChyi35OYlCDBCbF7W1Ukr4PAStjTXVT1J+Elh1rl1etOGWJnjnu
 rHoiAMRujHCfJ/+5TNRoLLd1IoooBqs0f8o1FpoaA40U3u2NTvTlHajA2wdpVZAKT520
 BT8Q==
X-Gm-Message-State: AOJu0Yz4OFLH/PMtRokX032CmhtBfTKuWcrJWFoHpRYzEbY1FrwgdxNl
 Nof7VP+On7HHyJhaDNXansx2Cg==
X-Google-Smtp-Source: AGHT+IFMOF/StadjCUpDR9Vh5s4LrV40FLLuB+y3rDhhWYUrwbQm8/Md02jRedBw5UC+tl8KCkLFHQ==
X-Received: by 2002:a17:90a:430d:b0:26d:5cd0:979f with SMTP id
 q13-20020a17090a430d00b0026d5cd0979fmr9088969pjg.43.1694501924180; 
 Mon, 11 Sep 2023 23:58:44 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a17090a2ac800b002696aeb72e5sm9315058pjg.2.2023.09.11.23.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:58:43 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PATCH v2 09/11] target/ppc: Remove references to gdb_has_xml
Date: Tue, 12 Sep 2023 15:58:04 +0900
Message-ID: <20230912065811.27796-10-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912065811.27796-1-akihiko.odaki@daynix.com>
References: <20230912065811.27796-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
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


