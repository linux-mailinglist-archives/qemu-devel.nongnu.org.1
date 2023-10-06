Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EA17BB5B2
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 12:55:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoiUE-0002yz-Nn; Fri, 06 Oct 2023 06:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoiU7-0002y7-7c; Fri, 06 Oct 2023 06:55:07 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoiU4-0003EM-3y; Fri, 06 Oct 2023 06:55:06 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:201e:0:640:d29a:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 2A12161E97;
 Fri,  6 Oct 2023 13:54:58 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7322::1:25] (unknown
 [2a02:6b8:b081:7322::1:25])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vsWl3o6Od0U0-TdJnjk27; Fri, 06 Oct 2023 13:54:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696589697;
 bh=VRvE+SDMj6meLBvyHZWcQDT4sIc1r9KG9Jaer102fl4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=KWNMgQSCd/dQWxDGlHpOCv/cmeJ2HEVRt/ByvmnXjmDAzx5JzIqtAREjqvCzI+6L/
 XjOHYYiHfyjKCK6Wx06cnS7aEfT58/VsPe4oyMoC8uTh9LkUdxrWPi4BvCh8Yxvuo1
 Ch1Euxv7+5SppfgZGSuLmkzx0rIK066DcdHyaWDk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <14fc1728-1a73-4c4e-915d-9bff13fa68b0@yandex-team.ru>
Date: Fri, 6 Oct 2023 13:54:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/14] python: use vm.cmd() instead of vm.qmp() where
 appropriate
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jsnow@redhat.com,
 crosa@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20231005135550.331657-1-vsementsov@yandex-team.ru>
 <20231005135550.331657-15-vsementsov@yandex-team.ru>
 <iyntga7bgkuel7cvowdvovte2ie7tp3u5dyr4zyicfygdggqdi@uuwpu3gehnos>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <iyntga7bgkuel7cvowdvovte2ie7tp3u5dyr4zyicfygdggqdi@uuwpu3gehnos>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Thanks a lot for reviewing!

On 05.10.23 23:29, Eric Blake wrote:
> On Thu, Oct 05, 2023 at 04:55:50PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> In many cases we just want an effect of qmp command and want to raise on
>> failure. Use vm.cmd() method which does exactly this.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   tests/avocado/vnc.py                          |  16 +-
>>   tests/qemu-iotests/030                        | 168 +++---
>>   tests/qemu-iotests/040                        | 172 +++----

[..]

>>   tests/qemu-iotests/tests/mirror-top-perms     |  16 +-
>>   tests/qemu-iotests/tests/nbd-multiconn        |  12 +-
>>   tests/qemu-iotests/tests/reopen-file          |   3 +-
>>   .../qemu-iotests/tests/stream-error-on-reset  |   6 +-
>>   41 files changed, 951 insertions(+), 1407 deletions(-)
> 
> Big but mechanical.  It would be worth amending the commit message to
> describe how you found all these spots (in case someone backporting
> this patch has to redo the work over a different subset of files based
> on what has changed since the two trees diverged).

Oops good notice.

I ofcourse didn't remember:) I started from searching for 'self.assert_qmp(result, 'return', {})", and found that there are unhandled cases, so the patch is a bit outdated and misses some new cases.

I started to write a script and found that this is not easy) I decided to search the script in my old good scripts folder, and found it! I remember, that I didn't posted it, because it was neither simple nor beautiful.. And too big for commit message. But seems, better is to post it still, as a separate commit maybe.

Feel sorry to send unupdated patch :(

> 
>>
>> diff --git a/tests/avocado/vnc.py b/tests/avocado/vnc.py
>> index aeeefc70be..862c8996a8 100644
>> --- a/tests/avocado/vnc.py
>> +++ b/tests/avocado/vnc.py
>> @@ -88,9 +88,8 @@ def test_change_password(self):
>>           self.vm.add_args('-nodefaults', '-S', '-vnc', ':0,password=on')
>>           self.vm.launch()
>>           self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
>> -        set_password_response = self.vm.qmp('change-vnc-password',
>> -                                            password='new_password')
>> -        self.assertEqual(set_password_response['return'], {})
>> +        self.vm.cmd('change-vnc-password',
>> +                    password='new_password')
> 
> Indeed a nicer idiom, where you are able to use it (whether by
> self.assertEqual or by self.assert_qmp).
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

-- 
Best regards,
Vladimir


