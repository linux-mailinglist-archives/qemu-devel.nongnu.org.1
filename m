Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EDF78FBAA
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 12:14:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc19a-0001Kh-2s; Fri, 01 Sep 2023 06:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qc19H-0001JH-Rc
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:13:10 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qc19F-0001Zg-9n
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:13:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 13B7B1E72D;
 Fri,  1 Sep 2023 13:13:38 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 57BF725065;
 Fri,  1 Sep 2023 13:13:02 +0300 (MSK)
Received: (nullmailer pid 3618983 invoked by uid 1000);
 Fri, 01 Sep 2023 10:13:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 0/8] move softmmu options processing from os-posix.c to vl.c
Date: Fri,  1 Sep 2023 13:12:54 +0300
Message-Id: <20230901101302.3618955-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is the same patchset as the previous RFC,
https://lists.nongnu.org/archive/html/qemu-devel/2023-08/msg02145.html .
----

qemu_init() calls os_parse_cmd_args(), which is obviously a very vl.c-specicic
piece of code.  It looks like when moving vl.c to softmmu/, os-posix.c should've
been moved too (together with os-win32.c).  But there are other functions in
os-posix.c which are used by other parts of the code, eg qemu-nbd or
qemu-storage-daemon both uses parts from there.  The result is rather ugly.
One of the side-effects is that even if system build is disabled, we still
have to compile util/async-teardown.c, since it is used in os-posix.c, - and
this one can not be built on ia64 due to lack of clone syscall.  But qemu-nbd
does not need async-teardown, which is also very softmmu-specific.

This patchset tries to address these defects.  It moves the "bottom half" of
vl.c options processing back into vl.c, effectively undoing commit 59a5264b99434
from 2010.  We do not have many os-specific options, and this move makes
qemu_init() the only function which processes options, all in the single
place, which is, in my opinion, easier to manage.

Before this move, lower-level constructs (chroot, runas) are being exported.

In the end, we have almost no softmmu-related things in os-posix.c, and the
same functionality can be actually used in qemu-storage-daemon or qemu-nbd.
For qemu-nbd, it is now possible to switch to using -runas/-chroot/etc the
same way as qemu-storage-daemon does, instead of having one more abstraction
named qemu_daemon().

Michael Tokarev (8):
  include/sysemu/os-posix.h: move *daemonize* declarations together
  os-posix: create and export os_set_runas()
  os-posix.c: create and export os_set_chroot()
  os-posix.c, softmmu/vl.c: move os_parse_cmd_args() into qemu_init()
  os-posix.c: move code around
  os-posix.c: remove unneeded #includes
  softmmu/vl.c: inline include/qemu/qemu-options.h into vl.c
  util/async-teardown.c: move to softmmu/, only build it when system
    build is requested

 include/qemu/qemu-options.h        |  41 --------
 include/sysemu/os-posix.h          |   8 +-
 include/sysemu/os-win32.h          |   1 -
 os-posix.c                         | 157 +++++++++--------------------
 {util => softmmu}/async-teardown.c |   0
 softmmu/meson.build                |   1 +
 softmmu/vl.c                       |  87 +++++++++++++++-
 util/meson.build                   |   1 -
 8 files changed, 134 insertions(+), 162 deletions(-)
 delete mode 100644 include/qemu/qemu-options.h
 rename {util => softmmu}/async-teardown.c (100%)

-- 
2.39.2


