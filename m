Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3168C7BBDEA
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 19:43:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qooqu-0000zT-R0; Fri, 06 Oct 2023 13:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qooqo-0000yr-76; Fri, 06 Oct 2023 13:42:58 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qooqm-0000Te-9h; Fri, 06 Oct 2023 13:42:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3a8c:0:640:ec94:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 9A63F60ACF;
 Fri,  6 Oct 2023 20:42:50 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a512::1:22] (unknown
 [2a02:6b8:b081:a512::1:22])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id mgd9oc5Oo4Y0-xAbhn8e4; Fri, 06 Oct 2023 20:42:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696614170;
 bh=BFA+lcE+byumsV1F40S7Idj0hMyx7TsJ2JK9gK49VjE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=L1QoHoOiS/esw7IS6eRe7m2/tpyIwN13EGTTXgcbL+AL8N15w+3hc7Q4x8XhK5Rpt
 NM7tywK6Y9GjzneI7I2Vws0cZqhlK6rS+qQ5wvyqLn2derKgy+SHW+auYZIPPI4Cwz
 h0w5yIaZIsAamCE2FByAOSLmW39ns9iFKeMdOqAM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <67452e9d-6d80-4af8-a252-838ea3d359a1@yandex-team.ru>
Date: Fri, 6 Oct 2023 20:42:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/15] scripts: add python_qmp_updater.py
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jsnow@redhat.com,
 crosa@redhat.com, kwolf@redhat.com, hreitz@redhat.com
References: <20231006154125.1068348-1-vsementsov@yandex-team.ru>
 <20231006154125.1068348-15-vsementsov@yandex-team.ru>
 <4q5nlgbdizox46ey7sadxyysmey5tvqf7qkk5d67jng4xbku3i@mnsmpz3v25wg>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <4q5nlgbdizox46ey7sadxyysmey5tvqf7qkk5d67jng4xbku3i@mnsmpz3v25wg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 06.10.23 20:01, Eric Blake wrote:
> On Fri, Oct 06, 2023 at 06:41:24PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> A script, to update the pattern
>>
>>      result = self.vm.qmp(...)
>>      self.assert_qmp(result, 'return', {})
>>
>> (and some similar ones) into
>>
>>      self.vm.cmd(...)
>>
>> Used in the next commit
>>      "python: use vm.cmd() instead of vm.qmp() where appropriate"
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   scripts/python_qmp_updater.py | 136 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 136 insertions(+)
>>   create mode 100755 scripts/python_qmp_updater.py
>>
>> diff --git a/scripts/python_qmp_updater.py b/scripts/python_qmp_updater.py
>> new file mode 100755
>> index 0000000000..494a169812
>> --- /dev/null
>> +++ b/scripts/python_qmp_updater.py
>> @@ -0,0 +1,136 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Intended usage:
>> +#
>> +# git grep -l '\.qmp(' | xargs ./scripts/python_qmp_updater.py
>> +#
>> +
>> +import re
>> +import sys
>> +from typing import Optional
>> +
>> +start_reg = re.compile(r'^(?P<padding> *)(?P<res>\w+) = (?P<vm>.*).qmp\(',
>> +                       flags=re.MULTILINE)
>> +
>> +success_reg_templ = re.sub('\n *', '', r"""
>> +    (\n*{padding}(?P<comment>\#.*$))?
>> +    \n*{padding}
>> +    (
>> +        self.assert_qmp\({res},\ 'return',\ {{}}\)
>> +    |
>> +        assert\ {res}\['return'\]\ ==\ {{}}
>> +    |
>> +        assert\ {res}\ ==\ {{'return':\ {{}}}}
>> +    |
>> +        self.assertEqual\({res}\['return'\],\ {{}}\)
>> +    )""")
> 
> We may find other patterns, but this is a nice way to capture the most
> common ones and a simple place to update if we find another one.
> 
> I did a quick grep for 'assert.*return' and noticed things like:
> 
> tests/qemu-iotests/056:        self.assert_qmp(res, 'return', {})

this one is

         res = self.vm.qmp(cmd, **kwargs)
         if error:
             self.assert_qmp(res, 'error/desc', error)
             return False

so here we can't just use cmd()

> tests/qemu-iotests/056:        self.assert_qmp(res, 'return', [])

yes, that's a result of query- command, caller wants the exact result.
Actually that's a check for "no block-jobs".

> 
> This script only simplifies the {} form, not the []; but that makes
> sense: when we are testing a command known to return an array rather
> than nothing, we still want to check if the array is empty, and not
> just that the command didn't crash.  We are only simplifying the
> commands that check for nothing in particular returned, on the grounds
> that not crashing was probably good enough, and explicitly checking
> that nothing extra was returned is not worth the effort.
> 

[..]

>>
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Thanks

-- 
Best regards,
Vladimir


