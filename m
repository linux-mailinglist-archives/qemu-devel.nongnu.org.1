Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 992A774BC44
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 07:44:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI0il-0000qo-N3; Sat, 08 Jul 2023 01:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qI0ig-0000pU-9K
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 01:42:58 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qI0id-00027K-1H
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 01:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688794971; x=1689399771; i=deller@gmx.de;
 bh=7wsrwYU7lxpp4Z0xWfyIzcV+aXgA6/gu+Yde3GZqjVY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IRXPX8i5tgavxvwrhQbxD0xvIYuw0yM2tYmtj0ChJLhPlnNsNCL6umj0wBbSMQAlSF4Mlrr
 VbyvtkeIir87JO6+aBjtWxG384BV2LfqT5xHUoSPldMd4+12WlxoPjZ99w//Vw7JclXEKYL/E
 s0fz1t4VWXt8lC1WyMDAfM4+P/+wtHZnUjYJqg2B8uqw+FSMcbqvCDmB6eKDMQMcHAMTtWe1X
 3b+codCD6VMc9yWpVoLoR6r8FkVUko7pgN3PoFh08hvJpSe/ipNxElHCu0HvFisWfl8FlxdrY
 gjjXWjyu4vXq0u0sWpMqLZgp+1ABLlaDHTaUWss2m5l1K3PEa5Qg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.155.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oBx-1q5xRX3ksX-00wqRh; Sat, 08
 Jul 2023 07:42:50 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH v2 1/3] linux-user: Fix fcntl() and fcntl64() to return
 O_LARGEFILE for 32-bit targets
Date: Sat,  8 Jul 2023 07:42:47 +0200
Message-ID: <20230708054249.10245-2-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230708054249.10245-1-deller@gmx.de>
References: <20230708054249.10245-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wIf+O/UFW9hSf0nf7PbM/YIL095ed5g0T98WJmC+/wTtTmPl4dF
 C1XnD4xvtYgFIOeHiJgUHXPpnnKVMono9njb/OiWlAiT6vdmjpZunwO4El5ujxD9OZgGImz
 ySUoq5yjTE03ECFmxsLBhWCWyCt9c3M9mEvWu7yC22jH+EEhoXgcnbnnhmkA3nVqPmZ1RcC
 PpGiZOk1Le3Yd2ZcnFQlA==
UI-OutboundReport: notjunk:1;M01:P0:09WdGbeJx3o=;wowQYuuRhjXqcrDsf3v9RMKgx8g
 Bgmzntw3uOAdZPC6aHHHq2+cn9GWyB6fD6r02GmP4V83C4I5fvu1b23t7v3UkuTw2uWxLyIz2
 8/HIBEmUZ94v2LLkKcPXJhoGyKPEoFTOcAB8/HeP596ElVdvx1BLxFT0ZPqL2Xt7YM1NtkB6J
 rkmeVbejHWDKJN3TEYJv8zwm0+9rfR/0uNfPcNhns+gGxZZT21DTznpl/zkV9nAttnACa0Zka
 9YWwirnEbTqAcBjtxx0eP2tGwZLbgK6yk5Mdf/B1nbD4jZh3G6wpz2zXJa9PT7mJLAxJduzeA
 cZqeLHeFXdULwnAns3aKAQfbu4WjPJ3CmfutuRoFp8Y7xXOdgXxceLzhED+fr9CUQWGccsNZH
 Myvu7GpbEZ/8l3stlgso+uGs4GRMJHQOFa/+ivrwMpB18MOTsZLJotZfmBYqPhN8Hj+P02xrT
 7epFvcVAL4UqUsMVjLQmmJ0tqUcjRAk1qu0iu/nN+WDsRSMwgW0y71InggP7n7EYP1Y/RM32j
 DPmtSEqcSTfaOsecviBlcvNSI28MBVwD5EXW/rmrEa8YEBE+BTRWl8mW1Qet/g1xkYqQoYCBB
 LW6FjVNQ4xV8Z9pZonH9EkbUwTtGy/r2I5VsoJ3/UWyBPExj2irLLVg6BJKS5JcptUMrfTSB/
 3SMPLdLfR4I7vxPpGbrun5IwOiXQgfIAEll4p1vjeKi+4UPgqtAFqjt0lY/oIGHm/4xTEAADz
 19ESLzG0zZuK8SjxquH00do1VxFAoi/lMF2RCfynE4GytuUbm8Cu4PJyjsF7eM5zMU5bQ4NmV
 a7m/kPgh6iEda0TSkaenfvUurDZDk6aGslgY3MR1r5DIV9mSdC9WYeXoH4H+VFdG0SQJ1dJnl
 DylCpzlv04um1myl87ZihUIm5wsTF/mqsqnZ6MZDgPrw5QBbeQjn2OXvzvqVC1W9hE3Qw/drg
 wnMyVtPzxtVWvQpvdW3aZszXF2Q=
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

When running a 32-bit guest on a 64-bit host, fcntl[64](F_GETFL) should
return with the TARGET_O_LARGEFILE flag set, because all 64-bit hosts
support large files unconditionally.

But on 64-bit hosts, O_LARGEFILE has the value 0, so the flag
translation can't be done with the fcntl_flags_tbl[]. Instead add the
TARGET_O_LARGEFILE flag afterwards.

Note that for 64-bit guests the compiler will optimize away this code,
since TARGET_O_LARGEFILE is zero.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/syscall.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 08162cc966..10f05b1e55 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7132,6 +7132,10 @@ static abi_long do_fcntl(int fd, int cmd, abi_ulong=
 arg)
         ret =3D get_errno(safe_fcntl(fd, host_cmd, arg));
         if (ret >=3D 0) {
             ret =3D host_to_target_bitmask(ret, fcntl_flags_tbl);
+            /* tell 32-bit guests it uses largefile on 64-bit hosts: */
+            if (O_LARGEFILE =3D=3D 0 && HOST_LONG_BITS =3D=3D 64) {
+                ret |=3D TARGET_O_LARGEFILE;
+            }
         }
         break;

=2D-
2.41.0


