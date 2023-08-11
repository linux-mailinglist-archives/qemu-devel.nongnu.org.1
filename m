Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CD6779648
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 19:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUW62-0003F1-NG; Fri, 11 Aug 2023 13:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qUW5x-0003Em-AL
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:38:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qUW5r-0002bN-U7
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:38:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 91CF919E6B;
 Fri, 11 Aug 2023 20:38:40 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 57F901DE7B;
 Fri, 11 Aug 2023 20:38:31 +0300 (MSK)
Message-ID: <0a5c2161-4c08-8678-84f4-768c5e40cba0@tls.msk.ru>
Date: Fri, 11 Aug 2023 20:38:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@gmail.com>
Subject: scripts/symlink-install-tree.py error
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi!

8.1.0-rc3, trying to build (in a subdir of the source dir), and getting an interesting
error message:

../../configure ... --disable-download ...
...
Found ninja-1.11.1 at /usr/bin/ninja
Running postconf script '/build/pkg/qemu-8.1.0~rc3+dfsg/b/qemu/pyvenv/bin/python3 /build/pkg/qemu-8.1.0~rc3+dfsg/scripts/symlink-install-tree.py'
Traceback (most recent call last):
  File "/build/pkg/qemu-8.1.0~rc3+dfsg/scripts/symlink-install-tree.py", line 17, in <module>
  out = subprocess.run([*introspect.split(' '), '--installed'],
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/subprocess.py", line 548, in run
  with Popen(*popenargs, **kwargs) as process:
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/subprocess.py", line 1026, in __init__
  self._execute_child(args, executable, preexec_fn, close_fds,
  File "/usr/lib/python3.11/subprocess.py", line 1950, in _execute_child
  raise child_exception_type(errno_num, err_msg, err_filename)
FileNotFoundError: [Errno 2] No such file or directory: "'/build/pkg/qemu-8.1.0~rc3+dfsg/b/qemu/pyvenv/bin/meson'"

The ./configure run is successful though, so this smells like a double
error: first it tries to run a non-existing meson.  And next it does not
fail the ./configure stage.

Adding
   print(introspect)
into scripts/symlink-install-tree.py
gives this:

   '/build/pkg/qemu-8.1.0~rc3+dfsg/b/qemu/pyvenv/bin/meson' introspect

so I guess it is the single-quotes which makes it fail, - assuming it
is the exact string which is in $MESONINTROSPECT.  Should be ok to
run it in shell, but not as good to run it in python.

(Note the directory name, which contains ~ and + - apparently one of
them causes the quoting around meson path).

/mjt

