Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 850F279A3DA
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:49:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfagQ-00038t-UD; Mon, 11 Sep 2023 02:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfafl-0002Vw-2a
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:27 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfafg-0004wp-BJ
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:22 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6bf298ef1f5so2990132a34.0
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414718; x=1695019518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RbNY4sxLzfh+2ICvNwghFUDrAY++mutb7jKSlH2h1II=;
 b=VYHzoOsyMqNRZrPBmBCo31CYKGbRygXILGlvkJxMzpGJI+sH6NYitTPX+qa5BqLS+i
 GwiqTAuaITPmtRLVBy6ZxskoKULGMU+chl33+LSjBTwQSPtaRK9DAG9oMyDhsc00hCXz
 OBs53ZzPAeVv1ublMreU/5DxQOBMrWo9ZMJrxArup2KZpw6GQ4gyIhAM0kJJ314My/ZR
 yunGOWoHywaEUpZ/k7cZryp48rAwU2ah6nfbAPaUBWin1YiYV3XsScJP7l2wWgQQo/aL
 121PSAxQHfdtLbJLr7QuDO2GZMOigiBd+9pJtKtns9txTgrXdDVCBFrTh/KON65j2w9d
 VLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414718; x=1695019518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RbNY4sxLzfh+2ICvNwghFUDrAY++mutb7jKSlH2h1II=;
 b=kJ2HSIAPL97KhtI5PpeH22tmECRya69PjU60L3gofg5MdWVRGZJ1tBPwKvWqIOzXWT
 b/dLAtqaSephKPs8012E1aAwvkLaKuTxWlaMRHMBJbZcAWdi9Y6r5gEOPem/KWYTctEr
 3ieOnGpvZJ/UowF8HAAXr0GKyKNhq5I8XFTL0bEHeEVjG8pPxzLAQOAGwDFnzFXy3qN6
 UyjFgsfML/6tT17SQFuvM7TjpSKyHQDvPKhfNsP7bYJmuhdRPIqzKfQ6mQPsobNjA0h6
 V5LpevHNx1q7vHpMSC3lyXLL1WNCs67GLSxRiOpNCRff4eYkuu58i2UCAHX2pCiv0PHl
 Z17Q==
X-Gm-Message-State: AOJu0YyGPcOhln6VgKGSlTZiRoxsqz8ift8wPQkwEy/YlLNBIPfBVA9M
 zmQcJkRfNmE5c1m93DOUSYxToQLf6rqhTQ==
X-Google-Smtp-Source: AGHT+IEX9KKxz6AMnkhmuzQGFuq0k9a0YyKVKuDRtR8vxlDV25xosQnn2gUJ69h0ioreTNukkVTaqw==
X-Received: by 2002:a05:6358:3422:b0:134:de8b:17f0 with SMTP id
 h34-20020a056358342200b00134de8b17f0mr9698587rwd.19.1694414718546; 
 Sun, 10 Sep 2023 23:45:18 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:45:17 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 26/45] hw/intc: Fix upper/lower mtime write calculation
Date: Mon, 11 Sep 2023 16:43:01 +1000
Message-ID: <20230911064320.939791-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32b.google.com
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

When writing the upper mtime, we should keep the original lower mtime
whose value is given by cpu_riscv_read_rtc() instead of
cpu_riscv_read_rtc_raw(). The same logic applies to writes to lower mtime.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230728082502.26439-1-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aclint.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index b466a6abaf..bf77e29a70 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -208,11 +208,12 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
         return;
     } else if (addr == mtimer->time_base || addr == mtimer->time_base + 4) {
         uint64_t rtc_r = cpu_riscv_read_rtc_raw(mtimer->timebase_freq);
+        uint64_t rtc = cpu_riscv_read_rtc(mtimer);
 
         if (addr == mtimer->time_base) {
             if (size == 4) {
                 /* time_lo for RV32/RV64 */
-                mtimer->time_delta = ((rtc_r & ~0xFFFFFFFFULL) | value) - rtc_r;
+                mtimer->time_delta = ((rtc & ~0xFFFFFFFFULL) | value) - rtc_r;
             } else {
                 /* time for RV64 */
                 mtimer->time_delta = value - rtc_r;
@@ -220,7 +221,7 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
         } else {
             if (size == 4) {
                 /* time_hi for RV32/RV64 */
-                mtimer->time_delta = (value << 32 | (rtc_r & 0xFFFFFFFF)) - rtc_r;
+                mtimer->time_delta = (value << 32 | (rtc & 0xFFFFFFFF)) - rtc_r;
             } else {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "aclint-mtimer: invalid time_hi write: %08x",
-- 
2.41.0


