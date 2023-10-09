Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 058E17BD92D
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:04:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpo2Z-0006EV-OR; Mon, 09 Oct 2023 07:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpo2C-0006Bs-HT
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:02:50 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpo2A-0003J0-0r
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:02:48 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-533d31a8523so7856340a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 04:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696849363; x=1697454163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zlXP41ypA0ujX/YV0zfxHyaduivoE0OxI8maqcWq1N0=;
 b=Wz1Np+LcHbHayjpNos82V4XoRMZ6RDYcFzvxW7YloQ02u1GbmndY41TmZPYDA9QDDg
 fT7GWVJDNlcrytIni+YUu3lO5vybhw4T9e1VG4m3MPx6egduqMY0WVXaKpND1Q7mOoyy
 PE5Mlc+Qqe6N+u4Bc27wT01KBOAdrmhK6zxW+gfMBojcWobWqB6R4SG+x6pT5bnjb6lC
 1cAzW8iT4pthosZ65Gwo+3ZSUKCBalzTX97EreFu7C449c1nwbozcyz9D9npNrMh5c0x
 dGNEVjEvZFKJnuxV5ld6YmEopR1o67lFi2yMTRE7Po/sR32eKfkGQRo6sVdeu1jwtEgP
 poTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696849363; x=1697454163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zlXP41ypA0ujX/YV0zfxHyaduivoE0OxI8maqcWq1N0=;
 b=bEjNDtUj6l9Ppzyd0PYB0NNioNRC+8Gqx692zN4Dpd/uzASBWonL1MWBf4/TFyJlPF
 7WwG57osEEpjnG05zUDpwq+RgsImbwqnU+pIyHpbs0SsZ8/8OMu4dHUYYIflwBTMdmip
 1RfP2xM2OinoxuNtLJ7+5pu/VplJFX9ZclCvAw5Pbg420yuRIJUdjYsKv31UcamBVx3S
 xFhAazfB4tuHbeCS1BeX4Y4eO8R4vjPEM12IjJGpzbRDKeIT8FletQp+Nm7Ydauoe51o
 UN936N3zTsWHQyK4iJs1jCcaFVMSBgt7EJOjKoy9GIUxEtxIs2Z7UjcW3d21WRzZt3NT
 ibFw==
X-Gm-Message-State: AOJu0Yx0ndvoBHlLEJpctoe9BAaCp5m+uieDeRt/t7MnrAzAGG/VX/0O
 HSYXnSdMOeLZpbK4W9EIWTFBfU1zV5rI5KYUry0=
X-Google-Smtp-Source: AGHT+IHtxMPE8b2HUQC2NC0iFpDI+BhO/gGzm7Q4zNMOtxF/N3ZyHfS2w3u4qZVVk/Clk+6SaP1R+Q==
X-Received: by 2002:a17:907:7631:b0:9a2:256a:65cd with SMTP id
 jy17-20020a170907763100b009a2256a65cdmr11273866ejc.4.1696849363071; 
 Mon, 09 Oct 2023 04:02:43 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 w19-20020a170906481300b009b9720a85e5sm6604806ejq.38.2023.10.09.04.02.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 04:02:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Cameron Esfahani <dirty@apple.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] target: Use env_archcpu() instead of
 ARCH_CPU(env_cpu(env))
Date: Mon,  9 Oct 2023 13:02:33 +0200
Message-ID: <20231009110239.66778-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

When we have a CPUArchState* pointer we can directly get the
corresponding ArchCPU* pointer with env_archcpu(). No need to
use QOM cast which is slower due when building with
--enable-qom-cast-debug.

This series replace ARCH_CPU(env_cpu(env)) by env_archcpu(env)
when possible.

Philippe Mathieu-Daudé (6):
  target/ppc: Use env_archcpu() in helper_book3s_msgsndp()
  target/riscv: Use env_archcpu() in [check_]nanbox()
  target/s390x: Use env_archcpu() in handle_diag_308()
  target/xtensa: Use env_archcpu() in update_c[compare|count]()
  target/i386/hvf: Use x86_cpu in simulate_[rdmsr|wrmsr]()
  target/i386: Use env_archcpu() in simulate_[rdmsr/wrmsr]()

 target/i386/hvf/x86_emu.h |  4 ++--
 target/riscv/internals.h  |  8 ++++----
 target/i386/hvf/hvf.c     |  4 ++--
 target/i386/hvf/x86_emu.c | 25 ++++++++++++-------------
 target/ppc/excp_helper.c  |  2 +-
 target/s390x/diag.c       |  2 +-
 target/xtensa/op_helper.c |  4 ++--
 7 files changed, 24 insertions(+), 25 deletions(-)

-- 
2.41.0


