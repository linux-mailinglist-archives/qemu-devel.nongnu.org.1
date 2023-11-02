Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C731E7DF8EA
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:40:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybg2-000473-QL; Thu, 02 Nov 2023 13:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeh-0003H5-KL
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:58 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybec-0002mF-NV
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:55 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32fa7d15f4eso724855f8f.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946729; x=1699551529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5gnjJmQvTJBwOrKE2T0p6/jD0OcYtl+uj21k3TqiHP4=;
 b=FTOQrp86S3Zn9+lavvvIfFk70WzcilcwNEREHrSWcZPXsPFX/FY8OdFlphBoIo7MO/
 RAYCuXncBVcDklEcbOM+E7w/5RD2zmjw9iXE4pn711gsd4AABdOv+hfEI9/YmM2iUSx6
 W5vRqAgseG4mLFyZFK1o38IMWbX9WLT6SNeXvvzf8Jmp8nzFXGIZ+8hoPpge+nwVdWF/
 27sZ/wdRssd90JnIkOJ5q2MTgV4jeLdM3A+H6msIfe/+gOrqfJFQ9ocT2kpFxVhJGHjx
 W577gsyRDyrhAwLku0+OvIp2/BRX0rr6N0tJEnY5BMJlBvKz5vbk7wEqxNyuUh4iuSK6
 naHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946729; x=1699551529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5gnjJmQvTJBwOrKE2T0p6/jD0OcYtl+uj21k3TqiHP4=;
 b=UPBp2JK3UaaqVzVDXSc9NWfZUXDkE+5hw2kvsTBGRFU3ZkBRF+Utg+9JTiWlxahuPi
 2IDoawyPYDBx7bgw9oRIENIIPVIAj0j/5V4yKxQoC7e4a3/0ORICmUj8TlAwBSj8ZYxs
 l4nHfuLDGycoVq+V02Mq6ARe153q+KP0tioG0f1a7sN3Cb3czRxjY5KL7fjIbFqseDqk
 53tB2VKvQXcdFVgxU3wJL9epbi7Qsf2cJCd8rFIpl/0zB8tnJnvAkg7X0vpK4vikjOQ6
 gmS6RvDMM3migyYpOlMFuS8kkWKQGmffzBd/sgPUU6a8Vyl/KiUO/SVOKN0KljnzTBEE
 LZxQ==
X-Gm-Message-State: AOJu0YzFtpW1Bzl224KHBNFPcwyS7MZZBHSU2swtEkyKFOoms3Zn1rEF
 TMYZPQqclMM/v/X0pyXwgfo8ayBLm3AkGijs2pc=
X-Google-Smtp-Source: AGHT+IG5xfEoPlKF9X8/10mA4xv47uBcTt8z9pM9Yi9nfF4n324OBjp7XfAZ74o+SxDQ40GGcYopRw==
X-Received: by 2002:a05:6000:156d:b0:32f:7db1:22fe with SMTP id
 13-20020a056000156d00b0032f7db122femr15023632wrz.15.1698946729384; 
 Thu, 02 Nov 2023 10:38:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/33] target/arm: Enable FEAT_MOPS insns in user-mode emulation
Date: Thu,  2 Nov 2023 17:38:25 +0000
Message-Id: <20231102173835.609985-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

In user-mode emulation, we need to set the SCTLR_EL1.MSCEn
bit to avoid all the FEAT_MOPS insns UNDEFing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231030174000.3792225-2-peter.maydell@linaro.org
---
 target/arm/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 954328d72a0..df6496b0193 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -296,6 +296,8 @@ static void arm_cpu_reset_hold(Object *obj)
         env->cp15.sctlr_el[1] |= SCTLR_TSCXT;
         /* Disable access to Debug Communication Channel (DCC). */
         env->cp15.mdscr_el1 |= 1 << 12;
+        /* Enable FEAT_MOPS */
+        env->cp15.sctlr_el[1] |= SCTLR_MSCEN;
 #else
         /* Reset into the highest available EL */
         if (arm_feature(env, ARM_FEATURE_EL3)) {
-- 
2.34.1


