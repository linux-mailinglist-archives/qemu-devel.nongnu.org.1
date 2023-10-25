Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F297D708A
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 17:15:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfaQ-00055p-UK; Wed, 25 Oct 2023 11:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfaO-00055X-UH
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:21 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfaM-0003a7-CD
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:19 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b26a3163acso4717952b3a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698246857; x=1698851657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAUDHg5SvFHq8f6WzNLKNQdJ5ooAkR6tXZ2miRiTziU=;
 b=nO71+nE2LdFony8l6el+fEBx3wWYRnBwipmu5DnUoynMwrsHMd1jHaozY0eweQTCrW
 rUpHdxksmx9pKsxMQZCm840xECEdxRTFbvMfnjSHv4KFre3UbiK7Cr2iqPM6VvrZK3PM
 GQKQYEhtB4EB9FUj70paHiLBGqwiFAnPxoigsYf2lDyx2MzAfwWTgYFRO/qdBPmsUkCY
 JGdNNWz+80QjP/I1h2DXxm4T3gWBzG3VzVK6rbJT7N5rUDC54z+RJ3TN9cwViWxw8jC7
 IXHgYz/lCEC3lJfq5C7Meb3Iub80fsvm9TP1AZcBd7D8hJX0ixQq94qy0v3HbIAYnI47
 hBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698246857; x=1698851657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lAUDHg5SvFHq8f6WzNLKNQdJ5ooAkR6tXZ2miRiTziU=;
 b=G5/jdOUO64Lqv7INdP6bfmtTB0IVkXcu1KOiXnQTbwnEZERNRvDkYuYrYUkflnNczr
 NQoPhliTaNqm0Vk59M6Pe8txmxHFIbyM+EbwdwGz3WBuR/SitbI20vVJBvoxMCZIz7Up
 9KCHZ18gSTUfyC6KFOeJGES5i6uC7FLIvV3z1b4uBDCjlXGY2I4BNS7M6eHA0DodiskA
 8X1KtkVRiRE0R7CsMjelN5NMNCA2+e4aOgqoWrhR3kfx7QHj9AKQp1kB7NBlAbhSEsFT
 lGm2RuB55MoiUg36ZQgX+DVCWA6Sf4yoTNRJFsRZGCHaMPVHz4z5MPGMNhq3tyIpNMgt
 17mg==
X-Gm-Message-State: AOJu0Yxg/if7cKll0nW2TtRgKJEy7JzRiI3PVJQhULA9hy2xYxuedREf
 MeU7o+1nrFRrd4v6oOJRLMG6GRI3llOQJhU4wPG16/qfKb/Ow2+TMj3SeTy+lCVGdwa12Qj01hB
 6P3eZpCwbVgj2LD4dywaOO90lkGGom4X6XIOhzUq6HE3fkEOBU4gM69zmjAcQdZltB4VnJ7N6Ob
 KX
X-Google-Smtp-Source: AGHT+IHICGbDwjDioFBC4TlX2oY8iVWoHsycALrhM2a5WwNdNBdt4RB0eGm3S/WYhS4vA3ZiiazcHQ==
X-Received: by 2002:a05:6a00:15c2:b0:693:3be8:feba with SMTP id
 o2-20020a056a0015c200b006933be8febamr13774975pfu.19.1698246856668; 
 Wed, 25 Oct 2023 08:14:16 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 w14-20020a63160e000000b005b8ebef9fa0sm2677807pgl.83.2023.10.25.08.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 08:14:16 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH 03/14] target/riscv: Add cfg property for Zvkb extension
Date: Wed, 25 Oct 2023 23:13:27 +0800
Message-Id: <20231025151341.725477-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025151341.725477-1-max.chou@sifive.com>
References: <20231025151341.725477-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

After vector crypto spec v1.0.0-rc3 release, the Zvkb extension is
defined as a proper subset of the Zvbb extension. And both the Zvkn and
Zvks shorthand extensions replace the included Zvbb extension by Zvkb
extnesion.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index d8d17dedeed..935335e5721 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -88,6 +88,7 @@ struct RISCVCPUConfig {
     bool ext_zve64d;
     bool ext_zvbb;
     bool ext_zvbc;
+    bool ext_zvkb;
     bool ext_zvkg;
     bool ext_zvkned;
     bool ext_zvknha;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b9eaecb699c..1b08f27eee4 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -508,9 +508,9 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
      * In principle Zve*x would also suffice here, were they supported
      * in qemu
      */
-    if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkg || cpu->cfg.ext_zvkned ||
-         cpu->cfg.ext_zvknha || cpu->cfg.ext_zvksed || cpu->cfg.ext_zvksh) &&
-        !cpu->cfg.ext_zve32f) {
+    if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkb || cpu->cfg.ext_zvkg ||
+         cpu->cfg.ext_zvkned || cpu->cfg.ext_zvknha || cpu->cfg.ext_zvksed ||
+         cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32f) {
         error_setg(errp,
                    "Vector crypto extensions require V or Zve* extensions");
         return;
-- 
2.34.1


