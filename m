Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A34D57981CE
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:07:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUdq-0002tr-2T; Fri, 08 Sep 2023 02:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdb-0002Pu-N6
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:41 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdY-0006Bp-R3
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:38 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68c576d35feso1614732b3a.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153195; x=1694757995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RbNY4sxLzfh+2ICvNwghFUDrAY++mutb7jKSlH2h1II=;
 b=pJE2ks3IENkjKHUJmLnxx6qfPHsXc7sMXNvFEbbIwJdiBkCGii6s5ItVb/D+w450VL
 r5fkEF4nE5i2hAAlwwwpjJ5LrZ/ad2O4Z9Z80egq1OsaMEaJ9xPcKh+9LA6l7ZjBl24d
 frwMkSZ13G61C9ZqtiDa++lRFKOrxMewN11eH85Gd+9o+pV3+Pnp0AMb3/EdtvkqTgmz
 onmTUfnYbgidIWHLlruZ3HiKjW8w6pzL1TSFE7Y+Zb6sfCTc3OhprcmqcRR3BDhiLvxw
 xfEuJ619bsW83RgBgzwsPBf4LZN36LuKkPetUhE5dRIRicxvtZPTbB6u4KQDizOpNS9s
 5CEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153195; x=1694757995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RbNY4sxLzfh+2ICvNwghFUDrAY++mutb7jKSlH2h1II=;
 b=dlGSu30jMu3IsvBQULPDZVCWa/K++5K3sXvpl7l01BrLcrqTnA3EiZaaA094OAUQzR
 CKUpWBivq0METLuklpCQ8GJIF3r1oigwgUfRNabf7iVMeLcLImMb1BfnrXU9djkzvpvL
 syPQYqelQrh+XjftbVavt42PKhJ5J7MP5iIzZ2vDcZCE03B0qAweJYOgbBha91wotb5N
 TSWnpe6KTxKFtIypnXYbC2zrsE4tat0foZjH6GE2T8w2YNGBHoq42gZITmsIbFlBwXKN
 hpFi+NwsnWK/cdSnPpH0Qu5Srlgy2IxDZLd65Q7Zx+nsO6hqZK6JUThiGQvhSpke8ZKe
 bodQ==
X-Gm-Message-State: AOJu0YyZc/JGdkBoIOvI8mJrm4AsDSNKmKSztubKmT8zyLcV7/eqktPR
 c8AzOmOGW5xj1IBTVX3EWgPpLRccdpoLIak7
X-Google-Smtp-Source: AGHT+IERqs+8agxeZ55AM+KOrnO1cUwl8XEe/MkOF53J8WwDfNxGAQOMGLOGIdYKJjHhL4Wz5t9MhQ==
X-Received: by 2002:a05:6a20:431a:b0:14c:c986:d105 with SMTP id
 h26-20020a056a20431a00b0014cc986d105mr1970735pzk.45.1694153195095; 
 Thu, 07 Sep 2023 23:06:35 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:06:34 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/65] hw/intc: Fix upper/lower mtime write calculation
Date: Fri,  8 Sep 2023 16:03:52 +1000
Message-ID: <20230908060431.1903919-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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


