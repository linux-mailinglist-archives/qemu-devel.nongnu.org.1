Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5B87540CA
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 19:45:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKMpA-0004Sc-E3; Fri, 14 Jul 2023 13:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qKMp7-0004Ry-PD
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:43:21 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qKMp6-00036y-4n
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:43:21 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6b7484cbc5dso1993685a34.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689356598; x=1691948598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cc/DNLO/7rXNwcDNdn2TdG1YzwOl2o4/xBTs+8ptJ+4=;
 b=ElsJrnI1FVd02Wap7Ww/A/I/wYsbid7GOOlLI4zeAcVLl+yy7Nd5oHDTbxD+kS6Exe
 tknz/c7t7i/TIFNQzoPL4wLD/k9YiXdr1WB7KCA7pnG3GDk4UoR5c5DSVunrEl6XTDl7
 7nVxgdYwL54dmCISnVh5eCK5HCG369XM3V5/ULie0/MHt8ACXyIO4hSqFRY4Cv1OtyIm
 ZKyJLi6GyFhB0wAGh0LCQDc8oX4ljOAEiImtsYozHaZaJrZIVBAW7X6WYNk9uhqsBr5Z
 7sxb0bDMRpP/WaaDTl9w/EHjFWIMaaGNHdqsAzbX3vPB5IS/ltVd7WVnKKvDW4E7f5qH
 gvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689356598; x=1691948598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cc/DNLO/7rXNwcDNdn2TdG1YzwOl2o4/xBTs+8ptJ+4=;
 b=Zji+k7a8FOGLuLcyQD2DCJvJfn3IzE5ugd1RYdeGj3JH+KAUwFHb9u91JZaW5uODz9
 UqyCA/Uzxr6c2kmlqoZFhTWS6omRgB7yPtY68LXpUOU0fwR4MIsDGZDI5l/bgtY0CDFM
 QXBSZ3hDMhO5Q8DvjTYvPdq1QGlrtkEKebwkw3DPGhhWyygyHTK80smQoae0LzjYY+5/
 Q+WKx/pi7luaBBVJMXi4XXc2BDmA+b79suY82zq3IPAzGYzIDyKuWxH5d2kXFErnxgGI
 auThCmk6p2L+eyt9D/cUlsR0J0maruWdva0Huru4UPsu1j5mKMOmLPxxdZSprFW0JdgF
 tCnQ==
X-Gm-Message-State: ABy/qLYXzLQNAvdvLJXV8pGH0dPfN5jLuGka1tJt/fN1XcOXT6q3oE26
 MMGXqWYWOpwGxQtNmJN/TfJsvBfpe1xTbjFYgJI=
X-Google-Smtp-Source: APBJJlFWWYDBMa4G21Nui16cqNR1WraPZ7MXI48oFOhaqbRpEe8u1OtMfv6OgG9qHDuaDPXQMUrQTg==
X-Received: by 2002:a05:6870:b612:b0:1b7:4e91:b8b4 with SMTP id
 cm18-20020a056870b61200b001b74e91b8b4mr2868149oab.15.1689356598378; 
 Fri, 14 Jul 2023 10:43:18 -0700 (PDT)
Received: from grind.. (201-69-66-19.dial-up.telesp.net.br. [201.69.66.19])
 by smtp.gmail.com with ESMTPSA id
 dw18-20020a056870771200b001b05c4b3b3dsm4240968oab.31.2023.07.14.10.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 10:43:18 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v3 0/8] target/riscv: add 'max' CPU, deprecate
Date: Fri, 14 Jul 2023 14:43:03 -0300
Message-ID: <20230714174311.672359-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x330.google.com
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

This version has changes suggested in v2. The most significant change is
the deprecation of the 'any' CPU in patch 8.

The reasoning behind it is that Alistair mentioned that the 'any' CPU
intended to work like the newly added 'max' CPU, so we're better of
removing the 'any' CPU since it'll be out of place. We can't just
remove the CPU out of the gate so we'll have to make it do with
deprecation first.

Patches missing review: 5,6,7,8

Changes from v2:
- patches 1, 3, 4:
  - remove "DEFINE_PROP_END_OF_LIST()" at the end of each prop array;
  - use ARRAY_SIZE() in the for loop
- patch 5:
  - remove the trailing '/' in the last line of the macro
  - wrap the macro in "do {} while (0)"
- patch 8 (new):
  - deprecate the 'any' CPU
- v2 link: https://lore.kernel.org/qemu-riscv/20230712205748.446931-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (8):
  target/riscv/cpu.c: split CPU options from riscv_cpu_extensions[]
  target/riscv/cpu.c: skip 'bool' check when filtering KVM props
  target/riscv/cpu.c: split vendor exts from riscv_cpu_extensions[]
  target/riscv/cpu.c: split non-ratified exts from
    riscv_cpu_extensions[]
  target/riscv/cpu.c: add a ADD_CPU_PROPERTIES_ARRAY() macro
  target/riscv: add 'max' CPU type
  avocado, risc-v: add opensbi tests for 'max' CPU
  target/riscv: deprecate the 'any' CPU type

 docs/about/deprecated.rst      |  12 ++++
 target/riscv/cpu-qom.h         |   1 +
 target/riscv/cpu.c             | 114 ++++++++++++++++++++++++++-------
 tests/avocado/riscv_opensbi.py |  16 +++++
 4 files changed, 121 insertions(+), 22 deletions(-)

-- 
2.41.0


