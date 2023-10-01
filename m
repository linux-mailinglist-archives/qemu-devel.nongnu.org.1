Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B817A7B458E
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 08:17:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmpje-00019c-R4; Sun, 01 Oct 2023 02:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmpjZ-00018v-S8
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 02:15:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmpjY-0007kh-1y
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 02:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4eUUatlK8PjLanFK9qkRcCf5u6x5z6Pf+XjXNVsZ5lQ=; b=JVjZtU0mlEsSAO3rDx1/mXWoQy
 bjtrCms4Nu6jUPoal31rcnMtbbXZdu682TeSVpK1rStImWHt8gzLHASKXYueRtaDO7ds/35iE5fNT
 VzfUhyVP2SvzrqKJ0Xn1qnL9X+mrZ3gBFemsXMCGluxoTApZHJglLbWrXXsn1+r7uHNYSkD4apbw0
 6YLngFy8xb1akuMCLCN+1rISQuDKujgd/Z0s1mzdmJSZJwYvxQLevMd4xPYcmftxoJ6F3KzEYQQhx
 fkRDIAQ/0rha+idk8rTDuCqIVeKBZoZSxbO717jBPVxaWZ8Sb2A/VGUlEERcjyCtzoG6vfjU3mS1Q
 mFL6TjEFbctzGQEPHOfKpZGRDyfNSIFKfsUb1LGM1xcnh2Ip4Oie1MHIasIBlx0NixnnPeeM9ghNC
 hchwAMU52eITA9C1GgfM0oo7gbdUoRUYdNwarH5va2E7SiA/qRsczWxi+LQrshgku7yjKFG0iEiAN
 ql4vhEhB4wLuJdhvQDquj1cR31GViNaS82fNydgfPMqvJwvv2dpul5FS1Se2rSLif7VYFTq/84QKr
 UM+Xuhr2nDgtWHr7DjSlMc0F4Bl8XP4ho97ZIbv3xhxn1lriBDZLs9dco1qfQl4V+vZxNddsiaGUA
 es4S5xyNms8JKkSzFRZvcIaBRJsadki2Tt9S5XTi0=;
Received: from [2a00:23c4:8baf:5f00:ba5b:bec3:281d:2c9f]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmpjH-0002aT-CD; Sun, 01 Oct 2023 07:15:03 +0100
Message-ID: <badc8326-09d5-2454-0723-7fb79cad9a08@ilande.co.uk>
Date: Sun, 1 Oct 2023 07:15:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230913144959.41891-1-lersek@redhat.com>
 <CAJ+F1CJfROA9ezKi6Tzs1hLun8jpnWhrQCjreQdWhGro97CAyA@mail.gmail.com>
 <4c36a1eb-9a76-2231-4ead-d8daab657d84@redhat.com>
 <CAJ+F1CKPaU5z8mnnFJWvw4CmFyEenFQ679A5Nf3CAqzJMqdqVA@mail.gmail.com>
 <d462d277-4f32-2b98-19c4-7af43167af8d@ilande.co.uk>
 <7dc6ed8b-adfd-2d00-b26e-3d7acb4fe9ee@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <7dc6ed8b-adfd-2d00-b26e-3d7acb4fe9ee@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:ba5b:bec3:281d:2c9f
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/4] ui/console: multihead: fix crash, simplify logic
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.587,
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

On 30/09/2023 22:28, Laszlo Ersek wrote:

> On 9/29/23 09:57, Mark Cave-Ayland wrote:
>> On 26/09/2023 09:00, Marc-André Lureau wrote:
>>
>>> Hi Laszlo
>>>
>>> On Mon, Sep 25, 2023 at 7:36 PM Laszlo Ersek <lersek@redhat.com> wrote:
>>>> Has this been queued by someone? Both Gerd and Marc-André are "odd
>>>> fixers", so I'm not sure who should be sending a PR with these patches
>>>> (and I don't see a pending PULL at
>>>> <https://lists.gnu.org/archive/html/qemu-devel/2023-09/threads.html>
>>>> with these patch subjects included).
>>>
>>> I have the series in my "ui" branch. I was waiting for a few more
>>> patches to be accumulated. But if someone else takes this first, I'll
>>> drop them.
>>
>> Does this series fix the "../ui/console.c:818: dpy_get_ui_info:
>> Assertion `dpy_ui_info_supported(con)' failed." assert() on startup when
>> using gtk? It would be good to get this fixed in git master soon, as it
>> has been broken for a couple of weeks now, and -display sdl has issues
>> tracking the mouse correctly on my laptop here :(
> 
> ... probably not; I've never seen that issue. Can you provide a reproducer?

The environment is a standard Debian bookworm install building QEMU git master with 
QEMU gtk support. The only difference I can think of is that I do all my QEMU builds 
as a separate user, and then export the display to my current user desktop i.e.

As my current user:
   $ xhost +

As my QEMU build user:
   $ export DISPLAY=:1
   $ ./build/qemu-system-sparc
   qemu-system-sparc: ../ui/console.c:818: dpy_get_ui_info: Assertion
  `dpy_ui_info_supported(con)' failed.
   Aborted (core dumped)

> Also, it should be bisectable (over Marc-André's 52-part series I guess).

Indeed. I've just run git bisect and it returns the following:

a92e7bb4cad57cc5c8817fb18fb25650507b69f8 is the first bad commit
commit a92e7bb4cad57cc5c8817fb18fb25650507b69f8
Author: Marc-André Lureau <marcandre.lureau@redhat.com>
Date:   Tue Sep 12 10:13:01 2023 +0400

     ui: add precondition for dpy_get_ui_info()

     Ensure that it only get called when dpy_ui_info_supported(). The
     function should always return a result. There should be a non-null
     console or active_console.

     Modify the argument to be const as well.

     Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
     Reviewed-by: Albert Esteve <aesteve@redhat.com>

  include/ui/console.h | 2 +-
  ui/console.c         | 4 +++-
  2 files changed, 4 insertions(+), 2 deletions(-)


ATB,

Mark.


