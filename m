Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E48D8148BB
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 14:08:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE7ud-0005ah-A7; Fri, 15 Dec 2023 08:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rE7uZ-0005aX-6i
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 08:07:27 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rE7uX-0000XF-9p
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 08:07:26 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 24F3A75A4B9;
 Fri, 15 Dec 2023 14:07:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 4EWN_-5416Ep; Fri, 15 Dec 2023 14:07:20 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 388F275A406; Fri, 15 Dec 2023 14:07:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 36AB275607B;
 Fri, 15 Dec 2023 14:07:20 +0100 (CET)
Date: Fri, 15 Dec 2023 14:07:20 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
cc: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vl: Print display options for -display help
In-Reply-To: <ZXxMow-5UGOSgWo1@redhat.com>
Message-ID: <73d44b18-51e9-23b5-2013-d1cd21b083e7@eik.bme.hu>
References: <20231214-help-v1-1-23823ac5a023@daynix.com>
 <9443821d-5eff-46e6-be69-707cca9cd0d0@linaro.org>
 <8f8d3317-c28b-3985-89d7-0fbd1ce4b56e@eik.bme.hu>
 <2d1689ea-b0d8-4c74-8101-b90ad626f2a9@daynix.com>
 <d1687e5a-a60e-fda8-5e8c-1ab9adf0e775@eik.bme.hu>
 <ZXxMow-5UGOSgWo1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1138603643-1702645640=:20721"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1138603643-1702645640=:20721
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 15 Dec 2023, Daniel P. Berrangé wrote:
> On Fri, Dec 15, 2023 at 01:43:37PM +0100, BALATON Zoltan wrote:
>> On Fri, 15 Dec 2023, Akihiko Odaki wrote:
>>> On 2023/12/14 22:00, BALATON Zoltan wrote:
>>>>> So we go from:
>>>>>
>>>>> $ ./qemu-system-aarch64 -display help
>>>>> Available display backend types:
>>>>> none
>>>>> gtk
>>>>> sdl
>>>>> curses
>>>>> cocoa
>>>>> dbus
>>>>>
>>>>> to:
>>>>>
>>>>> $ ./qemu-system-aarch64 -display help
>>>>> -display sdl[,gl=on|core|es|off][,grab-mod=<mod>][,show-cursor=on|off]
>>>>>            [,window-close=on|off]
>>>>> -display gtk[,full-screen=on|off][,gl=on|off][,grab-on-hover=on|off]
>>>>>            [,show-tabs=on|off][,show-cursor=on|off][,window-close=on|off]
>>>>>            [,show-menubar=on|off]
>>>>> -display vnc=<display>[,<optargs>]
>>>>> -display curses[,charset=<encoding>]
>>>>> -display cocoa[,full-grab=on|off][,swap-opt-cmd=on|off]
>>>>> -display dbus[,addr=<dbusaddr>]
>>>>>             [,gl=on|core|es|off][,rendernode=<file>]
>>>>> -display cocoa[,show-cursor=on|off][,left-command-key=on|off]
>>>>> -display none
>>>>>                select display backend type
>>>>>                The default display is equivalent to
>>>>>                "-display gtk"
>>>>>
>>>>> The latter is indeed more helpful.
>>>>
>>>> It is more helpful but maybe a bit overwhelming. Would it be
>>>> possible to only print the options with -display cocoa,help similar
>>>> to how -device help lists devices and -device sm501,help lists
>>>> options for one device? Adding info about default to -display help
>>>> is really helpful though (that could also be marked with (default)
>>>> like in -machine help.
>>>
>>> It's copied from what qemu-system-aarch64 -h outputs. At least it's less
>>> overwhelming than qemu-system-aarch64 -h.
>>
>> This changes what -display help does so if some script depends on that it
>> may not be a good idea. Since the same info is already in -help maybe this
>> change to add that to -display help as well is not the best solution so I'd
>> say drop this patch and leave it as it is for now.
>
> We consider help output to be only for humans.
>
> No scripts should ever be parsing any QEMU output, as we provide
> QMP for automated detection/querying of features.
>
> IOW, if some script is parsing help output we are fine to break
> them if it improves QEMU's output for humans in a justiable way.

OK fair enough. I'd still like some more consitency with -cpu help and 
-machine help and -device help which all list avalable options and then 
can take help for further help for individual items where applicable. So 
it would be better if -display and -audio could behave the same. (Are 
there any other options that might be missing this?)

Out of curiousicy what's the way to query available display backends for 
programs by QMP then?

Regards,
BALATON Zoltan
--3866299591-1138603643-1702645640=:20721--

