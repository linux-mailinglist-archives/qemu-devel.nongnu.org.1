Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F0582E288
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:26:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVOm-0000U3-4A; Mon, 15 Jan 2024 17:25:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVOk-0000Tg-J4
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:25:38 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVOi-00061R-V5
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:25:38 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6ddec7e5747so4191048a34.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705357535; x=1705962335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6PKX+MrVkykqVb8AE4gaARMOsKspIARUsOnGlNJ8hMo=;
 b=ZwTKFoinsi+uc7HjH24E17aQIxTj3xt6ulAhtpR9HkrDWxuKNskt7kI9AalorlIEfk
 EVworDsqjvXO4Kqi1IlerhM8YYBe1HpVle95Vw+mwoy9DW6GF4XJAIRJE8cn08j6D/pX
 tYCwk3hbPiHhdwXvDUZgikegToi0Gt/VegTwIhmHXTVZl94SoI3ikbpfWpnKhIDPq/XL
 bXdyy7zYTD53SWp7nLDmb7pBXQNRbslWLV2nzoSCuO7FCxeRRRSByUhdTocgKjFbIaeU
 yRm0IbxEVcGztvHV7cYH8UdJoyyTGpvg41kYE2+O/dauRKStL/wWWNqGoLJX15FJtTac
 e4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705357535; x=1705962335;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6PKX+MrVkykqVb8AE4gaARMOsKspIARUsOnGlNJ8hMo=;
 b=OkIcjcAO1RFDeIU7SgTfi+TTB0oHKeaPhH8Y6p/oYwHjX/KLLNl2POdGokn0GIJZj8
 6e8lk0Vw337RDbDcfuy1RbKaxI67T7omQqP3eyXsSMtKxFU6eRlrKluI6vChiE8QyJEU
 vVk+PWPJX8rQcPR2j1OO+tl1+YQqPifI9DxLspqoXqtCVxSUu8KuTmV3XvHMxKv/e4PT
 LoJ8hb3OLqZPguzCYrugrBUC+KtKh7fQg4/wo2A5E9wYIFvgqZUA8H+R9PIVjppyjSBO
 3qG3eG/OYO5PwFn62r2ZoUdHmJkn9u1lI9RoJjgfMkW/U9WKnSqDm1eEGGkm+2xYZ+Ix
 oV6Q==
X-Gm-Message-State: AOJu0Yx5LvHbrfnzTrTiPZ35B+wcVJetscIAoiiJZntX8jE7tB4jPX4+
 3YnTVctf4OwrqOR5bf+yJ/Dv6ZtkkZ2US10RP4o2EdmBXiwHeg==
X-Google-Smtp-Source: AGHT+IG7BZ/M6gIxdBXsETxXNoNBIs7iq1yYVcBhZHLnGLg1GdRIBwFkpHTI9NZ+8BnaGVry8wBz2g==
X-Received: by 2002:a05:6830:1e84:b0:6dc:48c1:3e4c with SMTP id
 n4-20020a0568301e8400b006dc48c13e4cmr7449002otr.57.1705357534804; 
 Mon, 15 Jan 2024 14:25:34 -0800 (PST)
Received: from grind.. ([152.234.123.64]) by smtp.gmail.com with ESMTPSA id
 ks19-20020a056a004b9300b006d977f70cd5sm8125940pfb.23.2024.01.15.14.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 14:25:34 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 00/12] target/riscv: add 'cpu->cfg.vlenb',
 remove 'cpu->cfg.vlen'
Date: Mon, 15 Jan 2024 19:25:16 -0300
Message-ID: <20240115222528.257342-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x332.google.com
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

This v2 contains changes proposed after the review from Richard. Most
notable change is in patch 11, where we simplified our lives a bit and
just calculated 'vlmax' using 'vlenb' instead of trying to use the TCG
global 'cpu_vl'.

Patch 10 also changed a bit to avoid the negative shift we were doing in
v1.


Changes from v1:
- patch 8:
  - instead of shifting sew, adjust the amount of shift rights to use 'vlenb'
- patch 9:
  - adjust the shifts rights to use 'vlenb' instead of shifting 'vlenb' left beforehand
- patch 10:
  - calc 'max_sz' before doing shift rights to retrieve MAX_SZ()
- patches 11 and 12:
  - squashed together
  - calc 'vlmax' using the same logic from patch 9 in both functions
- v1 link: https://lore.kernel.org/qemu-riscv/20240112213812.173521-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (12):
  target/riscv: add 'vlenb' field in cpu->cfg
  target/riscv/csr.c: use 'vlenb' instead of 'vlen'
  target/riscv/gdbstub.c: use 'vlenb' instead of shifting 'vlen'
  target/riscv/insn_trans/trans_rvbf16.c.inc: use cpu->cfg.vlenb
  target/riscv/insn_trans/trans_rvv.c.inc: use 'vlenb'
  target/riscv/insn_trans/trans_rvvk.c.inc: use 'vlenb'
  target/riscv/vector_helper.c: use 'vlenb'
  target/riscv/vector_helper.c: use vlenb in HELPER(vsetvl)
  target/riscv/cpu.h: use 'vlenb' in vext_get_vlmax()
  target/riscv/insn_trans/trans_rvv.c.inc: use 'vlenb' in MAXSZ()
  trans_rvv.c.inc: use 'vlenb' to calc vlmax in trans_vrgather_v*()
  target/riscv/cpu.c: remove cpu->cfg.vlen

 target/riscv/cpu.c                         |  12 +-
 target/riscv/cpu.h                         |   6 +-
 target/riscv/cpu_cfg.h                     |   2 +-
 target/riscv/csr.c                         |   4 +-
 target/riscv/gdbstub.c                     |   6 +-
 target/riscv/insn_trans/trans_rvbf16.c.inc |  12 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 152 ++++++++++-----------
 target/riscv/insn_trans/trans_rvvk.c.inc   |  16 +--
 target/riscv/tcg/tcg-cpu.c                 |   4 +-
 target/riscv/vector_helper.c               |  26 ++--
 10 files changed, 124 insertions(+), 116 deletions(-)

-- 
2.43.0


