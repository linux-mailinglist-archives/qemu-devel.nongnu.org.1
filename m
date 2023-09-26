Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 141877AEE69
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 16:20:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql8vE-0002A7-Oh; Tue, 26 Sep 2023 10:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ql8vB-00029p-Cy
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:20:18 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ql8v8-00011C-Jk
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:20:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 60A9C6138A;
 Tue, 26 Sep 2023 17:20:10 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b41d::1:39] (unknown
 [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 9KQTAo0OhKo0-5HFlTIRt; Tue, 26 Sep 2023 17:20:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695738009;
 bh=j1Kns/48VGEGd7m9QlprIb1xe4WsnSSWqSBms7UX0Bk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VjUpwLUgHNWEb8/Jw5F4k+laL8j6aTPgjsqlI9Evm6YTKS7oYs/d/LFdz2E/xoZoL
 GX/lCGF99ZrIh7dCBABqxY/YYOXhD/lCk8xir9UVYE+AHLdJE46+KrDJO8/+TDH8X6
 5eufGGvWJkenahHwyCl3RbhjWyBFleLg0NxOJZnc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <887188ac-4887-4491-f889-fe1f62a461e8@yandex-team.ru>
Date: Tue, 26 Sep 2023 17:20:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/12] device_tree: qmp_dumpdtb(): stronger assertion
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 Alistair Francis <alistair.francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-6-vsementsov@yandex-team.ru>
 <CAFEAcA9TjB7OJ-j+Cnst8pt3CjVADvyvG07ZvykQKRoowgMe3g@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFEAcA9TjB7OJ-j+Cnst8pt3CjVADvyvG07ZvykQKRoowgMe3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 26.09.23 13:51, Peter Maydell wrote:
> On Mon, 25 Sept 2023 at 20:42, Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> Coverity mark this size, got from the buffer as untrasted value, it's
>> not good to use it as length when writing to file. Make the assertion
>> more strict to also check upper bound.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
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
> 
> FDT_MAX_SIZE is not "this is as big as an FDT can ever be". It's
> only the internal sizing of device trees that we create ourselves
> in the machine models (and which we will bump up if for some
> reason we ever find ourselves needing to create bigger device
> trees). So it's not really a suitable upper bound.
> 
>>       if (!g_file_set_contents(filename, current_machine->fdt, size, &err)) {
>>           error_setg(errp, "Error saving FDT to file %s: %s",
> 
> Nothing bad happens if we pass g_file_set_contents() a very

but it will also try to read beyond the allocated fdt. In my thought clear crash on assertion is better than such memory access.

> large size -- we'll just create a large file. The user already
> has lots of ways to fill up their disk if they want to, and
> we don't have any idea how much disk space they might or might
> not have.
> 
> I would just mark this as a false positive.
> 
> thanks
> -- PMM

-- 
Best regards,
Vladimir


