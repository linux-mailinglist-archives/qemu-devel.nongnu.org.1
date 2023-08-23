Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33980786004
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 20:43:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYsoU-0006Wp-Os; Wed, 23 Aug 2023 14:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYsoQ-0006WZ-TL
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 14:42:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYsoO-0002PM-TI
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 14:42:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5836E1C706;
 Wed, 23 Aug 2023 21:42:52 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 05BCD215DA;
 Wed, 23 Aug 2023 21:42:33 +0300 (MSK)
Message-ID: <4f56b09d-1134-5d40-336a-7d2b909d4acb@tls.msk.ru>
Date: Wed, 23 Aug 2023 21:42:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 22/24] tests/: spelling fixes
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
References: <cover.1691405748.git.mjt@tls.msk.ru>
 <20230823055155.1917375-23-mjt@tls.msk.ru>
 <xu3di33awphpggqem25ebfasbveyyvb35fznf4b46xjgxiucv4@nawbmm3tgxqp>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <xu3di33awphpggqem25ebfasbveyyvb35fznf4b46xjgxiucv4@nawbmm3tgxqp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

23.08.2023 20:55, Eric Blake wrote:
> On Wed, Aug 23, 2023 at 08:51:53AM +0300, Michael Tokarev wrote:
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>> ---
> 
>> +++ b/tests/qemu-iotests/298
>> @@ -142,5 +142,5 @@ class TestTruncate(iotests.QMPTestCase):
>>   
>>           # Probably we'll want preallocate filter to keep align to cluster when
>> -        # shrink preallocation, so, ignore small differece
>> +        # shrink preallocation, so, ignore small difference
> 
> The sentence as a whole still comes across awkwardly; maybe shorten and reword to:

Yeah. I especially didn't tweak wording, - there are a LOT of places
which needs additional tweaking, and the patch set is already way too
large...  It was tempting to tweak some of these but I decided to draw
the line somewhere.

> The preallocate filter may keep cluster alignment when shrinking, so
> ignore small differences

Hwell :)


>> +++ b/tests/unit/test-throttle.c
>> @@ -136,5 +136,5 @@ static void test_compute_wait(void)
>>           g_assert(double_cmp(bkt.level, (i + 1) * (bkt.max - bkt.avg) / 10));
>>           /* We can do bursts for the 2 seconds we have configured in
>> -         * burst_length. We have 100 extra miliseconds of burst
>> +         * burst_length. We have 100 extra milliseconds of burst
>>            * because bkt.level has been leaking during this time.
>>            * After that, we have to wait. */
>> @@ -380,5 +380,5 @@ static void test_is_valid(void)
>>       /* zero are valids */
>>       test_is_valid_for_value(0, true);
>> -    /* positives numers are valids */
>> +    /* positives numbers are valids */
> 
> Multiple grammar errors in this function.  Should be:
> 
> /* negative numbers are invalid */
> /* zero is valid */
> /* positive numbers are valid */

Actually I missed this "valids" somehow, even after additional
re-reading of the changes.

Still, these are *grammar* errors, not spelling errors, so the
subject line does not fit anymore :)

> All other changes in this patch look good.  With additional tweaks,
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Adding extra comment about the grammar changes to the commit message :)

Thank you!

/mjt

