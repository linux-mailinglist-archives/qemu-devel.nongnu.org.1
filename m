Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9209B733E
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Oct 2024 04:56:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MHc-0003JK-2f; Wed, 30 Oct 2024 23:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHH-0002Ah-NH
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:55:21 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHG-0004Dy-8w
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:55:19 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20c805a0753so5216185ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346917; x=1730951717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhXxbqcgvmHHW26aIl/bBdwA+G3ldEL9efdtDSBpHQk=;
 b=X5e0PWPXVhdEH6ccGeGdUjKuMlE6z2pU4uxakfdDaOnwowYjPHSVzjy+24buaqM7Qd
 ICFTqkl3dLT2lRYxRM9VX0DYOGnajjFNohg6rDPiWWaG0xIO6dHdsa7WiDQFzAXW0hfP
 BK/kNIXIzJxEiyapvedJXnVxGEFcCfpTXsYzy83HTcGbjVvUBeiC2WJXrTf+7N3KY1tJ
 4+5WWTv9m4Ne5pImO/yF/SvescnKrbFnLjf0TkUBikN96nwmqNPV3RHUwssKwuqnlqmT
 /vWO4IoOxwRJNJXRlkR5mOaxNW5oqJUv1rMwGEe2wSVSU8qqGVr9EFSHZTg8lskSONnJ
 duXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346917; x=1730951717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhXxbqcgvmHHW26aIl/bBdwA+G3ldEL9efdtDSBpHQk=;
 b=vVslpln38MO28CHjEzxyj166OZW07J4nImnStRRa5S4d0M7M1aPOLHA4FXJlzusnzV
 KqVYlRbATMXVxSkdXF4Mm5iYYrvrS9DUJt0Om4xReEtNG5zknNd65b2lDghuiWGUd4cM
 KLVEhA50iFXF3vgG44siHLLgUNYKyD5wDeZafLONC4tBdxxM67I7PfmKUcgFms6PZAwp
 azdRoN6k+mFrMBxcUfuYOh/dKErQDrgN1sW4YAhx64V2FxrjuHltApBIg9udW6FvVXpm
 iid3IZnCrp8Gb7Bm0M6PJMpwKew6UsXE1swdFTXU+OYCZPa1FH/YJBGMMa1JvwqIXpeP
 aJxQ==
X-Gm-Message-State: AOJu0YwqMbJkPoDpj6WPgFDW6u+fohpEhsDuxqHInINbv6j+9EFXGZKl
 VhzPMFFT/4Pm8OzWzNwDv96KnNE4nqzosGy+iDq49IrRtSRoCyiYhHAUMeWz
X-Google-Smtp-Source: AGHT+IG/2Pnjh6NZJItQ3HGuq4GJIYwcv/aHRvOkf4q4uU2mEFZh4gyUHKloD/Or1dNulHz2DWvKiA==
X-Received: by 2002:a17:902:cf08:b0:20c:3d9e:5f2b with SMTP id
 d9443c01a7336-210c6cba5f1mr260681375ad.57.1730346916711; 
 Wed, 30 Oct 2024 20:55:16 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:55:16 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 35/50] target/riscv: Expose zicfiss extension as a cpu property
Date: Thu, 31 Oct 2024 13:53:03 +1000
Message-ID: <20241031035319.731906-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

From: Deepak Gupta <debug@rivosinc.com>

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241008225010.1861630-21-debug@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index afdba29995..f219f0c3b5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1475,6 +1475,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
+    MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
-- 
2.47.0


