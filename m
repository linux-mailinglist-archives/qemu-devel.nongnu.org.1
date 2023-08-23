Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 631E5785784
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 14:07:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYmcx-0002jM-PI; Wed, 23 Aug 2023 08:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYmcv-0002iu-Dl
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 08:06:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYmcs-0005VO-La
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 08:06:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 353351C5AA;
 Wed, 23 Aug 2023 15:06:34 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 634F821490;
 Wed, 23 Aug 2023 15:06:15 +0300 (MSK)
Message-ID: <41d6763c-2de6-6ef7-7a2c-edd83e127ae0@tls.msk.ru>
Date: Wed, 23 Aug 2023 15:06:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 06/24] docs: spelling fixes
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
 <20230823065335.1919380-5-mjt@tls.msk.ru> <87r0nugewa.fsf@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <87r0nugewa.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.684,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

23.08.2023 11:30, Alex Bennée wrote:
> Michael Tokarev <mjt@tls.msk.ru> writes:

>> --- a/docs/devel/qapi-code-gen.rst
>> +++ b/docs/devel/qapi-code-gen.rst
>> @@ -1368,5 +1368,5 @@ anymore, optional return or event data members that can't be sent
>>   anymore, and return or event data member (enumeration) values that
>>   can't be sent anymore makes no difference to clients, except for
>> -introspection.  The latter can conceivably confuse clients, so tread
>> +introspection.  The latter can conceivably confuse clients, so treat
>>   carefully.
> 
> I guess this is a cultural idiom because "tread carefully" is a common
> phrase in British English at least. For example:
> 
>    Investors need to tread carefully, as irrational exuberance has a
>    habit of eclipsing common sense in the world of tech.

Hm. I've never seen/heard anything like this. I think the meaning is
a bit different, - "thread" is about building something on top of this,
the base might be not very stable.  Sure thing this change might be
omitted.  It's just something which catches my eyes, but I'm not a
native English speaker for sure.

/mjt

