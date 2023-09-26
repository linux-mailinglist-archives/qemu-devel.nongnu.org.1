Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E08927AE9FD
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:09:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql50d-0001vw-UV; Tue, 26 Sep 2023 06:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ql508-0001dI-9S
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:09:09 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ql505-0004Qb-D0
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:09:07 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5429:0:640:6285:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 6A4B261151;
 Tue, 26 Sep 2023 13:09:00 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b41d::1:39] (unknown
 [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id w8Mn6g0Oma60-MTISgXtM; Tue, 26 Sep 2023 13:08:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695722939;
 bh=TgtlvIw7o3qmAf8D/vVz0ykzcV07mhj01xMEr3bZSq8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=1mn+yS0owBsfMKe1tLEJx+hmeq17kr3W2emhsxtMyh31Y0WJ/0ireMjf79wWoEQGD
 02bd8RjRCatEqfF/aMjXEYLKIkD0oDO43iJtxn94dblsFlR0Ue8poheowHyCFqh67I
 OiKRfdDMYtS/9kRkSN+4bf5IkFJBYS+95fQ53p6U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c8da03cb-ab5f-9104-0ddd-0f04080f55db@yandex-team.ru>
Date: Tue, 26 Sep 2023 13:08:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/12] device_tree: qmp_dumpdtb(): stronger assertion
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 Alistair Francis <alistair.francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-6-vsementsov@yandex-team.ru>
 <CAKmqyKM6_2uxa7q9XmRZA8e6dc7D3rmZGW2yPt8c9andOR4hCQ@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAKmqyKM6_2uxa7q9XmRZA8e6dc7D3rmZGW2yPt8c9andOR4hCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 26.09.23 04:26, Alistair Francis wrote:
> On Tue, Sep 26, 2023 at 6:42 AM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> Coverity mark this size, got from the buffer as untrasted value, it's
> 
> s/untrasted/untrusted/g

will fix.

> 
>> not good to use it as length when writing to file. Make the assertion
>> more strict to also check upper bound.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> 

Thanks!

> 
>> ---
>>   softmmu/device_tree.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/softmmu/device_tree.c b/softmmu/device_tree.c
>> index 30aa3aea9f..adc4236e21 100644
>> --- a/softmmu/device_tree.c
>> +++ b/softmmu/device_tree.c
>> @@ -660,7 +660,7 @@ void qmp_dumpdtb(const char *filename, Error **errp)
>>
>>       size = fdt_totalsize(current_machine->fdt);
>>
>> -    g_assert(size > 0);
>> +    g_assert(size > 0 && size <= FDT_MAX_SIZE);
>>
>>       if (!g_file_set_contents(filename, current_machine->fdt, size, &err)) {
>>           error_setg(errp, "Error saving FDT to file %s: %s",
>> --
>> 2.34.1
>>
>>

-- 
Best regards,
Vladimir


