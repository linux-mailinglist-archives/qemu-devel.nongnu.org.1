Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DA27AEBA8
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:43:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql6Sl-00005K-8y; Tue, 26 Sep 2023 07:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ql6Sa-000050-Qe
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:42:38 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ql6SX-0001E2-NZ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:42:36 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id C7A915F5D9;
 Tue, 26 Sep 2023 14:42:26 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b41d::1:39] (unknown
 [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id PgN8mk0OfOs0-EIh7Q6qo; Tue, 26 Sep 2023 14:42:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695728546;
 bh=4lbYD26LchTtVGQQKgxWDJ+izmYi1irFdlWMGP+DNz4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=F8kyATwG6Fhyc70GWJN2rSOMr/zwkgxeteTMNVmFf9HljQUd1100HWHRu3RG0hLXI
 8VYpuKco2cV4nsBDeYbaTrYpx/0t0g109I/ajzlCCvfhgKJUSIwubtN5jSn9p1iCHg
 y51vNJLtQPluBmIT97DpNT6Oz7uncbANB+0YeFBc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0b107b88-cb0e-adf9-2060-061176a85766@yandex-team.ru>
Date: Tue, 26 Sep 2023 14:42:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/12] hw/core/loader: load_at(): check size
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-2-vsementsov@yandex-team.ru>
 <CAFEAcA8MeLs5fz+PjLsL351OHv3vr8+4_tnD97guZHXs76iTog@mail.gmail.com>
 <43de490c-3e66-0703-4cb7-2fba306fc970@yandex-team.ru>
 <CAFEAcA9YT5q=M_udwypv6EYW4W0VbMCFYBGgrNZbyswfK44tLg@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFEAcA9YT5q=M_udwypv6EYW4W0VbMCFYBGgrNZbyswfK44tLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 26.09.23 13:54, Peter Maydell wrote:
> On Tue, 26 Sept 2023 at 11:51, Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> On 26.09.23 13:33, Peter Maydell wrote:
>>> On Mon, 25 Sept 2023 at 20:41, Vladimir Sementsov-Ogievskiy
>>> <vsementsov@yandex-team.ru> wrote:
>>>>
>>>> This @size parameter often comes from fd. We'd better check it before
>>>> doing read and allocation.
>>>>
>>>> Chose 1G as high enough empiric bound.
>>>
>>> Empirical for who?
>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> ---
>>>>    hw/core/loader.c | 17 ++++++++++++++++-
>>>>    1 file changed, 16 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>>>> index 4dd5a71fb7..4b67543046 100644
>>>> --- a/hw/core/loader.c
>>>> +++ b/hw/core/loader.c
>>>> @@ -281,11 +281,26 @@ ssize_t load_aout(const char *filename, hwaddr addr, int max_sz,
>>>>
>>>>    /* ELF loader */
>>>>
>>>> +#define ELF_LOAD_MAX (1024 * 1024 * 1024)
>>>> +
>>>>    static void *load_at(int fd, off_t offset, size_t size)
>>>>    {
>>>>        void *ptr;
>>>> -    if (lseek(fd, offset, SEEK_SET) < 0)
>>>> +
>>>> +    /*
>>>> +     * We often come here with @size, which was previously read from file
>>>> +     * descriptor too. That's not good to read and allocate for unchecked
>>>> +     * number of bytes. Coverity also doesn't like it and generate problems.
>>>> +     * So, let's limit all load_at() calls to ELF_LOAD_MAX at least.
>>>> +     */
>>>> +    if (size > ELF_LOAD_MAX) {
>>>>            return NULL;
>>>> +    }
>>>> +
>>>> +    if (lseek(fd, offset, SEEK_SET) < 0) {
>>>> +        return NULL;
>>>> +    }
>>>> +
>>>>        ptr = g_malloc(size);
>>>>        if (read(fd, ptr, size) != size) {
>>>>            g_free(ptr);
>>>
>>> This doesn't really help anything:
>>>    (1) if the value is really big, it doesn't cause any terrible
>>> consequences -- QEMU will just exit because the allocation
>>> fails, which is fine because this will be at QEMU startup
>>> and only happens if the user running QEMU gives us a silly file
>>>    (2) we do a lot of other "allocate and abort on failure"
>>> elsewhere in the ELF loader, for instance the allocations of
>>> the symbol table and relocs in the load_symbols and
>>> elf_reloc functions, and then on a bigger scale when we
>>> work with the actual data in the ELF file
>>
>> Reasonable..
>>
>> Don't you have an idea, how to somehow mark the value "trusted" for Coverity?
> 
> In the web UI, I just mark it "false positive" in the dropdown, and
> move on. Coverity has an absolute ton of false positives, and you
> really can't work with it unless you have a workflow for ignoring them.
> 

Yes, I have the possibility to mark "false positives", but tried to fix some things in the code which seemed reasonable to me. Thanks a lot for reviewing and explaining!

-- 
Best regards,
Vladimir


