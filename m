Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C20D9771137
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 20:02:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSLbZ-0003LI-8K; Sat, 05 Aug 2023 14:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSLbX-0003L2-2M
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 14:02:19 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSLbV-0005P4-KY
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 14:02:18 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bbff6b2679so20733615ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 11:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691258536; x=1691863336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=buMc4K6aeffRxJXdJ+e4JvuZbDjWEPA2iWMmDyRBluQ=;
 b=AOwG1i+e6pK/ODQgM6IW2L9nU1/v28Oqc46yl5y/kMOPz90VpHj6Mi4WnKk5fbRDCP
 of6Vq6nhPsMCLw9sLyJVcGp0FkrPB8S0AOkhAesFBYvo9XPuSCrfGSt1A/oiiO+iJd+6
 od4WYlA+VnytYiLx1k9pZp348/HmDdP5FNy3vGdeuKhB0RGxdHmTWRNNDdE9v5SwRcc2
 HwloKHfnxnmB72ExqggXpIH+baYagQ8ITBg6h6eeSfzOwlzaSRxkB5fWhlN/k8dbOeyH
 5vfYj0afLws+zTm6Y6PZN+5Oh1jTM8KY/eK08IltSBdeuKTb38i/3Wwl7o9OVzj5hGpw
 E+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691258536; x=1691863336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=buMc4K6aeffRxJXdJ+e4JvuZbDjWEPA2iWMmDyRBluQ=;
 b=fok32xMAmZQUgk0EQI5+RIB2b/4I9QAqldBWoewfKSCGNnmW9Vvv4nJiucPHMrmxBF
 2i+L6BkvrG923UXsJoLRG1zeXMasJipI3atXEyycZQ+pRvY49d6/E8q6w1TjXMoj5q9i
 NJWVXDMAbOomQgkOyaHdRUQ9HzhpGi0uRqUJgMB+is8B9Zqj47IxTJJTV//qN3zj4Ycz
 YY3RFd7+8CmOry2sXvTOilSZjyHd+cUWg5j4LYNUyPaMb9C0NgaRX12ZJIO1/7tty4un
 6mLoo77+SHZaEc6fasHVF6htPaJqoB81bYmANa/kG3foLX3lVFsBXUbexRAWdVi+8W8D
 5rLQ==
X-Gm-Message-State: AOJu0YzFpIPpYJ6sTAJd9b9vffQOXbSxtBltjhCK+iSH4TAOy9urekP4
 CxQp/5+b7kljSQYJhF5YPrbgGi44DvyqFTr4zgs=
X-Google-Smtp-Source: AGHT+IE6EUYjvXVExtIrm9/ssO9XaYUw2lup5GTi1BXY+JLoQbmonqXcNMFq/YkehefacMCVAKXVbQ==
X-Received: by 2002:a17:903:1107:b0:1b8:b3f9:58e5 with SMTP id
 n7-20020a170903110700b001b8b3f958e5mr4327757plh.38.1691258535990; 
 Sat, 05 Aug 2023 11:02:15 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a170902ecc700b001bba7aab822sm3796815plh.5.2023.08.05.11.02.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 11:02:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: Fix linux-user host detection for riscv64
Date: Sat,  5 Aug 2023 11:02:14 -0700
Message-Id: <20230805180214.57198-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Mirror the host_arch variable from meson.build, so that we
probe for the correct linux-user/include/host/ directory.

Fixes: e3e477c3bca0 ("configure: Fix cross-building for RISCV host")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index afb25fd558..98dc78280e 100755
--- a/configure
+++ b/configure
@@ -469,6 +469,13 @@ else
   echo "WARNING: unrecognized host CPU, proceeding with 'uname -m' output '$cpu'"
 fi
 
+case "$cpu" in
+  riscv*)
+    host_arch=riscv ;;
+  *)
+    host_arch="$cpu" ;;
+esac
+
 # Normalise host CPU name and set multilib cflags.  The canonicalization
 # isn't really necessary, because the architectures that we check for
 # should not hit the 'uname -m' case, but better safe than sorry.
@@ -803,7 +810,7 @@ default_target_list=""
 mak_wilds=""
 
 if [ "$linux_user" != no ]; then
-    if [ "$targetos" = linux ] && [ -d "$source_path/linux-user/include/host/$cpu" ]; then
+    if [ "$targetos" = linux ] && [ -d "$source_path/linux-user/include/host/$host_arch" ]; then
         linux_user=yes
     elif [ "$linux_user" = yes ]; then
         error_exit "linux-user not supported on this architecture"
-- 
2.34.1


