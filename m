Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EE37B46A2
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 11:51:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmt5t-0001Aw-9M; Sun, 01 Oct 2023 05:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qmt5r-0001Ao-9q
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 05:50:31 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qmt5o-0005jT-PU
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 05:50:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 82522268DB;
 Sun,  1 Oct 2023 12:50:56 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BD1F42BF71;
 Sun,  1 Oct 2023 12:50:15 +0300 (MSK)
Message-ID: <e0885aef-ea07-25e7-b2fa-b631547e86a0@tls.msk.ru>
Date: Sun, 1 Oct 2023 12:50:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/4] ui/console: multihead: fix crash, simplify logic
Content-Language: en-US
To: Laszlo Ersek <lersek@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230913144959.41891-1-lersek@redhat.com>
 <CAJ+F1CJfROA9ezKi6Tzs1hLun8jpnWhrQCjreQdWhGro97CAyA@mail.gmail.com>
 <4c36a1eb-9a76-2231-4ead-d8daab657d84@redhat.com>
 <CAJ+F1CKPaU5z8mnnFJWvw4CmFyEenFQ679A5Nf3CAqzJMqdqVA@mail.gmail.com>
 <d462d277-4f32-2b98-19c4-7af43167af8d@ilande.co.uk>
 <7dc6ed8b-adfd-2d00-b26e-3d7acb4fe9ee@redhat.com>
 <badc8326-09d5-2454-0723-7fb79cad9a08@ilande.co.uk>
 <9284b911-0f77-35b6-93f9-4551414dae3c@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <9284b911-0f77-35b6-93f9-4551414dae3c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -94
X-Spam_score: -9.5
X-Spam_bar: ---------
X-Spam_report: (-9.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.587,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

01.10.2023 12:31, Laszlo Ersek пишет:
> On 10/1/23 08:15, Mark Cave-Ayland wrote:
>> On 30/09/2023 22:28, Laszlo Ersek wrote:
>>
>>> On 9/29/23 09:57, Mark Cave-Ayland wrote:
>>>> On 26/09/2023 09:00, Marc-André Lureau wrote:
>>>>
>>>>> Hi Laszlo
>>>>>
>>>>> On Mon, Sep 25, 2023 at 7:36 PM Laszlo Ersek <lersek@redhat.com> wrote:
>>>>>> Has this been queued by someone? Both Gerd and Marc-André are "odd
>>>>>> fixers", so I'm not sure who should be sending a PR with these patches
>>>>>> (and I don't see a pending PULL at
>>>>>> <https://lists.gnu.org/archive/html/qemu-devel/2023-09/threads.html>
>>>>>> with these patch subjects included).
>>>>>
>>>>> I have the series in my "ui" branch. I was waiting for a few more
>>>>> patches to be accumulated. But if someone else takes this first, I'll
>>>>> drop them.
>>>>
>>>> Does this series fix the "../ui/console.c:818: dpy_get_ui_info:
>>>> Assertion `dpy_ui_info_supported(con)' failed." assert() on startup when
>>>> using gtk? It would be good to get this fixed in git master soon, as it
>>>> has been broken for a couple of weeks now, and -display sdl has issues
>>>> tracking the mouse correctly on my laptop here :(
>>>
>>> ... probably not; I've never seen that issue. Can you provide a
>>> reproducer?
>>
>> The environment is a standard Debian bookworm install building QEMU git
>> master with QEMU gtk support. The only difference I can think of is that
>> I do all my QEMU builds as a separate user, and then export the display
>> to my current user desktop i.e.
>>
>> As my current user:
>>    $ xhost +
>>
>> As my QEMU build user:
>>    $ export DISPLAY=:1
>>    $ ./build/qemu-system-sparc
>>    qemu-system-sparc: ../ui/console.c:818: dpy_get_ui_info: Assertion
>>   `dpy_ui_info_supported(con)' failed.
>>    Aborted (core dumped)
>>
>>> Also, it should be bisectable (over Marc-André's 52-part series I guess).
>>
>> Indeed. I've just run git bisect and it returns the following:
>>
>> a92e7bb4cad57cc5c8817fb18fb25650507b69f8 is the first bad commit
>> commit a92e7bb4cad57cc5c8817fb18fb25650507b69f8
>> Author: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Date:   Tue Sep 12 10:13:01 2023 +0400
>>
>>      ui: add precondition for dpy_get_ui_info()
>>
>>      Ensure that it only get called when dpy_ui_info_supported(). The
>>      function should always return a result. There should be a non-null
>>      console or active_console.
>>
>>      Modify the argument to be const as well.
>>
>>      Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>      Reviewed-by: Albert Esteve <aesteve@redhat.com>
>>
>>   include/ui/console.h | 2 +-
>>   ui/console.c         | 4 +++-
>>   2 files changed, 4 insertions(+), 2 deletions(-)

This is the first time the assertion failure has been found (right after
merge of this series, Sep-13):
https://lore.kernel.org/qemu-devel/801ac36e-b572-665b-5148-81baabf78a20@tls.msk.ru/

This is more discussion about it:
https://lore.kernel.org/qemu-devel/0cae6d58-1476-9b92-0b48-f593b8e92ef2@tls.msk.ru/

> This commit looks plain wrong to me; or rather I don't understand the
> argument.

The thing here is that different parts of the code uses different object
thinking it is the same thing.  So it is confusing at best and smells
wrong.  But it is how it's been for quite some time, this new assert()
just revealed the issue, I think.

/mjt

> In the particular crash, we fail in gtk_display_init -> gtk_widget_show
> -> ... -> gd_configure -> gd_set_ui_size -> dpy_get_ui_info, and when
> the latter calls dpy_ui_info_supported(), we find that
> "con->hw_ops->ui_info" is NULL. In this particular case, "con->hw_ops"
> is "vga_ops", and indeed "vga_ops" does not provide an "ui_info" funcptr.
> 
> SDL is unaffected because with SDL, we never call dpy_get_ui_info().
> 
> There's something fishy in the GTK display code BTW, in my opinion. I
> can't quite put my finger on it, but commit aeffd071ed81 ("ui: Deliver
> refresh rate via QemuUIInfo", 2022-06-14) definitely plays a role.
> 
> Before commit aeffd071ed81, "ui/gtk.c" wouldn't call dpy_get_ui_info()
> either! Instead, from gd_configure(), we'd call gd_set_ui_info(),
> directly setting the size from the incoming GdkEventConfigure object.
> 
> In commit aeffd071ed81, solely for the sake of carrying over the refresh
> rate, gd_set_ui_info() was renamed to gd_set_ui_size(). The width and
> height coming from the GdkEventConfigure object would be propagated the
> same way to dpy_set_ui_info(), but the *rest* of the QemuUIInfo object
> would be initialized differently. Before, the other fields would be
> zero, now they'd come from dpy_get_ui_info() -- most likely for the sake
> of carrying over the new refresh_rate field.
> 
> This in itself wouldn't crash, but it set up the call chain that is now
> affected by the (IMO too strict) assertion.
> 
> Why is a hw_ops-based ui_info needed for dpy_get_ui_info()?
> dpy_get_ui_info() never tries to *call* that function, it just returns
> &con->ui_info. So dpy_get_ui_info() *already* guarantees that it returns
> non-NULL.
> 
> Laszlo
> 
>>
>>
>> ATB,
>>
>> Mark.
>>
> 
> 


