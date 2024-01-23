Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F32838BAF
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:25:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDxA-0000MO-43; Tue, 23 Jan 2024 05:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSDx7-0000M8-VG
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:24:22 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSDx6-0004c1-2V
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:24:21 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-58e256505f7so2079440eaf.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 02:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706005458; x=1706610258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5ehqjnXm6FkJNQCaLeOIXpa8HmGDkiUMn46fmM7Xi0=;
 b=sdpSiXVIptxE0kJIjE1ayvuzOu0J2p1tlO/xn4iB/NvA9NJzFcEaAD0BwC/radbzpA
 dvDR02onu8gv2qNVqBvPGckKt9zDo/TlGM5prFN4nu/e3UW1zyVRzp6qWZEfgZMIIzNf
 ENQAYa1e4cGRDa26K51/2fvhYcj8Pi2JBfRS5mdbP1VynMao34j+ZteCNcKa9V/tvkWN
 fNZX2xg8T3VHGuNrid9azQZd4jc2AmQxYfM/7Twk/cnq8/uzUK8U0OqUmVgsYq0ctQf/
 BA4Yh/BIWYRaiUEe5LP5haaliUHrP+1H4xXqusIJxPLXL1wb8xpxT0vlJPEv88tWgMMO
 3uZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706005458; x=1706610258;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5ehqjnXm6FkJNQCaLeOIXpa8HmGDkiUMn46fmM7Xi0=;
 b=OLq1v2x/0wMvx6B2iEJE74JMYnRkwn3TjzaOBmaGcPMhoYD8ulirOypoR5I4kK11Tw
 PJ9c2NXJeXWHpvDG7QM+hYpRUdLhcYPeSC+62Wg7t9yXSLY7Ud4tBRSvCeOsNlOMPNdL
 /t4ssAfhOD7mFOCNWkudm0pMA4kA0ODyhlaXK0H4v515kfoY5s8PRpco4nhFML3KA7Im
 W0iXykOE1X9BNqcg8SMMwzyXarqnec2Qi8HWTeEEjNegg+L6B0fUPTBAQBnoGb1MZv8a
 1VV/aZ61xOJ9zaUzX1jVBFHRNNNzndPRLouKbYYB3tKHccQyqbnHqZZqND+l7jot1PtH
 O+NQ==
X-Gm-Message-State: AOJu0YzRIVeAU3/9RhQ2Kx7NC7Z5ixDhaxW90ex75TiAQ83vLWyC3Hll
 197sbzoji6lP4j/ce8jfC3j/Qk2Tw2ysNoxw/pM5wik+IG05dViJfdd1RywiMyAdts6EQLDzUL8
 PGn8=
X-Google-Smtp-Source: AGHT+IGeMfX9X8M8J4zmQ8TzqsJol4+qTGUkZxkP4I102/x5RXWdblIoFhFcXIoU2FVXSto9/8LP1Q==
X-Received: by 2002:a05:6358:3a1b:b0:176:49e6:d1be with SMTP id
 g27-20020a0563583a1b00b0017649e6d1bemr3390911rwe.7.1706005457983; 
 Tue, 23 Jan 2024 02:24:17 -0800 (PST)
Received: from stoup.lan
 (2001-44b8-2176-c800-b8a0-0408-58be-7d2e.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:b8a0:408:58be:7d2e])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a62f808000000b006d9ce7d3258sm11072408pfh.204.2024.01.23.02.24.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 02:24:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/8] tcg pach queue
Date: Tue, 23 Jan 2024 20:24:04 +1000
Message-Id: <20240123102412.4569-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

v2: Dropped s390x test case, which gets mis-compiled with
some cross-compiler.  Add tcg/arm fix.


r~


The following changes since commit 09be34717190c1620f0c6e5c8765b8da354aeb4b:

  Merge tag 'pull-request-2024-01-19' of https://gitlab.com/thuth/qemu into staging (2024-01-20 17:22:16 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240123

for you to fetch changes up to 9f6523e8e4689cafdbed7c10b7cf7c775b5a607b:

  tcg/arm: Fix SIGILL in tcg_out_qemu_st_direct (2024-01-23 13:32:10 +1000)

----------------------------------------------------------------
tcg/arm: Fix SIGILL in tcg_out_qemu_st_direct
tcg/s390x: Fix encoding of VRIc, VRSa, VRSc insns
tcg: Clean up error paths in alloc_code_gen_buffer_splitwx_memfd
linux-user/riscv: Adjust vdso signal frame cfa offsets
linux-user: Fixed cpu restore with pc 0 on SIGBUS

----------------------------------------------------------------
Joseph Burt (1):
      tcg/arm: Fix SIGILL in tcg_out_qemu_st_direct

Richard Henderson (2):
      tcg/s390x: Fix encoding of VRIc, VRSa, VRSc insns
      linux-user/riscv: Adjust vdso signal frame cfa offsets

Robbin Ehn (1):
      linux-user: Fixed cpu restore with pc 0 on SIGBUS

Samuel Tardieu (2):
      tcg: Remove unreachable code
      tcg: Make the cleanup-on-error path unique

Thomas Weißschuh (2):
      linux-user/elfload: test return value of getrlimit
      linux-user/elfload: check PR_GET_DUMPABLE before creating coredump

 linux-user/elfload.c        |  10 ++++++++--
 linux-user/signal.c         |   5 +++--
 tcg/region.c                |  10 ++++------
 tcg/arm/tcg-target.c.inc    |   3 +++
 tcg/s390x/tcg-target.c.inc  |   6 +++---
 linux-user/riscv/vdso-32.so | Bin 2900 -> 2980 bytes
 linux-user/riscv/vdso-64.so | Bin 3856 -> 3944 bytes
 linux-user/riscv/vdso.S     |   8 ++++----
 8 files changed, 25 insertions(+), 17 deletions(-)

