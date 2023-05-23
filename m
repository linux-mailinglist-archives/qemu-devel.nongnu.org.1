Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2FA70DBB3
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 13:46:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1QSB-0003tc-Vz; Tue, 23 May 2023 07:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q1QRv-0003qY-0M
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:45:07 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q1QRr-0001ml-4Z
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:45:06 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-38ef6217221so4137553b6e.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 04:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1684842299; x=1687434299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tiwh3g8qWZu24azv1kh/REuSLwR7On6jD0V4y8x6cvk=;
 b=LuiClhY8evOKdCapPm/vr0Q0PiuNcBa3g0sIZGnnUXOjwSgiMzmLZXyknwUt5M0yMX
 nHZMxHQ4Fj3OP432Y5v+i1tTxiU9wIhSf6Tggp+y24E/Bz5oADwIpUzzmoUvYoxbeLse
 wgouTKJhp1W6jQw0y5LovX+anF2H5KYvDBbh6DjuiFnUa4RipHISqorxa/KRZXfap72J
 U6U/aAcdXW00w3yxOqUTMpCQNCG48dK9HCYMcjQclb8VTpXAcMtRbcl6cohWiG8f7GVZ
 k7jbORJAMti7KyPHPrFkViJAvQcftAjMOmCiE1LmusiPMik7SY72hwwwOZOS1gKZ+KCD
 I+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684842299; x=1687434299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tiwh3g8qWZu24azv1kh/REuSLwR7On6jD0V4y8x6cvk=;
 b=IHl31QeEmyDK9hu0bQ8mVGypyNpilcVhnrTtZLZ49sN2efW4uGGGNSAb3OqNuDcSen
 +8PTsIOsRN/zXW6TFQAx7MvKBmdwLqaj5Zt5WcB/508ew4uhWAHDOE20gbDGXeTydjDu
 QhhRd6smpsKLRjFbUCWwoNx7kQbSTh+OIWsi8aQxgQqPUwMeQKS1HFqrkTyWXUA3JTsJ
 F3KcdFs1Xp030LF7XsdZzAvEJpa4IfNkDjYeeztLLp131fUZrVpCN+JXs1SU190hIwkk
 +9pt095rKeeywrMUzZAoOoGaUaCM7BuM33mBv4NHVxoMbIvwKr5KMUrsJgjRMniJUPcH
 Q1NQ==
X-Gm-Message-State: AC+VfDzbedSxoVC1EGrSxATy6du0xE8Ri3zzM8QZcdVdVzy33UjNZATk
 COxs6HYacmtROVTcayG8pDSCHoV9opxgW/IK6lZ5ZxqV9JXmrOMj4dKnFDHlw+XFTa8rDmFEF2F
 GGWa4zGw6szdFLB9+Ijb9hobNk9gRIiH5CbUFNCuTX4ilGgiZyIv7HbT4A4eIudy3wWx6d6k9C3
 Yl
X-Google-Smtp-Source: ACHHUZ7XkI3mK8KfsTItHThimuueHMOF4qmQGVgVT0kbgnpWoay1fPwrKO40pYUln1652yp0vajTaQ==
X-Received: by 2002:a05:6808:191:b0:398:10ad:e857 with SMTP id
 w17-20020a056808019100b0039810ade857mr2928537oic.48.1684842298678; 
 Tue, 23 May 2023 04:44:58 -0700 (PDT)
Received: from sw05.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id
 e3-20020acab503000000b003924c15cf58sm3799772oif.20.2023.05.23.04.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 04:44:58 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, alistair.francis@wdc.com, apatel@ventanamicro.com,
 palmer@rivosinc.com, dbarboza@ventanamicro.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH 0/2] Refresh the dynamic CSR xml after updating the state of
 the cpu.
Date: Tue, 23 May 2023 04:44:52 -0700
Message-Id: <20230523114454.717708-1-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=tommy.wu@sifive.com; helo=mail-oi1-x22e.google.com
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

The realize function of IMSIC will force select AIA feature and setup CSRs,
but the dynamic CSR xml is not updated, so we cannot print the AIA CSRs
in the remote gdb debugger.

In the patches, we provide a function to refresh the dynamic CSR xml,
and refresh the xml in the realize function of IMSIC.

Tommy Wu (2):
  target/riscv: Add a function to refresh the dynamic CSRs xml.
  hw/intc: riscv_imsic: Refresh the CSRs xml after updating the state of
    the cpu.

 hw/intc/riscv_imsic.c  |  4 ++++
 target/riscv/cpu.h     |  2 ++
 target/riscv/gdbstub.c | 12 ++++++++++++
 3 files changed, 18 insertions(+)

-- 
2.38.1


