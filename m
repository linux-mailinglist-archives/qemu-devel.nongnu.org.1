Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C6CB5855A
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Sep 2025 21:35:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyEvj-0001my-EK; Mon, 15 Sep 2025 15:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyEvJ-0001it-FD; Mon, 15 Sep 2025 15:31:37 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyEv7-0001th-Pl; Mon, 15 Sep 2025 15:31:37 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E7F718099E;
 Mon, 15 Sep 2025 22:31:12 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:184::1:6])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AVVVql1FrOs0-9YSMu8WZ; Mon, 15 Sep 2025 22:31:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757964671;
 bh=RlGfpNnRymeYEAnMnlMTM+rwGwILBlyJg6AE8Dy+EfE=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=wCVSaABr41RvCGbnoaXmRVBiXZlJRogMLHOW46Lo2YaZROyPfTof7uzadXI27YQhP
 aGnvpc7oHUReNtmAfoYjVKHmtd52e/Lm01U21TaIlq3+CdIntrF3lsZA4zD8I6rqCe
 S31xRGpeuV8gMkeJpxd9m+FSUcYWCdW19fLQW+U8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com
Subject: [PATCH v4 00/12] io: deal with blocking/non-blocking fds
Date: Mon, 15 Sep 2025 22:30:52 +0300
Message-ID: <20250915193105.230085-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all!

The series aims to unify code which sets fds blocking/non-blocking
through the whole source.

v4:
Drop patch about error_reporter, and use local_err
instead

04: - use local_err instead of dropped error_reporter 
    - change error handling in tcp_chr_sync_read
    - fix change in nbd_co_do_establish_connection
    - drop r-b because of changes
05-06: 
    - use local_err instead of dropped error_reporter 
08: add r-b by Daniel
10: - use local_err, drop r-b
11-12: add r-b by Daniel

Vladimir Sementsov-Ogievskiy (12):
  char-socket: tcp_chr_recv(): drop extra _set_(block,cloexec)
  char-socket: tcp_chr_recv(): add comment
  util: add qemu_set_blocking() function
  handle result of qio_channel_set_blocking()
  migration: qemu_file_set_blocking(): add errp parameter
  util: drop qemu_socket_set_nonblock()
  util: drop qemu_socket_try_set_nonblock()
  io/channel-socket: rework qio_channel_socket_copy_fds()
  util: drop qemu_socket_set_block()
  use qemu_set_blocking instead of g_unix_set_fd_nonblocking
  chardev: qemu_chr_open_fd(): add errp
  chardev: close an fd on failure path

 block/nbd.c                             |  4 +-
 chardev/char-fd.c                       | 14 +++--
 chardev/char-file.c                     |  6 +-
 chardev/char-pipe.c                     |  9 ++-
 chardev/char-pty.c                      |  4 +-
 chardev/char-serial.c                   |  9 ++-
 chardev/char-socket.c                   | 41 +++++++-------
 chardev/char-stdio.c                    | 10 ++--
 contrib/ivshmem-server/ivshmem-server.c |  9 ++-
 hw/hyperv/syndbg.c                      |  4 +-
 hw/input/virtio-input-host.c            |  3 +-
 hw/misc/ivshmem-flat.c                  |  3 +-
 hw/misc/ivshmem-pci.c                   |  7 ++-
 hw/remote/proxy.c                       |  6 +-
 hw/remote/remote-obj.c                  |  6 +-
 hw/vfio-user/proxy.c                    | 11 +++-
 hw/virtio/vhost-user.c                  |  5 +-
 hw/virtio/vhost-vsock.c                 |  8 +--
 include/chardev/char-fd.h               |  2 +-
 include/io/channel.h                    | 14 ++---
 include/qemu/osdep.h                    |  1 +
 include/qemu/sockets.h                  |  3 -
 io/channel-command.c                    |  9 ++-
 io/channel-file.c                       |  3 +-
 io/channel-socket.c                     | 74 ++++++++++++++++++-------
 io/channel.c                            |  4 +-
 migration/colo.c                        |  5 +-
 migration/migration.c                   |  8 ++-
 migration/postcopy-ram.c                |  2 +-
 migration/qemu-file.c                   |  4 +-
 migration/qemu-file.h                   |  2 +-
 migration/savevm.c                      |  4 +-
 nbd/server.c                            |  4 +-
 net/dgram.c                             | 28 ++++++----
 net/l2tpv3.c                            |  5 +-
 net/socket.c                            | 27 ++++++---
 net/stream.c                            |  9 +--
 net/stream_data.c                       | 10 ++--
 net/tap-bsd.c                           | 12 +++-
 net/tap-linux.c                         |  7 ++-
 net/tap-solaris.c                       |  7 ++-
 net/tap.c                               | 21 ++-----
 qga/channel-posix.c                     |  7 ++-
 qga/commands-posix.c                    |  3 +-
 scsi/qemu-pr-helper.c                   |  9 ++-
 tests/qtest/fuzz/virtio_net_fuzz.c      |  2 +-
 tests/qtest/vhost-user-test.c           |  3 +-
 tests/unit/io-channel-helpers.c         |  5 +-
 tests/unit/socket-helpers.c             |  4 +-
 tests/unit/test-crypto-tlssession.c     |  8 +--
 tests/unit/test-io-channel-tls.c        |  4 +-
 tests/unit/test-iov.c                   |  5 +-
 tools/i386/qemu-vmsr-helper.c           |  6 +-
 ui/input-linux.c                        |  3 +-
 ui/vnc.c                                |  2 +-
 util/event_notifier-posix.c             |  7 ++-
 util/main-loop.c                        |  5 +-
 util/oslib-posix.c                      | 22 ++++----
 util/oslib-win32.c                      | 25 ++++-----
 util/vhost-user-server.c                | 11 +++-
 60 files changed, 341 insertions(+), 214 deletions(-)

-- 
2.48.1


