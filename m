Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E00477D43F
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 22:38:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0mU-0006MW-OV; Tue, 15 Aug 2023 16:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0mS-0006Lw-QX
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:36:44 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0mQ-0000xa-AP
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:36:44 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bca3588edbso4021614a34.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 13:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692131801; x=1692736601;
 h=content-transfer-encoding:based-on:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7V5CTyM9EV/u0OOr5ukN/3gUzFVWrP4ijt3E++QW1kQ=;
 b=HN3/zdPiIjzREdHh6rkgD/oKJxZTwYEhWZP4iYm7hzJZ/+rM5iEpVQHL4XZWfztp16
 AubeVXbXWdf47GDbMgI+W1og17vlHhfGU9Mcb/zIROtNyP889bl7KGtvH6fM0IB1GTJx
 pj5YwHJn1iRdP2mtfjv3pNj1cF55o932rJ0C7HwI3nGZJwHo56Dh0c0kt5pY6cOcuLCj
 Oo/b13Z6RRlYuqbYIKZaJb6VJwXKdAMQ57xoiSEPJdJG6cWpzf0K3OnhSICyTWOoFP2L
 12CaJ8rmjcYcAwonvaEGZAUZNEn2kpfIRH8PSBamj/1pDF5XXYluRrXIiNd7G7vbZaYr
 f8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692131801; x=1692736601;
 h=content-transfer-encoding:based-on:mime-version:message-id:date
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7V5CTyM9EV/u0OOr5ukN/3gUzFVWrP4ijt3E++QW1kQ=;
 b=ELzR0RfIAyUfbGmhImGAuEdT/AQdAgI2b1eb8wlmI5pC3zChUaa7xA2abvOY0EAqKK
 GDlHg8+V6KSecS8Iw+5bh+bOr+eKMuqHIvZz/Ibmw4UGohLo9bm4osrUJRbEMbhcAb6b
 rGxFDU/5koafG3dpUKJzLjbj0vmsbyT9dX3FDgOtspNX0hqIN0Awq2O0FcpQKHB8lLQ2
 2YICh0ucrSX47RLZywjUUKc8Y/Wye+A8y9CrgtOiEloXl6lN8ibH3NTHUnh6JsIa3coN
 1aGXuLj6YhWt1WJJ0JTxDzvGtGVjnmNdEWjUdAh7l8Q4mY2sWdIlS3phpEhFMyF2Vvi1
 6pug==
X-Gm-Message-State: AOJu0YwBKcNgqIppF2ULuqT/nZ78n1d/VrAVxoxoULy5qM1phPL17zKL
 lU5wD8nodmIuDiIxKU0nhm9vMkGV+6bIkfcfpNo=
X-Google-Smtp-Source: AGHT+IHIDdrUOONT0wEwRl6Nznvf4U3FcoGCfdNRnJ4RvGOpfEveB2fuscgBdcTrD40JDXQbtu2eJA==
X-Received: by 2002:a9d:6ac2:0:b0:6b9:6276:c64c with SMTP id
 m2-20020a9d6ac2000000b006b96276c64cmr11234107otq.12.1692131800751; 
 Tue, 15 Aug 2023 13:36:40 -0700 (PDT)
Received: from grind.. (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a0568301bcf00b006b94fb2762asm5526849ota.23.2023.08.15.13.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 13:36:40 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/8] riscv: detecting user choice in TCG extensions
Date: Tue, 15 Aug 2023 17:36:27 -0300
Message-ID: <20230815203635.400179-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Based-on: 20230815201559.398643-1-dbarboza@ventanamicro.com
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x336.google.com
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

Hi,

This new version is a rebase on top of the new version of the 'max' CPU
series:

[PATCH v7 00/12] riscv: add 'max' CPU, deprecate 'any'

The changes made from v6 to v7 conflicted with the code from v1 of this
series.

No changes made aside from trivial conflicts.

All patches acked.

Changes from v1:
- rebased on top of "[PATCH v7 00/12] riscv: add 'max' CPU, deprecate
  'any'"
- v1 link: https://lore.kernel.org/qemu-riscv/20230728131520.110394-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (8):
  target/riscv/cpu.c: use offset in isa_ext_is_enabled/update_enabled
  target/riscv: make CPUCFG() macro public
  target/riscv/cpu.c: introduce cpu_cfg_ext_auto_update()
  target/riscv/cpu.c: use cpu_cfg_ext_auto_update() during realize()
  target/riscv/cpu.c: introduce RISCVCPUMultiExtConfig
  target/riscv: use isa_ext_update_enabled() in
    init_max_cpu_extensions()
  target/riscv/cpu.c: honor user choice in cpu_cfg_ext_auto_update()
  target/riscv/cpu.c: consider user option with RVG

 target/riscv/cpu.c | 400 +++++++++++++++++++++++++++++----------------
 target/riscv/cpu.h |   2 +
 target/riscv/kvm.c |   8 +-
 3 files changed, 266 insertions(+), 144 deletions(-)

-- 
2.41.0


