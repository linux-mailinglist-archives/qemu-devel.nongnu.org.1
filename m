Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFF77262C2
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:27:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6u7k-0003sr-O6; Wed, 07 Jun 2023 10:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q6u7h-0003pI-Ga; Wed, 07 Jun 2023 10:26:53 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q6u7f-0004o4-4m; Wed, 07 Jun 2023 10:26:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2c24:0:640:73f8:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id C29F3608E5;
 Wed,  7 Jun 2023 17:26:38 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b5a3::1:2b] (unknown
 [2a02:6b8:b081:b5a3::1:2b])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bQV0is1OrCg0-VugfDkIZ; Wed, 07 Jun 2023 17:26:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1686147998; bh=ciAmZdMpg9aQlJTSAGehykzT7H6qbwrpZW2VUq0ZMgg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=EbUE4rrN1ovqsgeZ4fI3juJJ9zc8q6QiAGZAZxg5sJx1M2EYCKuwKdMsrc0vymyJd
 KunQl9qM3qMhUFAlzmsM01il87fySAIGpTOvNpkka8a7pGpCcCpX6fSvYbNjIwBD0N
 axwM8sYvLiQfflwcw1rOqJWnm3VSityIR1dPXn84=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <318437e3-b7a1-9509-e80f-51fb9ec2a5a6@yandex-team.ru>
Date: Wed, 7 Jun 2023 17:26:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] gitlab: Disable io-raw-194 for build-tcg-disabled
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, berrange@redhat.com,
 jsnow@redhat.com, qemu block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230606162556.58110-1-richard.henderson@linaro.org>
 <CAJSP0QVwkoAauG37BLgcqsWrjp3rE3-fVdQjeCkB=aboUAKnjw@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAJSP0QVwkoAauG37BLgcqsWrjp3rE3-fVdQjeCkB=aboUAKnjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 07.06.23 15:44, Stefan Hajnoczi wrote:
> The line of output that has changed was originally added by the
> following commit:
> 
> commit ae00aa2398476824f0eca80461da215e7cdc1c3b
> Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Date:   Fri May 22 01:06:46 2020 +0300
> 
>      iotests: 194: test also migration of dirty bitmap
> 
> Vladimir: Any idea why the postcopy-active event may not be emitted in
> some cases?
> 

I think:

fast connection + small postcopy data => postcopy actually not started, everything is migrated in downtime, when both source and target are not running.

The test doesn't want to test exactly postcopy, but just want to check that bitmaps are migrated somehow.


So, we need something like this:

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 68894371f5..c0ce82dd25 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -74,6 +74,11 @@ with iotests.FilePath('source.img') as source_img_path, \
  
      while True:
          event1 = source_vm.event_wait('MIGRATION')
+        if event1['data']['status'] == 'postcopy-active':
+            # This event is racy, it depends do we really do postcopy or bitmap
+            # was migrated during downtime (and no data to migrate in postcopy
+            # phase). So, don't log it.
+            continue
          iotests.log(event1, filters=[iotests.filter_qmp_event])
          if event1['data']['status'] in ('completed', 'failed'):
              iotests.log('Gracefully ending the `drive-mirror` job on source...')



> 
> On Tue, 6 Jun 2023 at 12:26, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This test consistently fails on Azure cloud build hosts in
>> a way that suggests a timing problem in the test itself:
>>
>> --- .../194.out
>> +++ .../194.out.bad
>> @@ -14,7 +14,6 @@
>>   {"return": {}}
>>   {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>>   {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>> -{"data": {"status": "postcopy-active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>>   {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>>   Gracefully ending the `drive-mirror` job on source...
>>   {"return": {}}
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   .gitlab-ci.d/buildtest.yml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index 0f1be14cb6..000062483f 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -236,7 +236,7 @@ build-tcg-disabled:
>>       - cd tests/qemu-iotests/
>>       - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
>>               052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163
>> -            170 171 183 184 192 194 208 221 226 227 236 253 277 image-fleecing
>> +            170 171 183 184 192 208 221 226 227 236 253 277 image-fleecing
>>       - ./check -qcow2 028 051 056 057 058 065 068 082 085 091 095 096 102 122
>>               124 132 139 142 144 145 151 152 155 157 165 194 196 200 202
>>               208 209 216 218 227 234 246 247 248 250 254 255 257 258
>> --
>> 2.34.1
>>
>>

-- 
Best regards,
Vladimir


