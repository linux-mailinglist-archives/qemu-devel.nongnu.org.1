Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5634579A3DF
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:49:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfage-0004cL-70; Mon, 11 Sep 2023 02:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfaga-00049h-32
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:16 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagX-0005GL-Q4
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:15 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5735282d713so2599210eaf.2
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414772; x=1695019572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNko/n7sZ+Pauuo1Y0kdsEEem9IIq4A/xXv8veLPZZU=;
 b=KNiNVzZGq7hnCKM6hQtDGEgh0b22sGbfKOJWE7eKo+TQGZ/X1YoDqsq5M8y1d2L9rK
 M+z4S88xQIBQIjd57HkdAdLTg5hYJkjPqbhqOEeYJGL4dP39TrKpQ5VPj05ZjWX1q9gW
 SPtk5gbALea1tY98LqndhqqC5LQTPH6EKjMxBUUICuDZUCtOnv/aOwy43VRO5c6SQwws
 USneUwhIHtp6AwktgGUDzxbQpRlCfItzsVaQOEBSbl0+AT++d5QA+G5f6T+BC7NeQZe6
 9tRKHfoUVaKZJa6CNpMQMtjoVYxWIKAxlunziQMYit08cXH/ybmMoiqYFBl6F197Ut0A
 9T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414772; x=1695019572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BNko/n7sZ+Pauuo1Y0kdsEEem9IIq4A/xXv8veLPZZU=;
 b=bPgRynJN/rCFhUmZOZqr6icnJONmqVGG7AY307k/DPW5+jatbOM/DyDcKRIIBKMeXD
 vwEf5DADXdugHQaNebLDmO1uYEx7bTRmclZ5CXQcMw+nudd9c768PPZ3x9191Xn20T54
 lIKEb/lVpoZD68welOQPNmyZeomRhNvNZHIiz7w2hpKdPAEriF6XerBgVNZBlFMAl5WE
 nzNooF9SIsWBZlJ9/vqMm/J1KS617nGCF+JeJ9t55kbEWdbdBzBFH0r+OTx6fdej9dso
 KFJ8M3wN8r/T4IMdF9hnh3xWXx2v9DEmhE00TLc0bl+tQM3TdUWaBElS3ngjpI70n7QH
 WKCw==
X-Gm-Message-State: AOJu0YxuwRehY6ndsLvfwTBRgUspJ2gpg7ImHmB8SbM/Zmr4JKE/pjYT
 hRoFqlw6m96z/lbNBLSIaSyQ2tzB70nGNw==
X-Google-Smtp-Source: AGHT+IHC4N+/QaKbrrexvI4ln+qaPfZQJ/FmVN3kZwGlHzqtr+LbX7AF+wQfttg2dkq1oQOkaUTeVg==
X-Received: by 2002:a05:6358:988d:b0:13c:fbdb:57b6 with SMTP id
 q13-20020a056358988d00b0013cfbdb57b6mr9233909rwa.14.1694414772109; 
 Sun, 10 Sep 2023 23:46:12 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:46:11 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Robbin Ehn <rehn@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 40/45] linux-user/riscv: Add new extensions to hwprobe
Date: Mon, 11 Sep 2023 16:43:15 +1000
Message-ID: <20230911064320.939791-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc2c.google.com
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

From: Robbin Ehn <rehn@rivosinc.com>

This patch adds the new extensions in
linux 6.5 to the hwprobe syscall.

And fixes RVC check to OR with correct value.
The previous variable contains 0 therefore it
did work.

Signed-off-by: Robbin Ehn <rehn@rivosinc.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <bc82203b72d7efb30f1b4a8f9eb3d94699799dc8.camel@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/syscall.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dac0641bab..3521a2d70b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8793,6 +8793,10 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 #define RISCV_HWPROBE_KEY_IMA_EXT_0     4
 #define     RISCV_HWPROBE_IMA_FD       (1 << 0)
 #define     RISCV_HWPROBE_IMA_C        (1 << 1)
+#define     RISCV_HWPROBE_IMA_V        (1 << 2)
+#define     RISCV_HWPROBE_EXT_ZBA      (1 << 3)
+#define     RISCV_HWPROBE_EXT_ZBB      (1 << 4)
+#define     RISCV_HWPROBE_EXT_ZBS      (1 << 5)
 
 #define RISCV_HWPROBE_KEY_CPUPERF_0     5
 #define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
@@ -8840,7 +8844,15 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
                     riscv_has_ext(env, RVD) ?
                     RISCV_HWPROBE_IMA_FD : 0;
             value |= riscv_has_ext(env, RVC) ?
-                     RISCV_HWPROBE_IMA_C : pair->value;
+                     RISCV_HWPROBE_IMA_C : 0;
+            value |= riscv_has_ext(env, RVV) ?
+                     RISCV_HWPROBE_IMA_V : 0;
+            value |= cfg->ext_zba ?
+                     RISCV_HWPROBE_EXT_ZBA : 0;
+            value |= cfg->ext_zbb ?
+                     RISCV_HWPROBE_EXT_ZBB : 0;
+            value |= cfg->ext_zbs ?
+                     RISCV_HWPROBE_EXT_ZBS : 0;
             __put_user(value, &pair->value);
             break;
         case RISCV_HWPROBE_KEY_CPUPERF_0:
-- 
2.41.0


