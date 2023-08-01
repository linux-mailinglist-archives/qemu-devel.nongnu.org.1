Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0873076B682
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 15:59:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQpsU-0001ZX-0b; Tue, 01 Aug 2023 09:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qQpsQ-0001ZG-DQ; Tue, 01 Aug 2023 09:57:30 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qQpsO-0004GL-Ky; Tue, 01 Aug 2023 09:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690898245; x=1691503045; i=deller@gmx.de;
 bh=umcxsITwRNOeQ0dhUL3rB1X1FD18K8NrjAsZ7lxDBpU=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=rLS8aoUs6ofif4xGHZgq0Ytt+faSiAlWF0kwkfwe5Hc+g5KF6HI3H8H/lbBKDZ7p1JAHRdS
 NHVtXQyEhun+Z5GVw9IWIseJQ+QxTHGGGC+xTcIcURucXD0iIJmm+qScE6FTfKhx1Z5dYaEhJ
 Fz17ut87MceCmNtaJd34XUjrUb6y+280KV3KrJmKzE899oGSuI4qlcBxdWFyG9jpjmtd5EuoE
 nLMIr43VxywKH1m3Mi+6xe8lrsTRoYUokN65KmNh7SkDsnounUKKnGlp4IqMOJ2b+Iylug1Uq
 ECrJJvl27/edEo6EGAyMdcbIPyp71rY37Eh7VOGRzM8Ls8NVqI6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.150.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MY6Cl-1qLARE2oaD-00YPgW; Tue, 01
 Aug 2023 15:57:25 +0200
Date: Tue, 1 Aug 2023 15:57:24 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH] linux-user: Emulate /proc/cpuinfo on aarch64 and arm
Message-ID: <ZMkPRJ3subSuW+Rg@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:NlTkvylLUFPyn89Be8eTfMxck9zWSUmI3ijFFhhlqGfxwZasKA6
 Y+/Fy+lW3lyWYfq37vYINnka+cs+bDW7+HTpR3yXtAbmC89Lbym8gCIwC27bAPImUfnKw7C
 uu0QiT32UCKJhfiFGAFYG9Hs3dQqtR9xc3oCpq+QKRPhu6K5M+DzYHhGT7onJqc2llu+LDs
 b2qQeViRw5IhJ0LzXIuWQ==
UI-OutboundReport: notjunk:1;M01:P0:y22NqGAyzbI=;yajqhruky4Sd3u7v7Oy90GfXusr
 rvT6FVaoGIemjtanJ+QqmI0V5ueYtfcYhbDHpcHmmYZcUeRQ+sC6rV+Bi/9uC69ohOL7L9/Am
 dh4wrQQT2uO21c38fWKcW34j458AT76GwYIZIuJkR7KpBsyLjN8oK3Wp3ExXDusQRFwU9dY6l
 sGlPSX8UyxE5xJZxMVBevS4hK5Uav43jc5PSLkH5AiosY4eo4HU1PtlpaFw0Hd4v2SwUCaukN
 o04UgcRtdXsDnNYbSQf2TWtYU337otrvjl3287QGH1WbcPsQLHfkl5e1z27zP1eNbwikCARMv
 kGQs/+s/8MzZYnTZgAlm3IVhmgjZNNPonR0Hrp3rPwDhW9ATHunPzYlwK1RIufbYLNThAg9NP
 WQBHwqDPoEl8TBfaP6DgxXVDTnBsc5puY1ua8rLXhhSRDOVl1ay5airbw1YGl84W1nhToK/V2
 dNshKJe72n1rGbnM2yQtITh+ba9TgQ7Ngx6E3u3DbGX41rZcIvEG1Ke8fwesK4AgrI7Rto667
 07GLaBAoMABupuHGI7cC6MRNMN92VlHLQGhu4cGogMJVYec3pNeQBwxhb2Te8YSiQ6uEdTn+Z
 Na9Dj8OHWBPjnkcDWsh92G40Dd2qzTtA2GaJvU/9b/X4U9Dn90FS4kOwlGEUmv1Taq7JhtjD8
 qXcbvDhknCRn9d00F8EJKfyhJ7QLYFGNYOIPuZbxAMH2eAAxh+sgUo+wPo9Z+6Prp3X4zX4or
 Y+N2arX/iCTw3asIjh445IytV6lElNh2tkKMGgT0PA5sdDSfr5ZY95/OT0FaywkeF+AzhHlHJ
 pt30IQ0XjEqUibCW6mbSS20wkBtwPjZyVGRbs4O4V4eJwR5dXEZl6ToeHefcxE66uCVhzLP+x
 nREjR4Q7iwC+BUmSVNMY0g5dnButxVvu5PXJZ7XHcjZ0lnokm2/uAYP+62mIN03tDy3qpWC3+
 YWqv7LatmalayEr1vCv/ZvlC5a8=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Add emulation for /proc/cpuinfo for arm architecture.
