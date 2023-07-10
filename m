Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AA274D5E3
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:40:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq5V-0002rt-JR; Mon, 10 Jul 2023 08:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq57-0002aP-Os
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:34 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq55-0004ef-I7
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:32 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-666edfc50deso2797694b3a.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992410; x=1691584410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AladqjV8VmaGmNpvRhRP+HZSi5L51b4X63iQbv0K4tY=;
 b=Huk0F0+K1fm6Gp1VqIhivakjO0ok2s/1fEu+xNuA0VtSWFiDJengkQtQzPzvXuHloz
 nm67YbzEdZzOWj1Jh7I9oW08Ov+9JMxPWVxkfU1+xvYHKOE1faFdnefs57xAPJiU6Jqa
 18gaxE6Agl5qysxTN9qqwIGe+MlwiUwdoPxxBxlMOZL+8kUK+bDThpxlpn4odXSpYiu3
 G8kwGRN2A/4qMpSdxYiY4uT7T94k1kqcCrK/dK5RLpFsd7wpd9LlY7sMHWB+yOe9kOdw
 sv6/tp+Qs0OKutB6HkRpin+Etu6mbBVTcyJRxz1b7waxY9VnZQ5WLfsMsQLcFF4gG6eR
 yKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992410; x=1691584410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AladqjV8VmaGmNpvRhRP+HZSi5L51b4X63iQbv0K4tY=;
 b=LyW9M3Tk4B8zXhfAvi99Pp+KOlWGBCE4EFIFdd9eAsUYjdFAki6QxM+WKPUEzBlXFm
 Sv7R2EYDxT3a/91sl4/V6Jmjt4hXogu/1kbzPWmGMe+a8OIu5CmOHfjsckSGUxouwJW8
 LyTWDl7OHWTErsFu2KfDhggtvraBbPc5h78gkHGTreqg0cQ73wos7g9M1uuIqzDa2cnQ
 GAwMIw7QlhpmqWNL7jD84D6mt1axDgFa1YLtNq0XMpxK+YYyoQ/lLp/7b31FeWTmF+2R
 uqilk7u13GDxqEQj6oq5V/sbUQ2NGtwK7d82KBwTWsdK0B3mw3qgJhMuSpfBVrZKsIUL
 bLaQ==
X-Gm-Message-State: ABy/qLaDe1vBSlk8aqJsmmGeZLBmOINK0ljvVITSHdypDPje1ZuB/ojO
 1vNsYUhnPmGKfVc8ODM77JVTgL8CIdBB2Q==
X-Google-Smtp-Source: APBJJlEZJ+zkazy/ihvPOt0szhWa6lIAIheITWH5sW2USt+7hoPLm9dXcO2TC3iMNzexMD//yLSELA==
X-Received: by 2002:a05:6a20:3d01:b0:125:9d2e:ae1a with SMTP id
 y1-20020a056a203d0100b001259d2eae1amr22862093pzi.9.1688992409736; 
 Mon, 10 Jul 2023 05:33:29 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:33:29 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/54] target/riscv: Only unify 'riscv32/64' -> 'riscv' for
 host cpu in meson
Date: Mon, 10 Jul 2023 22:31:31 +1000
Message-Id: <20230710123205.2441106-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
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

We want to keep the ability to distinct between 32/64-bit host.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230627143235.29947-2-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 meson.build | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 58413d44a5..657e01069b 100644
--- a/meson.build
+++ b/meson.build
@@ -55,16 +55,11 @@ qapi_trace_events = []
 
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux']
-supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv', 'x86', 'x86_64',
+supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
   'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64']
 
 cpu = host_machine.cpu_family()
 
-# Unify riscv* to a single family.
-if cpu in ['riscv32', 'riscv64']
-  cpu = 'riscv'
-endif
-
 target_dirs = config_host['TARGET_DIRS'].split()
 have_linux_user = false
 have_bsd_user = false
@@ -99,6 +94,8 @@ elif cpu == 'x86'
   host_arch = 'i386'
 elif cpu == 'mips64'
   host_arch = 'mips'
+elif cpu in ['riscv32', 'riscv64']
+  host_arch = 'riscv'
 else
   host_arch = cpu
 endif
@@ -113,7 +110,7 @@ elif cpu in ['ppc', 'ppc64']
   kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
 elif cpu in ['mips', 'mips64']
   kvm_targets = ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mips64el-softmmu']
-elif cpu in ['riscv']
+elif cpu in ['riscv32', 'riscv64']
   kvm_targets = ['riscv32-softmmu', 'riscv64-softmmu']
 else
   kvm_targets = []
-- 
2.40.1


