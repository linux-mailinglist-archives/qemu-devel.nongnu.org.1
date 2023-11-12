Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5187E9230
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 20:13:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2FsC-0002Z2-Vy; Sun, 12 Nov 2023 14:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1r2Fs9-0002Yr-Qi
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 14:11:53 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1r2Fs7-0000jx-OL
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 14:11:53 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5E34B327FB;
 Sun, 12 Nov 2023 22:12:00 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0070D34AED;
 Sun, 12 Nov 2023 22:11:45 +0300 (MSK)
Message-ID: <2c07a981-beae-4ade-91a5-99f989de4b7d@tls.msk.ru>
Date: Sun, 12 Nov 2023 22:11:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: disable-pie build
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <610aad34-da0b-4b8a-aa22-4ad19513ae28@tls.msk.ru>
 <CABgObfYYnwD+hP2kh=O0jWG5soVno4hNy2iicszgXm--5CyFUg@mail.gmail.com>
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CABgObfYYnwD+hP2kh=O0jWG5soVno4hNy2iicszgXm--5CyFUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

12.11.2023 20:03, Paolo Bonzini пишет:
> 
> 
> Il sab 11 nov 2023, 03:40 Michael Tokarev <mjt@tls.msk.ru <mailto:mjt@tls.msk.ru>> ha scritto:
> 
>     Hi!
> 
>     It looks like --disable-pie configure, which uses -fno-pie -no-pie flags
>     for the compiler, is broken: it does not not tell the *linker* about the
>     option, so the link fails (at least on debian bookworm):
> 
>     /usr/bin/ld: libcommon.fa.p/hw_core_cpu-common.c.o: relocation R_X86_64_32 against `.rodata' can not be used when making a PIE object; recompile with
>     -fPIE
>     /usr/bin/ld: failed to set dynamic section sizes: bad value
> 
>     This is failing for *all* executables, including tests, qemu-img, etc.
> 
> 
> Is this new in bookworm? And also can you compare 8.0, 8.1 and 8.2?

First I observed this with 7.2, but the same happens with 8.1 and current master
(8.2-tobe).

cc -m64 -mcx16  -o subprojects/libvhost-user/link-test subprojects/libvhost-user/link-test.p/link-test.c.o -Wl,--as-needed -Wl,--no-undefined 
-Wl,--whole-archive -Wl,--start-group subprojects/libvhost-user/libvhost-user.a -Wl,--end-group -Wl,--no-whole-archive -fstack-protector-strong 
-Wl,-z,relro -Wl,-z,now -Wl,--warn-common -pthread
/usr/bin/ld: subprojects/libvhost-user/link-test.p/link-test.c.o: relocation R_X86_64_32 against `.text.unlikely' can not be used when making a PIE 
object; recompile with -fPIE
/usr/bin/ld: failed to set dynamic section sizes: bad value

Note: there's no -no-pie in there.  With the change to add -no-pie to qemu_ldflags,
it is there and the link succeeds:

cc -m64 -mcx16  -o subprojects/libvhost-user/link-test subprojects/libvhost-user/link-test.p/link-test.c.o -Wl,--as-needed -Wl,--no-undefined 
-Wl,--whole-archive -Wl,--start-group subprojects/libvhost-user/libvhost-user.a -Wl,--end-group -Wl,--no-whole-archive -no-pie 
-fstack-protector-strong -Wl,-z,relro -Wl,-z,now -Wl,--warn-common -pthread


And nope, this is not new in bookworm, -- it fails to build on bullseye
exactly the same way.  And it succeeds with the same change applied,
adding -no-pie to qemu_ldflags.

It looks like debian enabled pie by default in around 2018 or so.

I stumbled across this issue (with qemu can't be built on debian with --disable-pie)
several times just because I tried to run one or another CI test to reproduce some
issue, and it happened the test used --disable-pie (and most of that is executed on
redhat).

/mjt


>     diff --git a/meson.build b/meson.build
>     index a9c4f28247..0b7ca45d48 100644
>     --- a/meson.build
>     +++ b/meson.build
>     @@ -278,7 +278,8 @@ endif
>        # tries to build an executable instead of a shared library and fails.  So
>        # don't add -no-pie anywhere and cross fingers. :(
>        if not get_option('b_pie')
>     -  qemu_common_flags += cc.get_supported_arguments('-fno-pie', '-no-pie')
>     +  qemu_common_flags += cc.get_supported_arguments('-fno-pie')
>     +  qemu_ldflags += cc.get_supported_arguments('-no-pie')
>        endif
> 
>        if not get_option('stack_protector').disabled()