The output below mimics output as seen on debian porterboxes.

aarch64 output example:

processor       : 0
BogoMIPS        : 100.00
Features        : fp asimd evtstrm cpuid
CPU implementer : 0x50
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0x0
CPU revision    : 1

arm output example:

processor       : 0
model name      : ARMv7 Processor rev 2 (v7l)
BogoMIPS        : 50.00
Features        : half thumb fastmult vfp edsp thumbee vfpv3 tls idiva idi=
vt vfpd32 lpae
CPU implementer : 0x56
CPU architecture: 7
CPU variant     : 0x2
CPU part        : 0x584
CPU revision    : 2

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dc8266c073..917c388073 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8287,7 +8287,8 @@ void target_exception_dump(CPUArchState *env, const =
char *fmt, int code)

 #if HOST_BIG_ENDIAN !=3D TARGET_BIG_ENDIAN || \
     defined(TARGET_SPARC) || defined(TARGET_M68K) || defined(TARGET_HPPA)=
 || \
-    defined(TARGET_RISCV) || defined(TARGET_S390X)
+    defined(TARGET_RISCV) || defined(TARGET_S390X) || defined(TARGET_ARM)=
 || \
+    defined(TARGET_AARCH64)
 static int is_proc(const char *filename, const char *entry)
 {
     return strcmp(filename, entry) =3D=3D 0;
@@ -8503,6 +8504,33 @@ static int open_hardware(CPUArchState *cpu_env, int=
 fd)
 }
 #endif

+#if defined(TARGET_AARCH64) || defined(TARGET_ARM)
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    int i, num_cpus;
+    const int is64 =3D TARGET_ABI_BITS =3D=3D 64;
+
+    num_cpus =3D sysconf(_SC_NPROCESSORS_ONLN);
+    for (i =3D 0; i < num_cpus; i++) {
+        dprintf(fd, "processor\t: %d\n", i);
+        if (!is64) {
+            dprintf(fd, "model name\t: ARMv7 Processor rev 2 (v7l)\n");
+        }
+        dprintf(fd, "BogoMIPS\t: %d.00\n", is64 ? 100 : 50);
+        dprintf(fd, "Features\t: %s\n",
+                is64 ? "fp asimd evtstrm cpuid"
+                     : "half thumb fastmult vfp edsp thumbee vfpv3 " \
+                       "tls idiva idivt vfpd32 lpae");
+        dprintf(fd, "CPU implementer\t: 0x%d\n", is64 ? 50 : 56);
+        dprintf(fd, "CPU architecture: %d\n",    is64 ? 8 : 7);
+        dprintf(fd, "CPU variant\t: 0x%d\n",     is64 ? 0 : 2);
+        dprintf(fd, "CPU part\t: 0x%d\n",        is64 ? 0 : 584);
+        dprintf(fd, "CPU revision\t: %d\n\n",    is64 ? 1 : 2);
+    }
+    return 0;
+}
+#endif
+
 int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathnam=
e,
                     int flags, mode_t mode, bool safe)
 {
@@ -8522,7 +8550,8 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd=
, const char *pathname,
         { "/proc/net/route", open_net_route, is_proc },
 #endif
 #if defined(TARGET_SPARC) || defined(TARGET_HPPA) || \
-    defined(TARGET_RISCV) || defined(TARGET_S390X)
+    defined(TARGET_RISCV) || defined(TARGET_S390X) || \
+    defined(TARGET_ARM)   || defined(TARGET_AARCH64)
         { "/proc/cpuinfo", open_cpuinfo, is_proc },
 #endif
 #if defined(TARGET_M68K)

