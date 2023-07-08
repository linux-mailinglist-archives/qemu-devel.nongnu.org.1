Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD87C74BDEE
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 16:58:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI9NO-00060g-B1; Sat, 08 Jul 2023 10:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qI9NH-0005zl-8t
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 10:57:27 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qI9NF-00034a-6r
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 10:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688828241; x=1689433041; i=deller@gmx.de;
 bh=MRFWyys/pRDzPL17ehA9v7e55uBsofVk1QAYn28gpu8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=tsu3Q2zB+ARdvBVLnZEoWfgLvGHUBl7y3kYZa4P5+LRWR4DAuCzYV3Oges2dG8aLQgykJSk
 N0FUOVJLCv/YyfXLJXkGN311j4z9VamE1+RY0iJ2FOE5fasEij1gGqE7eHJJMQDlSXp/RZZa+
 SUO+BpcaLh86cDLuoC1S+86Kk87qOZpCQN6X3pDQ8eUGhQ109kBl/ZBTXNXj2F1Q8053xqR4s
 6BNHAezCZq2QO88c/f/43COnmUnOFReOBtY1Otb7vCkbGasRzgBgojc4i5oXg9udfbmKNSJTe
 DlM2MioHr7UKZOYa3DN/1UcH2vy2iNty5jFI0JoKUkuRqFj8UJaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.155.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sit-1pvLCg1Uhb-018LnM; Sat, 08
 Jul 2023 16:57:21 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 0/3] Linux user fcntl64 patches
Date: Sat,  8 Jul 2023 16:57:17 +0200
Message-ID: <20230708145720.136671-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2NXq20ATzJ8nseTRT5bSiF6SbVe24QZTjei2WbfOEm2dfLVUd4Z
 IVQdf4KqI+zOBU80gWKrv78nQT3dI6ZQKikcFZOnBGsVudGxXNIAufpZ9PYLFUZuTf/MPds
 GbMVje14uMBYPhdLx90zGSN4RbTSuJI2rHBK1qraThIgPtxHRJADbA9hOwFsJnnvRbxnTEn
 CsnyZAI6GCMP5faqfs9iA==
UI-OutboundReport: notjunk:1;M01:P0:22JKd3FG/V4=;BKSYqPnxkwrE0dUqlvnUKkYksvW
 rM06lSTVCo6fhI2Chh/Wku2YQLHiqu8SmqVDcZpd4/IA30V1E9WSCck/xJJjDISOLpIPVZxy5
 pbuVOM8ICQnFTRpQoHwii4tdtvYB9gpaQ2GdcNX91WjgeMTjFR9Yz/Z/SsK2sj+VJZBoo7gca
 QyR9AkAtGaFvcQTyyKKkrFFhycmuoclq55siVj/H5OOtmSOJCscqmNzpgaX9wyKfXqoq4GADy
 tQS3yztl89FnMh8cKWu5oEc822ueR7M44t4XIGTQwJo3OjVbHCIOEu/kBLZ/P3eaImdzpLdK2
 esPdsn0qO4ZT6QRvsFxBg1FTcWXPfAFn5y0xiqAbPb8BsMK5TjYvZgBDHxlCtpsFlb7ZHzpsn
 gVPPmRvhl/b6tazXFlW3zh70oP7QJfm4myHVUymkfYVSPDMk3LwhTfQyptCS+cFZQHvMwwcGm
 MjZ+INcvUmI7UiTOwGnWnGRBFkWJzJ6tusmAF3CtPCBM6y/uZD8Kl3pZwf/eZT9xv8Uw+r9+0
 tD/xWmf/1UAvkhphaQvDZuUsjHOhBK+kI3oMJeJ88PzhzxYEq6V4TOWr6LHtFTmr8cL+CrqoK
 W+FisF7diiuKX+2qwjiJhEbJEfnbVDEh1T4CKizEsU7vylWh7u/l+qPlwNpriunVNQVz8y+Nr
 S5FC3v3V7XPAWiucj+sm6L8x6uUZb88+IKrrmqmRMFEdwDlKUoCL/4G9yg2QfWmOHY63MlvY0
 v00t+SWvqmQbY4sfniH9fjR0x24F2oQZSHCxsqIiB7UMjQcLKaWmWiwSHRhwkJsZ15YyM+wfR
 BFnLeeOFhWKAiHTFWlo56hAy30+Jg/3gBxwlp8t78e+H/af1JvqqUSnQyNOEWeZMrRBOFMoKQ
 JUtfkXCgGfBxIXRD2dzDQfTaH0MFATbtinOKzWosWNc26QUChimemi46reP8mQxDtRtEb56JV
 0R2qVFIMoB7ltpTzDWn24gd3xYo=
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

The following changes since commit 97c81ef4b8e203d9620fd46e7eb77004563e367=
5:

  Merge tag 'pull-9p-20230706' of https://github.com/cschoenebeck/qemu int=
o staging (2023-07-06 18:19:42 +0100)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-fcntl64-pull-re=
quest

for you to fetch changes up to 036cf169a3484eeca5e17cfbee1f6988043ddd0e:

  linux-user: Improve strace output of pread64() and pwrite64() (2023-07-0=
8 16:55:08 +0200)

=2D---------------------------------------------------------------
linux-user: Fix fcntl64() and accept4() for 32-bit targets

A set of 3 patches:
The first two patches fix fcntl64() and accept4().
the 3rd patch enhances the strace output for pread64/pwrite64().

This pull request does not includes Richard's mmap2 patch:
https://patchew.org/QEMU/20230630132159.376995-1-richard.henderson@linaro.=
org/20230630132159.376995-12-richard.henderson@linaro.org/

Changes:
v3:
- added r-b from Richard to patches #1 and #2
v2:
- rephrased commmit logs
- return O_LARGFILE for fcntl() syscall too
- dropped #ifdefs in accept4() patch
- Dropped my mmap2() patch (former patch #3)
- added r-b from Richard to 3rd patch

Helge

=2D---------------------------------------------------------------

Helge Deller (3):
  linux-user: Fix fcntl() and fcntl64() to return O_LARGEFILE for 32-bit
    targets
  linux-user: Fix accept4(SOCK_NONBLOCK) syscall
  linux-user: Improve strace output of pread64() and pwrite64()

 linux-user/strace.c    | 19 +++++++++++++++++++
 linux-user/strace.list |  4 ++--
 linux-user/syscall.c   | 16 +++++++++++++++-
 3 files changed, 36 insertions(+), 3 deletions(-)

=2D-
2.41.0


