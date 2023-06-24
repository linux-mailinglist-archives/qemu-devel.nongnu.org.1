Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8632D73CAA7
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 13:51:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD1mW-00010j-3q; Sat, 24 Jun 2023 07:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qD1mS-0000zh-P4
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 07:50:16 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qD1mM-0001AU-B4
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 07:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687607408; x=1688212208; i=deller@gmx.de;
 bh=w5mqTgg/nsYXwdX7asI6ELqjL4SR8QF4EGBFuuSstB8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=b5ZshgYFT0Ni3Xa3CbQskU+AzObq2XgoNQW4fdscR5SWDcPXU4cHl/f7RTtSCKpMqdJIQPn
 eLuzdWkA7AIA/K9KkvLOlAE5DzalRXL7Wdd/orDlo0wx/kr6syAzBTnju4sNMsyFgRTjcAgaz
 Lluzic06f6kefvygsp9WQxph6RGZXCGU53r2olBJrN3bFrhwyFDdKc4uN+Jw7DGrb7l3uuVe+
 YpL3F6QRv7Y7K0FUHkWCEsFQGMgHAf4EyFYU+kgz6/2wV+to8bM1swNCQSHiLLwXlK/0Tvqb0
 PMait1MD+9cw/Ki46FgQ4mHVm5hdcKEpzLoAz7kfbgWRbwFlG91A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.156.152]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6v3-1pk1sJ0AR9-00pfDP; Sat, 24
 Jun 2023 13:50:08 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL v2 1/3] target/hppa: Fix OS reboot issues
Date: Sat, 24 Jun 2023 13:50:05 +0200
Message-Id: <20230624115007.30332-2-deller@gmx.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230624115007.30332-1-deller@gmx.de>
References: <20230624115007.30332-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:izbWVq1+HgDfvahTZPCsY+RJ/JRm46Zuk+gqMTjxkAiAw4Z3CY+
 q+BrmezfA7ZNL/OhiqNP+iVf2SqhTY0mZ86atoaJ+Hg+B4P8tjw9kzezg6K5Tvl2dgH+1Xz
 8wEoWF91JMTgQa/B8awF6VJ8pn2TvPXNtOV5hxi2RquKYjp9/z3zJxZfTjLme/FVXCO5M3b
 HRXX6ZCCUzv2X2uQYejtA==
UI-OutboundReport: notjunk:1;M01:P0:YlUoHTy5LQI=;1xEWScq01a19lPkpJXr/jSJoQ2k
 rSbEH4S41GApiPAN9MeUHX+i8P6dqUyYW5zKqtyxrGV1KccpR8HjbNhGt8tjeiMNYLQQOOTgf
 sBT6NHIkIu9zZVrGqXZd5kvid3v+xF+2nq8ZNoteJbrFHK5E/lclCmnQ+PLOu157aeCUG+I3x
 ePNjfYAqnPwTxSoq4A5h6vsmVh71oM/xL7hIbacSstl8v9u8jMSOrQHpeV3Fd83LyJXLqG2YJ
 G/CwK0JWP2vjTBUdPHL8zDun4eqjhPW6LmioOdPmSSYOa8VbSdLSaUB3JkNI5WTHMP5H2hNed
 PJIXwordUKYw3LSHnIEzSJUl7byLjsYXfDqpcjszTEHEsJGtJcAWSxsl78YBUp0lsvmeDVoyg
 75arQvl3O8IXItiSwkV9vLey+YHfiO1JSrWqmxfxXM78pi+ofPbsn7ohxvpsBe+blpkbr6VYW
 DmMU3icYIbPSiX0znF66QXsxduoKkXSExN4N14sw75tHLgSjcnvRSU5KIapUgBZTbGEMrhKQw
 R8f2Di1M3mGwibhYQ2UTx4A05i+peZzqnCSzEYrcOdjXo04KXpe0P7rBMUZ1AAsnUuU2S1uc5
 /x+uaJZusnoC4lwc74e9hKLzhFdlBqlH/ubo7HwQ0X66JQVP/FPAwWptWSuDH9RXEnE/mVUF9
 t/QRksnggxy3ojiFJep4Fk10hktMrnSX+KfSCyaSDTkFyilUQfPVl1tejlVjAPUjqF6qSGLgh
 2iXkBoVL5EIG81CvdTjP3AfsNVDdIvzB8d8B1E/0rl+auiRMmq4QIhPoU5DthRduVK93jVH4r
 sLVIo375yVcaIwdmrRmcMfrBibeDogd7PwMrqBB/aQSsGlXqOnze7H64LOJSaabqMeycLFPSD
 7W0uLfpB1MmfbTvEe6AwcgD59hcQALmNIiSbpqJejMlthdghUtnU95aYpOg/sgtTmpK9B3IjD
 Pq2QnZY5YySJ6m48HQEQPZ2tw/0=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
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


