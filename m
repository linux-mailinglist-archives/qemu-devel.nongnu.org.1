Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E432873A29F
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 16:03:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCKtX-0004hk-Mh; Thu, 22 Jun 2023 10:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qCKtW-0004hN-4P
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qCKtT-0004A0-Ue
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687442559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FtE37PqzX5hWsenl5mm7SbRlG0qtujORIHXXg3mxvhk=;
 b=deBxaC3Wp4DBD2zxuFJMyKCYz1fPooMoAJOnMJG+gTZkPjdyRYgUASQlADrespnIoBQNMO
 ayZfpTPf7uQHW58lg3bD3xxotDj0Kp8dbJlBCL0+hSY0e+cJkYWBRBeHWp9HMkQu7cP5ir
 quhdQUlFp9y9/zJc1Zhxo2Lxtx8J2fE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-NNMEh-uxPCSBGgYDw3IX3A-1; Thu, 22 Jun 2023 10:02:33 -0400
X-MC-Unique: NNMEh-uxPCSBGgYDw3IX3A-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-62ff2760cfdso88913306d6.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 07:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687442552; x=1690034552;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FtE37PqzX5hWsenl5mm7SbRlG0qtujORIHXXg3mxvhk=;
 b=j99HoZq2C8Kf3bG6mlHfkCbbdxWMQsolvq6l5wVGXYUTF/D7RrttDr9Nefk8+4ewq5
 2YGL+G/3kYImt/ptHuBhAZtENlM8R/aztdLcSsxAofMfZabe8pOYRXINMqwc/28+fzp5
 wYGA/ZOJLVUPOZG+TtY3EWU7h/jqsy4S2C5BLoApY0ra80sVUjns/0+beGzZR7MxQJBA
 56GJRmA4xys8po+TSdK81ksurH0zGfaL9Lq2ix6E39JNFgUYmVS7tnFZkVLGoEtA8g4T
 qJXsf2hmp38NcTJVyV2nd0h/uqvAE/sKKsrhysjTP6esWVXs3LTRjHqivXTZs966vfKx
 oBqw==
X-Gm-Message-State: AC+VfDy6syyaR1g0PTexr1FrlLb4DtfwKHmsD9xg6wjok7IAdRUZ73+6
 H96iNZvM+/D6bVCUeGXtfSQtRNqvRf1eQCpV4n4wfy9q/pBlNE1PbD20kByKipu9SVH5DJsVh9f
 pajEYm+OZ9dUsjcc=
X-Received: by 2002:a05:6214:27e1:b0:625:aa1a:9382 with SMTP id
 jt1-20020a05621427e100b00625aa1a9382mr22190254qvb.62.1687442552514; 
 Thu, 22 Jun 2023 07:02:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ayAKlbXwpI/fs08K3ZdkTv7RV6CFVf7FsZXgF/cygx6qfdi2RInIbCYflI7ZYqgtE4GdXJg==
X-Received: by 2002:a05:6214:27e1:b0:625:aa1a:9382 with SMTP id
 jt1-20020a05621427e100b00625aa1a9382mr22190212qvb.62.1687442552065; 
 Thu, 22 Jun 2023 07:02:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 y1-20020a05622a004100b003e0945575dasm3644073qtw.1.2023.06.22.07.02.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 07:02:31 -0700 (PDT)
Message-ID: <6f627049-f0ce-bdbc-3dac-f9723efdfd1a@redhat.com>
Date: Thu, 22 Jun 2023 16:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 0/8] migration: Add switchover ack capability and VFIO
 precopy support
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230621111201.29729-1-avihaih@nvidia.com>
 <20230621132848.79c9b674.alex.williamson@redhat.com>
 <5f1c5fa6-20a4-a29e-3381-728ea0aa1797@redhat.com>
 <4faf12dc-206d-b104-d94d-0bec2169b2e0@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <4faf12dc-206d-b104-d94d-0bec2169b2e0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/22/23 14:16, Avihai Horon wrote:
> 
> On 22/06/2023 14:34, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 6/21/23 21:28, Alex Williamson wrote:
>>> On Wed, 21 Jun 2023 14:11:53 +0300
>>> Avihai Horon <avihaih@nvidia.com> wrote:
>>>
>>>> Hello everyone,
>>>>
>>>> The latest changes to migration qtest made the tests run non-live by
>>>> default. I am posting this v6 to change back the switchover-ack
>>>> migration test to run live as it used to (because the source VM needs to
>>>> be running to consider the switchover ACK when deciding to do the
>>>> switchover or not).
>>>>
>>>> Changes from v5 [7]:
>>>> * Rebased on latest master branch.
>>>> * Made switchover-ack migration test run live again (I kept the R-bs as
>>>>    this was the original behavior when they were given).
>>>> * Dropped patch #8 (x-allow-pre-copy property). (Alex)
>>>> * Adjusted patch #9 commit message according to drop of patch #8.
>>>> * Added R-b to patch #9 and Tested-by tags to the series.
>>>
>>> I think Cédric is going to handle the pull request for this, so...
>>
>> Yes. I have a branch ready with this series and a few other fixes. Unless
>> Juan want to handle it.
>>
>>
>> Avihai,
>>
>> QEMU seems ready to allow migration when support is available in the
>> kernel now and so, we can set "x-enable-migration" to true by default.
>> Are you OK with that ?
>>
> Yes, sure.
> But as per previous off-list discussions, it's not merely changing x-enable-migration to true by default, right?
> If I recall correctly, Alex wanted to remove the x- prefix, 

OK. We have to start one day :)

> change it to ON_OFF_AUTO and some other stuff.

Is it to silently disable migration support if some failure occurs
at the kernel level when ON_OFF_AUTO_AUTO is set and report an error
when ON_OFF_AUTO_ON is set ?

> Do you have some patches ready for that?

nope.

> Or you want me to do it?

If you have time, yes please.

Thanks,

C.


