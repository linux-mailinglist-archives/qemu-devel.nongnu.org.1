Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DE376C0AD
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 01:10:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQyU6-0007KO-A3; Tue, 01 Aug 2023 19:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qQyU4-0007FC-My; Tue, 01 Aug 2023 19:08:56 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qQyU3-0004eL-0O; Tue, 01 Aug 2023 19:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690931324; x=1691536124; i=deller@gmx.de;
 bh=xwz6aMde3YBdcmDS3z738t66mXpAPMuyqhPYVzFaalo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cFfux6IdstsTRooKiUchoRQhgOxoCkji0CymdRW57dkgTU+T3ov587uVmkHxcL4NqCEH8N2
 WE/u6UsOJl4pTWjwDw1QpS3mnWgrMXTJKKtdkLCznEv3aSV+1PN+XkWiE/4087wuAa3Alp/sG
 uvoCqDwXr6SsrS7rFOZlFOe9VrYDCdXaZ0oxlEzB1yH+9Fe3spC8KTjl0KZc5E1YIrYumgwI9
 Wg1Y56HUb++6ATSGdQBoXj2hunBRYp1y7XKpPHtzCCe2wE4grWuAqAoW2uy6ruzmrjSaMnf7g
 s/pnlVJdJ9I8HAJLIBVD9cf04pObLuZ4IV6Ng2dqfkxitoWhI7aQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.150.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUnK-1paf4o2o8Q-00rXn2; Wed, 02
 Aug 2023 01:08:44 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v2 1/3] linux-user: Fix openat() emulation to correctly detect
 accesses to /proc
Date: Wed,  2 Aug 2023 01:08:40 +0200
Message-ID: <20230801230842.414421-2-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801230842.414421-1-deller@gmx.de>
References: <20230801230842.414421-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tl2lG5EEICYtpWPx52BODKo1D8Zt1ezxWfqBQQNp5EmWajBCH7V
 IXB+Heam/vRRSXKvfe73CE9j9vj6IWAt6Eb1ap4fC43Zc6SToZpL/J36ikzQMFnTjIog2tC
 g+dyDXfnYOxFnmWw6GxEhXqaj+YfgC8zQQROqZtN1ZmDuMzvmD88JmUrQiJgWINW9oDe1gO
 /k+pzNvX7F85KlSxoxl6A==
UI-OutboundReport: notjunk:1;M01:P0:32g3wDeELXg=;iIiO4tkyMzdKB5slio/2FwK/sAG
 BnV/iMjgE4zRYod4eBkMz34dTZ+dwYCYh/jWBmEEC8J0osp0/eIQH10L4ADMCx1NW0AK/ohxE
 N7hpmyNhL62Eb2GJqU7CRFYLrSguiYC+0cq52hlFpIv4pgmrM8BWD12raApcUDkhcz3eEEDil
 9NxFsPg3sexJalejTbdHbUa+8tDOsH0XWTtg9WKVUnm1hfskOCwSv+Ev/qVedJmOBQau0pGZM
 z3MkydDwC3+nxUTxissP+xrqG5x0paKy/nBTnadYoixCm4THjqA2s/ylN7peMSSwHwumppvyD
 PKDtIVE91J1hfcWQwOnwbLCq2wdgX6IJTAOMTXUkRAcyJ9mM/hZUFL7bTBnNrLWpLkbHG2+6+
 X4AQRKI2eUhNvUSvI2roeT1DHrWkn4SusJ39etFTy+bAKgCbrAWkKBX7LuZjBEe+IMkqNVQUW
 DCxE4SumjD7YhQS2Htg7PYPV4jnYMpeY5phcbQsRgIIfq0OFEYDxqtuE0AONZDS3l48XdI5Xb
 GDFsCYtVPmtLztrFR/hNmcpjbL58h1Oag/OTRi7qA+5yWyLuXGK057oZgw/yA2Z29QYeXa3Ch
 7V3BnlUFzDAN4B8z98nvNfbtIOGzQ+PnIdlMpC9r1rZWWVhngtXAoFK4rntEhBQDJoIQdJaan
 HGDtr3hFlTHkSlcTjJrNTsdAsNEJVmjM/fd0mMkNgO8mE1e3lJlOFH5/F0HBz5uJPg9saV/Z7
 8R6JxkTbIWXZJtPUqu1f85qIAogmW2xmq9DRAf8hH3w3AF19IzPRs1LKiQstEhurOJAQgHB8q
 WKod2N79BvxYfINMwsH+EaBelf2vDPR3NsCHSiDtcwwp2R4jwOmm7+8/5LbGRtyXhnYKQDSxV
 aphFw/rSdai6MzYYiVlBDGzCuuOtQKFAl/c04QoI7z/Ee0AZuZXM96d4Y35/3hj7o4lDstGAF
 qqJrfYETt05bPIO/ePIs46lqd+4=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
v3:
- use g_autofree on returned value from realpath

v2:
- use g_autofree instead of pathname on stack
  Daniel P. Berrang=C3=A9 requested to not put buffers on stack.
  Using g_autofree keeps code much cleaner than using
  extended semantics of realpath(), unless I can use g_autofree
  on malloced area from realpath().
=2D--
 linux-user/syscall.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 95727a816a..1ec7d27e37 100644
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
+    g_autofree char *proc_name =3D NULL;
+    const char *pathname;
     struct fake_open {
         const char *filename;
         int (*fill)(CPUArchState *cpu_env, int fd);
@@ -8567,6 +8570,14 @@ int do_guest_openat(CPUArchState *cpu_env, int dirf=
d, const char *pathname,
         { NULL, NULL, NULL }
     };

+    /* if this is a file from /proc/ filesystem, expand full name */
+    proc_name =3D realpath(fname, NULL);
+    if (proc_name && strncmp(proc_name, "/proc/", 6) =3D=3D 0) {
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


