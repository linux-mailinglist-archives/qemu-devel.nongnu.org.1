Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D209756F03
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 23:37:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLVsr-00025L-W0; Mon, 17 Jul 2023 17:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLVso-00023J-VT
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:54 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLVsk-00083p-NO
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689629747; x=1690234547; i=deller@gmx.de;
 bh=jqdGT+3zMzpTvJDkwwWYOMwSvh7bKZAP0NicUIgUqwU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ELoEgTJUkLzt+kH/9gZ6rgRHl3vocX3kq3rLJzdt2s984ac79RlPn6CpmK+U5hahbk6dKdF
 hIu/dcnslzpr6MMpUR9k4OTb2SRnfSuGkNGpVi/cS9yjsI9pCLQymfrMf5CbjHaKCF8s5V5qD
 uIk4ElmDFZxU3zG6v9q7Jr0U6xRXn+fll7QYn3BN5GpVvmL33RIkh+Niysz7R15x34e4lcHnc
 zcq6HFMrK9vYJLCBIw7peSHE1WpyVgqs4xd62cKq5pGPExJVziyHLc3hBk1+H6dHuVnCAOHM9
 z4xtZoc31UapRIJ5056nwjTNDay7O3yuXv++ZO/6ZT6vQwnUlOxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.97]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmGZ-1qf7EY12oj-00K77A; Mon, 17
 Jul 2023 23:35:47 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 6/6] linux-user: Fix qemu-arm to run static armhf binaries
Date: Mon, 17 Jul 2023 23:35:45 +0200
Message-ID: <20230717213545.142598-7-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717213545.142598-1-deller@gmx.de>
References: <20230717213545.142598-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:biImiLaFmNiZanSayC8FMswgYYfpLL6zfzYnsJcSZSvPwginvgk
 JM497MLp5Fj+9iFLnsHjaMR/6bUZBSge0uvONhJsRoLviURuBxDBGIUqhvbF0IYXXIDRICu
 3MLseDJAdBS3cYTxss4GUJOhnppouU9OFCjFXafSDZxcplo+K2JSMvNJGkxsEjjNLFRWeZu
 z667qD7+yZ5Lb7GI0b1MA==
UI-OutboundReport: notjunk:1;M01:P0:7QbaCM7FUlU=;PvHVaAOv426ohvEF/NZKClMQPrM
 LVq8fyLFFv5zw5Y7zHHkf16lW5w3uJ0JQzomC/T53I36uEfKAWRso8usowIqbjX5G64JZT1W3
 cXRl3YZX3vgPmuhQi+PYcgTOHFWtTjmWjSr8z/xx8UmrgkL4jBdVnPzYuDgocDR04qT0FHYzB
 0HpKsB1GyTrSWIaMDI6Ij5BMYR5g5AD+dgzwQep7JsvdZUlEgQwSaB9/gtlx1MDapv2ck5Pm7
 4Dtswv45ZHy11E+pKPMKOLMDk8fUhaDcpVCthQh7QKIRl/hiaWYlhyWIwiZPJy8H28ziTpq+s
 lzKtZSFjtoP0Gz5gtSETeCxLdvQfAYOtdh10dAUMJ4Z+xN+t/I732XLEPtJ+7fdxqVw4VBfqF
 khl17SETi3CfnCurxx4ibdNKG7UZf/cVL7y1HV/ncgmDpgrAs4C++AD6VPVW1pUgReXzqgqCk
 zfduvBbh9WiuNLoMTrZ2NHIWtpn3roSReQ/pb5mU5n844gq4FRCMBvODVm3oxGPLxGljTpGnx
 dL2yPx4ADNjyCbiKevjZgZLRtqmlSWL5INOs2UXYZcyOHUPm0bLDhHsU0m8FNP9tHY4q5IjhQ
 K44R7XxSq/gEVf4ce7dom5XfL79r2UBKtzlwCJ7SjAbL477GjOnDFGviJVEKKbQKMQ2lBAmCq
 D/NZqgPro+YN28+4tu+NuJFvN46B5/J4aklEKJURQiwuY1Ywiho7Zv5uBS+ZsHoLo7xD9Ydug
 26Q97U6+djx95Wnh6blwn3q+ux+vyfC6bp49JIJQiy6Gj5UJhfqscXkHJPLTCLSpykEcSzN97
 uFWOHpYNLq7QxcdquhdSRDNsy0EfxYUDjuv+yEyJ9zZCCCQ1z6JmPlPk6YcaKahJaHVe4ysUF
 AAgldasvl2EmUwAa2+B9sO5EzaRO7KYcucF0GIzdpVLZoybXEPiODbZEIHEHNaqT5z4HaisM3
 Gq0AIQ==
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
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

qemu-user crashes immediately when running static binaries on the armhf
architecture. The problem is the memory layout where the executable is
loaded before the interpreter library, in which case the reserved brk
region clashes with the interpreter code and is released before qemu
tries to start the program.

Fix it by ncreasing the brk value to the highest brk value of
interpreter or executable.

Signed-off-by: Helge Deller <deller@gmx.de>
Reported-by:  Venkata.Pyla@toshiba-tsip.com
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1040981
=2D--
 linux-user/elfload.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a26200d9f3..94951630b1 100644
=2D-- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3615,6 +3615,13 @@ int load_elf_binary(struct linux_binprm *bprm, stru=
ct image_info *info)

     if (elf_interpreter) {
         load_elf_interp(elf_interpreter, &interp_info, bprm->buf);
+        /*
+         * adjust brk address if the interpreter was loaded above the mai=
n
+         * executable, e.g. happens with static binaries on armhf
+         */
+        if (interp_info.brk > info->brk) {
+            info->brk =3D interp_info.brk;
+        }

         /* If the program interpreter is one of these two, then assume
            an iBCS2 image.  Otherwise assume a native linux image.  */
=2D-
2.41.0


