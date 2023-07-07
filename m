Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A3374B1AD
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 15:20:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHlN8-0005QY-Cs; Fri, 07 Jul 2023 09:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qHlN3-0005Q4-P9
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:19:38 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qHlMz-0001Lf-Sc
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688735969; x=1689340769; i=deller@gmx.de;
 bh=kW+aRGZnsWLqxw+XdUu3PLEnhXuIX+DbTAQorTksg3s=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=K9m4YF7YTMwB3FAZTJeIZAMIHRhcSbxiq6DuAuYBwRqD8Ddz9Jnwhk0u+YyDDaeojKpBRox
 TFmXT0Sm9xfn2caR2pvPQqY8cIXvnYzx1WPH8Y87c0K97j6644G4Xe1NOyOceosnDs1DZ8TE0
 X6AmKVH3mk/yxBy+ON2glw3BIVNEGUjdppk8PwxLsbkMk72M7SBbcMJ+U3Lk/XpwHqRqPjWU1
 bJhWNMb8DBpVymQ5XcGh9lhmEdXHTZgGmWqg2KPBLp+0j2vefEDTHwOTJuQ5G1iIe8ujXYbL1
 JvGGxVJAGwi2Ya/Z4tohfZm/Fr5ZesDSe+0bH/Q2GuaqDVGpZ/IQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.153.180]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8ykg-1qNnmh0iUY-00670Y; Fri, 07
 Jul 2023 15:19:29 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 1/4] linux-user: Fix fcntl64() to return O_LARGEFILE for
 32-bit targets
Date: Fri,  7 Jul 2023 15:19:25 +0200
Message-ID: <20230707131928.89500-2-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707131928.89500-1-deller@gmx.de>
References: <20230707131928.89500-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZlUQJHL0WzuzH6nmDdzcVxEsTrW9dBTQ1reCPhnXQJbtVH4Begu
 GRNfzozyKHZVMXwtzJjDxO+mvT7fcZpwdECcxll3sQjlYfRLbTjC1E3ZHne4aFR96On8wBJ
 HjPDh6sY9DJdlW+wfoFP1GjWtuhg2f9nubucmjGJwVxORlEfq6NbIb5NlM4mcA1oXqalD0b
 HdkZVb5m3z/Vv/wKJzoeA==
UI-OutboundReport: notjunk:1;M01:P0:r0dqhEGywF0=;1+MhtO3SEotqwaxRTKPr1oSWmW4
 KpeDdvWOd17lEIGB9xoIKbur9h5KHNa8u/f1SVru/jGmDEEwcJS1YIw5D4hStzaDUwpfaK3W+
 K3GkJOD25ue1W2zbmHK+t/L24dsS76YF4W3vLU7GU0zJ7BLSWYY20tVuQ3JNa+jMv/F1feGXE
 Q+MdgSfHC5QKcg2poYwXTxPhl+n/z28KsmciS+Z6jLQodfjjN2DzEw7kpCjBEEaDCq9iDPV9s
 zIXyV22vXRg8oae5G+utpKCOqYeGJUcL+tgH+S3bEpHRstW/3w8TeqBTkm7geWdvZJZ9Hr4u7
 hDC8b4F2/U4v8PEpVJXlxAAnIw8E0IKSx6vmcXahC3aqVK479cuoyidEqwuPn3ekLNbh+LhO1
 7FXjoFg0eHHWrXnbDQ1TuMZEhlO1Sz5VyhyuWIyeVvFvNU9JdgcKEYeWQbDodO6dg0eLUvgLd
 ZFovtmg/LRYK53jplrwBQA1UqYVY5enz1+FdSBtDFZvNn/0KxDgoBpBJg7OjjGij35x2MVzLY
 GxVKuHgvKrApbx3XFc75II/pScA0Y03dOVxNSGlyaC5po98UVK8AwfS8E7ytp8DzaSUzjl2rv
 kIM5ehgXImIrM3aS3npIM73dwIImhejles4sINjSEoOIcUAlM6B4tTIhTMPYpP+VspiKR9/K/
 9Kuum8KfchGRs/0v95XGYDh2LrxxBP5jImyOKgXONKybnzJbX/L5Mb1SbMT+6MuKyJV2uAy1O
 r5N2wOSvt9RCIcRlBaDM9vxyXbdo3aCcYwaelTyVLmmYZ0bmPunSTTktscLxYW/Ox1p9qnNLP
 s3jRV+s5ZpdGt84sU4YTGDGLQKpeNm3ZXPhZopL4I9/WF35DxW0PYVcy0pJSL8h+nVLs8iSER
 eCL+bNnLFdO3hnC3qJzP/sSRgv/y8aDsFLnbO3ZgNMHUW6xHTSVLUaRlroVSztEAjVDszHiFp
 IYQHdtEn4l/z8eVfum1BvgsKxkE=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
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

On a 64-bit host, O_LARGEFILE has the value 0.
When running a 32-bit guest on a 64-bit host, fcntl64(F_GETFL) should
return with the O_LARGEFILE flag set, because the 64-bit host supports
large files unconditionally.

The flag translation should have happened in do_fcntl(), but since O_LARGE=
FILE
is zero for 64-bit hosts, the translation can't be done with the
translation table.

Fix it by setting the TARGET_O_LARGEFILE flag unconditionally for
32-bit guests on 64-bit hosts when fcntl64() is called.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/syscall.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 08162cc966..3f1e8e7ad9 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12328,6 +12328,15 @@ static abi_long do_syscall1(CPUArchState *cpu_env=
, int num, abi_long arg1,
         }

         switch(arg2) {
+#if HOST_LONG_BITS =3D=3D 64 && TARGET_LONG_BITS =3D=3D 32 && \
+    O_LARGEFILE =3D=3D 0     && TARGET_O_LARGEFILE !=3D 0
+        case TARGET_F_GETFL:
+            ret =3D do_fcntl(arg1, arg2, arg3);
+            if (ret > 0) {
+                ret |=3D TARGET_O_LARGEFILE;
+            }
+	    break;
+#endif
         case TARGET_F_GETLK64:
             ret =3D copyfrom(&fl, arg3);
             if (ret) {
=2D-
2.41.0


