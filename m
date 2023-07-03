Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3008F74609F
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:19:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGMF1-00049y-QQ; Mon, 03 Jul 2023 12:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qGMEt-00049f-Sc
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:17:29 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qGMEq-0002TL-Oz
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:17:23 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 17751C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1688401032; bh=XJ2pcR4ZiCVxAjNKvHdeTUYjxJU1n/ZoU/wgyGxAYLE=;
 h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:From;
 b=I5zy5ZH0hqAXS+QNExB3jfDjRrgKQFFGo41PD5dFguRu5YkxCHkE3uXjH1NqI7mhM
 LmuvypfOqrnfon/gkzxuyThYmDVMXyLXOqB4klfnjN9HHwlj3L0L/KWap/O4btbcpi
 Mbui7rKPWh+1JTnHcUFc81uw0tS9wt8droJ3AhDGyHCzH9A3+8y3+qPxVJdS1BSwpa
 HlseV12y4J7BuJRKmqVV0YB8H96PZV9YZyQsGsFkvOi9d2tvHv3O2gERQnDruqK+mM
 SKIdtNIVY74lP6xDd92iHsWmaYHZwuRVPtgPzTMUMdtWX6b1rxwVXyq2FAoOHJNhtN
 CW3Y7WyZmwAxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1688401032; bh=XJ2pcR4ZiCVxAjNKvHdeTUYjxJU1n/ZoU/wgyGxAYLE=;
 h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:From;
 b=AMKAygRE1uFY+/dse2AEqkWP9YjsKPn9YqBiarXUwlQ4Zkfg7YzG2G0mMsbtp+tda
 29mayfcPDNjhgw8Ema+z/KhxSowis6qjb2Go3qiQYNPzRa2jqe+fUn97WLKzgzszWL
 1Y+y/eq6oNOD/KY263/D88zoXIqpRiHFJPhHP6BX88sPxywPkrKVptCOKOKVh34HZZ
 OqWMFCv1SwlKRnQex/FcMTg03JqkAf9Ky36G/odFqets1ASeqgOQTmXq3FVI6xPXa8
 MN6f1jwftFfeG6cjJInXdWFMLKPPeR9laCICdbkmMHkg3ZUe68+mHxhcEIl/4Jqh77
 YetTCs7S0wa/g==
Message-ID: <ce64bf09-4d62-ee48-c1e1-dbd3641e023d@yadro.com>
Date: Mon, 3 Jul 2023 19:16:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From: Mikhail Tyutin <m.tyutin@yadro.com>
Subject: [PATCH] Fix SEGFAULT on getting physical address of MMIO region.
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Dmitriy Solovev <d.solovev@yadro.com>, <richard.henderson@linaro.org>,
 <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
Received-SPF: pass client-ip=89.207.88.248; envelope-from=m.tyutin@yadro.com;
 helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The fix is to clear TLB_INVALID_MASK bit in tlb_addr, as it happens in 
other places e.g. load_helper().

Signed-off-by: Dmitriy Solovev <d.solovev@yadro.com>
Signed-off-by: Mikhail Tyutin <m.tyutin@yadro.com>
---
  accel/tcg/cputlb.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5b51eff5a4..9045b6330a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1708,7 +1708,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, 
int mmu_idx,
      uintptr_t index = tlb_index(env, mmu_idx, addr);
      uint64_t tlb_addr = is_store ? tlb_addr_write(tlbe) : tlbe->addr_read;
  -    if (likely(tlb_hit(tlb_addr, addr))) {
+    if (likely(tlb_hit(tlb_addr & ~TLB_INVALID_MASK, addr))) {
          /* We must have an iotlb entry for MMIO */
          if (tlb_addr & TLB_MMIO) {
              CPUTLBEntryFull *full;
-- 
2.34.1


