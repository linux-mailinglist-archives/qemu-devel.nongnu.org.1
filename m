Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B35BE76C0DF
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 01:29:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQymU-0001Jj-2F; Tue, 01 Aug 2023 19:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymS-0001Ii-54
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:56 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymO-00077t-TX
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690932467; x=1691537267; i=deller@gmx.de;
 bh=dNLgHG2agLIXgxeCp0C/7+fkMs1PEdZE6CSSHjmy6d0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RLojQbWby4qWMuYp/OpV5DD3LQu6GnNyHhqXusJNLnfKqToqE30nokbaTs9flKHWjRcnl05
 LqLPYri6ktKWUgLhefHfPsQZf/cm60Kp5YL+ObxyDUvEnzJV7IBkI++33HXZQO6Vv6lI4eDxX
 4IA4JiiG6vc8YuHBKu1Jm4JvWm1bup7d4MhMdg19LUKk6nJqH/iidZ9Buc2WEt7bILp1F4zun
 4To+H94Tt9wPUY0yecbr5MFK1LvdWG3fKEYGIuxRngznQG7uzxHcSSUYArmuF3moAyCgC2zqY
 CQiWZMUytGJcxWAtsh5udVkI7a3trHtnLIIgYWhkIeVFCEeWOC+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.150.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDou-1pcIvr0Eq8-00xZJK; Wed, 02
 Aug 2023 01:27:47 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v6 1/8] linux-user: Unset MAP_FIXED_NOREPLACE for host
Date: Wed,  2 Aug 2023 01:27:38 +0200
Message-ID: <20230801232745.4125-2-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801232745.4125-1-deller@gmx.de>
References: <20230801232745.4125-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B3tlJFMshtiM2Poswf1l5+h72Tn/39nTePXhwLZ1K7DWjHtB9t4
 ss+UfiYeoRbyApOMTnkTi8/w5NMxJmK8e/MdWFUxGc6ipHpgsHF5EPXpbb+Wf9KHVw1RP+O
 oVL6bKCCvGwsQRzfXUaQZR5zcW6roqruY1hq0eVUY5mrJCZRJpD0XoFkjeshX0aJMQwVQQv
 tVRg7VW4gn92bicRHMPWA==
UI-OutboundReport: notjunk:1;M01:P0:/36yxsE/tso=;mt90+x41U2D6EVVh0VO6Dna8tps
 eiI+Z3pn8nEnpTc4e9a2QG2kMR26VLCHY4/kDcqdvydUSuqSSyO7iSj2gLiAiex1eIayZm5xh
 cWAESoDe4QaisltZBYngzU/m3JSLRpYlZgJnGnYVSmL6YzjqBgactHB0x5rHzquRe9RpAKVas
 OJzj0pdcoianZkw6y8PqwXr3U8apOk9X6nhiCYwvnQXX4g7wrTdKmwpVvBDzYisaVDzaNuVoC
 pMFqlj0n+rjr8qePbqomGp5UfesIIn68/oXkY+aRzAlZmzZyh9nDHNt7G7dR//fcjPHzK1FQi
 VcmbXJ8nupIO5ohDPBqn/gMWSoSRPcqrCD06O9oIHdvY/mdJlDXnuNQWNvWK/d4XNdtIm72YZ
 Tc9vm87wzHcVgLpi5r1Wm/LKpPhSBQKdS6YY+WxDCk1wpWr4s5fgxF1LCU79/IqrPXQxRp7Qc
 0qOCAtMUKO7d6OcH2lMxSg7hZGFEcUd2L9X1BPFd2usK5PJQncsZoNLHEXXL2+6G1VzGwFAd4
 Kt9hfqiYrqPIDVCZV6Szh3CngRANgCy+Kow5I1fysg+acQjrlQ4iTvGFhLAQpLeGiWg5ersjr
 BAIoXLwLGvPmqnNoX/tLfjtay6pvxwwwJhqmuVy8Q3Py0SYOztkDHSlpCwfgCUYoch/b4Eyx6
 R/ylUrckFvH8+i3q1rtscmFmsSkXxPQuUofw1hlQgTKnO4eBa2i/Ojq4ki5qU4sgT6Nwkb26k
 wCvDb4WvZBLxJTvLmozKLhitgTDmk2rNWYQdpXnULMnt9Fnt2yAbrlvN0maZJKkfVAajLFNPR
 YALzT7Q7lQphxwATX5yE7Lsub3pWKl9om7zpABqAr5r6RTsoEkFPfbuYBKrpcBQFPzOOI3rg+
 656EePfTi/EzNYoheXDy6TWrrySiKQJ+qYGqqisSga4478/VZOOaa3XG6ZSnIS7xs/1owPiiY
 oKpm1HMfUXFrX6/mGGr0BbE8/Xw=
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Passing MAP_FIXED_NOREPLACE to host will fail if the virtual
address space is reserved with mmap. Replace it with MAP_FIXED.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index a5dfb56545..2f26cbaf5d 100644
=2D-- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -610,6 +610,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, i=
nt target_prot,
             goto fail;
         }

+        flags =3D (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED;
+
         /*
          * worst case: we cannot map the file because the offset is not
          * aligned, so we read it
=2D-
2.41.0


