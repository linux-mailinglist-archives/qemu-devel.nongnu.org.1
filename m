Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A82E6763937
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 16:34:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOdvJ-0005WI-GK; Wed, 26 Jul 2023 08:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qOdv6-0005VD-B9
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:47:12 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qOdv4-0002Ge-6d
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:47:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9a90:0:640:d8ed:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 968C45F177;
 Wed, 26 Jul 2023 15:47:02 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b687::1:2a] (unknown
 [2a02:6b8:b081:b687::1:2a])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 1lKUf10OpeA0-NrEIqKFy; Wed, 26 Jul 2023 15:47:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1690375622; bh=DoJmwZ/z5PvZh/SQzSSQPA3I4M8bX+EeIhT08pNH+Fs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wHyH45V1SBwK0BiyRsZhef5C/WH0rT0hhfdTS8rWOWdDH7HT+0rPxG10A2bD3+4oy
 IqnRlv9sjmbqQ88n+FFcpvygISZN7YwIzuAcu6KGv+rPSSqPyrMUXpJQfUV3yvn/k1
 sSCgV61Eow1pY9tlG4Y3TnYXmMUfjd7ssfbOJj+Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <bba9ee80-0051-44a4-0c70-eff608e552d6@yandex-team.ru>
Date: Wed, 26 Jul 2023 15:47:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 1/5] qapi/block-core: Tidy up BlockLatencyHistogramInfo
 documentation
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <20230726112855.155795-1-armbru@redhat.com>
 <20230726112855.155795-2-armbru@redhat.com>
 <a86c0dc4-a5dc-48cb-57af-92ecdf27ac81@yandex-team.ru>
 <87pm4e6fvl.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87pm4e6fvl.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

On 26.07.23 15:01, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 26.07.23 14:28, Markus Armbruster wrote:
>>> Documentation for member @bin comes out like
>>>       list of io request counts corresponding to histogram intervals.
>>>       len("bins") = len("boundaries") + 1 For the example above, "bins"
>>>       may be something like [3, 1, 5, 2], and corresponding histogram
>>>       looks like:
>>>
>>> Note how the equation and the sentence following it run together.
>>> Replace the equation:
>>>
>>>       list of io request counts corresponding to histogram intervals,
>>>       same number of elements as "boundaries".  For the example above,
>>
>> not same, but one more. N points break the line into N+1 intervals
> 
> Thanks for catching this.
> 
> What about "one more element than @boundaries has"?

Sounds good!

> 
>>>       "bins" may be something like [3, 1, 5, 2], and corresponding
>>>       histogram looks like:
>>> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> Message-ID: <20230720071610.1096458-2-armbru@redhat.com>
> 

-- 
Best regards,
Vladimir


