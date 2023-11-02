Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7C87DF30A
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 14:00:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyXIE-0001hp-3S; Thu, 02 Nov 2023 08:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qyXIC-0001hC-1Z
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qyXI9-0006W8-0B
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698929959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8EQefUulZO24WgVIFoZ9kbz5Kt6vDcsYeMWprvwYdWM=;
 b=WvQAl7CO+sQjNdWE2UEduMX6KMz1UnYfh08QgKb8Ph6vp9BFetXaJSYh7IX9GjKZ8ps0Dn
 1GilIAfFEP/y9Qt/TKB1ZnbxKWb7SvqFzVlTjL0IR1nJz309sm/RS5XrS5v1PaZgfm4f5M
 TjoXnqsDwgfCGQDJN9x/1Y5B9CJnxhQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-W5RsBWT1POe5CzBzNYveEw-1; Thu, 02 Nov 2023 08:59:18 -0400
X-MC-Unique: W5RsBWT1POe5CzBzNYveEw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-408f9cee5e8so5800765e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 05:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698929957; x=1699534757;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8EQefUulZO24WgVIFoZ9kbz5Kt6vDcsYeMWprvwYdWM=;
 b=jELkQ6p7ko25qBBkJKGOcf8f7nQeNSqrDufhivRxcfzgSf7grhqV+ya9HbFtX4HRAw
 Tdn0nmhqxJUJrEnKNiA3ehFTPvxPfEJSBL7NM7RgctnF9yU5+f91k0bqetEroLJ1u9i0
 xosKEUK/eU85ajUu8A29PfXkLqieHOnH6VJE2mZdlNaafs0vDAjQLWWF0oqUWyN8Vho7
 rmzuifZgw6JBRRvs043nxJQJM1cen3QIw6XfDVQMXBmKuO0+X+5Tavavx5dnlfbbE2kN
 YXEbq/Q1B8plHhkLIMsODqpVMMiEcIvkmH8CXHNTgj62e0ZDkxB1TBivb85IIkTozAhi
 RVow==
X-Gm-Message-State: AOJu0YxCizTUYZu4ld3R4bkmG0Ldgw/MgpQkAoZ+QbV5CJhpQRK0Inoz
 FxxZmuFZGte5XABq6USXfgRA9GqonZwIiwKMRXg68YR0Q943w7TnWcwoagt1A76RNCMaI5PVWZz
 3d03f62bunGAAm7E=
X-Received: by 2002:a1c:720f:0:b0:408:3f87:cba with SMTP id
 n15-20020a1c720f000000b004083f870cbamr14700461wmc.39.1698929957432; 
 Thu, 02 Nov 2023 05:59:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH97prISZ1FwUBRFGW2HcjXQZ1o7DBSnl6iQzgjLgGM4ubALDPWAbKEtoXBwEjo7+rvVTQUMQ==
X-Received: by 2002:a1c:720f:0:b0:408:3f87:cba with SMTP id
 n15-20020a1c720f000000b004083f870cbamr14700447wmc.39.1698929957098; 
 Thu, 02 Nov 2023 05:59:17 -0700 (PDT)
Received: from ?IPV6:2003:cf:d718:8590:77de:e1fd:a4df:d080?
 (p200300cfd718859077dee1fda4dfd080.dip0.t-ipconnect.de.
 [2003:cf:d718:8590:77de:e1fd:a4df:d080])
 by smtp.gmail.com with ESMTPSA id
 e22-20020a05600c109600b0040523bef620sm976895wmd.0.2023.11.02.05.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 05:59:16 -0700 (PDT)
Message-ID: <069ba523-344e-46ae-aca3-6b401fc840dd@redhat.com>
Date: Thu, 2 Nov 2023 13:59:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block-jobs: add final flush
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 Evanzhang@archeros.com, den@openvz.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20231004135632.18196-1-vsementsov@yandex-team.ru>
 <fd7da9d6-be5a-40f7-9c59-593ac8de41d1@redhat.com>
 <1ca2a1ea-4a6c-4fa1-9619-bfa160a8fb95@yandex-team.ru>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <1ca2a1ea-4a6c-4fa1-9619-bfa160a8fb95@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 01.11.23 20:53, Vladimir Sementsov-Ogievskiy wrote:
> On 31.10.23 17:05, Hanna Czenczek wrote:
>> On 04.10.23 15:56, Vladimir Sementsov-Ogievskiy wrote:
>>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>
>>> Actually block job is not completed without the final flush. It's
>>> rather unexpected to have broken target when job was successfully
>>> completed long ago and now we fail to flush or process just
>>> crashed/killed.
>>>
>>> Mirror job already has mirror_flush() for this. So, it's OK.
>>>
>>> Add similar things for other jobs: backup, stream, commit.
>>>
>>> Note, that stream has (documented) different treatment of IGNORE
>>> action: it don't retry the operation, continue execution and report
>>> error at last. We keep it for final flush too.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>
>>> Was: [PATCH v4] block-jobs: flush target at the end of .run()
>>>    But now rewritten.
>>> Supersedes: <20230725174008.1147467-1-vsementsov@yandex-team.ru>
>>>
>>>   block/backup.c             |  2 +-
>>>   block/block-copy.c         |  7 +++++++
>>>   block/commit.c             | 16 ++++++++++++----
>>>   block/stream.c             | 21 +++++++++++++++++----
>>>   include/block/block-copy.h |  1 +
>>>   5 files changed, 38 insertions(+), 9 deletions(-)
>>
>> [...]
>>
>>> diff --git a/block/commit.c b/block/commit.c
>>> index aa45beb0f0..5205c77ec9 100644
>>> --- a/block/commit.c
>>> +++ b/block/commit.c
>>
>> [...]
>>
>>> @@ -187,7 +187,15 @@ static int coroutine_fn commit_run(Job *job, 
>>> Error **errp)
>>>           }
>>>       }
>>> -    return 0;
>>> +    do {
>>> +        ret = blk_co_flush(s->base);
>>> +        if (ret < 0) {
>>> +            action = block_job_error_action(&s->common, s->on_error,
>>> +                                            false, -ret);
>>> +        }
>>> +    } while (ret < 0 && action != BLOCK_ERROR_ACTION_REPORT);
>>
>> Do we need to yield in this loop somewhere so that 
>> BLOCK_ERROR_ACTION_STOP can pause the job?
>>
>
> block_job_error_action calls job_pause_locked() itself in this case

But that doesn’t really pause the job, does it?  As far as I understand, 
it increases job->pause_count, then enters the job, and the job is then 
supposed to yield at some point so job_pause_point_locked() is called, 
which sees the increased job->pause_count and will actually pause the job.

Hanna


