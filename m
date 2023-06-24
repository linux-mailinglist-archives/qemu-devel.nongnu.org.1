Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5907A73CA9D
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 13:30:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD1Sk-0003u2-BQ; Sat, 24 Jun 2023 07:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qD1SE-0003oh-Mo
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 07:29:22 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qD1SB-0001rn-Tw
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 07:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687606156; x=1688210956; i=deller@gmx.de;
 bh=w5mqTgg/nsYXwdX7asI6ELqjL4SR8QF4EGBFuuSstB8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=C/SHdsmqyQD488Z51m1/4VFdBkmR3pkdeRaARAP3Knl9O+KEeclNs2uJ/OTHyA2dpJVUcQV
 PRQ4tUJAoQW8dBWQ9za5Gmh5X0j5Ckgq9Dvgq+ZqcEHs21IyB5zqLD1mQ8w7JDpZpTbSVNcye
 ERXqMMdSBSqINeYWlbVzAFMvF4WARh0mol6V2OwG7t8+AkJ4aqhFYROOdMLleKpuO6/GzDvfT
 2CZ7hwRjpyxooaLEgbdHDNFgxSbW9tne27rjI2mZFbFEa8NH9s67lgs//JGX/VoCIWPoQFDMW
 UAr8YhyNhSHqHb3uVg0zJgCi56tZwH0ITGSoxSleDBZqXfvHQ0cg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.156.152]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpJq-1pd8P80s2k-00Zzn0; Sat, 24
 Jun 2023 13:29:16 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 1/3] target/hppa: Fix OS reboot issues
Date: Sat, 24 Jun 2023 13:29:13 +0200
Message-Id: <20230624112915.27033-2-deller@gmx.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230624112915.27033-1-deller@gmx.de>
References: <20230624112915.27033-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mE0zCeFA0UarYg35EtclAAbBV+krFujvtLLfwQDkLJuLnHZlv/4
 QsaXFEUEFG9mHYvsO623+0TuT82w89anz6mIcNx79lZzHm44CMiJmlpCzdfanuyxn5a70M3
 RBdcUUXfJzjV398+jFQEngfASOx66Wxso+fm2dF0GrgStfFp8pcum2HRcKsLAhuZcy76UTf
 V6j/G1ml1XP0s1fBMQPfg==
UI-OutboundReport: notjunk:1;M01:P0:xlGcGnOZkD4=;42/+3bIfV1IUoblyMqmp2kEdrCN
 F51Jy03xszfRZNxzy6/t7ybUXS5YiWUAaGlTp4O7iYNGuvkv74afVdeGFInVxbX157HhVwkeI
 tVeL3isJaqRL72O264xjb4lweBw1czqlt64xWwHnTyCbjI7taixMczqJpVjhCa0KRnyuWKnTv
 2aOLELh4xBDcvc7vVfC9pWaI7Qb94deX6O0pB/9LLLaqJiBMkpX+tRBo2SAoQRUuzHFD9dB4R
 zE8rAlxv7ICx95Qz67lWTAtqIY8rj2Hf1gjDEaE522FChEAx1IasIgH8in8bOx++bpXk2JHuy
 9/o5rFreIb4DQyqwN1IcQQutqnUvdJo+lXC4OJpwhw09gU/Q6fW+qeEBck3pOVc19Qm77wyqy
 Y9mf84hdTuKlyjCb++zNbE76v4efo600AfSVT6xqEsSxUqsh6dI7R0A2hEqalV5SpWvuQNARr
 zztqsp/8qFoRzP62KcksNeU09WqNdZcUv7eAWMOiR3RYcmAEjbQMcuHd8/Fb3GSH7J8ebexvJ
 fL4DZbUWGrNCwjvB5hLAMRW6HosR05LyBwQ1aDuYz1so6LaTTGij/b5MAslEnB4LVNwoOCGcM
 kJEv7mDTYD1KOGCpDQ4e/GXcnBBaCkmV7C47PLwYBq7Iai23gJiIf3m8qvWLG+/zxvADTJTX5
 9928426FkKy7BM1xAfPr9UyAa7uycFQ1b96SfCcwdd2sbvK80pLXZzQgpg51OT0dQpl/a2pfR
 amuG1+8umQb/gSwiIyck4mytSI+2BCCpOKrXkZuMezXzM6psJKoptKRKf2392llChkvzvRYi3
 7woeGIUeKdyfL5iyPAKDWG2u92GD5v43a8LKBOIjdZayQcHtwjTcTt5fUUYMuuxvv8B1Vo9uF
 6tW24oDNw9jUCNg4bgwsjE1JaMtjJHdOZdKjFV5Y3H6V3eSpwPbfs+v8WIatML8Ue8Jfye5+w
 gS1liqfAcuErf0bsOKjJeSKi8Aw=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When the OS triggers a reboot, the reset helper function sends a
qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET) together with an
EXCP_HLT exception to halt the CPUs.

So, at reboot when initializing the CPUs again, make sure to set all
instruction pointers to the firmware entry point, disable any interrupts,
disable data and instruction translations, enable PSW_Q bit  and tell qemu
to unhalt (halted=3D0) the CPUs again.

This fixes the various reboot issues which were seen when rebooting a
Linux VM, including the case where even the monarch CPU has been virtually
halted from the OS (e.g. via "chcpu -d 0" inside the Linux VM).

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/machine.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index b00a91ecfe..9facef7f14 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -418,10 +418,16 @@ static void hppa_machine_reset(MachineState *ms, Shu=
tdownCause reason)

     /* Start all CPUs at the firmware entry point.
      *  Monarch CPU will initialize firmware, secondary CPUs
-     *  will enter a small idle look and wait for rendevouz. */
+     *  will enter a small idle loop and wait for rendevouz. */
     for (i =3D 0; i < smp_cpus; i++) {
-        cpu_set_pc(CPU(cpu[i]), firmware_entry);
+        CPUState *cs =3D CPU(cpu[i]);
+
+        cpu_set_pc(cs, firmware_entry);
+        cpu[i]->env.psw =3D PSW_Q;
         cpu[i]->env.gr[5] =3D CPU_HPA + i * 0x1000;
+
+        cs->exception_index =3D -1;
+        cs->halted =3D 0;
     }

     /* already initialized by machine_hppa_init()? */
=2D-
2.38.1


