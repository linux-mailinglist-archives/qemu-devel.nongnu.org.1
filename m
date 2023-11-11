Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9299D7E8C78
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 21:11:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1uIY-0003UC-HD; Sat, 11 Nov 2023 15:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1r1uIT-0003To-TA
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 15:09:38 -0500
Received: from mailout09.t-online.de ([194.25.134.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1r1uIO-0005YX-Qh
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 15:09:37 -0500
Received: from fwd72.aul.t-online.de (fwd72.aul.t-online.de [10.223.144.98])
 by mailout09.t-online.de (Postfix) with SMTP id A55C1583FA;
 Sat, 11 Nov 2023 21:09:29 +0100 (CET)
Received: from [192.168.211.200] ([93.236.156.187]) by fwd72.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1r1uIF-2jQsML0; Sat, 11 Nov 2023 21:09:23 +0100
Message-ID: <0f4ace5b-7541-4b88-bdd1-f78aed90d01f@t-online.de>
Date: Sat, 11 Nov 2023 21:09:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: disable-pie build
To: Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <610aad34-da0b-4b8a-aa22-4ad19513ae28@tls.msk.ru>
 <CABgObfYMct5NwGuYtOsFdEYaV6U=Ahe8zMPc_8QRh5a-cs_SEQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <CABgObfYMct5NwGuYtOsFdEYaV6U=Ahe8zMPc_8QRh5a-cs_SEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1699733363-3BFFC95D-7FF98E90/0/0 CLEAN NORMAL
X-TOI-MSGID: c3a336b1-d6a3-4525-b7f6-636b48fa9288
Received-SPF: pass client-ip=194.25.134.84; envelope-from=vr_qemu@t-online.de;
 helo=mailout09.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 11.11.23 um 17:09 schrieb Paolo Bonzini:
> On Sat, Nov 11, 2023 at 3:40 AM Michael Tokarev <mjt@tls.msk.ru> wrote:
>> Hi!
>>
>> It looks like --disable-pie configure, which uses -fno-pie -no-pie flags
>> for the compiler, is broken: it does not not tell the *linker* about the
>> option, so the link fails (at least on debian bookworm):
> Looks good, if you can send a patch perhaps Stefan can apply it (or
> someone else can handle it in my stead, because I'm away next week).
>
> Paolo

No, this doesn't look good. This patch again breaks the native Windows
build with MSYS2 and mingw64 cross compile probably too.

See

https://gitlab.com/qemu-project/qemu/-/issues/1664

https://lore.kernel.org/qemu-devel/20230522080816.66320-1-pbonzini@redhat.com/
https://lore.kernel.org/qemu-devel/20230523073029.19549-1-pbonzini@redhat.com/

and the big comment above the changed lines in meson.build.

With best regards,
Volker

>> /usr/bin/ld: libcommon.fa.p/hw_core_cpu-common.c.o: relocation R_X86_64_32 against `.rodata' can not be used when making a PIE object; recompile with
>> -fPIE
>> /usr/bin/ld: failed to set dynamic section sizes: bad value
>>
>> This is failing for *all* executables, including tests, qemu-img, etc.
>>
>> The following change fixes it:
>>
>> diff --git a/meson.build b/meson.build
>> index a9c4f28247..0b7ca45d48 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -278,7 +278,8 @@ endif
>>   # tries to build an executable instead of a shared library and fails.  So
>>   # don't add -no-pie anywhere and cross fingers. :(
>>   if not get_option('b_pie')
>> -  qemu_common_flags += cc.get_supported_arguments('-fno-pie', '-no-pie')
>> +  qemu_common_flags += cc.get_supported_arguments('-fno-pie')
>> +  qemu_ldflags += cc.get_supported_arguments('-no-pie')
>>   endif
>>
>>   if not get_option('stack_protector').disabled()

