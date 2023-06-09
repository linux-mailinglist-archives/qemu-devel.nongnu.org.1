Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5940729F01
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:46:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7c85-0000Ae-7S; Fri, 09 Jun 2023 09:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q7c7x-00009q-OK
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 09:26:06 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q7c7t-0001O7-52
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 09:26:05 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 1ED2B603A4;
 Fri,  9 Jun 2023 16:25:53 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b727::1:d] (unknown
 [2a02:6b8:b081:b727::1:d])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id qPWSqJ0Oh8c0-Sjl5bQiG; Fri, 09 Jun 2023 16:25:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1686317152; bh=d5WI2+G5oUSsNAa9lfhiPRBTzY7P+9AwcpMDu/jBwN8=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=DyLauxVUm75NDXVFMEi9gV5ue2SbxRQmQ/hLB4Z93ryoXfUi9AtWCwoi96B30pvUM
 xUi0GXz2beoqbcl59MD91Gng6tzFx0iTsHRt/Ki2OaLmporPpBzummMbXNg+P69vMQ
 lkLEfuIIRLIVUxV1LOT+R13cEpqVvhykFNnZwU0w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9b9873d2-00a1-32d5-93fc-b6cef5db9364@yandex-team.ru>
Date: Fri, 9 Jun 2023 16:25:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] coverity: physmem: use simple assertions instead of
 modelling
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, david@redhat.com,
 peterx@redhat.com, armbru@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
References: <20221226220351.754204-1-vsementsov@yandex-team.ru>
 <35c7e623-1433-5250-6188-29424814bccb@yandex-team.ru>
 <CAJSP0QWDcw8cYo8opfQ_+_U4p1DfQ49oo_ogOsnqJji+d1DzgA@mail.gmail.com>
 <CAFEAcA9qwYFpYOg9tG2Kh-dnR4sr6jYzmapqNjZKqie8L=WO4A@mail.gmail.com>
 <fea4486a-cb0f-3a23-eb5b-56fa4a6bca77@yandex-team.ru>
 <65a4bc93-ba15-7e60-765a-8691ebba94e5@redhat.com>
 <eb10c99a-a0c6-a1cf-72ee-76b796a1726e@yandex-team.ru>
In-Reply-To: <eb10c99a-a0c6-a1cf-72ee-76b796a1726e@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ping

On 20.04.23 22:06, Vladimir Sementsov-Ogievskiy wrote:
> On 16.03.23 00:22, Paolo Bonzini wrote:
>> On 3/15/23 15:28, Vladimir Sementsov-Ogievskiy wrote:
>>> On 22.02.23 18:57, Peter Maydell wrote:
>>>> On Wed, 22 Feb 2023 at 14:19, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>>>>
>>>>> On Wed, 15 Feb 2023 at 15:22, Vladimir Sementsov-Ogievskiy
>>>>> <vsementsov@yandex-team.ru> wrote:
>>>>>>
>>>>>> ping
>>>>>>
>>>>>> [add Stefan]
>>>>>
>>>>> I'm not familiar with the Coverity models. Peter Maydell is the maintainer.
>>>>
>>>> We haven't run Coverity scans since September last year.
>>>
>>> What's the problem with it? May I help somehow?
>>
>> The container broke when libslirp was removed, and I've been procrastinating fixing it. 🙁
>>
>> Paolo
> 
> Hi!
> 
> I see Coverity works again. Could we give this patch a try?
> 
> Locally, I now run Coverity on master, on master with dropped model (half of my patch) and with my full patch.
> 
> The model, that this patch drops, fixes 94 issues. The assertion I propose fixes same 94 issues and two more resource leaks.
> 
> The model, that this patch drops, also bring 4 issues. The assertion I propose brings no new issues.
> 
> Of course, my local setup is different from QEMU Coverity cloud run.
> 

-- 
Best regards,
Vladimir


