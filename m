Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B3C74D58C
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:34:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq5X-000356-7w; Mon, 10 Jul 2023 08:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5H-0002kN-Dn
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:45 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq58-0004fb-TC
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:43 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-392116ae103so3397168b6e.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992413; x=1691584413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/BxT6mZSvReQNnn/TdB/plDM9sBVaU+QVWT9sBu1Rsc=;
 b=dO848v0GGSCJhdOcATFRONoT9VPkD+4FlVoBgBJEHSpEO3GiLs/ouAIuTglRrx1bXl
 YKwO5egJgKNUIjV6CoiZaYezLUgTZAnbRo/MSMv9iuqMiWCJIVcaeC/4Tlm9y8jB7TF7
 xZxJdF9OzpH5GUysVbARCSNW5hfgyjRjynuLX9KW8p/C/PWNGcc771kOAoEP94k1IGUX
 JOE/sjAuQ5UMANZmKquKtYXh8kLtHBw5cG4TIZCuO25Fv7d/28XiIyDTqmBj8Puzt3mc
 cnsluOyF1DqLAfhIQE3Q8E9KFhkGiJl5uqUjYzFLu7IjNqeTfsE2jlQEema+VxP800eF
 YdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992413; x=1691584413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/BxT6mZSvReQNnn/TdB/plDM9sBVaU+QVWT9sBu1Rsc=;
 b=ehhdyPLFMp9NRDyI33FKGw+zFQeCDJuP1FqTmeP8yUmuueazGFcaoothfAjl7+zM7r
 FLpjPao3bs/8Vc7kt/KptZHZRiO01zt7f0f1dkkt1quV6m1XkiE2/aKKT1wmeYMPGH4h
 A0F5SKjv7gv4aSGLIXIsyVbrTIaQMld7QwU9clmfSlhnVMoDSbH6DOzqwWaIai5Ns93v
 5Porv43t8vryoqv1nIjBH8IQpIgy/COIQ4oA/vRdoATd4jERjvDI4+qGiQuAbEGtCftP
 rdc9eGE4WDbwA7yJ4d+rSCgO3/aqh7CtdIE2WhKHADOTvEMwM5If7oHQzP4/NqEagXXT
 Yipw==
X-Gm-Message-State: ABy/qLb0HCoUr23eXWyyyyaPoVoIBA8wYPpSvvJsxkTG2QB5NRmdfn2d
 7T1wcQoxkFSkfdExGo10XKZ3eYko7gA3HA==
X-Google-Smtp-Source: APBJJlGIzkk0IAOuPA/8t7trayFnXMHBWpTzRzJVqagemiYA8eK9Kn3kbkDT7yQGwQtsmuCHjYJQ1A==
X-Received: by 2002:a05:6808:1a97:b0:3a3:6331:fd6f with SMTP id
 bm23-20020a0568081a9700b003a36331fd6fmr8698567oib.40.1688992412945; 
 Mon, 10 Jul 2023 05:33:32 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:33:32 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/54] target/riscv: Only build KVM guest with same wordsize as
 host
Date: Mon, 10 Jul 2023 22:31:32 +1000
Message-Id: <20230710123205.2441106-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Per Anup Patel in [*]:

 > Currently, we only support running rv64 guest on rv64 host
 > and rv32 guest on rv32 host.
 >
 > In the future, we might support running rv32 guest on rv64
 > host but as of now we don't see a strong push for it.

Therefore, when only using the KVM accelerator it is pointless
to build qemu-system-riscv32 on a rv64 host (or qemu-system-riscv64
on a rv32 host). Restrict meson to only build the correct binary,
avoiding to waste ressources building unusable code.

[*] https://lore.kernel.org/qemu-devel/CAAhSdy2JeRHeeoEc1XKQhPO3aDz4YKeyQsPT4S8yKJcYTA+AiQ@mail.gmail.com/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230627143235.29947-3-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 meson.build | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 657e01069b..1ed47c779d 100644
--- a/meson.build
+++ b/meson.build
@@ -110,8 +110,10 @@ elif cpu in ['ppc', 'ppc64']
   kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
 elif cpu in ['mips', 'mips64']
   kvm_targets = ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mips64el-softmmu']
-elif cpu in ['riscv32', 'riscv64']
-  kvm_targets = ['riscv32-softmmu', 'riscv64-softmmu']
+elif cpu in ['riscv32']
+  kvm_targets = ['riscv32-softmmu']
+elif cpu in ['riscv64']
+  kvm_targets = ['riscv64-softmmu']
 else
   kvm_targets = []
 endif
-- 
2.40.1


