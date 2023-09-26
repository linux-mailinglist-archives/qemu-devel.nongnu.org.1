Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AAC7AEA1F
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:14:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql55O-0008Oh-K0; Tue, 26 Sep 2023 06:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ql558-0008Jz-Pc
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:14:22 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ql550-0005Tk-LO
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:14:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5429:0:640:6285:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id BC234615BD;
 Tue, 26 Sep 2023 13:14:07 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b41d::1:39] (unknown
 [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5EM7Jg0OhSw0-QjeDPh2t; Tue, 26 Sep 2023 13:14:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695723247;
 bh=ZtRadfK14Zf7WbmQ/TY2O3l/ddexR2MW+zXJPxNN/yk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Z785yqeuC3y2/rfjJrLVTeMym57sn1lDS9quL7b00lgEwxrPr/M4oqerjVtrpyqre
 4Z6zjz5+U5RnZc4bQVDa+53tho+q0URMGvRgWvKYqUZVoS2C3AVG79gaQDN0mcWdGh
 mTEjA8kb+Ffwzv8dW7zOmc9ORaGxGNuGw0JGKdD0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3e9ef42b-50dc-b64b-0fe2-d3a0c4153bd2@yandex-team.ru>
Date: Tue, 26 Sep 2023 13:14:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/12] hw/core/loader: read_targphys(): add upper bound
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Ard Biesheuvel <ardb@kernel.org>
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-12-vsementsov@yandex-team.ru>
 <26c46089-828a-721e-21f3-7286f270a60b@tls.msk.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <26c46089-828a-721e-21f3-7286f270a60b@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 25.09.23 23:12, Michael Tokarev wrote:
> 25.09.2023 22:40, Vladimir Sementsov-Ogievskiy wrote:
>> Coverity doesn't like using "untrusted" values, coming from buffers and
>> fd-s as length to do IO and allocations. And that's make sense. The
> 
> "And that makes sense".  Just a nitpick in commit comment.
> 
>> function is used three times with "untrusted" nbytes parameter. Let's
>> introduce at least empirical limit of 1G for it.
>>
>> While being here make the function static, as it's used only here.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   hw/core/loader.c    | 13 ++++++++++---
>>   include/hw/loader.h |  2 --
>>   2 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>> index aa02b27089..48cff6f59e 100644
>> --- a/hw/core/loader.c
>> +++ b/hw/core/loader.c
>> @@ -101,17 +101,24 @@ ssize_t load_image_size(const char *filename, void *addr, size_t size)
>>       return actsize < 0 ? -1 : l;
>>   }
>> +#define READ_TARGPHYS_MAX_BYTES (1024 * 1024 * 1024)
>>   /* read()-like version */
>> -ssize_t read_targphys(const char *name,
>> -                      int fd, hwaddr dst_addr, size_t nbytes)
>> +static ssize_t read_targphys(const char *name,
>> +                             int fd, hwaddr dst_addr, size_t nbytes)
>>   {
>>       uint8_t *buf;
>>       ssize_t did;
>> +    if (nbytes > READ_TARGPHYS_MAX_BYTES) {
>> +        return -1;
> 
> Right now this is not important, since the only user of this
> function, load_aout(), ignores errno value and reports general
> failure instead.  Original read_targphys() returned errno which
> corresponds to failed read().

Agree, will fix to -EINVAL

> 
> FWIW, at least load_aout() assumes we've read whole struct exec
> from the file in question, which might not be the case.
> 

Hmm, right. Will fix too.

Thanks for reviewing!

-- 
Best regards,
Vladimir


