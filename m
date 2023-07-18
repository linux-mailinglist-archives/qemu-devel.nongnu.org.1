Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC7C75852D
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 20:54:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLpoZ-0000sY-VR; Tue, 18 Jul 2023 14:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLpoX-0000s7-6p
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:52:49 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLpoV-0003NM-FG
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689706363; x=1690311163; i=deller@gmx.de;
 bh=B/0bGOwBaD33wN+exDA+N984DvH00jWlTxJF/y38M0M=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=VIv5qiyoN+0b0rRX03ta4gDUdX62kf6psqbp9DnrHWnc+kuyCWP9F97bpfrLT3+payt8wc6
 QwdW89N0jwqyXHf8KcVjwcRgANkOKaIK89X8IP2VSKRvu3IjXD6mSD2Ni22+1nkOl3T2KUR3P
 W6TVvOxoL4AXFcBcIfPh+1buEpSSwMHf8nq+IjEDXKdLesdPnHmJGmPOV8BYratzfnfGQQ6ob
 0ypNaQs8V/LSeKcEtHA10wnLGibCf315Sm5iU66SSkmQ8aZkRTwNL/WyTyTGH+nnp8Bp/U0IB
 8riuviWXLMaY/wgZEg9KuD0S5Maup0/hMNrrUTHFg2C9v4xeDO/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.74]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbivM-1pn2E12eKc-00dJsK; Tue, 18
 Jul 2023 20:52:43 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Andreas Schwab <schwab@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH v2 0/5] linux-user: brk() syscall fixes and armhf static
 binary fix
Date: Tue, 18 Jul 2023 20:52:36 +0200
Message-ID: <20230718185241.11433-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gIspJA+XZ/8Waa+2Jf0h07yYUZ250yttX0ioW6BBwEEQqRJYNZh
 nDOZa2XxGaRUiPGW4S880pj2OthlDRaZjuhtjaWIYYDQZWBSsHxN0m8bGWdihXOEL7+mwSP
 0n7Hm5QIlVcqAagg3hiDHLlm2w+hMnDNBzRG+Nmf4kF/HrS1awje3gCRwN9CqWFnlmmLeUt
 +TMl8hyheuwzNbymH83cQ==
UI-OutboundReport: notjunk:1;M01:P0:5eg5QvYymdU=;I6vZOp0ksUhyTm6sUOzTNKqJEY4
 Byr1SPmXh94mxys+iel4P7lgWEoe1Didb9/yR2yHa2cKk0bpO5TbkDyCqO/axVWUTyMqK6XHm
 00XbMThP2A+pWAG6hfwdcsGQ25+tsiHdsEys7H03EpNBzcziPX4pHh4O5yI3DUi8cL6cR+VbN
 m0pQrug9E5kvxd8Ot9SetbCE7PF1RH+SkryNq1VjnDJkG5InT7BL/wg2ZyZZcS4dsvqHn1hxX
 0u8wBUkawvTto/Hc/JbM4PgXHS8+MYE1WUJH2fHD8W2iVuanaQBcr8wvmJ7ZMz3ax9ppPyVWq
 rZugKFePU2FACtd3EKTUVDJ6Wcspxv8vxATmkIh7r3txJNSnz8wkxH2jLHYHrVHSAn7kCBqd3
 XZq0UNazjo3W+SvNAAQqI/scIOErvY3h8Axq6sDB0iGBcz9eItCaNpnAvetWTORN9FH/fqD6f
 aUbAtk5JgDJTwXkuwk02R+ioUSNozS5Wp+3yRRXFi141BeT5aXZhQTZGUvTjQobKQTO0CLHZj
 osPhF8R70+BkiHi07dIcCQaISgeJ7LuEKaW/EjDwNh5FVHOJpmQZ+vjPykUzDWMY6ZfciIFPm
 YODsGlDnVRpePYYhfN01n96xcHS1dIlXzOFb0jhD9MyrM1SwRYsdGh5Pu8WMy44jpTcObSU9/
 QePqY0JX7U2tVhzDKiBl+XyXdxX8NOXyweUEckhCt0SXHctckr5Zm++SjtEGmc3dYWW4cJpi/
 cHNa1mxaY9yvS53X7PJWV0qLRydhIt+F2zJK36X16s4jWW9mcVh0jRuQtJGn48BYtkxzkk09R
 gZZXMNmce3/1xOMtKKvHu5EijM4AvPxffqT5L3/mdBGoURlsCLHgBaDxdZlTbNv0YYuo8vW6+
 Gzc/6ofwc5sgkSQJSEzWhAerQLhgLPl+Y1EBImJcBrHAY0TqJZllKmyuayMNWOVKqpn24lU7i
 Qp+4v+DFeMro6cAUNV51uUltDks=
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

Commit 86f04735ac ("linux-user: Fix brk() to release pages") introduced
the possibility for userspace applications to reduce memory footprint by
calling brk() with a lower address and as such free up memory, the same
way as the Linux kernel allows on physical machines.

This change introduced some failures for applications with errors like
- accesing bytes above the brk heap address on the same page,
- freeing memory below the initial brk address,
and introduced a behaviour which isn't done by the kernel (e.g. zeroing
memory above brk).

This patch series fixes those issues and has been tested with existing
programs (e.g. upx).

Additionally one patch fixes running static armhf executables (e.g. fstype=
)
which was broken since qemu-8.0.

Changes in v2:
- dropped patch to revert d28b3c90cfad ("linux-user: Make sure initial brk=
(0)
  is page-aligned")
- rephrased some commit messages
- fixed Cc email addresses, added new ones
- added R-b tags

Helge

Helge Deller (5):
  linux-user: Fix qemu brk() to not zero bytes on current page
  linux-user: Prohibit brk() to to shrink below initial heap address
  linux-user: Fix signed math overflow in brk() syscall
  linux-user: Fix strace output for old_mmap
  linux-user: Fix qemu-arm to run static armhf binaries

 linux-user/elfload.c |  7 +++++++
 linux-user/strace.c  | 49 ++++++++++++++++++++++++++++++++++++++++----
 linux-user/syscall.c | 23 +++++++++++++--------
 3 files changed, 66 insertions(+), 13 deletions(-)

=2D-
2.41.0


