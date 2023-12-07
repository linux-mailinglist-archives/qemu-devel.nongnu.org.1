Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08862808C0B
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 16:40:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBGSo-0005xt-Ex; Thu, 07 Dec 2023 10:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rBGSj-0005wc-3Y
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:38:53 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rBGSh-00080q-0p
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:38:52 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3332ad5b3e3so1101267f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 07:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701963528; x=1702568328;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VASR91DiF19ip9aHE05QCy1kZYGttEFaati7FSvhsAk=;
 b=My4pos2fKNYntFE7E0q7OHnfxzRfXvLvKkqu3sYCXQIyUEtt5sRTG2e8WDKH5N8I0h
 Lma3zdW0Xt7/Tn/npSRee24By4hiq/8JQah4w2DwSCMep+0xzy+1JRdYQfhuVVkb96t7
 /h4HrWs4ivUMF/DDJ4BHrLDe0TVcMwGFq7xAKd8TIPsKPvrJZD7LcUPx0ZBaS6/OF++T
 qBCRS3/RtKsSrkIo4Bfi0wYpbdQy4Ih4zvAYxIoBL7X03ijlDhCt4nX8c63tEsWTi/4a
 P53NOWdbJF+zWgMsJXDf+CadrnAbrRCyUgcYUAMwuHYBPQdmjOC5tvS63ofxJ6XgbtUw
 835g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701963528; x=1702568328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VASR91DiF19ip9aHE05QCy1kZYGttEFaati7FSvhsAk=;
 b=JXMoD4yy6E0uyoq+bfR6RxN59CDg5BzCZ1Kp2A0Y1ODbsZZUOuI2YSgxezzwbp/yEs
 3InGo+buKlJjMWqTohhKlcMQk2yRbL+Dy0/+Sf10+jkIeuBQzk5o2rrseCNghOII1VjF
 E4aM7ZHlOUF0H3LxRE2qzv+gDl9kvcUIjfvNsxaiI7O3DbSeUNzpGM83OWalVZ2z7mgW
 NLcJ2+MdGC47xOsSkLeotFUSRJppmNTZh+50BBxQiIdhJF7rX3rFfguN7zwv7kWbcVrl
 WCDp4ER8FaOFJNR6makLGhJWmd7at5jNa44mcCoaIyZMYOVueAIwFMBn94hkm6Td+rI3
 E0Mg==
X-Gm-Message-State: AOJu0YzuJCZdNZgf0P73eokliskNBLB0R8D3MslN+NVT7G++rJqBL1FN
 bvVAgGsutDOs1vS9+MHN6Mcou57nWODzrtgfCczkMw==
X-Google-Smtp-Source: AGHT+IHF+NsorDkYfC5rnY9pjkHRMww+NTCCpEbOqv4QqJccks1rVrhKNHEU+FJKT4WKRofOK292XA==
X-Received: by 2002:a5d:4845:0:b0:333:2fd2:51d0 with SMTP id
 n5-20020a5d4845000000b003332fd251d0mr1445213wrs.73.1701963527792; 
 Thu, 07 Dec 2023 07:38:47 -0800 (PST)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 b16-20020a5d4b90000000b0033339e03a60sm1711399wrt.59.2023.12.07.07.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 07:38:47 -0800 (PST)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH 0/2] Add support for (ratified) Zacas extension
Date: Thu,  7 Dec 2023 15:32:29 +0000
Message-ID: <20231207153842.32401-1-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=rbradford@rivosinc.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The Zacas extension is now ratified:
https://github.com/riscv/riscv-zacas

This series uses a patch from Weiwei Li from:
https://github.com/plctlab/plct-qemu/tree/plct-zacas-dev with the
following changes:

* Fixed destination register (looks like a copy and paste error),
* Fixed extension name enabling,
* Minor coding style fixes,
* Updated for new extension handling & cpu.h header split.

This patch was mentioned on the list here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg970280.html

The series was tested against riscv-tests from the following PR:
https://github.com/riscv-software-src/riscv-tests/pull/492

Rob Bradford (1):
  disas/riscv: Add amocas.[w,d,q] instructions

Weiwei Li (1):
  target/riscv: Add support for Zacas extension

 disas/riscv.c                               |   9 ++
 target/riscv/cpu.c                          |   2 +
 target/riscv/cpu_cfg.h                      |   1 +
 target/riscv/insn32.decode                  |   6 +
 target/riscv/insn_trans/trans_rvzacas.c.inc | 150 ++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                  |   5 +
 target/riscv/translate.c                    |   1 +
 7 files changed, 174 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzacas.c.inc

-- 
2.43.0


