Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0589EBFC5
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Dec 2024 01:06:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLAE3-0002my-Et; Tue, 10 Dec 2024 19:05:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tLAE1-0002mn-3G
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 19:05:09 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tLADv-0004wP-67
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 19:05:08 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:292a:0:640:622b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 4AEE260DD7;
 Wed, 11 Dec 2024 03:04:57 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6b8:b081:b4a4::1:2a])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id r4aWZp2Ila60-1chJJ2g0; Wed, 11 Dec 2024 03:04:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1733875496;
 bh=y6Z72DKH0on/ziHV/a7pWjLhK5zI8b8z6oQXaqMxeAA=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=ldEXFIu9xQxu64fJEi7TK1OahwzOMyut98P7YDqlEj3zeSCsFIy0EPWQm2TlGtIXw
 4W4TCHmNmpqsyQfu0L5jetOnmJA+zkJNWLS1TNc8W5hdIid2jM/9m32imnbS7FFwIL
 K9/yi/wSaf52iy076lH7By42bvgr3Bch9OFodOVU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] overcommit: introduce mem-lock-onfault
Date: Wed, 11 Dec 2024 03:04:45 +0300
Message-Id: <20241211000447.1310181-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Currently, passing mem-lock=on to QEMU causes memory usage to grow by
huge amounts:

no memlock:
    $ ./qemu-system-x86_64 -overcommit mem-lock=off
    $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
    45652

    $ ./qemu-system-x86_64 -overcommit mem-lock=off -enable-kvm
    $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
    39756

memlock:
    $ ./qemu-system-x86_64 -overcommit mem-lock=on
    $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
    1309876

    $ ./qemu-system-x86_64 -overcommit mem-lock=on -enable-kvm
    $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
    259956

This is caused by the fact that mlockall(2) automatically
write-faults every existing and future anonymous mappings in the
process right away.

One of the reasons to enable mem-lock is to protect a QEMU process'
pages from being compacted and migrated by kcompactd (which does so
by messing with a live process page tables causing thousands of TLB
flush IPIs per second) basically stealing all guest time while it's
active.

mem-lock=on helps against this (given compact_unevictable_allowed is 0),
but the memory overhead it introduces is an undesirable side effect,
which we can completely avoid by passing MCL_ONFAULT to mlockall, which
is what this series allows to do with a new option for mem-lock called
on-fault.

memlock=on-fault:
    $ ./qemu-system-x86_64 -overcommit mem-lock=on-fault
    $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
    54004

    $ ./qemu-system-x86_64 -overcommit mem-lock=on-fault -enable-kvm
    $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
    47772

You may notice the memory usage is still slightly higher, in this case
by a few megabytes over the mem-lock=off case. I was able to trace this
down to a bug in the linux kernel with MCL_ONFAULT not being honored for
the early process heap (with brk(2) etc.) so it is still write-faulted in
this case, but it's still way less than it was with just the mem-lock=on.

Changes since v1:
    - Don't make a separate mem-lock-onfault, add an on-fault option to mem-lock instead

Daniil Tatianin (2):
  os: add an ability to lock memory on_fault
  overcommit: introduce mem-lock=on-fault

 include/sysemu/os-posix.h |  2 +-
 include/sysemu/os-win32.h |  3 ++-
 include/sysemu/sysemu.h   |  1 +
 migration/postcopy-ram.c  |  4 ++--
 os-posix.c                | 10 +++++++--
 qemu-options.hx           | 14 +++++++-----
 system/globals.c          |  1 +
 system/vl.c               | 46 +++++++++++++++++++++++++++++++--------
 8 files changed, 61 insertions(+), 20 deletions(-)

-- 
2.34.1


