Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7FA785125
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 09:07:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYhxB-0006V9-1l; Wed, 23 Aug 2023 03:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qYhx9-0006Ua-80
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 03:06:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qYhx7-000429-Mm
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 03:06:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe24dd8898so49928335e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 00:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1692774411; x=1693379211;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UIydMWSHseXTCz2TrjbmNN3Ck1DmgBCrrMfXrisST0w=;
 b=Qqy3lnppabwSLusr9KnXBXLJhoElYH1R7okIxbhzy+r8KTm7meClFFaIk+MNvaf+4S
 mAfJGYLireq6n/gAcczIcukw4EBfWJvoVdm0QSICvBinW9XvcpM09+Xc7sZ0DvVgXCRS
 fw4AdYZ1JPbBxOlT7bgPtBWo9LVkpmQfyixcrKAjb7nVQ0vgMNVXWYG1LAJxOTLOfNHK
 wer7Ka7HvccC41yJ4yaq+b70qJdtVsNmDuj+P0iEYRYXZGvY/L4D0QNfOS4LtVfi/qTk
 MWAbvUvbamdZO+b/TiHAYfNE922+kB6eWR8Zn41p7eVh5sEzXeByxHRBhLodnuE7gR1t
 qW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692774411; x=1693379211;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UIydMWSHseXTCz2TrjbmNN3Ck1DmgBCrrMfXrisST0w=;
 b=bdBaZgts11armbC6jiCXGGZ+vYlyyYy4Lumf5on1ajAd9gLM+KSF6SoYRuRU4djqJw
 adDYf1QmPPomcUJMEK8jCZY71x63jlP9HoY2M+0AyXGs9pWdRh7BmBkxNHwE2rZUVLP2
 W1wOlusg/FoF3vLmfUESxy2f0kQOdxXiv+cUhEbtPmJeZ1Ra7PTQ8Ud4Nihc6Jwp3SLB
 WWnRO6pZjF0pSoJH1TEg68fCny1dzB3VbZiNjKNNMPpM4FOy5kocx06lfqF7emFRjzN9
 NPHUyyyVJ8//hRKglfbSl9rSnIU1OiumrszD8IhcGwFe//G/Cj12VyGyzjj20jwjIno8
 vWow==
X-Gm-Message-State: AOJu0YwJGbqaJa6v99ttivKcmDPFzpytM54kIvaRcxEuh74ADfxfFh+X
 eFzqpmY/ZvAeSooqNhoOjrrDnW0B/EQqOKx7a/Q=
X-Google-Smtp-Source: AGHT+IFiGMICCVWXHr9+vIqzf7gYAS9quRU2Kbg/i7XqYjrPRjCa4Se2oN6ad20fLDSjAx94mUmMfQ==
X-Received: by 2002:a7b:c414:0:b0:3fb:dff2:9f17 with SMTP id
 k20-20020a7bc414000000b003fbdff29f17mr9474417wmi.15.1692774411142; 
 Wed, 23 Aug 2023 00:06:51 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:d434:6b1d:751:97d0])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c294500b003fc06169ab3sm21176358wmd.20.2023.08.23.00.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 00:06:50 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v2 0/3] Risc-V/gdb: replace exit(0) with proper shutdown
Date: Wed, 23 Aug 2023 09:06:36 +0200
Message-Id: <20230823070636.362957-1-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This serie replaces some of the call to exit(0) in hardware used by
Risc-V boards or made when gdb is requested to exit.
Otherwise, the gdb connection can be too abruptly disconnected resulting
in the last gdb packet "Wxx" being not sent.

As qemu_system_shutdown_request doesn't allow to pass the exit code,
only perform the above modification on a sucessful exit.

Difference with v1:
 - avoid sending a shutdown request in gdb_exit if one has already been
   set.

Clément Chigot (3):
  hw/misc/sifive_test.c: replace exit(0) with proper shutdown
  hw/char: riscv_htif: replace exit(0) with proper shutdown
  gdbstub: replace exit(0) with proper shutdown

 gdbstub/gdbstub.c     |  3 +--
 gdbstub/softmmu.c     | 13 +++++++++++++
 gdbstub/user.c        |  2 ++
 hw/char/riscv_htif.c  | 12 +++++++++++-
 hw/misc/sifive_test.c |  4 +++-
 5 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.25.1


