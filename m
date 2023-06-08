Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 685FC7285AA
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 18:46:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Ilk-0006Z0-P7; Thu, 08 Jun 2023 12:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q7Ili-0006YL-3R
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:45:50 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q7Ilg-0004zF-ES
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:45:49 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6b162fa87d8so461808a34.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1686242747; x=1688834747;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dbyg+3rLiafmftEC2QBZoCf8N+IfPj0zZvJkRSWlBzk=;
 b=QzxKym2bES8nRKZZGOZhG/1+WPXrSSnwzcNm9jORewQSed4Azfys4f2l8CxhFfIYsN
 3aM9V9lCQup5/5QpvCWoCMXChM0RLNr02iRge1DdpteGCW2ldetmI+OR5j2hrmrFnyGN
 SKSDei0onwHIrR2xmT3aWSKe/ddc2T/7FilfYTLDyWIkj2l0Nm4ei/Tbg5zAxbYpexpx
 5njpAxYU/700DwqA3OjHI3+oSk3yXSl98DRgtmmmyDvloEygdt/vt0ttkdGVuJNCjLmd
 w9Hef+e5V0I5v+mHO7cZywm1FBD9Bb0YF7XR9cvtDDfsPVvDW2mF5dbhF5AqWiiT67w5
 WQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686242747; x=1688834747;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dbyg+3rLiafmftEC2QBZoCf8N+IfPj0zZvJkRSWlBzk=;
 b=SQCBmxXNrNjGJpcy6CnbFIPeud9rZnR8tiquttQ+1UXuDBKQSzBOfJw6u633ACxCuZ
 lmGWiohZ4MNcVmgu2GRSlxzSCFgMVnFnN86qMP3GA8qv8Gi9RxRtYFcH6dKFrK+Dpewp
 jMkmX64fOGABCSU7xOcKVJ4aVUH48cZl7UirT2g+NbLPKYNw+PnT+FepoyfjNmRXK/5t
 9EScq3tVuTj2AXwAUqr5x/xITnrmtEujE9WK8rhjyCzyY+e2VCjWRjW5tSKSqrO2U2Bm
 b/vXiapRyDAaXk90ClnyK4c7FYJuxKMVrCPHl8Wwh2afDsrLrKTeku4YjXot1lYiYqYu
 MJYQ==
X-Gm-Message-State: AC+VfDyx/UML7IB8Mhxo/0UYE2cSlK62EIGAZ6CTeoPPRESpDaaPF2wd
 5j0G+u/bYoT4OVS6m3A2Kw24njcnKMsfI5uOeLViA1kv5hMIBhNpT3iPkTyhVU1PUvqfXxQvE8z
 T15jcVyEkgSteEXQvtOalZJxX7ni/mTc/D88i/YtJCoK/7UTAKdHFd8vOWsqp8SfJDssnhz7GvP
 U0
X-Google-Smtp-Source: ACHHUZ7CcT58ehiIeJQXhEoD/6Avraa51wgketaook68ALorFQuTJmVZ54unAGf2otXvQS0MvOzyCA==
X-Received: by 2002:a05:6870:d892:b0:1a3:5f63:b4b3 with SMTP id
 dv18-20020a056870d89200b001a35f63b4b3mr2302677oab.56.1686242746609; 
 Thu, 08 Jun 2023 09:45:46 -0700 (PDT)
Received: from sw05.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a4adb8c000000b0054574f35b8esm9107oou.41.2023.06.08.09.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 09:45:46 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, bin.meng@windriver.com,
 jim.shu@sifive.com, frank.chang@sifive.com, liweiwei@iscas.ac.cn,
 philmd@linaro.org, Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH v5 0/3] Implement the watchdog timer of HiFive 1 rev b.
Date: Thu,  8 Jun 2023 09:45:39 -0700
Message-Id: <20230608164542.3675619-1-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=tommy.wu@sifive.com; helo=mail-ot1-x334.google.com
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

The HiFive 1 rev b includes a watchdog module based on a 32-bit
counter. The watchdog timer is in the always-on domain device of
HiFive 1 rev b, so this patch added the AON device to the sifive_e
machine. This patch only implemented the functionality of the
watchdog timer, not all the functionality of the AON device.

You can test the patchset by the QTest tests/qtest/sifive-e-aon-watchdog-test.c

Changes since v1 ( Thank Alistair for the feedback ):
- Use the register field macro.
- Delete the public create function. The board creates the aon device itself.
- Keep all variable declarations at the top of the code block.

Changes since v2 ( Thank Alistair for the feedback ):
- Delete the declaration and definition of the create function.

Changes since v3 ( Thank Alistair and Thomas for the feedback ):
- Use `device_class_set_props()` for the properties in sifive_e_aon device.
- Add SPDX identifier in QTEST.
- Use libqtest.h in QTEST.
- Let the statements on one line as long as they still fit into 80 columns.

Changes since v4 ( Thank Phil for the feedback ):
- Improve code style consistency.
- Move the timer create function to the sifive_e_aon_init.
- Allocate the sifive_e_aon device state in the SoC.

Tommy Wu (3):
  hw/misc: sifive_e_aon: Support the watchdog timer of HiFive 1 rev b.
  hw/riscv: sifive_e: Support the watchdog timer of HiFive 1 rev b.
  tests/qtest: sifive-e-aon-watchdog-test.c: Add QTest of watchdog of
    sifive_e

 hw/misc/Kconfig                          |   3 +
 hw/misc/meson.build                      |   1 +
 hw/misc/sifive_e_aon.c                   | 319 ++++++++++++++++
 hw/riscv/Kconfig                         |   1 +
 hw/riscv/sifive_e.c                      |  17 +-
 include/hw/misc/sifive_e_aon.h           |  60 +++
 include/hw/riscv/sifive_e.h              |   9 +-
 tests/qtest/meson.build                  |   3 +
 tests/qtest/sifive-e-aon-watchdog-test.c | 450 +++++++++++++++++++++++
 9 files changed, 858 insertions(+), 5 deletions(-)
 create mode 100644 hw/misc/sifive_e_aon.c
 create mode 100644 include/hw/misc/sifive_e_aon.h
 create mode 100644 tests/qtest/sifive-e-aon-watchdog-test.c

-- 
2.27.0


