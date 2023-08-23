Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D53786172
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:27:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOh-0000HV-QZ; Wed, 23 Aug 2023 16:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOV-0008Ky-67
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:59 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOK-0005UL-P7
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:51 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso47176655ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822221; x=1693427021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVbtbg9YLiki2PHPwQ3RAo+50+pEwE5ioy9dgOI0Jcc=;
 b=FQkS0RQLs4C2fXU2MhPTK1f9VNjcQl9Ze87TDbd5VVtWmhasOkGSWH0d/+M/sRRtmC
 AMOCN24WQZdv3Ga3beySQ086XY/sx6IQvhRS48h46f7iUTZfg/w0ws1p2om0lN0v9hue
 QPhb1kCljiwi3/TMnM07+4e5cGDMzO11wqtadPISGc96IvDtEZKjWyxQriqDF7+zghYf
 A9oIrF2BiJ9JiKAyeNAIXCHXRTpZVnx5ey7bP7Evc2HNG6vMg65NROyTdTmYdszhK5LG
 9OB3je1bQ9C+ifaehwibu4C1ZU338ayyiViB6OU/tAlSmjvJJPshLnOp/3nLx/NGvI23
 gmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822221; x=1693427021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xVbtbg9YLiki2PHPwQ3RAo+50+pEwE5ioy9dgOI0Jcc=;
 b=WhQQrBGW+S2g4t+wmX81xApU51l4jNw4wxv0zRQHzdc1uYMViie18lkHo54QRBa/Zs
 tJdjrjo4xwC2AwqEKxpNFPCMZuNwuDEzUj1ynjKfXp2nGg3iXxHrB/vyMyNH/EPHj7PR
 ezH1AVs3/OitsR3dBMzvkVL+jWMUwFKXdaDXE0Z/J1WiHcKWP1oBrd2wn9mEAusYxZmR
 TJ6g+ym7w//4md0x66XaFbkHwTgLpulbXU5hoeQlEZn73roitcVlZUu8QTUJaq/NTsSO
 ieSpCzrTRuwNfEHxkgC6LzbUKzIn7jhG8W29iOZlKb9F1eqIhThiEyu85MqEXpNXoS91
 lhWA==
X-Gm-Message-State: AOJu0Yy2Qflt4GHL03gBAz5LrzneTYAfqKP3bFC30dVPkCeTbcGEfdpY
 m9hKnUbnJUonjMDrLRzW828D5ryHQ/HhYXro7vU=
X-Google-Smtp-Source: AGHT+IF26qfYycFCRcoizlQHBdDRIKa+WKHKMdAUNdjcIjZWfvplLme41912LvQvE2OIgGkfa1Mm/w==
X-Received: by 2002:a17:902:a409:b0:1bd:c783:dac3 with SMTP id
 p9-20020a170902a40900b001bdc783dac3mr12152449plq.63.1692822221185; 
 Wed, 23 Aug 2023 13:23:41 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/48] docs/devel/tcg-ops: Bury mentions of trunc_shr_i64_i32()
Date: Wed, 23 Aug 2023 13:22:52 -0700
Message-Id: <20230823202326.1353645-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Commit 609ad70562 ("tcg: Split trunc_shr_i32 opcode into
extr[lh]_i64_i32") remove trunc_shr_i64_i32(). Update the
backend documentation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230822162847.71206-1-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/tcg-ops.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 6a166c5665..53695e1623 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -882,14 +882,15 @@ sub2_i32, brcond2_i32).
 On a 64 bit target, the values are transferred between 32 and 64-bit
 registers using the following ops:
 
-- trunc_shr_i64_i32
+- extrl_i64_i32
+- extrh_i64_i32
 - ext_i32_i64
 - extu_i32_i64
 
 They ensure that the values are correctly truncated or extended when
 moved from a 32-bit to a 64-bit register or vice-versa. Note that the
-trunc_shr_i64_i32 is an optional op. It is not necessary to implement
-it if all the following conditions are met:
+extrl_i64_i32 and extrh_i64_i32 are optional ops. It is not necessary
+to implement them if all the following conditions are met:
 
 - 64-bit registers can hold 32-bit values
 - 32-bit values in a 64-bit register do not need to stay zero or
-- 
2.34.1


