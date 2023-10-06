Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A837BB1C9
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 08:57:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoelD-0002MY-QV; Fri, 06 Oct 2023 02:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoel8-0002Ld-24
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:56:26 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoel4-00035v-Eh
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:56:25 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3247d69ed2cso1737368f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 23:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696575381; x=1697180181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cdqiX6dWVRa/4AzOq/8yLZQcOO/sdfforGUfkwiTcSg=;
 b=MjNZ05OCQIcLA1hWPrjBz4u99niHM4yv34Dc1xsRluAsuBkFn/CJjcGu7dE96YagLh
 xMovNiydrS9pPYU3j2EqOSoSskRQYANKf35qslM2O36xgAIp4HluYEPecOAo2nK0awaN
 zaVTNkvhvVyeC+KsERO9Q4YoD6tHSsKHwXTC2ayQiJZEF6sI/OBMZKAxU4pVf5gcUUu3
 gEAFo+VuDzVSp+lWyLNIu3n+2CE6Nx19U0rvoZRTxU1dBXGloRxmJtyKvKDhvXkQIORz
 G60AND0RsrlLLv6CSYUjtv1RM3fx2DBCMukhLnNDuSl6CLI4r6Akh31sJ1JsJcvxYIL+
 Z95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696575381; x=1697180181;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cdqiX6dWVRa/4AzOq/8yLZQcOO/sdfforGUfkwiTcSg=;
 b=HuzHRBwl//oM857sUQnN6W6D/4kyvnPZC1NBuxNFVXCh12w1C0O5gT6LnZXA5Dc+Q8
 5yJn4UfmRn1BRAhIv1RDYLtkoNxyblQwiS2wt+qm6r59bSf6PZdUFeb2e2N0Ri45k6/j
 ADVemctkBXcc1a9vJicqRJ0f9pxNKr2thL/cOEIHizP4OG0C8v+PU0TQ1fP5K73xftij
 kJTDlaiUKNryKNhp+U1JaYI0aRD8uuCMjv1yWD7JZxhSZZiKzXr86Wqn4/HRLkNFWKON
 V7CEdy9eWx5ZPTD2GfYRs5ETgLO8Y/HM66km3OcPLKxWHWqXLZHuqNUGiEGwt/ETuVsC
 VwEQ==
X-Gm-Message-State: AOJu0YymOgVTaS5+zBkqkeFTY8Nl2ATksDC2p3PvQ8NL5Ek1npCCKSK+
 ZZikkQoGINqq0QXSXMlTnhPGzQhmnUQBiYKvWlk=
X-Google-Smtp-Source: AGHT+IEPECq1BEe64KI4qe6y0oUHApfummfWvjpvuVyjfdOKfGpSZDw9KnzY5cc+uo81kotyoj6O0g==
X-Received: by 2002:a5d:474f:0:b0:31f:d5db:a13 with SMTP id
 o15-20020a5d474f000000b0031fd5db0a13mr6778613wrs.61.1696575380700; 
 Thu, 05 Oct 2023 23:56:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.115.173])
 by smtp.gmail.com with ESMTPSA id
 m15-20020adfe94f000000b0031984b370f2sm911268wrn.47.2023.10.05.23.56.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Oct 2023 23:56:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ni Hui <shuizhuyuanluo@126.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Marcin Nowakowski <marcin.nowakowski@fungible.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-stable@nongnu.org,
 Sergey Evlashev <vectorchiefrocks@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH RESEND] target/mips: Fix MSA BZ/BNZ opcodes displacement
Date: Fri,  6 Oct 2023 08:56:17 +0200
Message-ID: <20231006065618.34843-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

The PC offset is *signed*.

Cc: qemu-stable@nongnu.org
Reported-by: Sergey Evlashev <vectorchiefrocks@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1624
Fixes: c7a9ef7517 ("target/mips: Introduce decode tree bindings for MSA ASE")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/msa.decode | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/msa.decode b/target/mips/tcg/msa.decode
index 9575289195..4410e2a02e 100644
--- a/target/mips/tcg/msa.decode
+++ b/target/mips/tcg/msa.decode
@@ -31,8 +31,8 @@
 
 @lsa                ...... rs:5 rt:5 rd:5 ... sa:2 ......   &r
 @ldst               ...... sa:s10 ws:5 wd:5 .... df:2       &msa_i
-@bz_v               ...... ... ..    wt:5 sa:16             &msa_bz df=3
-@bz                 ...... ...  df:2 wt:5 sa:16             &msa_bz
+@bz_v               ...... ... ..    wt:5 sa:s16            &msa_bz df=3
+@bz                 ...... ...  df:2 wt:5 sa:s16            &msa_bz
 @elm_df             ...... .... ......    ws:5 wd:5 ......  &msa_elm_df df=%elm_df n=%elm_n
 @elm                ...... ..........     ws:5 wd:5 ......  &msa_elm
 @vec                ...... .....     wt:5 ws:5 wd:5 ......  &msa_r df=0
-- 
2.41.0


