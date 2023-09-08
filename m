Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 189187981D2
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:07:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUds-0003KV-Nt; Fri, 08 Sep 2023 02:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdf-0002Qk-Au
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:45 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdc-0006Hj-32
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:42 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c0d0bf18d7so13796715ad.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153198; x=1694757998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ccGf/43x5nzKqeckplvIj3QC6H4I6RRe2CJqwTH4Zqo=;
 b=KP2DQkLvAdtRvox0N6SOB9NvQU6VZ06L6txxxgCN0GiWFnuwGGdgMsz5ONCOnxqtgm
 9EXt4iboWYpfYnFCu7/Ns/qvP7HLM1IhEMXDmy1lS9/GVxxbingflvyO8TBgQ+es+9gi
 JEXyep6DF8zi23syx4HZuNIODTML9/Dw2AwWmBBPZYUkRV1EdbFldcXXo6VLXTNKw8ru
 HAm9xjLJWA8+ywKuPMVMMNwqtmaX9ak3kg90Q8VukVXR8mvJz2J/BNbDaw4RYS3bZd4q
 W4yAKTnUQhs/eXrwAjTYNuWdYbaNxH6qhpakm3WHXpJYKkygi5WOTnGCntSk3ci0XXvs
 bNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153198; x=1694757998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ccGf/43x5nzKqeckplvIj3QC6H4I6RRe2CJqwTH4Zqo=;
 b=eaOiqMqy1smX2/SXYMUogSn2MxODljjFcAmxfTcS3d8Y22pX19KNR49dw7QzAGXMNY
 dYZrDPh21v/8cdHohbIxpG5GlfN8YVybnjUPX2xiHUH2PNCu51SBn+Qf0VUOeiMJ8PJt
 WXeS0OfTXPqkNCUZiSHaXU714mbJPwkqYhvrRUVddx5TQT3GPEWUuxTQ2K+cssbY3ffV
 +zhvi85RIMJC3xtTDOAPfutIASdO5DtJAKcNaQH98nY72MmBv7ljXKMqE/W49pZ0+Ji8
 ve8kjDu4/8ydjq0KjrB8mrwPZLinkCNhSIxznySNdOmDy7sj+uxep2ACSY7PCLjEvTiN
 giYw==
X-Gm-Message-State: AOJu0YxDd5HCoPaL+nkZv5DMJJLP8wtcaaYy3QJxHNYeJAX+nfXBdexP
 6FWvknC0FnmQyChCvuZjLBYFwMILKITLRZZe
X-Google-Smtp-Source: AGHT+IFUytjo9ReK8iqU2qz3U3ENlv9Ru4HkL+It8a5Vl11QCIaR2bKlk6mvVquRGjZAgu8vQnr1iw==
X-Received: by 2002:a17:902:ec88:b0:1bd:f314:7896 with SMTP id
 x8-20020a170902ec8800b001bdf3147896mr1711721plg.25.1694153198266; 
 Thu, 07 Sep 2023 23:06:38 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:06:37 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 27/65] hw/intc: Make rtc variable names consistent
Date: Fri,  8 Sep 2023 16:03:53 +1000
Message-ID: <20230908060431.1903919-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Jason Chien <jason.chien@sifive.com>

The variables whose values are given by cpu_riscv_read_rtc() should be named
"rtc". The variables whose value are given by cpu_riscv_read_rtc_raw()
should be named "rtc_r".

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230728082502.26439-2-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aclint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index bf77e29a70..25cf7a5d9d 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -64,13 +64,13 @@ static void riscv_aclint_mtimer_write_timecmp(RISCVAclintMTimerState *mtimer,
     uint64_t next;
     uint64_t diff;
 
-    uint64_t rtc_r = cpu_riscv_read_rtc(mtimer);
+    uint64_t rtc = cpu_riscv_read_rtc(mtimer);
 
     /* Compute the relative hartid w.r.t the socket */
     hartid = hartid - mtimer->hartid_base;
 
     mtimer->timecmp[hartid] = value;
-    if (mtimer->timecmp[hartid] <= rtc_r) {
+    if (mtimer->timecmp[hartid] <= rtc) {
         /*
          * If we're setting an MTIMECMP value in the "past",
          * immediately raise the timer interrupt
@@ -81,7 +81,7 @@ static void riscv_aclint_mtimer_write_timecmp(RISCVAclintMTimerState *mtimer,
 
     /* otherwise, set up the future timer interrupt */
     qemu_irq_lower(mtimer->timer_irqs[hartid]);
-    diff = mtimer->timecmp[hartid] - rtc_r;
+    diff = mtimer->timecmp[hartid] - rtc;
     /* back to ns (note args switched in muldiv64) */
     uint64_t ns_diff = muldiv64(diff, NANOSECONDS_PER_SECOND, timebase_freq);
 
-- 
2.41.0


