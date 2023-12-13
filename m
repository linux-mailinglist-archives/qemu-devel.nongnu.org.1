Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC558810BAD
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 08:40:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDJq4-0000tl-TP; Wed, 13 Dec 2023 02:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1rDJq2-0000sI-8M
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 02:39:26 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1rDJpz-0000Y6-Gq
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 02:39:26 -0500
Message-ID: <7378b6a4-7abc-990a-9486-48c36dc70b9b@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1702453159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Yq837+tmpCkiwPuG/f1JMNKZlGDweMNZHDDqPKMQwY=;
 b=SBvL7Tn4HXlAIVUmrGkE9sjryDPY1MAFDtXosLtYD0QEOo84bY/2St87AqoDSJmrk7pBN4
 62TUvdAb37fmeozJnSlfHgKBzu+C7uP03uVrCXVxyIVbXlSIfm66mXG+ErGXMo3djLq9OT
 iL8WM2d/nLBk4rein3AhqZVqk/QR+FA=
Date: Wed, 13 Dec 2023 10:39:18 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] ui: fix DIV_BY_ZERO in tightvnc
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: kraxel@redhat.com, sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
References: <20231213065201.886391-1-frolov@swemel.ru>
 <CAMxuvay5gb6XBMpHB3gu-U=sJ-PqF-oB7jeuiD6rifhWg16bAw@mail.gmail.com>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <CAMxuvay5gb6XBMpHB3gu-U=sJ-PqF-oB7jeuiD6rifhWg16bAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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



On 13.12.2023 10:31, Marc-André Lureau wrote:
> Hi
>
> On Wed, Dec 13, 2023 at 11:08 AM Dmitry Frolov <frolov@swemel.ru> wrote:
>> Division by zero may occur in rare constellation of conditions if:
>> 1. not TrueColor mode on the client side
>>     tight_detect_smooth_image16() and tight_detect_smooth_image32(),
>>     defined by macro DEFINE_DETECT_FUNCTION()2, are affected.
>> 2. if all pixels on the screen are equal, then pixels == stats[0]
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> What about the tight_detect_smooth_image24() division?
>      errors /= (pixels * 3 - stats[0]);
Here everything is OK, because there is a check some lines above:
     if (stats[0] * 33 / pixels >= 95) {
         return 0;
     }
thus, stats[0] < pixels*95/33,
95/33 < 3.
>
> It should probably have a similar safety check.
>
> The code is originally from libvncserver, but they completely changed
> their implementation in:
> https://github.com/LibVNC/libvncserver/commit/7124b5fbcf0df8db4d3f73023d77af6ea56409e7
> otherwise,
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>
>> ---
>>   ui/vnc-enc-tight.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
>> index 41f559eb83..f1249ab136 100644
>> --- a/ui/vnc-enc-tight.c
>> +++ b/ui/vnc-enc-tight.c
>> @@ -284,6 +284,9 @@ tight_detect_smooth_image24(VncState *vs, int w, int h)
>>           for (; c < 256; c++) {                                          \
>>               errors += stats[c] * (c * c);                               \
>>           }                                                               \
>> +        if (pixels == stats[0]) {                                       \
>> +            return 0;                                                   \
>> +        }                                                               \
>>           errors /= (pixels - stats[0]);                                  \
>>                                                                           \
>>           return errors;                                                  \
>> --
>> 2.34.1
>>


