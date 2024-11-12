Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A42999C5A8B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Nov 2024 15:39:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAs2b-0001A0-Fe; Tue, 12 Nov 2024 09:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1tAs2X-00019C-F8; Tue, 12 Nov 2024 09:38:46 -0500
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1tAs2V-0000OF-Gl; Tue, 12 Nov 2024 09:38:45 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com CB68DE0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1731422314;
 bh=gROn1cEJ7NEAs7MLcq2gpRDzWtiIjqPpmcsTBUo98ds=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=z/gmvgoxGmwim7nI/Akf+uShAd4sZ8NHw70dJet1z/dlKehSu2LUR3WFJ3/QF2hbs
 +KHWEhe6rq9llT0Ols+YIRzS97B2/D7wlEkHPpQXtpGFpyTGIXMQPFGWGpne8UpGoL
 dQxmdas/SS3OUezvqQT/jIvl62fkPESC1aiUYyo4YSTBiMiAr42srba5tY6mOYwJGZ
 KUKEG12d1ODJlAEwE+Hvt/gzreUTLptkcmXCWaD7dYw6/yOcbbl0xhNZJ3E2BDZHEl
 8R2POObsm/g2+uIrMk/LavLK6wNwiTWkSNWd9GntKYPnU4yGOxXUWFefqNXbVpGl/j
 TnOwlQBK8f9Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1731422314;
 bh=gROn1cEJ7NEAs7MLcq2gpRDzWtiIjqPpmcsTBUo98ds=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=EzqFSO93OxHBC/6dyTGRnOPowNoDbFukmUdEPd8dxejt6AQ+T/kJw/GOeR9/PX3vf
 ibMTZvjv9GWVys5Wlknko5LiSM5ud5f5iALDkyiURLWCyMuQ3XzarE+NOWMpqy1S9A
 SgU35iOli1r+pIESIAJmfqfEQouxNhY0k3vp5xXHjPw9G4b6MllIhSV5utLLqR5qxg
 FZ7oAstC5iC0ISBtMKUhCWgQyv7AD23aTb5fY/8M4ehiC2QmdhdP6MwL8d1jA+RMuz
 zj/LW9DsGdGMAfHjA2qmdIMxzK9ARCm22QfG5HKQr97qcw3iFR+PlW5CZh1BGKQWK3
 cayWPCbIJTDSA==
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, <farosas@suse.de>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [RFC PATCH v6 0/2] Support RISC-V CSR read/write in Qtest environment
Date: Tue, 12 Nov 2024 17:38:24 +0300
Message-ID: <20241112143826.88130-1-ivan.klokov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.253;
 envelope-from=ivan.klokov@syntacore.com; helo=mta-03.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

These patches add functionality for unit testing RISC-V-specific registers.
The first patch adds a Qtest backend, and the second implements a simple test.

---
v6:
   - Refactor code and fix checkpatch errors.
---

Ivan Klokov (2):
  target/riscv: Add RISC-V CSR qtest support
  tests/qtest: QTest example for RISC-V CSR register

 hw/riscv/riscv_hart.c        | 55 +++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.c       | 27 +++++++++++++++++
 tests/qtest/libqtest.h       | 14 +++++++++
 tests/qtest/meson.build      |  2 +-
 tests/qtest/riscv-csr-test.c | 56 ++++++++++++++++++++++++++++++++++++
 5 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/riscv-csr-test.c

-- 
2.34.1


