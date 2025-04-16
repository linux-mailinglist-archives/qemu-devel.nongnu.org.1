Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCF4A8AF6B
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Apr 2025 06:58:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4upw-0008Jm-Ff; Wed, 16 Apr 2025 00:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1u4upu-0008HV-1P; Wed, 16 Apr 2025 00:57:22 -0400
Received: from out28-125.mail.aliyun.com ([115.124.28.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1u4upq-0008CB-Hz; Wed, 16 Apr 2025 00:57:21 -0400
Received: from TC-DZ-03-0020.tc.local(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.cNtMeik_1744779426 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 16 Apr 2025 12:57:09 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: palmer@dabbelt.com,
	alistair23@gmail.com
Cc: zhiwei_liu@linux.alibaba.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, zhangtj@tecorigin.com,
 zqz00548@tecorigin.com, lc00631@tecorigin.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 0/1] fix the way riscv_plic_hart_config_string() gets the
 CPUState
Date: Wed, 16 Apr 2025 12:53:57 +0800
Message-ID: <cover.1744776027.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.47.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.125;
 envelope-from=lc00631@tecorigin.com; helo=out28-125.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi, all:

I made the following changes in version 2 of the patch:

Regarding the plic initialization phase to get CPUState by traversing
qemu_get_cpu(), this is an early design flaw, a better approach would be to use
riscv's hartid for indexing via the interface cpu_by_arch_id().

PATCH v1: 
https://lore.kernel.org/qemu-riscv/416e68f4-bf12-4218-ae2d-0246cc8ea8ec@linaro.org/T/#u

--
Regards,
Chao


Chao Liu (1):
  hw/riscv: fix PLIC hart topology configuration string when not getting
    CPUState correctly

 hw/intc/sifive_plic.c      | 2 +-
 hw/riscv/boot.c            | 4 ++--
 hw/riscv/microchip_pfsoc.c | 2 +-
 hw/riscv/sifive_u.c        | 5 +++--
 hw/riscv/virt.c            | 2 +-
 include/hw/riscv/boot.h    | 2 +-
 6 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.48.1


