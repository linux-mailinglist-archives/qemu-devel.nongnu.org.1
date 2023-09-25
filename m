Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 269727ADB08
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:11:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknEY-0008N6-K5; Mon, 25 Sep 2023 11:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qknEQ-0008HM-Fj
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:10:43 -0400
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qknEN-0005Ls-Gd
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:10:42 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MwfrG-1rZtU43FmM-00yB8d; Mon, 25
 Sep 2023 17:10:30 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 0/5] linux-user: clean up local variable shadowing
Date: Mon, 25 Sep 2023 17:10:24 +0200
Message-ID: <20230925151029.461358-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YlewPUGyST8yeSu9QUlJ/17Nor3ZS+NlYexFrK7HsGjfy70utqg
 mJu8q0IDIvOwSpF7Ib14wmbGzEe0JBs5eqb6+pxiRFK5iTIh0IeWs5g2U/fiADMJpx7lfbj
 R+TCHpVOIBbUo0nLsKHgpH/Cxxp36gnHTBfZuH+5ZXZm3IcaNNp/nzULi0NCbTy8xkJjop9
 rVFHIowaeSI6yhhuO2eog==
UI-OutboundReport: notjunk:1;M01:P0:65mx6ie9exQ=;3GibBb0NjKr552LyQ1wvm2BU3d6
 leF5j400o0wBo2riMq5IxwNrWxFatXtsgSZzr8vlKwjGX8V8SpkO3W5qrrMuLbVS1XiqmidDL
 7Zj9TmTtLvslKePsFTeeh8hCBzimLeJTUjUXFavkq8AQvQKksNlyDHAVIZ3U5BXi+YfqYiQyt
 PGmG8mCLyIpS3UttghzoDSXicys/YYTnGgH7OgGoTJXq4KY59ZTYTiTYzl8FlmO9itxgdvQpN
 bRPJf31XqqjNXFw3kkc1c0FLxu9F1N9V4eCKWv0DOQzQHJTxgEqAnxrvMl7cmOzYANFONUJPb
 4ImFnbuvHW4JRPScD7i7a0x4VCf7i2s/a8SCIgho8FyykxkNzgr3QRjQTF+HH9u8Mzs2+w/W1
 dw4vy+C32RfQ+e0Q0zKX1LBtjP1m9u/Y8PkSMjLlKUHAXJMrj6s3Y4VNnh/LTdNo5hpDfqmoC
 By66BYTLybE+KIvwPXm9LgSlRknBA8l3lWaoKVzEBHaIm3irxJUmxpqLhvlGTw2fE7TxR3RF6
 u76O1V36Nc6SwPQEXHKA8cFIrZdeVo3LPekZaZfhOeqQ9lDhOnOX0yvD14exG+5+HjipOKENm
 quPdZilOLQgmPC0nJ7aBuCxNHTJ89fKDgFu1lldMsRFJhxA+nmXFv80YmmCu0VVcxqreCGz3P
 99etj/WUSnyviGTkCA0y9nb8R7eG9vS/wqaCH9zMT4Sih6J2XBHDJU5OFhQafcTz7Eo4nTTGs
 TTd8+TpDe/mD12OSTnddz1x2pZFC1gGJ7ARpdAdKAdm/7ESzkP7ZsiszUxUjRRsqX4Fj1FUEr
 bNy5zK7hBIEuya/EZNZpNgMoqfCG5NowKlrxkm3b1pDBVbVVa5skLFAcm59NdLeSzP2uqJCOz
 HMc2kBznUcyiIzA==
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



Laurent Vivier (5):
  linux-user/flatload: clean up local variable shadowing
  linux-user/mmap.c:  clean up local variable shadowing
  linux-user/syscall.c: clean up local variable shadowing in
    do_ioctl_dm()
  linux-user/syscall.c: clean up local variable shadowing in
    TARGET_NR_getcpu
  linux-user/syscall.c: clean up local variable shadowing in xattr
    syscalls

 linux-user/flatload.c |  8 ++++----
 linux-user/mmap.c     |  6 +++---
 linux-user/syscall.c  | 36 ++++++++++++++++++------------------
 3 files changed, 25 insertions(+), 25 deletions(-)

-- 
2.41.0


