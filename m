Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C25597BF4E8
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:54:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7Y0-0004Zi-QY; Tue, 10 Oct 2023 03:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7Xw-0004Us-83; Tue, 10 Oct 2023 03:52:52 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7Xu-0005FR-GH; Tue, 10 Oct 2023 03:52:51 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-690f7bf73ddso3641875b3a.2; 
 Tue, 10 Oct 2023 00:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696924368; x=1697529168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=roiz7qd4xg9b3Dt4lev8OwLhxv+44QA0qcR8ZsTk0kg=;
 b=AeVg++xf02rARwMCaPY89pn5kWw7MiMKltAZwiMvV3xFU7xPiySoNZykbq3qOIPpYh
 qgXWT444eN9LxFLOKJ55clNIWgKTPf0pRQUiNdNULcX7Fqq2jHVoCWQYnQkj33hPAaC1
 FuCnFakauFNlEOA68tgu+VaE19I/MO9xuxV0YEaOYlUsntji1rzww9dUbcVsFpbs8RNz
 ZVXiUOlSl44h+Uq2kjIy27dl/B/yey42aP5HozctRNKje3ewpE9hod5MbCZ9YgrMi/lK
 LJ/HyW8o13maF5IVRf4/2Upx2eiQFGAOD+8SFd6OcCqwMyeKlIqKaXcRm6a6fsvxMKtU
 HuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924368; x=1697529168;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=roiz7qd4xg9b3Dt4lev8OwLhxv+44QA0qcR8ZsTk0kg=;
 b=gYb0fXqbGTWpZdC+VMekhIs8t6CRtF8Nfeyx7Za4LTEpuVBpm5YA0KJ3UFb2XH1+xU
 HSMB03bqzZa8KKZP9x7Dv8GYRhK7FXpSwqUrQhxKowPDAs+RJW7SJkCOEfnzQxeCWGtE
 bPzadHDwQ7Fk/n/n11wFZwQ4eq/FEVUmqu3+M1fPkfAP71z9zVU9fuH/4UmZNkKCsfQx
 /Eee03fHn/k026VNWlNAwCnOgjlUuYGxmyq1UFqcAGGUCPbfeB8xr+eq+AJkd5dSXrFw
 cWMCDamVhGdqJco2utEs+Gn233dAdCVttbnI94kKI5VfRTMT3bEVSB4rMpvH4Biohe95
 DKIQ==
X-Gm-Message-State: AOJu0Yxnurk7+rqDLmG7KQ5e65171rUhpcNzgfhHd6yX2DbmP4/tZvTW
 /F6MeDeCekRNMN//qN0XyGT1oPzZBRw=
X-Google-Smtp-Source: AGHT+IFKR1QifVOztIOFwRLUSfdIyAAjf4Z0Op5L96WFRxYdv/23asvxFFkfvW6BP7Mz1E02PPaMIQ==
X-Received: by 2002:a05:6a20:12d6:b0:13d:a903:88e6 with SMTP id
 v22-20020a056a2012d600b0013da90388e6mr18402510pzg.48.1696924367881; 
 Tue, 10 Oct 2023 00:52:47 -0700 (PDT)
Received: from wheely.local0.net (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a62e215000000b0069353ac3d3esm7548102pfi.38.2023.10.10.00.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 00:52:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 00/11] ppc: avocado test additions and new defaults
Date: Tue, 10 Oct 2023 17:52:27 +1000
Message-ID: <20231010075238.95646-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Sorry for going missing for a while, had a few things on but have
been working on figuring out testing and git setup to get some
things merged.

To start with I'd like to add a few more tests. Since most of my
own tests for missing bits (like KVM backend) are mostly just
ad hoc scripts, I thought adding them to avocado is a better idea.
Comments on those in particular from CI gurus would be welcome,

patch 4, because it boots a Alpine distro image and installs a
QEMU package via its package manager.

patch 5, because it grabs some Linux kernel images I put up on
another gitlab page.

patch 6, because it adds a FreeBSD boot test.

patch 7/8, because they add tests for non-public images (flames
welcome).

Thanks,
Nick

Nicholas Piggin (11):
  tests/avocado: ppc add powernv10 boot_linux_console test
  tests/avocado: Add ppc pseries and powernv Hash MMU tests
  tests/avocado: Add pseries KVM boot_linux test
  tests/avocado: ppc add hypervisor tests
  testing/avocado: ppc add new BookE boot_linux_console.py tests
  tests/avocado: Add FreeBSD distro boot tests for ppc
  tests/avocado: Add ppc boot tests for non-free AIX images
  tests/avocado: Add ppc MacOS tests
  tests/avocado: Use default CPU for pseries machine
  ppc/spapr: change pseries machine default to POWER10 CPU
  ppc/pnv: Change powernv default to powernv10

 hw/ppc/pnv.c                        |   4 +-
 hw/ppc/spapr.c                      |   2 +-
 tests/avocado/boot_freebsd.py       | 109 ++++++++++++++++++
 tests/avocado/boot_linux.py         |   9 ++
 tests/avocado/boot_linux_console.py |  61 ++++++++++
 tests/avocado/migration.py          |   1 -
 tests/avocado/ppc/macos9.ppm        | Bin 0 -> 921615 bytes
 tests/avocado/ppc_aix.py            |  63 ++++++++++
 tests/avocado/ppc_hv_tests.py       | 173 ++++++++++++++++++++++++++++
 tests/avocado/ppc_macos.py          |  90 +++++++++++++++
 tests/avocado/ppc_powernv.py        |  21 +++-
 tests/avocado/ppc_pseries.py        |  20 +++-
 12 files changed, 543 insertions(+), 10 deletions(-)
 create mode 100644 tests/avocado/boot_freebsd.py
 create mode 100644 tests/avocado/ppc/macos9.ppm
 create mode 100644 tests/avocado/ppc_aix.py
 create mode 100644 tests/avocado/ppc_hv_tests.py
 create mode 100644 tests/avocado/ppc_macos.py

-- 
2.42.0


