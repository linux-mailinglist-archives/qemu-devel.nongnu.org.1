Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E516175AFAC
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:26:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTe9-0006Gf-Bx; Thu, 20 Jul 2023 09:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMTe7-0006GO-JJ
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:24:43 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMTe0-0003bF-T2
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:24:43 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-56598263d1dso593935eaf.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 06:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689859471; x=1690464271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qPOwvnef5qOMjQkH0REi4yq7z8sApVX3jbBtVHqEn7M=;
 b=Ne6AL6sWaLo6Y7wU5shQUK2cYVaHmyXSQeLVnq4ZXMLF6HCutRo0SIHR0aHpcbDz08
 0XlQJHacA6snY9wAMlg/lJsPbGM3RMf3OTuJkrCbLqFIv5LTXcLVPF0/5aK12tHrSujc
 i/8wPP1P2aeLlv0F1T5CZ+9qY9MuiMX7M238DUhRkSWkiFnlajF3A2eEBo4bp/IXeRe0
 ufPGri5oG0eLQxMiuLZTCynFV3sPxhRgOqZRcGP8X1OM1Or7iDNzrqakgV927RmBdBub
 DrAJd1hwvqzIyY5Seo5YwvfhtV2y1cY9aes5NM5epl4VQhHAfTwwOvAusdLyjnV5bQRo
 fFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689859471; x=1690464271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qPOwvnef5qOMjQkH0REi4yq7z8sApVX3jbBtVHqEn7M=;
 b=bAgbM6zsEm+cZ1lBsproC6L2UlSs5dYpYc2c8ztFBd895dgNA6tpkuyEkjhe1qUkv0
 HQtTxZM50/qn+qG+gm4Sb8ExBAved498YxcPdpZnZx7SEhsFJaIo3zvEdoK7ntwer+Zu
 noXzq1sL5SjLF4lEBeBuDMMHTzjd7y0nIt2EQxesp/LWWG6WH0Ty5Tf//bS8udqkVaFP
 f2V5wFn2yFviiMwnnT3/13uCXtzGSn21/oqCONU0FIYe+8FQD3cXiUhbM5ic7Lq6a3Ls
 Ly5QE/jARz83uvGbin2RhT2HYp3vbeNIjGlBe8NTUz+w+mZVdF/69TATKLfyYKdlBCfr
 eNMg==
X-Gm-Message-State: ABy/qLYMjK3ROD0Q7biyTJySPPoHEXndnFsa9sd22wLkVuwL/ESoZJE9
 8NU5lQmKHT9f1kZB0KtLZuI8FyeeBecOefIJXw7YOg==
X-Google-Smtp-Source: APBJJlGhIfP1myBeHa6WrnObDVHSBC6cTIQ5uWjRIP4/OuKjKvYYHRNIKD8upLMHi2KRMBUpkJdVaw==
X-Received: by 2002:a4a:41cb:0:b0:566:b483:ee00 with SMTP id
 x194-20020a4a41cb000000b00566b483ee00mr2061427ooa.5.1689859470854; 
 Thu, 20 Jul 2023 06:24:30 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 p186-20020a4a48c3000000b0054f85f67f31sm421361ooa.46.2023.07.20.06.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 06:24:30 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/2] target/riscv: add missing riscv,isa strings
Date: Thu, 20 Jul 2023 10:24:22 -0300
Message-ID: <20230720132424.371132-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,

Found these 2 instances while working in more 8.2 material.

I believe both are safe for freeze but I won't lose my sleep if we
decide to postpone it.

Daniel Henrique Barboza (2):
  target/riscv/cpu.c: add zmmul isa string
  target/riscv/cpu.c: add smepmp isa string

 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.41.0


