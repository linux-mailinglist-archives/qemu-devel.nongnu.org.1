Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5670D76BD6E
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 21:12:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQulm-0002Zp-6h; Tue, 01 Aug 2023 15:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qQula-0002UV-81; Tue, 01 Aug 2023 15:10:48 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qQulX-0002DI-O5; Tue, 01 Aug 2023 15:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690917037; x=1691521837; i=deller@gmx.de;
 bh=x2WCk90r3kqILwUNojPe8GNq/6l5cw5ovlA7R/f2IzU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HLG7KUrUOlX6EiLTny+/V2iKCPTxX6+xBNTs8pReTpdkkWOx9n/0p9tkTGOQN9lvNpXLrtd
 ZWx7+5cFbtNhpVheG0JPcH2YlX3v6qtwQkgLxG8BBBlALg9CuJoa3b1jLb2RO7DwPbaVLHSzf
 /kTwlD2x2Xjk6amOxV1gFclJnr9LKXl3lvprLv8SfoJLiZ6mx+yW50DPPnW4mH4eqJyn5bqKZ
 JqePzIxrWqKEXORcQ6bfZUleMqPmBgcwIpSDTnMpEQT8rik6i9TbMvXNz9vIwTduyiYyBtGiY
 XXR59nVTGz4Yo/TrLmdjBEyIaMD78gkW92Da/G+SkNw0qyc3Mmww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.150.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJhU-1q1n8y432y-00jEov; Tue, 01
 Aug 2023 21:10:37 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 1/2] linux-user: Fix openat() emulation to correctly detect
 accesses to /proc
Date: Tue,  1 Aug 2023 21:10:34 +0200
Message-ID: <20230801191035.374120-2-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801191035.374120-1-deller@gmx.de>
References: <20230801191035.374120-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t2Qxvy/8uIfWsppEqM5abCnaRoULrkykz2ZZeXCLGXfQJOOPBAP
 J27DaF0PPCWxDac6ygd3ozCHVLG5VyovwcyXD5SOyPxkXT9/KQedMBvsIr3666V1ljzzSP+
 UK4plnoZgiQGmOvv6amqPweeqYQBGnHxUpxLFd+/G9P3mu72AAM7Rt31tLwuFj0Ppq/FelH
 /aFyBLFlbACObr4uJw3/w==
UI-OutboundReport: notjunk:1;M01:P0:zBl5iumgsRU=;vRj4BaMYLi2Ah55QRXZv1dNAIYC
 MeDzHyAVn0i/6xLMETkxIbIPAKMEezsex/L9BnYGl9ALQvn6lxl968TFm0dHu3iyj0ZRsohk/
 Gk4VJr2D9+pRfPNAwj5IulZ2OJmm4pxVlr1EweSdF1DtPOdSfWfiK1vDprkt6bwMxFtV8qvel
 UFqHLU7keLrhW4tTFncKvb8q0DNqIbrzESDyUUM6xbP/xVYRuWZsaIoAkUxb+4V6g0N6bFeeP
 azonhVqN9oF0HUliOprdxvTGRRtl8D/9qVhmWTzpBwLwo501VYcsKiBvzgAUphsXJE6KMbDhx
 TMjvbmRUEDPpgt8/p1f2khIVLdZLyxI6HKzlQV3hWqiPQsJRRkuMWdM+Kp3G1sB4emj9JEyZK
 cUqTVpxuVycwhFv7/6XsnuyCgYjXxXL31ly5fyBTSqzxQX2iP7HQwGvqhBEpelbRyPoOBx+23
 eGFmC7M59id9B8TkIH+yLVYvhpk3TUMZGLSyl6r1dVpfBfWLhCjVCc77h+dLpQr6u4bHujCGb
 anZm6J8uoZjNY9EFg6mmoYdeTjqvBhLqS9dpaNB3nLnNC6rjBdnRdCqG5FBO1HIEe6y5K97U3
 2cxptu6zO6HLqrMUEbfeIhzC556AtdcbrPMz5Grj62LBCa/tOzCallnHRFXh1cDAVSr0dc8da
 if0chTETwORqRN2NB+1zb1Wgn85oxXYgE8E/xQsy6Qc46Ny5iLMeip78xqcDkPazcgfvQKW/q
 OVsDjozgab5gNbYqFJ9LNaCuGJ4CcQV6bJCEoZzHPaklNlL0GvujeDVikTgGZcbD+szZKQMi0
 PpovMEoA8yIJnrNq6YTQMpo78rfrvmzVoM2qJFr8zGwLUfTfKW1vE4DR/lNtr220BbT8nQWSi
 mi2DW3SNioPDXhGXcvSsM3gBcRnysZSd/VeIISyeEnAcg//bSbAHCJkBrRdO8kPElt/z4rTQF
 HedYIIlznfIkZqeuAMZeETt6x5k=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
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

In qemu we catch accesses to files like /proc/cpuinfo or /proc/net/route
and return to the guest contents which would be visible on a real system
(instead what the host would show).

This patch fixes a bug, where for example the accesses
    cat /proc////cpuinfo
or
    cd /proc && cat cpuinfo
will not be recognized by qemu and where qemu will wrongly show
the contents of the host's /proc/cpuinfo file.

Signed-off-by: Helge Deller <deller@gmx.de>

=2D-
v2:
- use g_autofree instead of pathname on stack
  Daniel P. Berrang=C3=A9 requested to not put buffers on stack.
  Using g_autofree keeps code much cleaner than using
  extended semantics of realpath(), unless I can use g_autofree
  on malloced area from realpath().
=2D--
 linux-user/syscall.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 95727a816a..a089463969 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8539,9 +8539,12 @@ static int open_hardware(CPUArchState *cpu_env, int=
 fd)
 }
 #endif

-int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathnam=
e,
+
+int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
                     int flags, mode_t mode, bool safe)
 {
+    g_autofree char *proc_name =3D g_new(char, PATH_MAX);
+    const char *pathname;
     struct fake_open {
         const char *filename;
         int (*fill)(CPUArchState *cpu_env, int fd);
@@ -8567,6 +8570,13 @@ int do_guest_openat(CPUArchState *cpu_env, int dirf=
d, const char *pathname,
         { NULL, NULL, NULL }
     };

+    /* if this is a file from /proc/ filesystem, expand full name */
+    if (realpath(fname, proc_name) && strncmp(proc_name, "/proc/", 6) =3D=
=3D 0) {
+        pathname =3D proc_name;
+    } else {
+        pathname =3D fname;
+    }
+
     if (is_proc_myself(pathname, "exe")) {
         if (safe) {
             return safe_openat(dirfd, exec_path, flags, mode);
=2D-
2.41.0


