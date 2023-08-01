Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BB476BD6F
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 21:12:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQulm-0002dr-No; Tue, 01 Aug 2023 15:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qQula-0002UW-87; Tue, 01 Aug 2023 15:10:49 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qQulX-0002D8-OG; Tue, 01 Aug 2023 15:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690917036; x=1691521836; i=deller@gmx.de;
 bh=uDGEymMeuxbJm7iG659JvfKB+IkoK8ZuaJ/NcV7oLs4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=SQGDJWASUozXwS1uK0HSQk9PSfn9dfxUQxO2TFNH3XuW8aXGxeiA6P1eE4mOIAMGwxMvl1H
 kWfc8+qlhUx7RzY86Zzj10tS+0AFFzzhx7Pdw9PurmPlb+nazIcSg8cA3QtMMhEdoK0uSplfB
 CxGhfj38+CDcqHKzlxChtCZ8vYEM/Jm99Ev/JEuu9nRmCz/k5eI4rkM5dJpH1Ksjf3ScpsDtH
 F8hmHJYFVpU+N2IOPGLqpaaMuOOoDpSc64s20gpiq+nX2hQu/M1Z2Z5d+nCz153L2cpiNk5vI
 wkSlBb9TnRAaXXAXVnvwdsF4V6fnJtSwqneEHdjFgjYxGHJjObGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.150.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbRjt-1ppN5R2uFN-00bqxM; Tue, 01
 Aug 2023 21:10:36 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 0/2] linux-user: /proc/cpuinfo fix and content emulation for
 arm
Date: Tue,  1 Aug 2023 21:10:33 +0200
Message-ID: <20230801191035.374120-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LmUdfw4mDpzYk+PZxXdWMdUMj6KMTlX0DL7Xd0ZLO5jLQbr8lqF
 qXSpF3BPdBowA3PACJJyrt5LwTVhA59yPv6kLQkQ8RBWkRqbZNRADlTKahuR0+O1OJn/VNv
 aDJ+ll2ZilMjtHNdAq6rmM+KON0MNBwUUVuA9Fb2FX8u2LFI/jZBLxgzMYMHW9ZSYduIpWF
 Kp5ReMN6/PRLQokktloHw==
UI-OutboundReport: notjunk:1;M01:P0:zRnIdzBKIx0=;Kja0hvd8hqtKjIDQo9kKkhzbqaq
 G35N4lcs0R6ZZDcBluuOKU7MdU3gT2FbbR57viDdnbIEaKYlmPgkwv7M1Q32KGZuDWr9Cn8Pb
 bZZ2WOAd/mKsLmhVVBSsz7MGPx6oVgSRLaVsiNz626gkNKJCTzpKxlsLi++f3PNF75IwKg6fv
 A/Rs4LkbbMUjQUD1vvsET6S+/0tqunSy0U9sXEI686vIrRw+1KWa01n6mlPDmgYC6hhzSJkMF
 0blPgAQJDxKYkhT5atsiCfOsWMeRVwYshTOkE8kE2arkXbbVQBHTqHtw8Xe393oDIvo96Mkvn
 qFO20uRpjzaFWGrPGvmm5P4KX7LDakeUqb2pNgmJq2otIGZlfySLjHxykouT+rKbrpYwhiaiR
 J09/G6jtrTBd2u4uyLuPJX4RqpNtpxaed4R7Jm/YTQZk72kMv6TaRb0yrqL140cti4362fPzn
 q/2cCNnlxMqInOl4uClQvOhtNH/vVU/T2OadbGca232PROBS7j2gN1gXUabfME4UfMhec/Wc4
 e+E/TePYUEBTrhXgIKmu5CyuGulAFEDD97XlaGVROs9+H4/nFaHl0SuWFJN8nKknoumqV8ckc
 Z+Lqvj/8xW9vOOogK9BYarI3+/pFEWpC5yloOxKa0NHgOAIm4l/jP8OgcF4dkN2ShSSIEBZQf
 vksJIljkWecKRurg19lxL7iA97eNSNIx7m1ESd9O8HeDueIIycsBbdkIfvi/QArCKDDKl5QqS
 Fd7035XaeKLs015yhLaqdvQ+jMvU+mtbVmeGQA5VJ2vdxF9rdr00kEl8J5qUAWjvpcZCMaiz4
 2GTO5EFVzq1FvVte/JI3shzU3tj1juTUQIFGTnvcowZGK3QNtPpmNRzan/NlgcmveW8H7xqOO
 VNnoaM6AAtVrWkVljahaJ1E+IRJzY2dPzzBLvxggCIby4ewcdm6f8+wnudY7SRvSMctyHzAe7
 FDjwuZBfbrKrHgzxM4LjWBnd0MY=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

One fix for correctly detecting /proc/cpuinfo access
and new /proc/cpuinfo output for arm/arm64

Helge Deller (2):
  linux-user: Fix openat() emulation to correctly detect accesses to
    /proc
  linux-user: Emulate /proc/cpuinfo on aarch64 and arm

 linux-user/elfload.c | 130 +++++++++++++++++++++++++++++++++++++++++--
 linux-user/loader.h  |   6 +-
 linux-user/syscall.c |  70 ++++++++++++++++++++++-
 3 files changed, 198 insertions(+), 8 deletions(-)

=2D-
2.41.0


