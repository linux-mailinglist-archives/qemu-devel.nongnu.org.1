Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0575773B84E
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:57:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgLt-0000NS-QJ; Fri, 23 Jun 2023 08:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCgLq-0000Mi-QY; Fri, 23 Jun 2023 08:57:22 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCgLo-0006Jq-O1; Fri, 23 Jun 2023 08:57:22 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-666edfc50deso484693b3a.0; 
 Fri, 23 Jun 2023 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687525038; x=1690117038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Js42wtidVy3tPs6xOn56IPUa1nDZLb2Wa+qLrT9HjSw=;
 b=VfXo5xFhh4tjikb91mCJtgTA4halp+72cAMwZKEa74fy5Lv4qUjARh4LmC9j0DwbJJ
 +LqkJuq0ptyE/C/zhCiHu+pRnxsUPoOqPAtZDq3b7B/PCky9Gq2VFMT10BErEOPqBW6D
 B3me42F7VBbN9wAy7DwvdizzW85l+LP5l9bty9JWq4c8H+jpFm7nTHKEClvOFyRGyaOX
 zqL+7/QpQPQgUXmsbnAIx7fI1bvQwXEioFCC/dqj9ccf/FRFtM/a3vlm5lzw2tdTyYyx
 6f7XKoQF0bLAZpw4chhyZ9IdsqDgr0+/pJgSvDv41OtAmhp739omaNfGJmW/ZG18xKRo
 1/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687525038; x=1690117038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Js42wtidVy3tPs6xOn56IPUa1nDZLb2Wa+qLrT9HjSw=;
 b=J4a81vG4Pa1ArJZklrr+Ytv+fL1NM5kyR0Wd0yokLq8PfRIklM88MJaY6vXVArZ3Xl
 brNKpOXFDyGlPxWE46zGcSduP75z1m9Im/sfEw4xfmFO/C1CNONsJjThZH/ZzhiDpXKh
 JVUQe7+wN21Lhsfgq8YclmzV4O2ccXeRyM+q0nH3Sg8MYLAvNzV/E4p2wF/bibHLFkTM
 PTb5C3i5FjueczxV2ZE174bBZy6v/CRG5bdBk7jXjXbNJyXRNQINyh1FeOMWyhxdcphB
 cXSrVsqqmVkRn7vUdz+5v9YfXQlVIQe+A6aXX5Ik2hy64+aUpuX4NfxE0BQXTf8WZ24W
 Fr0A==
X-Gm-Message-State: AC+VfDznHJBLV+3eU3Faki42NP/M2I0FjXi9rrz6r+WBEFj+X9TjhhrC
 tTFFET7fvlpJ8uzu6BuOaNkn9UursPk=
X-Google-Smtp-Source: ACHHUZ6pEi50OSPRZ9Tu+ML3DnYJLLU6a4NaXg8l75dDkouLk0BDkAkJFg5PUIpivXogSbns42rH+Q==
X-Received: by 2002:a17:902:a38b:b0:1b6:92f0:b6f5 with SMTP id
 x11-20020a170902a38b00b001b692f0b6f5mr9902917pla.14.1687525038560; 
 Fri, 23 Jun 2023 05:57:18 -0700 (PDT)
Received: from wheely.local0.net (193-116-198-102.tpgi.com.au.
 [193.116.198.102]) by smtp.gmail.com with ESMTPSA id
 b12-20020a170902bd4c00b001a04d27ee92sm7141795plx.241.2023.06.23.05.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:57:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/7] ppc: fix larx migration, fix record-replay 
Date: Fri, 23 Jun 2023 22:57:00 +1000
Message-Id: <20230623125707.323517-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi, this is a bit of an RFC patch, I may need to send patches to
different trees to merge but they kind of go together.

The primary motivation is to fix migrating larx reservations,
previously discussed here:

https://lists.gnu.org/archive/html/qemu-ppc/2023-06/msg00452.html

It turns out a recent patch fixed it in a hacky way by chance, but the
fix is not compatible with rr debugging as Peter noted. Fortunately rr
debugging is broken on ppc, so we are done.

Can it be fixed nicely? Patch 1 tries that by migrating reservation
state when rr is in use. The rest of the patches is getting rr to
work. I've not go to trying to add a specific larx test case for it
yet, but it started to pass basic tests. There is one strangeness
explained in the final patch which I've not yet worked out though.

Comments welcome.

Thanks,
Nick

Nicholas Piggin (7):
  target/ppc: Fix CPU reservation migration for record-replay
  scripts/replay_dump.sh: Update to current rr record format
  spapr: Fix machine reset deadlock from replay-record
  spapr: Fix record-replay machine reset consuming too many events
  target/ppc: Fix timebase reset with record-replay
  tests/avocado: boot ppc64 pseries replay-record test to Linux VFS
    mount
  tests/avocado: ppc64 pseries reverse debugging test

 hw/ppc/ppc.c                       | 11 +++-
 hw/ppc/spapr.c                     | 32 +++++++++--
 include/hw/ppc/spapr.h             |  2 +
 scripts/replay-dump.py             | 89 ++++++++++++++++++++++++++++--
 target/ppc/compat.c                | 19 +++++++
 target/ppc/cpu.h                   |  3 +
 target/ppc/machine.c               | 26 ++++++++-
 target/ppc/translate.c             |  2 +
 tests/avocado/replay_kernel.py     |  3 +-
 tests/avocado/reverse_debugging.py | 28 +++++++++-
 10 files changed, 197 insertions(+), 18 deletions(-)

-- 
2.40.1


