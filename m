Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D280392CEBE
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jul 2024 12:01:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRU84-0003oT-L6; Wed, 10 Jul 2024 06:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sRU7q-0003dL-NZ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:00:40 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sRU7o-0007PI-4D
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:00:37 -0400
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 46AA0CQ0022356
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Wed, 10 Jul 2024 18:00:12 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from atctrx.andestech.com (10.0.15.190) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 18:00:12 +0800
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, Alvin Chang <alvinga@andestech.com>
Subject: [PATCH v2 0/2] RISC-V: Add preliminary textra trigger CSR functions
Date: Wed, 10 Jul 2024 18:00:08 +0800
Message-ID: <20240710100010.814934-1-alvinga@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.190]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 46AA0CQ0022356
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Alvin Chang <alvinga@andestech.com>
From:  Alvin Chang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

According to RISC-V Debug specification, the optional textra32 and textra64
trigger CSRs can be used to configure additional matching conditions for the
triggers.

This series support to write MHVALUE and MHSELECT fields into textra32 and
textra64 trigger CSRs. Besides, the additional matching condition between
textra.MHVALUE and mcontext CSR is also implemented.

Changes from v1:
- Log that mhselect only supports 0 or 4 for now
- Simplify writing of tdata3

Alvin Chang (2):
  target/riscv: Preliminary textra trigger CSR writting support
  target/riscv: Add textra matching condition for the triggers

 target/riscv/cpu_bits.h |  10 +++
 target/riscv/debug.c    | 138 ++++++++++++++++++++++++++++++++++++++--
 target/riscv/debug.h    |   3 +
 3 files changed, 144 insertions(+), 7 deletions(-)

-- 
2.34.1


