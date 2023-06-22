Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B89739899
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFAl-0004Ci-7G; Thu, 22 Jun 2023 03:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAf-00040p-8c
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:01 -0400
Received: from mout.kundenserver.de ([212.227.126.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAY-0002sg-Dd
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:00 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M4K2r-1qByBa1BzN-000HiB; Thu, 22
 Jun 2023 09:55:51 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/24] q800: introduce mac-io container memory region
Date: Thu, 22 Jun 2023 09:55:30 +0200
Message-Id: <20230622075544.210899-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:svQwwDmFA38z6bbN+gxEuCW27U5/FS7UZcBHWj0U0nsVCctWy4N
 2mx+DVcX75TCsjvUZQ/gG7K1ZHscTYXv+4ezx+g8Mq62LWgtkUg7nqopnkHjR9NPQO9TFkR
 QpIrQvvqKmEO0BnktW6IdIhTQo7Fn+d16aJPknMoRFlba+6W/04KehqaJ8Fekxh4xBrCxzR
 gy+gyCFQhVP+D8mibuOTg==
UI-OutboundReport: notjunk:1;M01:P0:itwQze57olQ=;aX0shrmONI184ebTrUJnSDLQTWl
 eivwifzGTPo3zNW78b7nBy+G1e3DuHXrcUHUMdRPsqq2o2xv52Y5pEKF16LJ6zNqBmt2WB0Av
 BZy2CtRxTMEn1hDOllAhmTW2e4rybZ75sIU56jwB1k7Z7+Upa1sYvK+7Zi12Vf5vwVOJmPN7S
 aTFaJloW7LmvdppWG45BFmNzdHyy+ghGEqIpT2eqBNl1BVZv2vx1ey3mvY2dTRsnFSmnuorLD
 BR+sL6ZTX96ABzKO888+9qxQ9AXnvyCO/kUN+nXmQA8p5pL6qLX0wwwI1YeV/cYj8JIv9nUad
 shHt0ZZM40RPwd3oVsNcK0NnApI6/IgAedAim7PqAGBDZm1bJmInxHsgmNOzo3kA/CmQg4Qjt
 OkQ5nuMKzOoZu3YDKM3SV/MIapBJe28d2469WMFmwbNzTCcIvwkfSWz1iC4pbcq3RbHsT/gti
 AwsL2bN9jk0i64i1qdRqc32YT2gaYSkFEwo2RK4URwUwMyLXn5wumnJ9NZYrKGiFK8v6eVBfJ
 RHs+GUPC/f0WS02ml9RvqyukRV5Lg+kRHmlvSmPZCZR5lsuyLEkzWsRREVHtfxU7CCGnXl/Jo
 jShbLZwLTjQiiXtgnLDskbmFFZLeNm/JXQe6wRWig7blTTHaYSvGuyuAnrj9AqeBTNoyA1qNV
 Km1N1fACyUubKaBSGLdit9nNpblNnVMkf4XR58tcyg==
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Move all devices from the IO region to within the container in preparation
for updating the IO aliasing mechanism.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230621085353.113233-11-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h | 1 +
 hw/m68k/q800.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index fda42e0a1c30..17067dfad791 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -39,6 +39,7 @@ struct Q800MachineState {
     M68kCPU cpu;
     MemoryRegion rom;
     GLUEState glue;
+    MemoryRegion macio;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 505e50d4af2e..359bdf3443a6 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -177,6 +177,12 @@ static void q800_machine_init(MachineState *machine)
     /* RAM */
     memory_region_add_subregion(get_system_memory(), 0, machine->ram);
 
+    /*
+     * Create container for all IO devices
+     */
+    memory_region_init(&m->macio, OBJECT(machine), "mac-io", IO_SLICE);
+    memory_region_add_subregion(get_system_memory(), IO_BASE, &m->macio);
+
     /*
      * Memory from IO_BASE to IO_BASE + IO_SLICE is repeated
      * from IO_BASE + IO_SLICE to IO_BASE + IO_SIZE
-- 
2.40.1


