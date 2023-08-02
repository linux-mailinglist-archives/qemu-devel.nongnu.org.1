Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E0776CDFD
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 15:10:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRBbB-0006Zl-3e; Wed, 02 Aug 2023 09:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qRBb6-0006ZT-T9
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 09:09:05 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qRBb4-0000fz-E5
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 09:09:04 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 03E50C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1690981735; bh=xPcbQgoR4FQvFF3PPLjN1g2SbYf4kSwQ5pp9Q/52uk4=;
 h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:From;
 b=DC+B1sbAo5PbFmhxh54ZQ4eBHbZ2qNZjjALVEmY4m3fsy/jv4+ZZUOUU7lcQAvN30
 gE3CWTwfklqoxKKj9x1UQAi9qGyyZLDbgsrAnjLh0RkYPgR7a0+IlbH2uCwDvVws6j
 /q7khZ1wK6j5+f7wlpzcyl6hUL3Qkz8j5CzWqZDy1L8pmAwzd5BmWQuUh/qL0Ip0mb
 3rZo0inPCRImqwLxZvZ+eQNa/LohVlru5Ax+u3Zjw4QoRZ+qs/uSvWTxS7CvnEDiTR
 /aIHEK0LcphDuQ1MWLpe+hqcnXeVpBC2FEYysoonEQj4OH+Ntw69fFbziMq4VlFVnD
 akWQDz/0lTCfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1690981735; bh=xPcbQgoR4FQvFF3PPLjN1g2SbYf4kSwQ5pp9Q/52uk4=;
 h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:From;
 b=mPf5UT0qwKv9QYxcDrvt4BTqhfpn8YYGH8EgutRCOic1WrASnYdNkuh3u8yEuuKhe
 a062qDNb/ruFkkWGXn79dtRnScBIKx1+Z0ecjoNVYg/OicgEynkydN0hnLlVoX21cs
 EAONIL+26hHNsvOKQ3DX6/oEnpK5uTndnJkLfGldbClZ1zrI8ZFasZU5ppqEDO3xEX
 l7FwWbOHRMIR7hd2xb5jVu9rmIhd3LqbxLZkQyUsUNiAL6GTRK42i1ZEh0LUAIS3YE
 y+PxX/Mhhuyu0iNk7UIg3l0099aUM0aNF8a1k9/syfYuAiwL2nZoIos3EUjTLmofJ6
 K63UavZWu17Nw==
Message-ID: <bf8ae2fd-158a-57b6-6270-2e56b6506421@yadro.com>
Date: Wed, 2 Aug 2023 16:08:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From: Mikhail Tyutin <m.tyutin@yadro.com>
Subject: [PATCH] Fix SEGFAULT on getting physical address of MMIO region.
Content-Language: ru
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: <d.solovev@yadro.com>, <richard.henderson@linaro.org>,
 <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
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

The fix is to clear TLB_INVALID_MASK bit in tlb_addr, as it happens in other places e.g. load_helper().

Signed-off-by: Dmitriy Solovev <d.solovev@yadro.com>
Signed-off-by: Mikhail Tyutin <m.tyutin@yadro.com>
---
  accel/tcg/cputlb.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ba44501a7c..900dfc1079 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1735,7 +1735,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
      uintptr_t index = tlb_index(env, mmu_idx, addr);
      uint64_t tlb_addr = is_store ? tlb_addr_write(tlbe) : tlbe->addr_read;
  
-    if (likely(tlb_hit(tlb_addr, addr))) {
+    if (likely(tlb_hit(tlb_addr & ~TLB_INVALID_MASK, addr))) {
          /* We must have an iotlb entry for MMIO */
          if (tlb_addr & TLB_MMIO) {
              CPUTLBEntryFull *full;
-- 
2.34.1


