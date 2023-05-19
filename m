Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 572A2709D79
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 19:06:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q03Xg-0002Ii-BW; Fri, 19 May 2023 13:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q03XN-0002B3-EX
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:05:05 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q03XG-0005Tt-Hh
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:05:05 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3093a6311dcso3456743f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 10:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684515896; x=1687107896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ldIYpO58WlQz7SONVRBaMprlSjZba7awGHquy9aweoU=;
 b=pY7Jtv6JxOqzJuC1kPWFmJfl8VDXGiwFTUq9cU7IWQsG7RgWhaCqu0d8je61zSPxRL
 niR/ibE1qldY8AIi6PLQNXi/1YzhIu/7QtgT8L14T2Udz0slLPyvgaDPwC+NOokv6N5m
 wKLdhT8t2o8rq9MPpL5GmOd7xTxd67JSETQYsKyFEPewsTxLYixOFmQqGf4noPBmYDvX
 pJRDMu2bxUUrbBpH4YZKw3HmBDBYWIzPpcO2OlFl42oQyJEeLQi44rj7L+hBm2i6av0G
 MkA0d0dkOF4W1PtHsD4raeKsC5npjDYHI8YMdAtrYMgrjPEeuo96LQ5HkZdPi2+vqaHi
 4yqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684515896; x=1687107896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ldIYpO58WlQz7SONVRBaMprlSjZba7awGHquy9aweoU=;
 b=k41UlImaov73v7ZGZjwlM7RWxGAR8zhALvvYAbrhuIj0C2BrLG5SS2vUuUK18Aj+ms
 LY0CGsA1cvPy0B2OoxYSNzUOldZ5VA1CrA02l5o/LUO6up7n8FYLbhlexpngUoafmCSQ
 AMmwPzTOQTTx2pvAecNhN/JYEfCuSqPWu+JTY+3RkhLNFb6k3f3o0GlWxVDz4Taw7rIS
 oFJiQDhSbGqproBTQor+4pkMli8eVeSaZYCb2JhB5s4ChM/OECSAEy6S5WCLiejgrETf
 7zJpwokX9NukwyDYzOR5YU6uYB7hkN6ripGRnqG5jlclNBs5NtdaTj0Aekuazsx3267q
 bRDg==
X-Gm-Message-State: AC+VfDyI2G2b2dEL7JFhwCdjnM0kgFcleiXvJqziF/JJ8/IlAdfk1hj7
 yM8VQzmkrktUR5QkQLRtAAPQpA==
X-Google-Smtp-Source: ACHHUZ75cS+5mC0hGOBs+hsnP3H5ZcYn1OALhcRAV77OmFjhgRsh1XMK2xgk5U3kfPXnChk0spMreQ==
X-Received: by 2002:a5d:5588:0:b0:304:a40c:43c6 with SMTP id
 i8-20020a5d5588000000b00304a40c43c6mr2057545wrv.11.1684515895655; 
 Fri, 19 May 2023 10:04:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c024800b003f42ceb3bf4sm2936982wmj.32.2023.05.19.10.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 10:04:55 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9C6BA1FFBB;
 Fri, 19 May 2023 18:04:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>,
 Mark Burton <mburton@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 0/8] plugins/next: bugfixs and iops based time control RFC
Date: Fri, 19 May 2023 18:04:46 +0100
Message-Id: <20230519170454.2353945-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

There are a couple of bug fixes in here but also the RFC for exposing
time control to the plugin. Its very rough and ready and I've not done
very many tests on the stability of the time slowing down but reducing
the iops value does seem to at least get reflected in slower dhrystone
scores.

Alex.

Alex Bennée (8):
  plugins: force slow path when plugins instrument memory ops
  plugins: fix memory leak while parsing options
  plugins: update lockstep to use g_memdup2
  sysemu: add set_virtual_time to accel ops
  qtest: use cpu interface in qtest_clock_warp
  sysemu: generalise qtest_warp_clock as qemu_clock_advance_virtual_time
  plugins: add time control API
  contrib/plugins: add iops plugin example for cost modelling

 include/exec/cpu-all.h                        |   2 +-
 include/hw/core/cpu.h                         |  17 ++
 include/qemu/qemu-plugin.h                    |  19 ++
 include/qemu/timer.h                          |  15 +
 include/sysemu/accel-ops.h                    |  18 +-
 include/sysemu/cpu-timers.h                   |   3 +-
 include/sysemu/qtest.h                        |   1 +
 accel/qtest/qtest.c                           |   1 +
 accel/tcg/cputlb.c                            |   4 +-
 accel/tcg/user-exec.c                         |   6 +-
 contrib/plugins/cache.c                       |   2 +-
 contrib/plugins/drcov.c                       |   2 +-
 contrib/plugins/execlog.c                     |   2 +-
 contrib/plugins/hotblocks.c                   |   2 +-
 contrib/plugins/hotpages.c                    |   2 +-
 contrib/plugins/howvec.c                      |   2 +-
 contrib/plugins/hwprofile.c                   |   2 +-
 contrib/plugins/iops.c                        | 260 ++++++++++++++++++
 contrib/plugins/lockstep.c                    |   4 +-
 plugins/api.c                                 |  22 ++
 softmmu/cpus.c                                |  11 +
 softmmu/qtest.c                               |  26 +-
 ...t-virtual-clock.c => cpus-virtual-clock.c} |   5 +
 target/arm/tcg/sve_helper.c                   |   4 -
 tests/plugin/bb.c                             |   2 +-
 tests/plugin/insn.c                           |   2 +-
 tests/plugin/mem.c                            |   2 +-
 tests/plugin/syscall.c                        |   2 +-
 util/qemu-timer.c                             |  26 ++
 contrib/plugins/Makefile                      |   1 +
 plugins/qemu-plugins.symbols                  |   2 +
 stubs/meson.build                             |   2 +-
 tests/tcg/aarch64/Makefile.target             |   8 +
 33 files changed, 433 insertions(+), 46 deletions(-)
 create mode 100644 contrib/plugins/iops.c
 rename stubs/{cpus-get-virtual-clock.c => cpus-virtual-clock.c} (68%)

-- 
2.39.2


