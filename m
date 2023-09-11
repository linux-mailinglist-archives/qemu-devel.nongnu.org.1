Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C70A79A4A2
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:37:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbT2-0005My-AF; Mon, 11 Sep 2023 03:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qfbT0-0005Mq-9Q
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:36:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qfbSx-0005aG-Pi
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:36:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DFE0C20AB6;
 Mon, 11 Sep 2023 10:36:03 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4D13127213;
 Mon, 11 Sep 2023 10:36:02 +0300 (MSK)
Message-ID: <a1f2b1ac-3d88-8e46-5a3b-f6df740bd418@tls.msk.ru>
Date: Mon, 11 Sep 2023 10:36:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: linux-user vs system build options and libraries
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

I noticed that linux-user binaries, when built separately (with
--enable-linux-user --disable-system) or when built as part of
system build (--enable-linux-user --enable-system) differ in size
and link with significantly more libraries which they shouldn't
link with.  libnuma, liburing, libgnutls, - that's what gets linked,
just to name a few.  zlib is also there which most likely shouldn't
be.

Looking at the link lines I see a whole lot of various stuff being
linked, thankfully with --as-needed so most of it gets dropped by
the linker - these are stuff like pixman and many other things.

I already mentioned this before, - to me, whole meson.build options
thing is done a bit backwards: we use have_foo to mean NEED_foo, so
in quite a few places these meanings are wrongly intermixed.  Like,
if I try a linux-user build with --enable-spice, it will tried to
be used even if it makes no sense whatsoever.  We could check spice
and enable have_spice this way (or spice_libs=/spice_defs= etc),
but only use it in those build targets which actually need it.

Also, which might be a separate issue, --enable-plugins seems to
be in effect for linux-user too, which result in libgmodule being
linked with.

Also, there's no way to build/install just the linux-user parts
without, say, installing keymap files, docs are always built,
and so on..

It looks like we've quite barbarian build system still, even after
conversion to meson :)

/mjt

