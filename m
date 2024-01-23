Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C138838BBC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:26:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDxT-0000Qg-0k; Tue, 23 Jan 2024 05:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSDxP-0000Q0-SZ
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:24:39 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSDxO-0004dl-9y
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:24:39 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6dd6c9cb6a8so301902b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 02:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706005477; x=1706610277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E554SzyD9ekZLsqgb3tmLUdyIwMdiLrTVwZboQHPuUo=;
 b=Hh8uOy4QemhqM5K1zNY/TD39SOFkI/8kHXaUtvk2Qmz8vDe0sl1JCSxd2SXxNOX7kC
 iXJDz60jf5jzhSpGbeAHl+rPOZulhGZ6EUwVjs8jafpu0qNbsY+lSwVN+A1Yy7NRlc0r
 2F3CiIFwZLBG4hzecQNPf7nVPY2QGaEL86+fswGQ/SjVMc93KGI2WX731ixC3EjL54Wd
 qcT+jZh74ciwbgXoC3kHghx/8vhbo89jj5PbYu74t91E1q4iI6xL8p9T15QqB8g4CpbV
 JKKILUwUKD9xiq8uPpHzPQjLUFSyt/1u8ZyqHo3z3WMGpZCDC3/uvDYzJ36NbGsRDhLa
 4suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706005477; x=1706610277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E554SzyD9ekZLsqgb3tmLUdyIwMdiLrTVwZboQHPuUo=;
 b=nMwdMHmsLxznHJeEfaEAHghwUhRenfoPTcA/QXXK5jXItHCWlqcqp0QNAxhTdnKJBt
 7SYeGiSrbbrOOa2SyBi6yd19beEwnEXRYoLztdbvCtzJOIyd6L7IYmE1b1EGCFw1HuHK
 MSxMBFgv7EGrGHQ+S+LqNVPUMr3x9VvIwbCYUEto+vjvi3TRXOJlQSFrftKy+kdFSaX9
 StbY2W4Ui3AhaujeoQoKTerDSlaoygizcVki2A8NUPX720XWK49gaU3cv8dDXCr3MFpX
 sQuR3JYYn0CLMjFvnoABGHBuXXIQhNggbbbO9eU0kM+kWBI4XYDi/7Psj6xzt0H8RMj0
 vlrQ==
X-Gm-Message-State: AOJu0Ywim1YINCfD5JAryhOTSJ52KbobF1wYigrt3PabTpU234SS3qCE
 mXbrRi+mRJxCel1nNEkUVz96S81yz3h0BKM6GHRzzbBUfZhYmjdwP1E1dmpojD+yFBr9Zr3DvKx
 ilms=
X-Google-Smtp-Source: AGHT+IFnc72Ezb/oA48Tuc+odgcgyC5HWoJuwyc4PEIkullDwBLzxgW6WM2G4GvObLitDAUtmgvlqw==
X-Received: by 2002:aa7:9301:0:b0:6d9:8ccb:be1b with SMTP id
 cz1-20020aa79301000000b006d98ccbbe1bmr3684018pfb.29.1706005475273; 
 Tue, 23 Jan 2024 02:24:35 -0800 (PST)
Received: from stoup.lan
 (2001-44b8-2176-c800-b8a0-0408-58be-7d2e.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:b8a0:408:58be:7d2e])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a62f808000000b006d9ce7d3258sm11072408pfh.204.2024.01.23.02.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 02:24:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 6/8] linux-user/elfload: test return value of getrlimit
Date: Tue, 23 Jan 2024 20:24:10 +1000
Message-Id: <20240123102412.4569-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123102412.4569-1-richard.henderson@linaro.org>
References: <20240123102412.4569-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

From: Thomas Weißschuh <thomas@t-8ch.de>

Should getrlimit() fail the value of dumpsize.rlimit_cur may not be
initialized. Avoid reading garbage data by checking the return value of
getrlimit.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20240120-qemu-user-dumpable-v3-1-6aa410c933f1@t-8ch.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index cf9e74468b..c596871938 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4667,9 +4667,9 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     init_note_info(&info);
 
     errno = 0;
-    getrlimit(RLIMIT_CORE, &dumpsize);
-    if (dumpsize.rlim_cur == 0)
+    if (getrlimit(RLIMIT_CORE, &dumpsize) == 0 && dumpsize.rlim_cur == 0) {
         return 0;
+    }
 
     corefile = core_dump_filename(ts);
 
-- 
2.34.1


