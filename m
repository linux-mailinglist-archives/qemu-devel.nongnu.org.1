Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CDA74BDEF
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 16:58:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI9NJ-00060J-So; Sat, 08 Jul 2023 10:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qI9NG-0005zd-S9
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 10:57:26 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qI9NF-00034X-6o
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 10:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688828241; x=1689433041; i=deller@gmx.de;
 bh=oo3GBOSXiL40Lf5vi714n1QkrlsT47SxACuqeDPOeP4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aA2Kx56SjHUU9s00ArQz39opMkfytAAn+5f5m65IqXzjHGkYrZX+AkLs3AjEbTe91YI4cB1
 zqkElQ0Urwan2gQ3blaQ1ROqrKFaM8ur0B2oglQX+fiwOj0gPLhn5HiAeTh0HwdVbzKzG5mqG
 Zy0qzoqX4j05D4C1dyBkmJFzKNRiqQ66PRU0GdiQcCdaayTkpj9ioSCpZjyONf24G/LtPowHH
 ZXB4hu6tCOW2sZg2Zelv8fKsyBlUrqwj78md5skdRI8FhbYoQBF1co2vv0RG1qT0EgjtAya8g
 QlTL/zIV+8FrCObTPsiLuRSRnu2XUEi43VvHkdjyrCaDQQwxWpog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.155.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4JmT-1qHsG02qsj-000Jq2; Sat, 08
 Jul 2023 16:57:21 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 2/3] linux-user: Fix accept4(SOCK_NONBLOCK) syscall
Date: Sat,  8 Jul 2023 16:57:19 +0200
Message-ID: <20230708145720.136671-3-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230708145720.136671-1-deller@gmx.de>
References: <20230708145720.136671-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rYdtbELtqkUnMupNkOAtIV3XQOj4NCMqrYa3CwXbxppmqiCc3Jw
 jpwVTxbwtS2QiWveBiJhJdjfP5yQ1Jq1hLHHl/uXrI/KmF3UUJJHrhmuYHLEVTCGDz0bAPj
 9gr9KQ1CVZD4MUH1sg5fCyDbkj1cLthhSo/HxK+7N7z/nDf96l47uBDg5uZObEViR+L8ETO
 ytYIMlYklgeF/lEjuK4lg==
UI-OutboundReport: notjunk:1;M01:P0:LZqfhJBQ8Q0=;og4b340bJUKlwgkF8jxJDaEvue1
 26pO4fdhSOYK9rWPqeWuJNiyvnZ2s6cMBF0lStv27A4VvlPqmdvv57FaDoSI8a+sliACf1ph8
 obsYzlscHs63mkISLcYVghY0d77vrRnJhUnzzaHgVFCyT30cKf2RyeFkfs3aXwCV3FlCMMtVQ
 BR2iL1AYCe2ivXh6/bXNK5MBQAL1H/yIOabQY1woEYgugnIbUU6hxQu0CdbRNH1N40dzgr1U1
 w5PCzuhCbt9GiGNIhXijbpiKi+sQT4lB6J2vxL9h+duOZ5E804o8kMnZFYyxyeevH9Po4HrXS
 e6DqUxBCe+aW0IkxYTquCa8D8n4i5LV1CmoZtCp/1sSUNQztVuxc18YUXIAldtneiyGMnU7Gc
 WhB1ZYp1FR590fj7GmQ8/2yqDBeHaD5AmaoRSJLMMZ9lgb7mCb1Hz77O5KriVkQ4/Ki3N92sH
 HqwnzdBIZ0MXepYohZntgkb60Aq7G52Fa0ubkYIb+lGxSlzE7w9m3XZ+Ho1u856wQnKitNRho
 J6cQM11n6Yh7OIdr0aU8sMF2UfnQot/6fseOlSe2C1f8GBZ3DCRHfwLuC+/woNyGdNQo8iQ17
 bjyqSjkF+NytdnJla6pfp/M/vezleJOxyHrrJM7S56zFBE+wnYUNBzaKNVggMsCVfql6ZCSuM
 fh9fbVse/VK/iQjLVSGEOD5yj6BZymoJLvITRLN8b535w/pfBMzOAzMQsB6oTNd9Y7YhaxCCC
 eNIiGbmlaoUyHrRNnyJ77BAqBjANt5K3KXCV3ecTrzg/cD9004hqAYd+qjQKcdMOR+XewEDfu
 2QqLg2QrIKhcVS0ny1TntGE3nETuD/HcBZvIyYQ3HhW2BEhMnzq5Xw+aRHu5V5UXAvA9sHJO7
 ghzKTPd/cNhI1QSoAgpPfHzL92HuP7d+/Ob4wOUwWD+wYV5EZ7Bdmo+JoNQ0UxcSrHna/Yp0K
 dQLGOhm8CnB0E1Bo2FROyoIAgoo=
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


