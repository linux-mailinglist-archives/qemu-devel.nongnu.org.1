Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2512779EA8
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 11:39:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUl4X-0005BL-24; Sat, 12 Aug 2023 05:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qUl4U-0005B9-GF
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 05:38:10 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qUl4S-0002Yi-Gz
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 05:38:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8C50C19F8C;
 Sat, 12 Aug 2023 12:38:14 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 022EA1DF4C;
 Sat, 12 Aug 2023 12:38:04 +0300 (MSK)
Message-ID: <744ac8a7-dd6b-2ce4-3f47-250812241d0e@tls.msk.ru>
Date: Sat, 12 Aug 2023 12:38:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: util/async-teardown.c: is it really needed for --disable-system build?
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

On Debian we're building qemu tools (eg qemu-img &Co) on systems which don't
support qemu-system.  And after commit c891c24b1a "os-posix: asynchronous
teardown for shutdown on Linux", this fails on certain architectures too,
notable on ia64.  This is because ia64 does not have the "traditional"
linux clone system call, it has clone2 with different stack setup.

But I wonder why this file is being compiled to begin with, when --disable-system
is specified?

os-posix.c (which calls init_async_teardown() from os_parse_cmd_args()) is marked
as part of blockdev_ss, not just system_ss.

qemu-nbd calls os_setup_early_signal_handling() from os-posix.c.  This is, I guess,
why os-posix.c is part of blockdev_ss.

qemu-storage-daemon uses: os_set_daemonize(), os_setup_signal_handling(), os_setup_post().

And util/async-teardown.c is always built on linux.

It smells like, at the very least, os-posix.c should be split. We shouldn't include
a ton of qemu-system functionality (like very specific option parsing) into qemu-nbd
for example.

How about splitting os-posix.c into a few files in util/ (not in the root dir), and
adding them to util_ss in case of posix-os?  Ditto for os-win32.c, I guess, but I
haven't looked at this.

And for the question in $subj, this one needs to be guarded by CONFIG_SOFTMMU.

Thanks,

/mjt

