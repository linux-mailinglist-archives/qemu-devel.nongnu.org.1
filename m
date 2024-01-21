Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3140D833738
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Jan 2024 01:22:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRLaP-0002Yk-UV; Sat, 20 Jan 2024 19:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLaO-0002YQ-MY
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:21:16 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLaN-0007Qn-7O
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:21:16 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d6fbaaec91so16701885ad.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jan 2024 16:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705796473; x=1706401273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xu2jaDl0CebkWF1EGwbc5gC+5GyuWO8TNdEnyUmyH68=;
 b=zB1ECvkmgrwdiPenZzDGtE9p4m1jwc6vpFoDjMd1cduNtOx/E929wuuMPYda6+eviD
 MWW/AKc4H7ENq2NfdjXW2wt5P8NTOD+p0zQULfV4UnQyxqyx6Z8uwZlvxqUK1AdRE0ML
 lQlz/AcoSmMqEYwmVhzthfFYPTM7CyhVQJi63hKdVRHfG4QYkoDXrzhFEE8kCaltIhAy
 g6W7iLyTYs2yfI6XN76SVsQfOJlHBujBn80Zp5/7SgtiWgd/UMd/Mqy4KJJnjznV3avi
 U9eEAvFkB/ADh8e9Thukz2ng9wiLQ2S69tkr/5zvOOPu9tQmTT1qTMZWvOE3oW7yktkJ
 xq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705796473; x=1706401273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xu2jaDl0CebkWF1EGwbc5gC+5GyuWO8TNdEnyUmyH68=;
 b=ewAIsSmCbFXPHmbryPZIuGUJA0hyWjv7s8sk+4QvZoKDA0OvpC5Gb6tvztLXeCdKBH
 lzMkJptjyqB+Ciyel6YhpAvSLTxolVloaHrLieY13RsNWjbCtX1iASzgouciXzNMVJbb
 C0vQk7kPcAbak6PFJiWz3trOQOraN8qxYQK/PBrfB7zx/1B4eVIsLIcAS+Q69fYieYOY
 vKUkH4vaT3ZhAVv9wUWPC/DK6haLs/kl4qu5bUI821SC9k/DO//uOtC/cpF/lSo5KFPZ
 h6LpP1LiDZvgzDQSEbgpk9Hxwa5WZHQccoxSU5hL+LcO6SVQJK4bLjqQUfn0gHoV8Buv
 rsCQ==
X-Gm-Message-State: AOJu0Yzr9aM/FdUn3NzO0WFEjL+CcO+J8AdVAaWUZOnQIimPWMw5Mk2s
 83FiVPxJe9LEr+5j+3z4Iw6unoEuaV8wvZoPQ54ti85wNLLPfpoIaVNaFanKL3GAyLlPdQ3QHLh
 Q5Gc=
X-Google-Smtp-Source: AGHT+IH5p7dLi6RF6/Udu3gjScmM2zK87XtgN7a0APjO1Y0PLpjL8sE5paodCue1L3k4D4J+1bd66w==
X-Received: by 2002:a17:902:e852:b0:1d7:41b7:332b with SMTP id
 t18-20020a170902e85200b001d741b7332bmr875256plg.14.1705796473556; 
 Sat, 20 Jan 2024 16:21:13 -0800 (PST)
Received: from stoup.net ([2001:8004:5170:1e39:1361:3840:4873:7990])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a17090276c400b001d5af7fbda0sm5023546plt.122.2024.01.20.16.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 16:21:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PULL 7/8] linux-user/elfload: test return value of getrlimit
Date: Sun, 21 Jan 2024 11:20:46 +1100
Message-Id: <20240121002047.89234-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240121002047.89234-1-richard.henderson@linaro.org>
References: <20240121002047.89234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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


