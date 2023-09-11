Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 022AB79A3E3
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:49:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfagW-0003av-6g; Mon, 11 Sep 2023 02:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfafc-0002Ou-Qo
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:19 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfafa-0004tF-5i
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:16 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3a812843f0fso2499496b6e.2
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414712; x=1695019512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g72WiAV5qZ1oQb/83wFsWAvyLD7y1PtWQ+7+Ow3xVqA=;
 b=Jfw3NfpEuxZX1wDK6hRbJqd2yCcvPrHMjwpHkShL1gb7VQ9iyHfNllsR+YTMlusLJ5
 DDjUTIZvWZNXUfbD2v7mm/F+I/ZbL2hKfrOlK2+zJZujBJzOmanjNEfTecj3i+JdkiG7
 xF+di4guaAqEJSYx1GaEgB5rr77fYb8BZxhx/hAvnSp8WEwhMOkCfES8ZJrn4IBvgeql
 tNeodUXWLlBV2a9ix0tbebTvAX1KH58w3GS+2JWKJfGYrWx5hsGbZ8uZk1dQOA4/Zm06
 V7ad8XdRjIX9W75rZzT6G+b8bEswANTY4GN2MYmDL0/f/iFk6ICQE7HsklfbGepZMPa4
 CSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414712; x=1695019512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g72WiAV5qZ1oQb/83wFsWAvyLD7y1PtWQ+7+Ow3xVqA=;
 b=Knz7Hwq95vk5K5CXKifLpAo2zOPL6gsw7YwYsioLVSIerjJwPdWhiMNzvNVKM/Q7m1
 caQV9/7r600kaOz49qLSU+cDtJankXW+WRAOBdo1t1CI9PFiRRIePlsCnrPsS5qCs6sv
 5WZMgovreNwNuwrz3KHTB8cw4POl3BUsinBWsbeD/b0VE0/4kfeOaYT4HWtHN0HIYLNr
 wEv43FdF8cXZUh1m9zseQP+ETXc4FHJNjvWvfnnJ6prGg4I+3yXTEhlTd0YZiErdaWVG
 gILken7B0fmrBxkzp4DX6K0wKrs8lsiiG4C2svR2ota8bFCm7EAVI3d81pb/ENgX3GvA
 w4nA==
X-Gm-Message-State: AOJu0Yw8/ljAlC2uk8mIkRYA6rr4b3ixm6E6VRIAQfZC1V5MSGlPyZ2E
 c1krt6fLdU1vzzqjyqJYU6bNg8wuDDMH9Q==
X-Google-Smtp-Source: AGHT+IHFPtCFB3WbC8IEGGtwqWtsQAGqRgtsMfU90NoPotAeR1xjZVfOZXncADTbhxPcPL60vqClgQ==
X-Received: by 2002:a05:6808:2189:b0:3a4:6b13:b721 with SMTP id
 be9-20020a056808218900b003a46b13b721mr10207455oib.46.1694414711700; 
 Sun, 10 Sep 2023 23:45:11 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:45:10 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 24/45] target/riscv: Add Zihintntl extension ISA string to
 DTS
Date: Mon, 11 Sep 2023 16:42:59 +1000
Message-ID: <20230911064320.939791-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22b.google.com
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

From: Jason Chien <jason.chien@sifive.com>

RVA23 Profiles states:
The RVA23 profiles are intended to be used for 64-bit application
processors that will run rich OS stacks from standard binary OS
distributions and with a substantial number of third-party binary user
applications that will be supported over a considerable length of time
in the field.

The chapter 4 of the unprivileged spec introduces the Zihintntl extension
and Zihintntl is a mandatory extension presented in RVA23 Profiles, whose
purpose is to enable application and operating system portability across
different implementations. Thus the DTS should contain the Zihintntl ISA
string in order to pass to software.

The unprivileged spec states:
Like any HINTs, these instructions may be freely ignored. Hence, although
they are described in terms of cache-based memory hierarchies, they do not
mandate the provision of caches.

These instructions are encoded with non-used opcode, e.g. ADD x0, x0, x2,
which QEMU already supports, and QEMU does not emulate cache. Therefore
these instructions can be considered as a no-op, and we only need to add
a new property for the Zihintntl extension.

Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Jason Chien <jason.chien@sifive.com>
Message-ID: <20230726074049.19505-2-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 target/riscv/cpu.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 61f6238756..0e6a0f245c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -66,6 +66,7 @@ struct RISCVCPUConfig {
     bool ext_icbom;
     bool ext_icboz;
     bool ext_zicond;
+    bool ext_zihintntl;
     bool ext_zihintpause;
     bool ext_smstateen;
     bool ext_sstc;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index dc4b88e625..fae1c92c5c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -87,6 +87,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_icsr),
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_ifencei),
+    ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
@@ -1790,6 +1791,7 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("sscofpmf", RISCVCPU, cfg.ext_sscofpmf, false),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
     DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
+    DEFINE_PROP_BOOL("Zihintntl", RISCVCPU, cfg.ext_zihintntl, true),
     DEFINE_PROP_BOOL("Zihintpause", RISCVCPU, cfg.ext_zihintpause, true),
     DEFINE_PROP_BOOL("Zawrs", RISCVCPU, cfg.ext_zawrs, true),
     DEFINE_PROP_BOOL("Zfa", RISCVCPU, cfg.ext_zfa, true),
-- 
2.41.0


