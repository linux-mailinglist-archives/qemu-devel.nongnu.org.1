Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A4AB4200A
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Sep 2025 14:53:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmw4-00061w-QE; Wed, 03 Sep 2025 08:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvt-0005uq-CN
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:50 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvp-0000kp-8Z
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 6EBD7C0162;
 Wed, 03 Sep 2025 15:49:37 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id anf8gZ3GnW20-6ez1Rk9L; Wed, 03 Sep 2025 15:49:36 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756903776;
 bh=KgBDmn2CL6n1Kz39QWWynh1px15TodRLtys1uZLo7AI=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=XNPExnFKw+C6heNZkB/nl1VaoN8xkK8wjAWU5L4AGqMfJRztm0o+WBCtScLBJ4xL0
 lzGIdqQx/2ytG0NRI2RHfphtD0Qjr8DWAPo1TjxzBXHCEdtBQ1BHZ/BkzW8+X9ho+m
 Z8sjkYRt8FUas2FPCXHdbRM8dlccUeFuFczBRSuI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru
Subject: [PATCH v3 00/19] TAP initialization refactoring
Date: Wed,  3 Sep 2025 15:49:14 +0300
Message-ID: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Hi all!

Here is a refactoring of initialization code, to improve its
readability and get rid of duplication.

v3:
- rebase on top of [PATCH 00/10] io: deal with blocking/non-blocking fds
- improve some commit messages
- add t-b marks by Lei Yang (hope, they still counts after rebasing :)

v2:
01,03: improve commit msg
14: fix return value for new net_tap_init_one()
15: add return statements to other cases, to not break them
20: new

Below are the initialization flow diagrams showing the changes.

BEFORE REFACTORING:
==================

```
net_init_tap()
    |
    +-- if (tap->fd)
    |   +-- duplicated logic*
    |   +-- net_init_tap_one()
    |
    +-- else if (tap->fds)
    |   +-- for each fd:
    |       +-- duplicated logic*
    |       +-- net_init_tap_one()
    |
    +-- else if (tap->helper)
    |   +-- duplicated logic*
    |   +-- net_init_bridge()
    |
    +-- else (normal case)
        +-- for each queue:
            +-- net_tap_init()
            +-- net_init_tap_one()

net_init_bridge()
    |
    +-- duplicated logic*
    +-- net_tap_fd_init()

net_init_tap_one()
    |
    +-- net_tap_fd_init()

net_tap_init()
    |
    +-- tap_open()

net_tap_fd_init()
    |
    +-- qemu_new_net_client()
    +-- Initialize TAPState

* duplicated logic: set fd nonblocking + probe vnet_hdr
```

AFTER REFACTORING:
=================

```
net_init_tap()
    |
    +-- if (tap->fd)
    |   +-- net_tap_from_monitor_fd()
    |
    +-- else if (tap->fds)
    |   +-- for each fd:
    |       +-- net_tap_from_monitor_fd()
    |
    +-- else if (tap->helper)
    |   +-- net_init_bridge()
    |
    +-- else (normal case)
        +-- net_tap_open()

net_tap_open()
    |
    +-- for each queue:
        +-- net_tap_open_one()

net_tap_open_one()
    |
    +-- tap_open()
    +-- net_tap_fd_init_common()

net_tap_from_monitor_fd()
    |
    +-- net_tap_fd_init_external()

net_tap_fd_init_external()
    |
    +-- net_tap_fd_init_common()

net_init_bridge()
    |
    +-- net_tap_fd_init_external()

net_tap_fd_init_common()
    |
    +-- qemu_new_net_client()
    +-- Initialize TAPState
```

Solved problems:

- duplicated logic to handle external
  file descriptors (set nonblocking, probe vnet_hdr)

- duplication between tap/helper case in
  net_init_tap() and net_init_bridge()

- confusing naming and functionality spread between functions (we had
  net_init_tap(), together with net_tap_init(); also main central
  function was net_init_tap_one(), and part of its logic (not clear
  why) moved to separate net_tap_fd_init()),

- net_init_tap() was just too big

Vladimir Sementsov-Ogievskiy (19):
  net/tap: net_init_tap_one(): add return value
  net/tap: tap_set_sndbuf(): add return value
  net/tap: net_init_tap_one(): drop extra error propagation
  net/tap: net_init_tap_one(): move parameter checking earlier
  net/tap: net_init_tap(): refactor parameter checking
  net/tap: net_init_tap(): drop extra variable vhostfdname
  net/tap: move local variables related to the latter case to else
    branch
  net/tap: use glib strings vector and g_strsplit for fds case
  net/tap: drop extra tap_fd_get_ifname() call
  net/tap: net_init_tap_one(): refactor to use netdev as first arg
  net/tap: net_init_tap_one(): support bridge
  net/tap: net_init_bridge(): support tap
  net/tap: refactor net_tap_init() into net_tap_open_one()
  net/tap: introduce net_tap_open()
  net/tap: introduce net_tap_fd_init_external()
  net/tap: introduce net_tap_from_monitor_fd() helper
  net/tap: split net_tap_setup_vhost() separate function
  net/tap: drop net_tap_fd_init()
  net/tap: introduce net_init_tap_fds()

 net/tap-linux.c |   5 +-
 net/tap.c       | 553 ++++++++++++++++++++++--------------------------
 net/tap_int.h   |   2 +-
 3 files changed, 263 insertions(+), 297 deletions(-)

-- 
2.48.1


