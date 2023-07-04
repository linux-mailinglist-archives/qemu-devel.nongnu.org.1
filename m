Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A118746C31
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:42:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbb8-0001No-VZ; Tue, 04 Jul 2023 04:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1qGbb7-0001NS-Cb
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:41:21 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1qGbb5-00005M-FR
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:41:20 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-55af0a816e4so2721949a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1688460078; x=1691052078;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzQwHilUs2+h3+nromIKPNidcbjRoSUxGEzJrfFiXVs=;
 b=mpcVt1iaFZezX07RMdpb+pWV3H9LWWJOUdgjCLeeObyq8iLnutYz92JzEjPW5SA6tq
 /bG49B/Yjmh095FCdmTyEv5eltp1PJBBihQg9a3SjuT28wQuh+s55OGffyBHZ+1c8Izb
 VziXrOmzLag2D94QlMdPEjr5kkmCAcA4GE5kw8hfsx35bVJEzF1B8Kl8yvzzpfcaB3WZ
 yHxiEL9GF4ApNpsz5A34etcqEz4JweM2X5vTztUoOZ0KfGgDMMUJEwCRfOmpsgChIQan
 a9ETf36PcPmSiKJLXrbiyqphjgWD0FbpqZuLr6mVm/4DnZ6F3kCd+9Y4mjVDt3ISwlpV
 dv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688460078; x=1691052078;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AzQwHilUs2+h3+nromIKPNidcbjRoSUxGEzJrfFiXVs=;
 b=g0pEpX/q5NDb3HQBsKJUeKH5MA1OFvuE5313LBJHhOGrFpl2dKvPTJcDljMxnVKz/w
 yK0d/j2Wc7+Nw6CWNxQHOCycxKcvEbw4cYfAYkDYhwk6pUWJdEszmpYNy/j9NF4RxBcD
 /FtNMSDLl4VyM+zAJlCA3n4wAS9oyVyvKUX5z5qvG8+l1HrWU0EMln0AGXtcCsLgQqlq
 l+rj8rtPb5J+Y4823yHgcD5r7PdGAQy98jEA7czcWzu7nEtXdVSMrcxhJezhVSv8sB42
 n6ekGhV29jeVlMTs/gV5M4P7TiXywVXcDVoA6Q7Vd0HcMUH2idrX18QU+Xh6xEyVOsC6
 yKRw==
X-Gm-Message-State: AC+VfDz6NDIdaBw0AdqJ6ZILOpdq7BUIOsKEFswb0Rp/i4OaR2nuP5Ej
 AFLzEM4j/caK4rKTii+0YxHc+jFgvkGUX0Q0kCKUlWfveZiK3XyaJSP92xtkVt+012PwdqqdZ/Z
 1U6tpyzn1M+GK7DGB3P+AGITcdNkmtC7PeH2f/MrvzJ5OD5mMW0sew9HhswV1kyKf4O/qKxHdgl
 7CGQ==
X-Google-Smtp-Source: ACHHUZ59u0NA2vfQbDTqTWiGhs2RRDG1P0Npmnmqs1+xE1URZGAdm5RlX3YFj1KJQw/nE7C3HpRf2g==
X-Received: by 2002:a05:6a20:3212:b0:12c:763b:f098 with SMTP id
 hl18-20020a056a20321200b0012c763bf098mr8898296pzc.11.1688460077504; 
 Tue, 04 Jul 2023 01:41:17 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a170902ab8100b001b80b428d4bsm13870188plr.67.2023.07.04.01.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 01:41:16 -0700 (PDT)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH] target/riscv: Add Zihintntl extension ISA string to DTS
Date: Tue,  4 Jul 2023 08:40:10 +0000
Message-Id: <20230704084013.21749-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=jason.chien@sifive.com; helo=mail-pg1-x535.google.com
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

These instructions are encoded with used opcode, e.g. ADD x0, x0, x2, which
QEMU already supports, and QEMU does not emulate cache. Therefore these
instructions can be considered as a no-op, and we only need to add a new
property for the Zihintntl extension.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
---
 target/riscv/cpu.c     | 2 ++
 target/riscv/cpu_cfg.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 881bddf393..6fd21466a4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -81,6 +81,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_icsr),
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_ifencei),
+    ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfh, PRIV_VERSION_1_11_0, ext_zfh),
@@ -1598,6 +1599,7 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("sscofpmf", RISCVCPU, cfg.ext_sscofpmf, false),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
     DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
+    DEFINE_PROP_BOOL("Zihintntl", RISCVCPU, cfg.ext_zihintntl, true),
     DEFINE_PROP_BOOL("Zihintpause", RISCVCPU, cfg.ext_zihintpause, true),
     DEFINE_PROP_BOOL("Zawrs", RISCVCPU, cfg.ext_zawrs, true),
     DEFINE_PROP_BOOL("Zfh", RISCVCPU, cfg.ext_zfh, false),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index c4a627d335..c7da2facef 100644
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
-- 
2.17.1


