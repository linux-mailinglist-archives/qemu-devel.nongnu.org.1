Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5273A7BB9D
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Apr 2025 13:35:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0fKH-0004NY-VO; Fri, 04 Apr 2025 07:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u0fJj-0004M4-6H
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:34:36 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u0fJh-00006c-4l
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:34:34 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CD8054E6004;
 Fri, 04 Apr 2025 13:34:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id aXytGgZggksN; Fri,  4 Apr 2025 13:34:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C0E464E6010; Fri, 04 Apr 2025 13:34:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BEADA74577C;
 Fri, 04 Apr 2025 13:34:27 +0200 (CEST)
Date: Fri, 4 Apr 2025 13:34:27 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
cc: qemu-devel@nongnu.org, Volker Ruemelin <vr_qemu@t-online.de>, 
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] alsaaudio: Set try-poll to false by default
In-Reply-To: <37909074.vkC8U9mzk0@silver>
Message-ID: <abecc55b-f032-03e3-a9f3-628b1f8f7e5d@eik.bme.hu>
References: <20250316002046.D066A4E6004@zero.eik.bme.hu>
 <2118992.kbFERA6akJ@silver> <alpine.LMD.2.03.2503311503200.6402@eik.bme.hu>
 <37909074.vkC8U9mzk0@silver>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1699519478-1743766467=:22764"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1699519478-1743766467=:22764
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 4 Apr 2025, Christian Schoenebeck wrote:
> On Monday, March 31, 2025 3:05:24 PM CEST BALATON Zoltan wrote:
>> On Sun, 23 Mar 2025, Christian Schoenebeck wrote:
>>> On Sunday, March 16, 2025 1:20:46 AM CET BALATON Zoltan wrote:
>>>> Quoting Volker R�melin: "try-poll=on tells the ALSA backend to try to
>>>> use an event loop instead of the audio timer. This works most of the
>>>> time. But the poll event handler in the ALSA backend has a bug. For
>>>> example, if the guest can't provide enough audio frames in time, the
>>>> ALSA buffer is only partly full and the event handler will be called
>>>> again and again on every iteration of the main loop. This increases
>>>> the processor load and the guest has less processor time to provide
>>>> new audio frames in time. I have two examples where a guest can't
>>>> recover from this situation and the guest seems to hang."
>>>>
>>>> One reproducer I've found is booting MorphOS demo iso on
>>>> qemu-system-ppc -machine pegasos2 -audio alsa which should play a
>>>> startup sound but instead it freezes. Even when it does not hang it
>>>> plays choppy sound. Volker suggested using command line to set
>>>> try-poll=off saying: "The try-poll=off arguments are typically
>>>> necessary, because the alsa backend has a design issue with
>>>> try-poll=on. If the guest can't provide enough audio frames, it's
>>>> really unhelpful to ask for new audio frames on every main loop
>>>> iteration until the guest can provide enough audio frames. Timer based
>>>> playback doesn't have that problem."
>>>>
>>>> But users cannot easily find this option and having a non-working
>>>> default is really unhelpful so to make life easier just set it to
>>>> false by default which works until the issue with the alsa backend can
>>>> be fixed.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>> This fixes my issue but if somebody has a better fix I'm open to that
>>>> too.
>>>>
>>>>  audio/alsaaudio.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
>>>> index cacae1ea59..9b6c01c0ef 100644
>>>> --- a/audio/alsaaudio.c
>>>> +++ b/audio/alsaaudio.c
>>>> @@ -899,7 +899,7 @@ static void alsa_enable_in(HWVoiceIn *hw, bool enable)
>>>>  static void alsa_init_per_direction(AudiodevAlsaPerDirectionOptions *apdo)
>>>>  {
>>>>      if (!apdo->has_try_poll) {
>>>> -        apdo->try_poll = true;
>>>> +        apdo->try_poll = false;
>>>>          apdo->has_try_poll = true;
>>>>      }
>>>>  }
>>>>
>>>
>>> Correct me if I am wrong, but AFAICS if polling is not used then no state
>>> changes would be handled, no? At least I don't see any snd_pcm_state() call
>>> outside of alsa_poll_handler().
>>
>> I have no idea but this fixes the problem (and does the same that can be
>> also done from command line but nobody can find that command line option)
>> so unless somebody has a better idea could this be merged as a fix for
>> now?
>
> Well, I understand that if fixes the misbehaviour you encountered. But how
> helpful would it be if it then breaks behaviour for other people instead?

What behaviour would it break and how?

> I think it would be better to add a 2nd patch that would handle state changes
> in callback mode. That would satisfy both groups of people. AFAICS
> snd_pcm_state() can be called both in polling mode and callback mode.

I can't do that because I don't quite know neither alsa nor audio in QEMU 
so I have no idea what to do. Can you give more clues?

> Just my 2 cents. Of course it's up to Gerd to decide.

If you know it would break something I agree it should be fixed and I can 
try but I could not reproduce any breakage and most people likely use 
other audio backends so unlikely to encounter problems with alsa.

Regards,
BALATON Zoltan
--3866299591-1699519478-1743766467=:22764--

