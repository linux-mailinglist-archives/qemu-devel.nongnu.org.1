Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66488AB8412
	for <lists+qemu-devel@lfdr.de>; Thu, 15 May 2025 12:36:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVoy-0008A9-Jn; Thu, 15 May 2025 06:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnX-0005Jd-7K
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnT-0008F3-7K
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso6417805e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304797; x=1747909597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B60awm+HLGNl5/+mKblvLLwTzjYJ+2PMTdxexiaHS08=;
 b=C0SPTJb0n9q8gjZzHYjzI/JiqYLWuRUgilKKFSg5q/TCBSqvCPv4K6eEuOgKcTKQ0Z
 rPjGjeAFWnq5CS76hNAVEBtDZzNQ0ABvZ+bROVoFQU/ZiXbsZxmRyUZfwng2ErBsOqp/
 wjKJ/LOSlatEiX3BKwZprXtETKcyqkTda1wYV8/X8/VpaRgi0hKv+OAF9lCv9dYW9g5q
 Ga2bVFpQiowLGKe0mY9bb1uOCh2nGHhJfNy6Pojv/5ozRnlStUgioxHAJJAcZlwLbJeq
 hbcffqqL3XVdoRfePRaVxST7UxXeGl9YDnGTedeLN/BirQE+RB+DT6B1H1i+Glf/ywcM
 otbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304797; x=1747909597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B60awm+HLGNl5/+mKblvLLwTzjYJ+2PMTdxexiaHS08=;
 b=Yt1DtYbamwlIZBp8TgnVQyrKLT0HKBzoflBAHLfavciFgwQzu6MXe0d/Z69hVBRg0K
 a03/peYfuHRsNY4FXNtWuCv1kPbjOll8eEZXhko/9J9LZiiMUQXWB+eHzVmBdgJqaixJ
 FS7hOpJK2ziZeiNJTWv84ntGQ44d7G4/MvT0T9HIPn0So6XqDfpDRLPQLL5Paq6uwOvQ
 URhDzKFiblpzZJM3ol9N1YjkGPXFNPum6pI8IUJmvCTlBGA3hLBuuGM3P9iyIKDNbuFI
 zwhpFFaRKzW4rPBSCeTru1+wvKdkBztLEXAyUJgsIeFQywz51F5S0W+FaI2is3FrhzT6
 nHAQ==
X-Gm-Message-State: AOJu0YxeLqRQURp5fk3I0oJSRSnK1ETqIcwa6vhGlLkfXhb1yAJg/6EK
 8QfMtROQKu57f6F7PASQPHaZy47iIW+8nQY73lES1rbFeJjCALff47VkSwT42uw4DLj0PxHPn0/
 OJx4=
X-Gm-Gg: ASbGncs2H2e1TzNLo2D/ohUQWzagBUh4Jy8M8tL4RUBFd8lSDzh4YvozH8B+lyfQf/d
 vUmqyuqVfNXe2+jupQ8Cmc9Ie5Jo4dI1EMN1MNjFKLkxLaSQPxqRz2LJDnDwICojC2tj9UoKK3g
 00pvkR2xtg/1PQFb0QkAWUK4Lidr6jo0dgJpJy1XoLWqLz2zv1zT6H+Hzxf+SwLFk27rQnKq2z2
 ArM+NRyhRaxj7xgCWozOuKblnnkq45Pxyf8vk2A7CnFww6OGJRAeVP+IpTeKS6+CHrDDrjqMy+A
 Q/hY5cYcfmoaWhYXzN4oSeckLV3DO1CGGZs9ZwO53vJqGchiTBtmXOmv3Q==
X-Google-Smtp-Source: AGHT+IHH3qxdEhpelFsGC60IIrRPXs/Nck18wVtyYemwb6M7fb/TCFlVbuTJeriPoE5WMDNRIHshgA==
X-Received: by 2002:a05:600d:1b:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-442f4735a8bmr46573915e9.27.1747304796751; 
 Thu, 15 May 2025 03:26:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/58] target/arm/arm-powerctl: compile file once (system)
Date: Thu, 15 May 2025 11:25:25 +0100
Message-ID: <20250515102546.2149601-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250512180502.2395029-28-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 95a2b077dd6..7db573f4a97 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
-  'arm-powerctl.c',
   'arm-qmp-cmds.c',
   'cortex-regs.c',
   'machine.c',
@@ -38,6 +37,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
   'arch_dump.c',
+  'arm-powerctl.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.43.0


