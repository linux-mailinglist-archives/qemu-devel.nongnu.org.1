Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 372F574BC47
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 07:44:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI0ii-0000q6-K5; Sat, 08 Jul 2023 01:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qI0if-0000pM-Eq
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 01:42:57 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qI0id-00027M-0G
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 01:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688794971; x=1689399771; i=deller@gmx.de;
 bh=+MSM8h55QN1qQYOXWl0OKkCF9OBQUPKZbUY+9yeVxXs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tKu0moS/JoR/xk8DwdHccTixg9NOvmyH+UEz5mYwHP24k31VzFFfMb+ziyiaMrctOG1F+nB
 ZlEebUS0gHuE3FaEP5llKSdbCpPNpM8FET9/4fuylQd+8Nqr2j0zEXvJRhORPFgxWMAlvQcfk
 DH74d/CcyvDWMeqmM2mP6GnKhdWB0UPflvWBCpCpRvFKFD/DeWAoxLXn5hUDM67U+eZ6junJI
 P+Y4GjrW/YLjm7EpwcPeXCK03yM+mcn3iQkvVV1oC6zBquRlVVUN4CH7MzAWXhe04O5n9bcND
 1GM/Xeut8ft0pZP+baYZtFBj4TNcLDzE7JdS+yiY/YN8lMCgn47Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.155.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQic-1qAovN0EGE-00ASfu; Sat, 08
 Jul 2023 07:42:51 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH v2 2/3] linux-user: Fix accept4(SOCK_NONBLOCK) syscall
Date: Sat,  8 Jul 2023 07:42:48 +0200
Message-ID: <20230708054249.10245-3-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230708054249.10245-1-deller@gmx.de>
References: <20230708054249.10245-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UlwTVXHCFzJP8kpnUJ6yJJqNujG9jEABXH0DBFUryljyZysRqUE
 WTYudiNZI2sIQa86wz9o/sNxgdhPzKY/bBbNjIb6lS0fKf0iX77668Asg66deLXNndnjfPT
 nf1lzzMUyys266UgOGGV8ysd5RzbiXFbU17lSQO9CvvMKqmLC4dhfDQshsnYzQsNCoFYou3
 zVwjIJ2vauw6aQ0Cdpp6A==
UI-OutboundReport: notjunk:1;M01:P0:SWKrw+5S19g=;XKz+pdagBkVTtVxlnyab59OkLb3
 Pp/Vk6AS+aEcV1SKSM3inEZSR8H23C4iRV/bHNiPgL/V7Nn562aGBLqtoJLeRVc9EGCARRTp4
 H6uUGEiS0nzJugz2MBMRf+yljj8Xv1+MP8iVBpyFNaOpAi3K0NqTGSX0B0cDs4qTT2QBeH40i
 M1M322V4CSLO4CNIMpLeySPGpOGbijXRuNXOUD55/3AeagreJTIekJGNwMSjAxYm0L3PeFdb6
 s4WalOQAsOl8WHLeLSGvaqifh70o4auwEe609AcdPK6YbwuGmqma+TpXbWVQlDfO7UWyzjjrl
 wUD0lIP4QiusmVwolnzVNjRx81lOkyizYRHdx76wSk0V4s4zacT6xjNUOlYUgBQtehYM6Tk36
 F/yhTaWslRvlOg8vBxKSbNhx6U2uHbJg7tHdbkoabzTc+56rhk7OdRDbLgstJvCQcZYNhr9AY
 RFkf+CxVRwlTV061JRO080R8g4XUg3oy8Odkm4S4dK+dfGABbD4HecghKbuXvjNfjMSAy7LBc
 ukd6BuWVjVLK9EEaL7hzQzv3wMhp03BXP70IUaONlOh33zIy/+t99+BwJxCsFoll7c5BuXNRn
 Ws8Ej+vjCXfKODn67abwv65r2kLkqpghqSpSRvAw8NQws52AFfkUOODZCrsy/qkAccZKG+FTZ
 wogC875RH5maSSnpXQ/g2M8PbGuJJCAAiwuHfy51O5tmEEThZHi//R806qoIAXvdYig1se9mL
 K9Ex1zAYbx4z11WNCD23MCEaHTl1n+SmHqlNrD//lREJW0OfNjqCreliuniGydqPtaPNv+/g8
 1C7FkaxtZrO8cKW+B7zho+DxgadldyxDo8wegrLvNxbRll7073iORp1ZPen8CPzRj/GHkTKXm
 iiawYakKCh6hl5oH0vONyOHKGNrNtK7A3UUOpORyl/MxOiapQlIuZ5s53nYslYn08LftK2mr8
 s/1TPNOREe6S6/aTMXubunEU5gs=
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

The Linux accept4() syscall allows two flags only: SOCK_NONBLOCK and
SOCK_CLOEXEC, and returns -EINVAL if any other bits have been set.

Change the qemu implementation accordingly, which means we can not use
the fcntl_flags_tbl[] translation table which allows too many other
values.

Beside the correction in behaviour, this actually fixes the accept4()
emulation for hppa, mips and alpha targets for which SOCK_NONBLOCK is
different than TARGET_SOCK_NONBLOCK (aka O_NONBLOCK).

The fix can be verified with the testcase of the debian lwt package,
which hangs forever in a read() syscall without this patch.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/syscall.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 10f05b1e55..9b9e3bd5e3 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3440,7 +3440,17 @@ static abi_long do_accept4(int fd, abi_ulong target=
_addr,
     abi_long ret;
     int host_flags;

-    host_flags =3D target_to_host_bitmask(flags, fcntl_flags_tbl);
+    if (flags & ~(TARGET_SOCK_CLOEXEC | TARGET_SOCK_NONBLOCK)) {
+        return -TARGET_EINVAL;
+    }
+
+    host_flags =3D 0;
+    if (flags & TARGET_SOCK_NONBLOCK) {
+        host_flags |=3D SOCK_NONBLOCK;
+    }
+    if (flags & TARGET_SOCK_CLOEXEC) {
+        host_flags |=3D SOCK_CLOEXEC;
+    }

     if (target_addr =3D=3D 0) {
         return get_errno(safe_accept4(fd, NULL, NULL, host_flags));
=2D-
2.41.0


