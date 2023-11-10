Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3BE7E7BE2
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 12:36:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Pna-0006GT-Oi; Fri, 10 Nov 2023 06:35:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r1PnY-0006Fy-Ew; Fri, 10 Nov 2023 06:35:40 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r1PnW-0007uF-8s; Fri, 10 Nov 2023 06:35:40 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B8CF975A4C1;
 Fri, 10 Nov 2023 12:35:56 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AD01C75A4B8; Fri, 10 Nov 2023 12:35:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AB46175A4B7;
 Fri, 10 Nov 2023 12:35:56 +0100 (CET)
Date: Fri, 10 Nov 2023 12:35:56 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org
Subject: Re: [PATCH 2/2] Add warn_unused_result attr to AUD_register_card
In-Reply-To: <ZU4R+08zuo8xvlg8@redhat.com>
Message-ID: <02562baf-3d92-f5b4-2592-a9d868586451@eik.bme.hu>
References: <cover.1699606819.git.manos.pitsidianakis@linaro.org>
 <4b040fc18cb0e563e92ce084ca18b89a050a8aaa.1699606819.git.manos.pitsidianakis@linaro.org>
 <CAFEAcA80sv6ewJ+LoROn-9ooEyLGQwiqYpL3=fqrK7gA0oZG-A@mail.gmail.com>
 <3wmne.fhuf28sb5yfg@linaro.org> <ZU4R+08zuo8xvlg8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1631310355-1699616156=:56818"
X-Virus-Scanned: ClamAV using ClamSMTP
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

--3866299591-1631310355-1699616156=:56818
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 10 Nov 2023, Daniel P. Berrangé wrote:
> On Fri, Nov 10, 2023 at 12:44:56PM +0200, Manos Pitsidianakis wrote:
>> On Fri, 10 Nov 2023 12:21, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> This kind of thing is why Coverity's unused-result warning has a
>>> lot of false positives. We shouldn't introduce extra code like
>>> this to work around the fact that the tooling doesn't understand
>>> our error-handling convention (i.e. error_fatal, and the way
>>> that some functions report errors both via the return value and
>>> also via the Error** argument).
>>
>> I respect that :). But I personally believe that clinging to C's
>> inadequacies, instead of preventing bugs statically just because it adds
>> some lines of code, is misguided. Proper code should strive to make bugs
>> impossible in the first place. At least that is my perspective and I would
>> like there to be constructive discussions about different approaches in the
>> mailing list. Perhaps something good might come out of it!
>
> Your approach to the problem:
>
>  if (!AUD_register_card("OMAP EAC", &s->codec.card, &error_fatal)) {
>    exit(1);
>  }
>
> is adding dead-code because the exit(1) will never be reachable. So while
> it lets you squelch the unused result warning, it is verbose and misleading
> to anyone who sees it.
>
> Perhaps a more viable option is to pull in gnulib's ignore_value macro
>
>  #define ignore_value(x) \
>    (__extension__ ({ __typeof__ (x) __x = (x); (void) __x; }))
>
> and then we would have just this:
>
> ignore_value(AUD_register_card("OMAP EAC", &s->codec.card, &error_fatal));

I wonder if just casting to (void) without assigning to a value could 
avoid the warning? In that case you would not need a macro just

(void)AUD_register_card("OMAP EAC", &s->codec.card, &error_fatal);

Not sure it's clearer than a macro which states what it does but the 
definition is a bit cryptic while this cast is simpler but may also puzzle 
somebody not familiar with it.

Regards,
BALATON Zoltan
--3866299591-1631310355-1699616156=:56818--

