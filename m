Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E03D476B826
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 16:59:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQqq5-0005gX-Se; Tue, 01 Aug 2023 10:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQqq4-0005gL-JB
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 10:59:08 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQqpy-0002Et-KG
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 10:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690901938; x=1691506738; i=deller@gmx.de;
 bh=nVp3FX6R7xWC/s+kG9hjxnY22pZtoCfvc/eCJvKLZt4=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=EZ0MrKLAE+XMaNvsP3kcNGN40SBjbCvEBtprX74PWiJ/KFXh3fDVsMc5Iwo5lRu8PBDsl/F
 pn8bw+bI0EMjqNgn1JW5ts7clYNRdz1U39oiGcOGpOJ1c7rU9WOdTocI1EyyZCWRQ+ffJXXcp
 pWyHxVSoP2v+NhkTkDd/ftKFVLSRBoreoCzrcQrcuBnNXAwJO24M/HA/wJn/9Q0hp3rdIP6oj
 0FAVvSMlUvN0D85gGyBcXioC81clMGhFzdjxBHbgm8VjQy/JFxHILWvCkautbKQ4tHxp6OfRc
 vQ6HYpDhwRfQ0ZLBA6Yp2UQCka2O3Fqj0xOSvImsWEgeGdo7GgyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.150.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYXs-1q03zg1Dpe-00m6Yw; Tue, 01
 Aug 2023 16:58:58 +0200
Date: Tue, 1 Aug 2023 16:58:57 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Fix openat() emulation to correctly detect
 accesses to /proc
Message-ID: <ZMkdsWHTeHT2+lF2@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:jwjt0pdbIhiH2GHjgHu8xF+zn11BtlaT/5ilOdxTUwrJynHODkT
 jSVZ0sfol4xhxN2zrQRToBh99r1YHrmHEb7qUni+B/r2RFYt9JDQk0uoqMYZCmPN1TG43rL
 M4macBhHmk+QmGwHq3QHHBmcHbKFKVdQPtVF4lud/lprDByk8Afihhd+Qc+uA214b23ZOuO
 q0iNOL40Dj4azaEPTurFw==
UI-OutboundReport: notjunk:1;M01:P0:5TMhzJYBlY0=;muM4bivJYzlNGUVs5DVmfVqid3V
 00UNhskmOxBKGPhkYtaDh3QrMYXZS8W4rRBs+V6twHtWDkHvUlHOhNuCk00AtDl8H9rjiCE4l
 IqiSo8IbwN96/vdb01NNY4MhpIx6WXMD7uktRxeHCAuzxb7/ojt4494xcM2k4AZnlyJjW9EJ4
 etY+RQ5f9MBSNTuSjRo+Kly/iSCpAZ756UsLquOAegZgRwd/OVYCuwtNQeaMinfWaO7HDTJkv
 05fHq7M5g/vk0UFMgf4hag+HGBGoM8FPlxl425olRy7ufGTK0+gUunuGY421ZrF8NJB3FRsOG
 g0KEzKPBy8dNsCgUov6pDfsRHUzHC0Epo5Mt0Bksun7dWREwQCI+e02NOD14BTpjWLzrvSo3U
 2DaQSvJu72TZdKFjNRNrl9I7xl2Hdy1sSYl9YGNcGRDr5M/2zpdUGhGXnJFYXUOicUmc+FgKW
 BL6kAlW4luYGzV78pQjnzLy4LC4Ar6vLwHbRVZhoGJBW8BCAk9btMVkIJAisek7idqUSyP1yX
 6FxWi5IBANScrjAQGlCg4u3rHEjQoi/vfxfA0q1gqaDeSOxHwNF9cJWCDYpkmfzA0CtODhD/h
 Q8U5xel51tmBVxnwu5f7DPRWL7urgV3249PijJ5ixJ7z9y4ozc6Xa6Ug+W81mWg0x1rd++EZ8
 6qnmuXd3IOOlABSJKfwxKTp+LC1ikutdnBNlx4LZmL0Ri5t1eMBcGoxxX3+eu7lgFvceI9OTb
 PEE94Qj+xTxiBvdzzgUHFhM1gcDVwA0qLkDomkhfurJHk5aFYcIqrJP78O/TCTgy4k7cTR13l
 LdDWgCtFv7AZoSd1yR/xPDB2/U6D1IvOi2koiAXPAgyRRoeeE9iJnUjlSBYKFBFaSDKgw8vKQ
 r6+JT7DlzAPx2NNi5+FpR96C/QdzPbP2uDyql7n5ygxOnR6OtrWODfbrzpx+b8YnvN4dWF6sl
 sqUqksS6CYy8BA6VwjxuSjZOiWo=
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

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 917c388073..bb864c2bb3 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8531,9 +8531,11 @@ static int open_cpuinfo(CPUArchState *cpu_env, int =
fd)
 }
 #endif

-int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathnam=
e,
+int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
                     int flags, mode_t mode, bool safe)
 {
+    char proc_name[PATH_MAX];
+    const char *pathname;
     struct fake_open {
         const char *filename;
         int (*fill)(CPUArchState *cpu_env, int fd);
@@ -8560,6 +8562,13 @@ int do_guest_openat(CPUArchState *cpu_env, int dirf=
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

