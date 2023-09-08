Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC727981C5
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:06:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUcU-000068-8v; Fri, 08 Sep 2023 02:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUcL-00005P-Uv
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:05:23 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUcJ-0005Gi-Om
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:05:21 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c1e780aa95so12634175ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153117; x=1694757917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJk34toFNyidTQI3XnnaKroUPxNRe6WC7SlLZ/NA1WQ=;
 b=l1wliExY8OefUX+cd/ujsaGAWLaglJRUTVZuockjGhMv4OZNXcYlWiZGDQRa+jmKlJ
 FAT5/ptXmpPewKjeN3W7gfRyZcMNa4SG18gXoe4D9OfcXybz1HUKrn1L1W6vBra5U8GE
 jwMKEQ3eI8jRjG8Ew+9kwrPctYLDCL3zKFkB7fP+Ea/OjDflInNt5CsOGHeGyKQpnSWY
 R3ADPoHDUU3LjpYCjI4Ce/owq1iMMga18S5w+V3vt2qbu5AeC6PC3E/8afbS+/RZiEdH
 tPB9yhfMHyQxpcpR29PAi1M71hR9GOCZXorkQBa6wO6y48OtN2IZZwM61hvlNtCgCHKD
 EU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153117; x=1694757917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJk34toFNyidTQI3XnnaKroUPxNRe6WC7SlLZ/NA1WQ=;
 b=ZPvzmFooBNol3i1rSmxu5GiuV8V6MDhTgYH4J7hLT9aY/bPX1CUD4W0ZcooGLDMwzL
 yw2UG7ZvzVkYWpXGcy3FlkA7nhV1b71o/r8bYnaceuJOyIsrSu4PUMv6uglVzlB5Gtno
 Qvde/tegY8G4+IEEe/B6eT3Hett/eulESxJba37lE+AMCDDh6PewVt/ilj85ObaRc3Yw
 4ptXKDeVzmGHciMVhsRZx68NgZzgcUNGBRtMdVFKMiseIca6iFYi5suxe95vVF4OI1Oo
 uw00PZ1nLyQlMMCVC3OtKIzhHPh+sufNF0QHEFZAURcJzhzQ55QrFsmnjIbCmRDdjMMQ
 0VDQ==
X-Gm-Message-State: AOJu0YxYCI2+zdQ7NXL8HrDj27OBMTHPBmnZoyDn86TZL+mQqjyVwgGx
 6C8L0HLg7/dJ3ax0Z2xoa2W4p6RPckhbBkxQ
X-Google-Smtp-Source: AGHT+IGbmpdEZdIuFPyazAS7/XPguCMdHTkP9BPNQvvfjrdSWRiNezCELVeYhKYwSr0djs4/8HPikg==
X-Received: by 2002:a17:902:f682:b0:1c3:83e2:d0a9 with SMTP id
 l2-20020a170902f68200b001c383e2d0a9mr859967plg.58.1694153117125; 
 Thu, 07 Sep 2023 23:05:17 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:05:16 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/65] target/riscv: Fix page_check_range use in
 fault-only-first
Date: Fri,  8 Sep 2023 16:03:32 +1000
Message-ID: <20230908060431.1903919-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Commit bef6f008b98(accel/tcg: Return bool from page_check_range) converts
integer return value to bool type. However, it wrongly converted the use
of the API in riscv fault-only-first, where page_check_range < = 0, should
be converted to !page_check_range.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20230729031618.821-1-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index bc9e151aa9..379f03df06 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -584,7 +584,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
                                          cpu_mmu_index(env, false));
                 if (host) {
 #ifdef CONFIG_USER_ONLY
-                    if (page_check_range(addr, offset, PAGE_READ)) {
+                    if (!page_check_range(addr, offset, PAGE_READ)) {
                         vl = i;
                         goto ProbeSuccess;
                     }
-- 
2.41.0


