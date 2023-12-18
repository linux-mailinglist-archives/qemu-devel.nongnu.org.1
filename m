Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCE4816C0B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:17:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBce-00006J-Vj; Mon, 18 Dec 2023 06:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFBcI-00082S-UU
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:17:08 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFBcF-00008o-Gh
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:16:58 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3A67F756094;
 Mon, 18 Dec 2023 12:16:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id oWDMtKKC1ec9; Mon, 18 Dec 2023 12:16:49 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 03B34756078; Mon, 18 Dec 2023 12:16:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 01DB5756066;
 Mon, 18 Dec 2023 12:16:48 +0100 (CET)
Date: Mon, 18 Dec 2023 12:16:48 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
cc: Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, qemu-devel@nongnu.org, 
 Rene Engel <ReneEngel80@emailn.de>
Subject: Re: [PATCH v7] ui/cocoa: Use NSWindow's ability to resize
In-Reply-To: <d889c324-c758-4a7a-9d7c-c3cfde926bac@daynix.com>
Message-ID: <9d25decb-e57e-60a5-56e6-954288b9c051@eik.bme.hu>
References: <20231217-cocoa-v7-1-6af21ef75680@daynix.com>
 <81d626f7-1fe5-0c74-acaa-4a2a4070a381@eik.bme.hu>
 <d889c324-c758-4a7a-9d7c-c3cfde926bac@daynix.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1407956315-1702898209=:10312"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

--3866299591-1407956315-1702898209=:10312
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 18 Dec 2023, Akihiko Odaki wrote:
> On 2023/12/17 20:39, BALATON Zoltan wrote:
>> On Sun, 17 Dec 2023, Akihiko Odaki wrote:
>>> This change brings two new features:
>>> - The window will be resizable if "Zoom To Fit" is eanbled
>>> - The window can be made full screen by clicking full screen button
>>>  provided by the platform. (The left-top green button.)
>>> 
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Tested-by: Rene Engel <ReneEngel80@emailn.de>
>>> ---
>>> V5 -> V6:
>>>  Rebased.
>>> ---
>>> Changes in v7:
>>> - Fixed zoom-to-fit option. (Marek Glogowski)
>>> - Link to v6: 
>>> https://lore.kernel.org/r/20231211-cocoa-v6-1-49f3be0191f2@daynix.com
>>> ---
>>> ui/cocoa.m | 542 
>>> +++++++++++++++++++++++++++++--------------------------------
>>> 1 file changed, 258 insertions(+), 284 deletions(-)
>> 
>> Is ir possible to break this patch up into smaller ones for easier review? 
>> E.g. separate patch moving mouse event handling out of handleEventLocked, 
>> replacing stretch_video flag with NSWindowStyleMaskResizable and whatever 
>> else can be done as independent steps? Not sure if that's possible or needs 
>> the whole chnage at once but this patch seems to be too big. Some more 
>> comments below.
>
> I split it into three patches with v8, but most changes are still in one 
> patch because they depend on the change to unify the full screen window and 
> normal window and vice-versa.

It still helps to remove unrelated changes from the big patch so it's 
more obvious what's needed for that change and thus easier to review.

[...]
>>> @@ -513,36 +504,43 @@ - (void) drawRect:(NSRect) rect
>>>     }
>>> }
>>> 
>>> -- (void) setContentDimensions
>>> +- (NSSize) fixZoomedFullScreenSize:(NSSize)proposedSize
>>> {
>>> -    COCOA_DEBUG("QemuCocoaView: setContentDimensions\n");
>>> +    NSSize size;
>>> 
>>> -    if (isFullscreen) {
>>> -        cdx = [[NSScreen mainScreen] frame].size.width / 
>>> (float)screen.width;
>>> -        cdy = [[NSScreen mainScreen] frame].size.height / 
>>> (float)screen.height;
>>> +    size.width = (CGFloat)screen.width * proposedSize.height;
>>> +    size.height = (CGFloat)screen.height * proposedSize.width;
>> 
>> One of these will be overwritten in the next if below so maybe drop this 
>> init and do the calculation in the if legs which is then also clearer to 
>> show that this would scale one of these with screen.width/screen.height or 
>> the inverse of that.
>> 
>> This also removes stretch_video flag and the calculation to preserve aspect 
>> ratio. Is that correct? Would it now distort the image when zooming to full 
>> screen if guest resolution is not the same as host screen? Is that how 
>> zoom-to-fit should work? At leest with -display sdl going to full screen 
>> guest screen is zoomed preserving aspect ratio but maybe sdl does not have 
>> zoom-to-fit option. I don't know how it works with other displays such as 
>> gtk.
>
> The purpose of this method is to fix the aspect ratio for zoom-to-fit by 
> shrinking width or height. It operates in the three steps:
> 1. Compute the values necessary either for shrinking width or height.
> 2. Decide which of width or height to shrink.
> 3. Compute the final values.

Wouldn't it be simpler to do in two steps:
1. Decide what needs to be scaled
2. Do the computation accordingly
I.e.

if (size.width < size.height) {
    size.width = proposedSize.height * (CGFloat)screen.width / screen.height;
    size.height = proposedSize.height;
} else {
    size.width = proposedSize.width;
    size.height = proposedSize.width * (CGFloat)screen.height / screen.width;
}

Seems to me more explicit than doing the scale factor calculation split in 
two lines that's harder to follow. I had to think about what that does 
while this shows it clearer. If you prefer shorter lines you could also 
init size = proposedSize and then scale either width or height afterwards 
which would still be clearer than your way I think.

Regaards,
BALATON Zoltan
--3866299591-1407956315-1702898209=:10312--

