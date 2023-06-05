Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C269722482
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:25:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68JP-00076p-Hg; Mon, 05 Jun 2023 07:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q68JJ-00075w-I1; Mon, 05 Jun 2023 07:23:41 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q68JH-00065l-Q4; Mon, 05 Jun 2023 07:23:41 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-256422ad25dso1895861a91.0; 
 Mon, 05 Jun 2023 04:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685964217; x=1688556217;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dg7ZPL0roivSyiEPf2iIkZLzzksa+gj3tc/Gt9FD0Zs=;
 b=B7VB/7u4+fPocNIn83ZLJt8P5Jxw+eRdn3AD1BbrJ/1ObJk0k1tL0M1z4RMfyl5EAT
 3dndRuvXW5fbArJ17RVZTzmvhFQ4Logu7ljOEqWQ3zs4rqVKWDbOdyNXonpO1F7yloLh
 d1VOeo/2J5K8YhZZjzDxeSWWV12ZAzkolGkhHLsGlL/b2DDZhEIbnk/GWWO2aefqLL0w
 TnWdOK9w7hqgCMV2XOg395ptqimXTf/kbkYfTa2kI7L90gFBf85y6r39LE/iS9YYbVVe
 STAbdATHwnWBXKQm302M8+WO0jTpDZu2+XGDJUEdzHh0euN6vRaPlDGdx+A//u2rc5LR
 5Wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685964217; x=1688556217;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dg7ZPL0roivSyiEPf2iIkZLzzksa+gj3tc/Gt9FD0Zs=;
 b=HsTSgGF9Lsf3kUTz+EEKWPqkHVNX9hmJcYEmM2iM9WD+m2qrrW1ia5mZPkMTxmMB2Q
 j20Tlr9HIaf32GNceXtO6Wj931+No1kejD1nUDzlmOzpG5kMk+HjpA0Ur4oQXwirBPMQ
 8KUVnSj+A5F0GOFBLrTLz5RVmiCaQTfPw0U3DgMjo7OQblB8Xb2OxtVEnbH0rScQGayk
 WeeK5zLXfEhEbULQzMPHogPY/lXiiJG9eC7L9j4NyV+Ahra+CeOHgGnnckNREu/6jw3V
 Hy1INZSEOIWi19qUl5ysCGzhDIQZ1A/iA/NL09hzf+Dxw/M02EuIPfZ/1Tabl7jwaioc
 1N6g==
X-Gm-Message-State: AC+VfDx8UWcVxnP0bQX1Gf3hM/anHfI+gWXJqZBr+iAqXOVEZei3qv9Y
 Ns6ctFwxPBcdoS/WO792ZCSsJZWcC5E=
X-Google-Smtp-Source: ACHHUZ7GBihPOYtwMQaCvE5YrpRqzEORz0nWX7D/pCr2T4a1FlOp8dAdjKTLTdfAtS81A1iBEufrDQ==
X-Received: by 2002:a17:90a:cb95:b0:256:4207:5041 with SMTP id
 a21-20020a17090acb9500b0025642075041mr2937160pju.28.1685964217509; 
 Mon, 05 Jun 2023 04:23:37 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 f32-20020a17090a702300b0024e026444b6sm15953385pjk.2.2023.06.05.04.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 04:23:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 0/4] target/ppc: TCG SMT support for spapr
Date: Mon,  5 Jun 2023 21:23:19 +1000
Message-Id: <20230605112323.179259-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1034.google.com
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

Previous RFC here

https://lists.gnu.org/archive/html/qemu-ppc/2023-05/msg00453.html

This series drops patch 1 from the previous, which is more of
a standalone bugfix.

Also accounted for Cedric's comments, except a nicer way to
set cpu_index vs PIR/TIR SPRs, which is not quite trivial.

This limits support for SMT to POWER8 and newer. It is also
incompatible with nested-HV so that is checked for too.

Iterating CPUs to find siblings for now I kept because similar
loops exist in a few places, and it is not conceptually
difficult for SMT, just fiddly code to improve. For now it
should not be much performane concern.

I removed hypervisor msgsnd support from patch 3, which is not
required for spapr and added significantly to the patch.

For now nobody has objected to the way shared SPR access is
handled (serialised with TCG atomics support) so we'll keep
going with it.

Thanks,
Nick

Nicholas Piggin (4):
  target/ppc: Add initial flags and helpers for SMT support
  target/ppc: Add support for SMT CTRL register
  target/ppc: Add msgsndp and DPDES SMT support
  spapr: Allow up to 8 threads SMT on POWER8 and newer

 hw/ppc/ppc.c             |  6 ++++
 hw/ppc/spapr.c           | 16 +++++++---
 hw/ppc/spapr_caps.c      | 14 ++++++++
 hw/ppc/spapr_cpu_core.c  |  7 ++--
 include/hw/ppc/ppc.h     |  1 +
 target/ppc/cpu.h         |  9 ++++++
 target/ppc/cpu_init.c    |  5 +++
 target/ppc/excp_helper.c | 30 ++++++++++++++---
 target/ppc/gdbstub.c     |  2 +-
 target/ppc/helper.h      |  2 ++
 target/ppc/misc_helper.c | 69 ++++++++++++++++++++++++++++++++++++----
 target/ppc/translate.c   | 46 ++++++++++++++++++++++++++-
 12 files changed, 188 insertions(+), 19 deletions(-)

-- 
2.40.1


