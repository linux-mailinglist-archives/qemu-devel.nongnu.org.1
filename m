Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 015297E8F76
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 11:23:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r27br-0002tJ-OZ; Sun, 12 Nov 2023 05:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1r27bp-0002sv-5U
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 05:22:29 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1r27bn-0008RZ-9u
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 05:22:28 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 85B32326D8;
 Sun, 12 Nov 2023 13:22:28 +0300 (MSK)
Received: from [192.168.177.132] (mjt-x200la.wg.tls.msk.ru [192.168.177.132])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9CF5134A8A;
 Sun, 12 Nov 2023 13:22:14 +0300 (MSK)
Message-ID: <43d299fa-b166-47d5-ba41-66889793d541@tls.msk.ru>
Date: Sun, 12 Nov 2023 13:22:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: disable-pie build
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Volker_R=C3=BCmelin?=
 <vr_qemu@t-online.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <610aad34-da0b-4b8a-aa22-4ad19513ae28@tls.msk.ru>
 <CABgObfYMct5NwGuYtOsFdEYaV6U=Ahe8zMPc_8QRh5a-cs_SEQ@mail.gmail.com>
 <0f4ace5b-7541-4b88-bdd1-f78aed90d01f@t-online.de>
 <CABgObfZg4WO+zZ-wH5mbwH6f0pVd6AzxXukd_5xdg6TGb8O9hw@mail.gmail.com>
Content-Language: ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CABgObfZg4WO+zZ-wH5mbwH6f0pVd6AzxXukd_5xdg6TGb8O9hw@mail.gmail.com>
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

On 12.11.2023 12:13, Paolo Bonzini wrote:
> 
> 
> Il sab 11 nov 2023, 21:09 Volker Rümelin <vr_qemu@t-online.de <mailto:vr_qemu@t-online.de>> ha scritto:
> 
>     No, this doesn't look good. This patch again breaks the native Windows
>     build with MSYS2 and mingw64 cross compile probably too.
> 
> 
> Doh, you're right of course (https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg05486.html <https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg05486.html>). We need to add qemu_ldflags by hand to all executable.

Hmm?  With the change I mentioned, it builds fine on linux, - *all* executables are being
built fine.  Without the qemu_ldflags+= part, all executables fail to build with the
same error.  I'm not sure what's going on here...

I haven't tried win32 build though.

Also, it all builds fine on fedora without any change, which puzzles me.

/mjt

>      >> /usr/bin/ld: libcommon.fa.p/hw_core_cpu-common.c.o: relocation R_X86_64_32 against `.rodata' can not be used when making a PIE object; recompile with
>      >> -fPIE
>      >> /usr/bin/ld: failed to set dynamic section sizes: bad value
>      >>
>      >> This is failing for *all* executables, including tests, qemu-img, etc.

