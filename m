Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD0283634A
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 13:34:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRtV2-0002on-Pj; Mon, 22 Jan 2024 07:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rRtV1-0002oF-5x
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 07:33:59 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rRtUz-0003Vl-Hu
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 07:33:58 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6dbdb1cb23fso1267316b3a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 04:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705926835; x=1706531635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nc1VKcNqDiOj1GUtv4Hxiy2B04WPepTuZM4ColiAJHE=;
 b=PxCn5qCv1uxZI6U3ZYAbvLS7X0ys3ZIR1HIGX4eMfRszDLF2NCRzy4vuXsGTApyWaH
 Ij+O5PSb3GTGerJNgF5TyQDQ+ilut1x6HX0u0dI6HW6Gofi82HGKmMugRcYpruM973+T
 By/rgKw0R/jG17sBj1xBhplmgxZg7UVheMCPuJSTIX3DOfqBstmtYEliDg263ksRvCCT
 6PrdzPwl0clu5+F3fFEXjbxXt/EOPh1kqXg5AV3co6GfzfR79It+tplxKb0/5iSlxQDq
 lDv3QXFQ8zXwppldBSHNRgIt0K86kCNm1u8NgCtEu7CstO7+DtYGm2MeCFpUyg8vj6TB
 FAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705926835; x=1706531635;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nc1VKcNqDiOj1GUtv4Hxiy2B04WPepTuZM4ColiAJHE=;
 b=U6mGwhYjDZU8xVH1J/fcq74FRUdW2slIjDWi/EnGNtezMUiMURbcU1TM3AQt+BSQ34
 KacioLMRQ4qhCMuYRcPmeA+JkZA49fqvmWSXuFUX2LSh88Ba66tFbN7FSY0w1qQBR3s/
 TY+KXelhQpfMPnAvO8JiDagZkwdkPw9gO8n26ULBPII5EcC77NqiLznfGLUNojoX7chr
 orvVk/JSnm2zLU7qo+o0Xwjw8aFjcJqiyBG3p79BPHvWnkj0RJp4s6okJX86ORiiLyAc
 DiLtnr+rLxHnD48OjLggrtNlmYKqlSeIKCjWZSBL0GEnSiZkZK0RHMS1cA5mqKd7kjzd
 0fUQ==
X-Gm-Message-State: AOJu0YzH/6OyGzz6u+goc0UBleT7FaKTGAFaJeT4w0qHMczybCdER3ph
 TfRQAH8DKLBAGdDUYsaMppXwZYOUauxQ5ROtYIz820kNt0/ULgcM2lRrv8uU4yIML+pnCVujl3B
 D
X-Google-Smtp-Source: AGHT+IEsw3wPuEbGsV/0pZhJmxJxKzdfPWtIzcRAE7/u3PE5tVIqd0LO2eBZuMo5gkJG31OFQNKIBQ==
X-Received: by 2002:a05:6a00:3a09:b0:6db:a0e5:7ec3 with SMTP id
 fj9-20020a056a003a0900b006dba0e57ec3mr6117239pfb.22.1705926835269; 
 Mon, 22 Jan 2024 04:33:55 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a056a00140a00b006d9b2694b0csm9414305pfu.200.2024.01.22.04.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 04:33:54 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 0/2] riscv: add rv32i,rv32e and rv64e CPUs
Date: Mon, 22 Jan 2024 09:33:46 -0300
Message-ID: <20240122123348.973288-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
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

Hi,

This v3 has the same patches from v2 rebased with a newer
riscv-to-apply.next branch (@ 096b6b07298).

No other changes made. All patches acked.

v2 link: https://lore.kernel.org/qemu-riscv/20240108161903.353648-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (2):
  target/riscv/cpu.c: add riscv_bare_cpu_init()
  target/riscv: add rv32i, rv32e and rv64e CPUs

 target/riscv/cpu-qom.h |  3 ++
 target/riscv/cpu.c     | 64 ++++++++++++++++++++++++++++++++----------
 2 files changed, 52 insertions(+), 15 deletions(-)

-- 
2.43.0


