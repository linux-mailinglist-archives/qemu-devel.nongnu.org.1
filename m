Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC49B763EF5
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 20:50:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOjMx-0000jy-G5; Wed, 26 Jul 2023 14:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjMn-0000jD-3Q; Wed, 26 Jul 2023 14:36:09 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjMl-0008Jw-Cj; Wed, 26 Jul 2023 14:36:08 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bba48b0bd2so533235ad.3; 
 Wed, 26 Jul 2023 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690396565; x=1691001365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OTYHHB7LsLK6VsyELQ8ySde/gWfncQJsmnmH13BQxoE=;
 b=JswuT1or989InqtJZC2IJY6ASZ3yHoHYltOe/1hRvtwgYJIscyqY/mNreI8l+bqnLk
 pgSmmKVBJSEQtZGbx4Ajo2XH9sSVZiL23RMPlmzaZVkusxCjv1u5myGKxCG3jt60ajEY
 3Trn3vgdP5+MeSygzW/EaspyKZwFkSsQHf/ZK1vB+5XJqeYbgSLnSwd/Y1/zP/RvRK7Z
 BtelwQjCBGfCvIxlmRh/Dkt0Tfm7fJCayBp2KQV3mL2Rr8R53a7kZtGbUtHKQ3rRFG2N
 hQHxAxPB0phrw2iMlzdswFf2K0qYQNjFdRVm43FVofq9zV4UUwXQKpfBl6ta4fkOKXY1
 +qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690396565; x=1691001365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OTYHHB7LsLK6VsyELQ8ySde/gWfncQJsmnmH13BQxoE=;
 b=eZJGWVvACrqv6Ukyn5CpYyMSE8bi+aMhiy18BQMPB49YVODVtv+3FbxhRrjPLsBh6K
 e0P/QtB3WUFu/RJgQB7eVq8ZAbuXAvJA2WPv33igjIBmGRfBuaeMYLXHFhqx0tDXp3W9
 2TcRC1kdkph/GC1c5BIWcxHOHcFpkP1VjZC4EWeuRuZToi5Ms9UvsfhZuXOHV74vAP/S
 vf8ikPwSczmN+icUOCRL+2WmE26hUImR5h28c26qWCb58eK5cl8n71/qib+VZmFDYEar
 c+1TkYMZ/aVrx4Oa7GT28ATYP2qbfnYrTGrAEMdNyrBWLU/+s1S3sS9LidgEKNWsW0u+
 fzrw==
X-Gm-Message-State: ABy/qLbTr4CQZnThE+gUMDAp/oYg1Xngt83lj6pBaPBuIdDZxDaFp0ou
 Q5zWIs/g11tzxnfOFPEyW9hLXj3i3Cw=
X-Google-Smtp-Source: APBJJlEBrn4ZZyISfngkvT0N+sxKxSbsq558UZqm+/SV0DNRC/jcIk4kbg6/eTHTaBTCbyFPdcIgTg==
X-Received: by 2002:a17:902:e5cb:b0:1b8:a328:c1e6 with SMTP id
 u11-20020a170902e5cb00b001b8a328c1e6mr2848995plf.63.1690396565636; 
 Wed, 26 Jul 2023 11:36:05 -0700 (PDT)
Received: from wheely.local0.net ([118.102.104.45])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a17090301cd00b001b83dc8649dsm13485670plh.250.2023.07.26.11.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 11:36:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH 5/7] tests/avocado: boot ppc64 pseries replay-record test to
 Linux VFS mount
Date: Thu, 27 Jul 2023 04:35:30 +1000
Message-Id: <20230726183532.434380-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726183532.434380-1-npiggin@gmail.com>
References: <20230726183532.434380-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

This the ppc64 record-replay test is able to replay the full kernel boot
so try enabling it.

Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/replay_kernel.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 79c607b0e7..a18610542e 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -255,8 +255,7 @@ def test_ppc64_pseries(self):
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
-        # icount is not good enough for PPC64 for complete boot yet
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        console_pattern = 'VFS: Cannot open root device'
         self.run_rr(kernel_path, kernel_command_line, console_pattern)
 
     def test_ppc64_powernv(self):
-- 
2.40.1


