Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF9E76C0DB
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 01:28:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQymS-0001Iq-P3; Tue, 01 Aug 2023 19:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymQ-0001A7-O7
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:54 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymO-00077w-Tn
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690932467; x=1691537267; i=deller@gmx.de;
 bh=mxsVouj45H8MnO8VeR6Gb0m91qsKsgzj5h9mJziPaLk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=H5LqQEWvIvtz+RzSXPUhqp02hzlGT186r1kgXFGXuit74L/rX04h9JHmcueVC4vDIc2OWxo
 sXDJoKiF60HOKLR85EYh54Ek6KSSGC1LW3hSw4VrBpSYVs9T1tPNzrCda3kEY6g65CFGia0jY
 q//QYHG8trR1R2uNeEupw2r0tZHpUvaD+CxbbarYrK85L6c2GxkDRQQWWsFlyDPFq59eRWfbg
 bGBeRG7jTL03b21PMH2SV8LVnXGLmmEe/lVwW9IJ1/c/V4Xgl01KkMpRS44PATP0nrbPnAX2r
 Vbi4Me6pf9kDikc3BYi0AoavJDSpJ43kHTeh4/yVR/NaBsTcyQSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.150.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zBb-1pnbiz3MRf-014y5p; Wed, 02
 Aug 2023 01:27:46 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v6 0/8] linux-user: brk fixes
Date: Wed,  2 Aug 2023 01:27:37 +0200
Message-ID: <20230801232745.4125-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:72YiTgzt4HjdPAuCf17C0+CIMqEQfsB5hMuQidBBQFDNFLQ4hrT
 ekAx+VrW6q15v2/OH9tjyPEfakvEdepfEJhMD4VWXYF3VAE8gqqOWAsgzmKO+9BxzkQyzck
 UhzHMtXjf8U1us6kkWvp412eKkmKslF98bLOU7ifQ11DzfK3u+nZvdhYG2WJVlgxLiF9/WL
 NbaBIrvtLZBqpPgC8wPJA==
UI-OutboundReport: notjunk:1;M01:P0:pxb9sgBxOcM=;xFJ4+kICgyfd3t6jlq39AZjn/fy
 Ak819ZrxA++UEzt1E2RNYkCI6on9ktglgnPXAM5exXknPBh9uzCSEZzo94nQRUizNsorXNqtP
 MA2Y+RGtTZ1FQPbg9M+mEcSRShN77f58OS5hfwQ4b8kNNouRNGOFE0jzTS1MOD9SQoH88TQ5O
 Xgu1946PJ7NwlCMEoz4+KJMil9HjrMrlIbuOllSOHtW5mFouX1wQ+fGhyFvMLgskhiJkb/yor
 89hl+8q2BvSkb1PMoJzuTkxcHwZiudSzu9dqkm4TzCK9+E1Fkt4VE1U6riIaGYYKvie2hwzYr
 cvYVuh9g0eryeBZjzQRD5yNdhZ4tTBApURwovSZiOrLjs7ZbO+tHDUQcBGUeg8cpr0kMfCzJl
 FTiF6LKcR4bBfIelxzd2W0MkyitHOfs3Rq4v0nQ7yXgmDPZwyNY24kKRal9XFLldEp/tMO5NY
 X7tjBHf3tCuDiPj+d7kdABRdLYH1ONMa3oWXG0+kn20N+DSNPT7lS9SLp3v1CPtFggO7Vn862
 83KSarjguGC5BsXkMXnV8tIxzRIBXvsJw4Gnroj61OmBlHeq5R2dNHCv6jx36JNKXsKCutDN6
 vYhVJZg/ssPncURKOxEvh22XOrhJ7rC1lrp+NpKWSQ247rXyA+nXnNjsJX5Ef5qyvgQv2+duI
 qSxZHLjgkpqZNcD3rvfzMvUiQJxipkbmitfF5z8za5p9wECBvwnO53MoYjjPmAZYQxNuCvYrZ
 yGiZ5/8vk7RmIl/gf0uGGHn3sL0g8kneqVHtG2an4oBuqYJBpL8UZ+ae3tF5BGmrvW+CCxzXM
 iNQeWBhPQ3Jr/W7ODNF6DTADsupOhtswYyDFvYh3POquaNnL0m9h9YW0eR8j+E+McNNMh1/Ex
 U+wHF5PJSnwh/2jRSE6bHbQ2CTa8wXG1ziYy60sQ9d88RbR4Z9Bbffu/jSQpDiR568i3/QhSQ
 7hdtA8m0w5/ukoNbC+u44+Lumeg=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patch series is a fix-up for some current problems
regarding heap memory / brk handling in qemu which happens
on some 32-bit platforms, e.g. problems loading static
binaries.

This series includes the 5 patches from Akihiko Odaki
with some additional fixes and cleanups by me.

Akihiko Odaki (5):
  linux-user: Unset MAP_FIXED_NOREPLACE for host
  linux-user: Do not call get_errno() in do_brk()
  linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
  linux-user: Do nothing if too small brk is specified
  linux-user: Do not align brk with host page size

Helge Deller (3):
  linux-user: Show heap address in /proc/pid/maps
  linux-user: Optimize memory layout for static and dynamic executables
  linux-user: Load pie executables at upper memory

 include/exec/cpu_ldst.h |  4 +--
 linux-user/elfload.c    | 59 ++++++++++--------------------
 linux-user/loader.h     | 12 +++++++
 linux-user/main.c       |  2 ++
 linux-user/mmap.c       | 35 ++++++++++--------
 linux-user/qemu.h       |  4 +--
 linux-user/syscall.c    | 80 ++++++++++++-----------------------------
 7 files changed, 79 insertions(+), 117 deletions(-)

=2D-
2.41.0


