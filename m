Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 209FF7B9D05
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:37:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNZy-00078v-CC; Thu, 05 Oct 2023 08:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoNZf-00072t-55; Thu, 05 Oct 2023 08:35:27 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoNZa-0007g6-OM; Thu, 05 Oct 2023 08:35:25 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7d8a:0:640:8fc3:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 890AE61113;
 Thu,  5 Oct 2023 15:35:16 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b584::1:2f] (unknown
 [2a02:6b8:b081:b584::1:2f])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id FZX9FO4OqCg0-pXrcS2v9; Thu, 05 Oct 2023 15:35:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696509315;
 bh=Zd0dbIqoOpwQGkuAF4jr5vmJmWyLHD4NFZ5BxVPCSpM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=l7nPk/2PaxCcJgFPZ9F6MecIp0EP6osvufkA4Ws94z+nHkIpZ6OKfdofBUbbwFK3q
 lufR/TsBH8ouLNPlHydP+vdSkLvZcrz2/tRRfI067/keL7QmNYAcWxesm/hKuyizWo
 M4eaoSP1hZeIvd5HyOR/U41OEhjKDupzhZx5p+bQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <602039f4-2a22-49ed-ab19-5ca62c9f2b47@yandex-team.ru>
Date: Thu, 5 Oct 2023 15:35:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to tame CI?
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 quintela@redhat.com, Kevin Wolf <kwolf@redhat.com>, hreitz@redhat.com
Cc: qemu-devel@nongnu.org, Daniel Berrange <berrange@redhat.com>,
 richard.henderson@linaro.org, Qemu-block <qemu-block@nongnu.org>
References: <87fs5aho6e.fsf@secure.mitica>
 <CAFEAcA89zgd+ZFBcMasTZErH6eTknXJhnDaXyW_LWj_vAYKrnw@mail.gmail.com>
 <e68d2e2f-6afe-820b-fa45-44db5b6edf09@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <e68d2e2f-6afe-820b-fa45-44db5b6edf09@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
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

On 26.07.23 16:32, Thomas Huth wrote:
> On 26/07/2023 15.00, Peter Maydell wrote:
>> On Wed, 26 Jul 2023 at 13:06, Juan Quintela <quintela@redhat.com> wrote:
>>> To make things easier, this is the part that show how it breaks (this is
>>> the gcov test):
>>>
>>> 357/423 qemu:block / io-qcow2-copy-before-write                            ERROR           6.38s   exit status 1
>>>>>> PYTHON=/builds/juan.quintela/qemu/build/pyvenv/bin/python3 MALLOC_PERTURB_=44 /builds/juan.quintela/qemu/build/pyvenv/bin/python3 /builds/juan.quintela/qemu/build/../tests/qemu-iotests/check -tap -qcow2 copy-before-write --source-dir /builds/juan.quintela/qemu/tests/qemu-iotests --build-dir /builds/juan.quintela/qemu/build/tests/qemu-iotests
>>> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
>>> stderr:
>>> --- /builds/juan.quintela/qemu/tests/qemu-iotests/tests/copy-before-write.out
>>> +++ /builds/juan.quintela/qemu/build/scratch/qcow2-file-copy-before-write/copy-before-write.out.bad
>>> @@ -1,5 +1,21 @@
>>> -....
>>> +...F
>>> +======================================================================
>>> +FAIL: test_timeout_break_snapshot (__main__.TestCbwError)
>>> +----------------------------------------------------------------------
>>> +Traceback (most recent call last):
>>> +  File "/builds/juan.quintela/qemu/tests/qemu-iotests/tests/copy-before-write", line 210, in test_timeout_break_snapshot
>>> +    self.assertEqual(log, """\
>>> +AssertionError: 'wrot[195 chars]read 1048576/1048576 bytes at offset 0\n1 MiB,[46 chars]c)\n' != 'wrot[195 chars]read failed: Permission denied\n'
>>> +  wrote 524288/524288 bytes at offset 0
>>> +  512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> +  wrote 524288/524288 bytes at offset 524288
>>> +  512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> ++ read failed: Permission denied
>>> +- read 1048576/1048576 bytes at offset 0
>>> +- 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> +
>>
>> This iotest failing is an intermittent that I've seen running
>> pullreqs on master. I tend to see it on the s390 host. I
>> suspect a race condition somewhere where it fails if the host
>> is heavily loaded.
> 
> It's obviously a failure in an iotest, so let's CC: the corresponding people (done now).
> 

Sorry for long delay.

Does it still fail?

In the test we expect that copy-before-write operation fails (because of throttling and timeout), and therefore snapshot is broken and next read from snapshot should fail.

But most probably the copy-before-write operation succeeded in this case for some reason.. I don't think that throttling and timeouts in block layer can guarantee some determinism.. But usually it works.

we use throttling with bps-write = 300 * 1024, i.e. 300KB per second. and cbw-timeout is set to 1 second.

Then we do write 512K,

then the comment say:
# We need second write to trigger throttling

and we write another 512K.

first 512K are written, and we should wait 512/300 = 1.7 seconds since _start_ of that write before issuing the second one.. But if write was slow we may have to wait less than a second from finish of the first write start the second one. Then timeout will not fire.

====

I see two possible ways to fix that:

1. decrease bps-write a bit. For example to 200 BPS.

2. rework the test to use null-co instead of real images. This way we will not suffer from unstable IO duration.


So, is the problem still fire sometimes?	

-- 
Best regards,
Vladimir


