Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0175070321F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:04:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyaee-0007c2-3P; Mon, 15 May 2023 12:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyadq-0007A1-Lk; Mon, 15 May 2023 12:01:49 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyado-00019s-MA; Mon, 15 May 2023 12:01:42 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-643b60855c8so11078642b3a.2; 
 Mon, 15 May 2023 09:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684166498; x=1686758498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UFgLKtj2togDa1W+n9DCBV5UooTXFn0G/5XadMfDEg8=;
 b=NusywUXqYokt6gNXikBaYt31mXTCg880I85dTIoRFCijtO8x5KXcAYqtL09LiNMuTg
 wp2wBWyY35A6sXH04p8OL+plBSy32jmG78e67tqQ3FjtvrIZO9auGVysFy4MnRM5VdYQ
 tpqT07b8a6PfXOjWQzMjgcgAr0XKgyPXKaOEDIcEpq98jvjmDvlXDnGIsNuzjMCYg6Z4
 5D6xuqx+d9+HMXuZ6qDkjqUnO1s5j57eHhhagD+xoSctPj//uDDGU2aLxh8296j4bef3
 CDvxM//XyIjXCseoc6PBheVeFBUwZwBCcZpP4lrBhWZUJ22ciya3RwPePKtq1bUA3xLM
 Tu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684166498; x=1686758498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UFgLKtj2togDa1W+n9DCBV5UooTXFn0G/5XadMfDEg8=;
 b=LYxOepCfzW64NhNb9HbUDq5HpglpfCCtzfPCpOkYBiEDwi5ybtplb/GtXNllpbInBc
 dJHdAwxXNOASyJHevRaFJGaqqOpoI+HfP2/TA9YTysUxinblQIoKRh7+hhxlc+Xt9FgV
 d6DULCRY0mQRVdjnPFRsuuqCgC5UKITS4Y+kRO+885UH5ZdoVTEhiDfQYb9Quy8Z4wM8
 qtWcE9zRoxHNESsRgOPSFQCnZ1L90kAlxhRTo1/HHFxBiRlg2dp3qO8biT8L7wnoVcQO
 KxTKTPT7hZR1sA+8KfbRqhFhuAebrXbclPHNtcEv3GDSCnafW+pjCPF8igrinpPLzOcr
 2SbA==
X-Gm-Message-State: AC+VfDz23IO2Pp+0XM4tvi7TQaJO8bfUCd/iUks2u0pd8g9qLCpCnGU4
 sCMKzz82A5QGQggXkvWcUYUM/Q6vAEc=
X-Google-Smtp-Source: ACHHUZ6eOaWRBqptnnPcKbVncmHzY88xFqX52lv5QcG1YoVR/l+yVZdTOC6i9dSO19DINzLibQcrPg==
X-Received: by 2002:a05:6a00:218a:b0:637:aea0:b23d with SMTP id
 h10-20020a056a00218a00b00637aea0b23dmr47788916pfi.10.1684166498358; 
 Mon, 15 May 2023 09:01:38 -0700 (PDT)
Received: from wheely.local0.net ([202.168.30.146])
 by smtp.gmail.com with ESMTPSA id
 x5-20020aa784c5000000b0064394d63458sm2742198pfn.78.2023.05.15.09.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 09:01:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harsh@linux.vnet.ibm.com>
Subject: [PATCH] target/ppc: Use SMT4 small core chip type in POWER9/10 PVRs
Date: Tue, 16 May 2023 02:01:31 +1000
Message-Id: <20230515160131.394562-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

QEMU's PVR value for POWER9 DD2.0 has chip type 1, which is the SMT4
"small core" type that OpenPOWER processors use. QEMU's PVR for all
other POWER9/10 have chip type 0, which "enterprise" systems use.

The difference does not really matter to QEMU (because it does not care
about SMT mode in the target), but for consistency all PVRs should use
the same chip type. We'll go with the SMT4 OpenPOWER type.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
This is a replacement for

https://lists.gnu.org/archive/html/qemu-ppc/2022-03/msg00227.html

But the chip type is changed to 1 instead of 0, because that's the
more familiar SM4 / small core CPU.

Thanks,
Nick

 target/ppc/cpu-models.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index 1326493a9a..a77e036b3a 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -348,11 +348,11 @@ enum {
     CPU_POWERPC_POWER8NVL_BASE     = 0x004C0000,
     CPU_POWERPC_POWER8NVL_v10      = 0x004C0100,
     CPU_POWERPC_POWER9_BASE        = 0x004E0000,
-    CPU_POWERPC_POWER9_DD1         = 0x004E0100,
+    CPU_POWERPC_POWER9_DD1         = 0x004E1100,
     CPU_POWERPC_POWER9_DD20        = 0x004E1200,
     CPU_POWERPC_POWER10_BASE       = 0x00800000,
-    CPU_POWERPC_POWER10_DD1        = 0x00800100,
-    CPU_POWERPC_POWER10_DD20       = 0x00800200,
+    CPU_POWERPC_POWER10_DD1        = 0x00801100,
+    CPU_POWERPC_POWER10_DD20       = 0x00801200,
     CPU_POWERPC_970_v22            = 0x00390202,
     CPU_POWERPC_970FX_v10          = 0x00391100,
     CPU_POWERPC_970FX_v20          = 0x003C0200,
-- 
2.40.1


