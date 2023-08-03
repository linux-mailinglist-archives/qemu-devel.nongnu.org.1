Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA12A76F438
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 22:49:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRfF1-0007Wg-Lh; Thu, 03 Aug 2023 16:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qRfEz-0007V4-OV; Thu, 03 Aug 2023 16:48:13 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qRfEw-0002SS-Ty; Thu, 03 Aug 2023 16:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691095684; x=1691700484; i=deller@gmx.de;
 bh=xwz6aMde3YBdcmDS3z738t66mXpAPMuyqhPYVzFaalo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bapFYpASH8ihOXy/fchYrTEtlGYnFQP6jI9rb0Hb4bIFd/BQmkzGN7eZdejZWEdWZX4s804
 SyEz7asbwcgtJaTVYkyDcwnPxwy5fnimh0Soc7dvKpvSfko+stubN+jNQ1yIdeIYsRXOb5UQT
 o7rvC1MVV4ihtYL6I2kDH4SYVnkfYoYeMVoSfk/El3IiKQJ7unrPBpjt6l73UGgvvYTT8lxLI
 Dmgyp62rQLu1SmfNrbaLBper1J9pfUwqmnWvbxlRBH8aqvmyNulbuDVVeWhyplN8DNK3PIiL5
 dL6gxPaQdB80zsntzGnEr7qRUxDAPjLgKi8F0D9labWrMxvWF4FA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.147.53]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRCOK-1qDQB61xh6-00NDW1; Thu, 03
 Aug 2023 22:48:04 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v3 1/3] linux-user: Fix openat() emulation to correctly detect
 accesses to /proc
Date: Thu,  3 Aug 2023 22:48:01 +0200
Message-ID: <20230803204803.639733-2-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803204803.639733-1-deller@gmx.de>
References: <20230803204803.639733-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FWY0+UEU+U6Ysrxr9GvdMR9C0hGXfG7CzpCGA3MsfxX9XVIBQ4B
 Yk2LkXdZXd/NUNJEw/XMZ+3V7AFITZB0+/Zfe+KaasTZbeOuqCQBrylzGlY/U1IqnRB5Yrh
 FQfz5m9gVBjxHPmkZvagu++ZGlH4hgnyzz3dpgOCO+JxYpPvMqvUd3GiFHWZHJtWd7/E11R
 dh768SfjRZMYNVMK6kNaQ==
UI-OutboundReport: notjunk:1;M01:P0:UU1Tlh3NTCg=;X5hFlEhISiimliao1YqqmdYEM3J
 +cSrVgXc6jAl/6gU0ofMT6zSNRzQo22mRCJIXTA+C2VlSMEyoKqEFUONrsi3KR6B/tUpcguPl
 1DNjGSuT8ssLy6SGAAymW80Roy8oEKK5OA5Hq7hyz7fBYnNEoUsWhIE2qjr+Q0l3hh6QQc9uQ
 AjFzWhjRZj+79p/lfT7AuB+Lq4Dqs6oeeHEREzb1cI+o4GzEdIN5H1KfLhMdSygoeB+31Nxh0
 KDaHOvugHxYdEIThrECjkIJheSKdsGEODLur4P5iChYHQKkElVCaVhmvBMR53PiWqSAO55aJ6
 /OW+BOJAKApyzWPQNh+OPV3IuqL3mWRXxXuIP/oRtrJsLwWxY9WoXSACTMWDziStGLkxmBJRy
 lxnfmKICIIqZa/2jC28E/TS6vaSbioF/e3+5k0LQ3lG2gmLzZBP4n8muGawGdLyoieX2H20yh
 OErwWWr2QrgUSerAM8K8E0wOHEWIbTswyqGZ3G3tMFnI7ft2Tg8qJbkZDYhGNLUbkZ9V51SKu
 Ny2+/1yBTcLIk2tFZbxMEfoqTRGLxBnU8ot0RcBd/cEPGLZgIEnFThoclhhZgnusMSVknAqoj
 73xMTkMPt8UADs8F+Zakg9oljOeG83xaECnvg+vf4sxc6A4PE/R1Xm0V6RWPqmjhw8BkypwXH
 0Yx5d+30uwLI3JOx6QJZwEsL+9VrBSIn5fyAGfSmE1qpRHhMXBbSRmwo9/BvRE8309dgEY8kR
 LXkvQXk0ZLIjgBefhT9joa601SVMkV2rCFC7vM8rNwsWGwOH/bvQwNC5wpgmv0bOgtBptGBcv
 uD7XOZ+8m+U9TT1kfO9ROJ35ABRGk/2LFwA+wwh+L7ZA1kIkyVZXpWuEusu/+p1sa1KMPZhUg
 LQvFxU8omKsdm8T19QlZb9HSDiiEUSWnYwLZ6HytOKIZqCInYcfmU9XkBG10zqOrgBxLIX6/9
 D4mJHg==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
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


