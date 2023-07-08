Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD4374BCFA
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 11:13:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI3yY-0006Cw-Qt; Sat, 08 Jul 2023 05:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <reaperlu@hust.edu.cn>)
 id 1qI3yT-0006Bt-3x; Sat, 08 Jul 2023 05:11:29 -0400
Received: from [202.114.0.240] (helo=hust.edu.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <reaperlu@hust.edu.cn>)
 id 1qI3yQ-0007jr-Oc; Sat, 08 Jul 2023 05:11:28 -0400
Received: from localhost.localdomain ([10.12.190.169])
 (user=reaperlu@hust.edu.cn mech=LOGIN bits=0)
 by mx1.hust.edu.cn  with ESMTP id 3689B3bo008217-3689B3bp008217
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 8 Jul 2023 17:11:15 +0800
From: Ruibo Lu <reaperlu@hust.edu.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, luruibo2000@163.com, alistair.francis@wdc.com,
 liweiwei@iscas.ac.cn
Subject: [PATCH v3 0/2] target/riscv: improve code accuracy and
Date: Sat,  8 Jul 2023 17:10:52 +0800
Message-ID: <20230708091055.38505-1-reaperlu@hust.edu.cn>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: reaperlu@hust.edu.cn
X-Host-Lookup-Failed: Reverse DNS lookup failed for 202.114.0.240 (deferred)
Received-SPF: pass client-ip=202.114.0.240; envelope-from=reaperlu@hust.edu.cn;
 helo=hust.edu.cn
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

I'm so sorry. As a newcomer, I'm not familiar with the patch mechanism. I mistakenly added the reviewer's "Reviewed-by" line into the wrong commit, So I have resent this patchset


Changes in v3:
* fix the allignment of pmp_is_in_range parameter line

Changes in v2:
* change the initial values of sa_in and ea_in to false
* change the condition expression when address area fully in range

Ruibo Lu (2):
  target/riscv: Remove redundant check in pmp_is_locked
  target/riscv: Optimize ambiguous local variable in pmp_hart_has_privs

 target/riscv/pmp.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

-- 
2.41.0


