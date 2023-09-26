Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 825B87AEE8A
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 16:51:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql9O2-0004Kr-Mg; Tue, 26 Sep 2023 10:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ql9Nz-0004Kf-19
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:50:03 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ql9Nu-0007KJ-RH
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:50:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5429:0:640:6285:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 415FF613D7;
 Tue, 26 Sep 2023 17:49:54 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b41d::1:39] (unknown
 [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id rnQImn0Oca60-StuCL6yV; Tue, 26 Sep 2023 17:49:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695739793;
 bh=52P7ivRmreoIBrospgFGRtv2ATCZjDAvi7vkNLxLgx8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ITbSJkEGeoFb2fVYWQNALUQ2twPUqDf3ILK/EiwDduVBiqbvwo0kt8Kz8mbLuouGL
 SPuAHW/qkLK07mQPYxNKlbK3hwQnLCZ5HJTmYNdEj8MFGZMHWsXVe50OeuKiIHiaxy
 dZ8AeHAiCmGfIzy5+eJXo1HqkRQwI9C7O4SitF4Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ca305dae-9e1d-bb76-36e6-fd007a817d0c@yandex-team.ru>
Date: Tue, 26 Sep 2023 17:49:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/12] kvm-all: introduce limits for name_size and num_desc
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 "open list:Overall KVM CPUs" <kvm@vger.kernel.org>
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-10-vsementsov@yandex-team.ru>
 <CAFEAcA8CXa1fyyGtZRwbyPch9wwmgMrg8wbWEPZ3pL3GW6n1dg@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFEAcA8CXa1fyyGtZRwbyPch9wwmgMrg8wbWEPZ3pL3GW6n1dg@mail.gmail.com>
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

On 26.09.23 14:05, Peter Maydell wrote:
> On Mon, 25 Sept 2023 at 20:43, Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> Coverity doesn't like when the value with unchecked bounds that comes
>> from fd is used as length for IO or allocation. And really, that's not
>> a good practice. Let's introduce at least an empirical limits for these
>> values.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   accel/kvm/kvm-all.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index ff1578bb32..6d0ba7d900 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -3988,6 +3988,9 @@ typedef struct StatsDescriptors {
>>   static QTAILQ_HEAD(, StatsDescriptors) stats_descriptors =
>>       QTAILQ_HEAD_INITIALIZER(stats_descriptors);
>>
>> +
>> +#define KVM_STATS_QEMU_MAX_NAME_SIZE (1024 * 1024)
>> +#define KVM_STATS_QEMU_MAX_NUM_DESC (1024)
> 
> These seem arbitrary. Why these values in particular?
> Does the kernel have any limitation on the values it passes us?

Documentation doesn't say about limits

> Do we have any particular limit on what we can handle?
> 

Hmm. At least, we don't arithmetic operations with these values to overflow. But in this case g_malloc0_n should crash anyway.

So we may rely on g_malloc0_n as on assertion that the values are good enough and further doubts are false-positives. Will drop this patch.

-- 
Best regards,
Vladimir


