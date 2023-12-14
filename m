Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0786C8131B3
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 14:36:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDlKH-0004lF-Gn; Thu, 14 Dec 2023 08:00:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rDlKB-0004jH-W3
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 08:00:24 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rDlJx-0002OL-1n
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 08:00:23 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AFDCE75A4C3;
 Thu, 14 Dec 2023 14:00:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 9Zr-gosuaplf; Thu, 14 Dec 2023 14:00:03 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CC6E275A4C2; Thu, 14 Dec 2023 14:00:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C9B9175607B;
 Thu, 14 Dec 2023 14:00:03 +0100 (CET)
Date: Thu, 14 Dec 2023 14:00:03 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vl: Print display options for -display help
In-Reply-To: <9443821d-5eff-46e6-be69-707cca9cd0d0@linaro.org>
Message-ID: <8f8d3317-c28b-3985-89d7-0fbd1ce4b56e@eik.bme.hu>
References: <20231214-help-v1-1-23823ac5a023@daynix.com>
 <9443821d-5eff-46e6-be69-707cca9cd0d0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1582926978-1702558803=:43804"
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

--3866299591-1582926978-1702558803=:43804
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 14 Dec 2023, Philippe Mathieu-Daudé wrote:
> Hi Akihiko,
>
> On 14/12/23 07:47, Akihiko Odaki wrote:
>> -display lists display backends, but does not tell their options.
>> Use the help messages from qemu-options.def, which include the list of
>> options.
>> 
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/ui/console.h |  1 -
>>   system/vl.c          | 11 ++++++-----
>>   ui/console.c         | 20 --------------------
>>   3 files changed, 6 insertions(+), 26 deletions(-)
>
>
>> diff --git a/ui/console.c b/ui/console.c
>> index 7db921e3b7d6..6aee5e9a7ffb 100644
>> --- a/ui/console.c
>> +++ b/ui/console.c
>> @@ -1691,23 +1691,3 @@ const char *qemu_display_get_vc(DisplayOptions 
>> *opts)
>>       }
>>       return vc;
>>   }
>> -
>> -void qemu_display_help(void)
>> -{
>> -    int idx;
>> -
>> -    printf("Available display backend types:\n");
>> -    printf("none\n");
>> -    for (idx = DISPLAY_TYPE_NONE; idx < DISPLAY_TYPE__MAX; idx++) {
>> -        if (!dpys[idx]) {
>> -            Error *local_err = NULL;
>> -            int rv = ui_module_load(DisplayType_str(idx), &local_err);
>> -            if (rv < 0) {
>> -                error_report_err(local_err);
>> -            }
>> -        }
>> -        if (dpys[idx]) {
>> -            printf("%s\n",  DisplayType_str(dpys[idx]->type));
>
> Is the "qapi/qapi-commands-ui.h" header still necessary?
>
>> -        }
>> -    }
>> -}
>
> So we go from:
>
> $ ./qemu-system-aarch64 -display help
> Available display backend types:
> none
> gtk
> sdl
> curses
> cocoa
> dbus
>
> to:
>
> $ ./qemu-system-aarch64 -display help
> -display sdl[,gl=on|core|es|off][,grab-mod=<mod>][,show-cursor=on|off]
>            [,window-close=on|off]
> -display gtk[,full-screen=on|off][,gl=on|off][,grab-on-hover=on|off]
>            [,show-tabs=on|off][,show-cursor=on|off][,window-close=on|off]
>            [,show-menubar=on|off]
> -display vnc=<display>[,<optargs>]
> -display curses[,charset=<encoding>]
> -display cocoa[,full-grab=on|off][,swap-opt-cmd=on|off]
> -display dbus[,addr=<dbusaddr>]
>             [,gl=on|core|es|off][,rendernode=<file>]
> -display cocoa[,show-cursor=on|off][,left-command-key=on|off]
> -display none
>                select display backend type
>                The default display is equivalent to
>                "-display gtk"
>
> The latter is indeed more helpful.

It is more helpful but maybe a bit overwhelming. Would it be possible to 
only print the options with -display cocoa,help similar to how -device 
help lists devices and -device sm501,help lists options for one device? 
Adding info about default to -display help is really helpful though (that 
could also be marked with (default) like in -machine help.

I'm not complaining, thanks for taking care of this so quickly but if it's 
not too difficult to add separate -display cocoa,help and not list options 
in -display help maybe that would be better and more consistent with other 
help options.

Regards,
BALATON Zoltan

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
>
--3866299591-1582926978-1702558803=:43804--

