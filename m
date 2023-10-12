Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AB67C6FCE
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 15:55:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqw9c-0000JN-Ht; Thu, 12 Oct 2023 09:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qqw9T-0000Fj-Vp; Thu, 12 Oct 2023 09:55:00 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qqw9Q-0005g9-Co; Thu, 12 Oct 2023 09:54:59 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:ba1:0:640:375a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 8EDA162FC1;
 Thu, 12 Oct 2023 16:54:48 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a401::1:4] (unknown
 [2a02:6b8:b081:a401::1:4])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id lsfLlv6Oo8c0-PBbk7Yew; Thu, 12 Oct 2023 16:54:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697118888;
 bh=vaxMZnDcCMy1UdA9IORdlkoxGImo99atnIvQNusKcug=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=twWIyjXbm1NaEMRgbYe8bD4RH657W1UPrS2L0MwiCq+7jZWMEC8k4erhuwr6wkBK5
 w4ATyACH3QBdOIfdyIa/EaFVoJ5+JXP+xaZ6ALNplVPqomx6KMTenXxZJ1WWLYRRwc
 jxwoMJiiLEfFpl5+Jb5bFO+rJEtaAnYiJ1WjTczM=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <293c6b03-857d-42b8-b0cd-ab0a1f3ff85f@yandex-team.ru>
Date: Thu, 12 Oct 2023 16:54:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] mirror: implement mirror_change method
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@virtuozzo.com,
 t.lamprecht@proxmox.com, alexander.ivanov@virtuozzo.com
References: <20231009094619.469668-1-f.ebner@proxmox.com>
 <20231009094619.469668-6-f.ebner@proxmox.com>
 <f6987c95-b1c4-4bfa-ae05-931c4f946151@yandex-team.ru>
 <cc727bee-b9aa-4493-b26e-1ea93d15f8eb@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <cc727bee-b9aa-4493-b26e-1ea93d15f8eb@proxmox.com>
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

On 11.10.23 14:22, Fiona Ebner wrote:
> Am 10.10.23 um 21:37 schrieb Vladimir Sementsov-Ogievskiy:
>> On 09.10.23 12:46, Fiona Ebner wrote:
>>>    +static void mirror_change(BlockJob *job, BlockJobChangeOptions *opts,
>>> +                          Error **errp)
>>> +{
>>> +    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
>>> +    BlockJobChangeOptionsMirror *change_opts = &opts->u.mirror;
>>> +
>>> +    if (s->copy_mode == change_opts->copy_mode) {
>>> +        return;
>>> +    }
>>> +
>>> +    if (s->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING) {
>>> +        error_setg(errp, "Cannot switch away from copy mode
>>> 'write-blocking'");
>>> +        return;
>>> +    }
>>> +
>>> +    assert(s->copy_mode == MIRROR_COPY_MODE_BACKGROUND &&
>>> +           change_opts->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING);
>>> +
>>> +    s->copy_mode = MIRROR_COPY_MODE_WRITE_BLOCKING;
>>> +}
>>
>> So, s->copy_mode becomes shared between main thread and iothread.
>>
>> We should either use mutex or atomic operations.
>>
>> Note, that the only realization of .set_speed uses thread-safe API.
>>
> 
> Can it be an issue if it's only ever set from the main thread?

Yes, I also think, that actually setting int variable is "atomic enough". But I'm not sure about all architectures/OSes/compilers)

> 
> But sure, I'm implicitly relying on that, which is not ideal. The
> mirror_change() function does multiple checks based on the current
> value, and only then changes it, so I suppose it would actually need a
> mutex rather than just changing to atomic accesses? Otherwise, the
> current value can't be guaranteed to be the same in the different checks
> if we ever add something that can change the value from another thread.


It could still be written like this

if (change_opts->copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING) {
   report error
}


if (qatomic_cmpxchg(&s->copy_mode, MIRROR_COPY_MODE_BACKGROUND, MIRROR_COPY_MODE_WRITE_BLOCKING) != MIRROR_COPY_MODE_BACKGROUND) {
   report error
}

report success

===

and we'll have to access it as qatomic_read(&s->copy_mode) in other places

> 
> I suppose, I should re-use the job mutex then?
> 
> Best Regards,
> Fiona
> 

-- 
Best regards,
Vladimir


