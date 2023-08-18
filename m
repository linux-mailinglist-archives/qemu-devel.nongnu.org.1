Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9167807DF
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 11:03:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWvNU-0006q2-PG; Fri, 18 Aug 2023 05:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qWvNN-0006pg-1z
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:02:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qWvNK-00078U-U0
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:02:36 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fe4a89e8c4so6710605e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 02:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1692349352; x=1692954152;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DAUhZSBJn3JLih4kQ23lXkAMrnHRWXshQwHFQUtfLS8=;
 b=hJFV/Ur/eFFMqGyhCXF3vT0QUDZjZlh4NNArxyWLKWP7GCM9kJMNW6EMFs4L0u2XM1
 OnWmOpNY8Yxi+3yQG2FUYqO5aqbAjVzMDRxl2SclToYM1GIGojplH8GCiJg4vS+QB1xP
 PuHWEFK//KCXQ6OMj9An43V+hlolmv0RqKso2pfqxZiSJBeTQDhF0+lObSRVVfw2RMO7
 h62hwcB58apas5kpt5dsfjnu6vkynzSXr3EkUKzbIS9XxdYxBkB0ynfuvx4RKCIIbWC1
 fIp6J6HHN7fyLaNzPkZBh2iQFYpQM1DX9Dme7vwA/bokrbJRg+Wft8Iu+0jyD88dJwin
 NLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692349352; x=1692954152;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DAUhZSBJn3JLih4kQ23lXkAMrnHRWXshQwHFQUtfLS8=;
 b=lZyhAQtZRlCDP14FAC6owJys9uMxzcv7hgskWy6ctqR6ysMK1R/+08im8aP4zmAhpg
 1yxFL/HxUsdWZ7RfF5HMXPbU2rKWybxnS+p0CafC4TSxVBJGllNt80Q0QX356eWeIJPQ
 En2i2GnpIFVl4p47edZquPmXu2A4kph01TtLokEy6nK4ffy1orh0RwScek22GDQRSQYQ
 vIQ2jqWxmdBe1Sulf4OtXIfedMDA9ZtaFQrpE4Gy6nWEuGFBQV0tvIACYQMXigrx2gPO
 pJa13pRLdq2a6QppGmny2KdCK7ZAbMhg2WqOobM3DmLObrK3mJEZ7295biXyp8xC48es
 FSpw==
X-Gm-Message-State: AOJu0YxQyxLpX0ejmSvU+UwFU79xrNJlcwL/4sy04JvmnIw5zbFBbx8Q
 tIBPEjyDtmR09rh44rExjQrxZiLM2zxTnjUjvxc=
X-Google-Smtp-Source: AGHT+IGj0XR7rTD7hiMpcv/9PO/YXjXcRD8OAhqUGDpuC+U/UpiFzy4hDJtebfjUmZiykRTXUGDWZw==
X-Received: by 2002:a5d:434a:0:b0:317:e5ec:8767 with SMTP id
 u10-20020a5d434a000000b00317e5ec8767mr1346988wrr.21.1692349352134; 
 Fri, 18 Aug 2023 02:02:32 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:44f6:7cae:4aa1:4fb7])
 by smtp.gmail.com with ESMTPSA id
 r5-20020adfe685000000b0030647449730sm2085745wrm.74.2023.08.18.02.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 02:02:31 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH 0/3] Risc-V/gdb: replace exit(0) with proper shutdown
Date: Fri, 18 Aug 2023 11:02:21 +0200
Message-Id: <20230818090224.409192-1-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32a.google.com
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

Clément Chigot (3):
  hw/misc/sifive_test.c: replace exit(0) with proper shutdown
  hw/char: riscv_htif: replace exit(0) with proper shutdown
  gdbstub: replace exit(0) with proper shutdown

 gdbstub/gdbstub.c     |  3 +--
 gdbstub/softmmu.c     | 11 +++++++++++
 gdbstub/user.c        |  2 ++
 hw/char/riscv_htif.c  | 12 +++++++++++-
 hw/misc/sifive_test.c |  4 +++-
 5 files changed, 28 insertions(+), 4 deletions(-)

-- 
2.25.1


