Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ECE81A5F8
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 18:07:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG019-0006RW-QT; Wed, 20 Dec 2023 12:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rG013-0006RE-75
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 12:05:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rG010-0006in-N3
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 12:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703091948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6YZXWLC5YVAhjkCeMUHf0nK8vpBx7qJqtNMEiGY1mzQ=;
 b=GuXthl5N/zCQD5IOGQqlC1tTwxU9J0DLSlnbcf2DY/50M1jZ/7vcHlmmlsW1SCHbSxe8jF
 Z4IO7HTNSkBycsB9ribd3I4nth1OIJypHeuyyLta8uzCEOvrHk/kcFN1ivxOsPwN5dOodd
 Zb1tTm/9x33TS8K2ETuqectK8UB7uSU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-keXKBsFOMRWzJvGXetau8A-1; Wed, 20 Dec 2023 12:05:47 -0500
X-MC-Unique: keXKBsFOMRWzJvGXetau8A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33677bbd570so937091f8f.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 09:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703091946; x=1703696746;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6YZXWLC5YVAhjkCeMUHf0nK8vpBx7qJqtNMEiGY1mzQ=;
 b=AoF4v+VarMJpzkql3IBfGLCFPHhf2rIYBLcBtnTyjan0wLhRXqRmNB90hQSFUbCF4F
 0uSUOhhmq0AhXyHMZPAYuzJny4jkQDg0GjuhjbatubMuZLjm/VtREkZ2SrevH3fTQAUl
 7ps8TncjOkzlNT0WenwH1yhBSqgZZs0IvFExRdMzamwQCpBW2oD8rHJTZZfNJbW0NSV9
 uefeM79mGndmApPJwuUw5KImc1EKvAYdc0DkGP/AdNWgYO4R/6WkAxG7iV5Fl8MMyvA8
 9PI6xW9kY5bl8irQ4J+GDddPOpDeA0TBMD4Bg+ybPUmMymvz88Mxyq5R/Zu3MPK6Ly+A
 4G1w==
X-Gm-Message-State: AOJu0YzlWBZDu2AVHBmY27XnLuAuRfCxyDpS4Q6VEVs4iw4QLvYPXzj4
 ScrhQmjjq8nAMhle+GSZpGpeWkch9zAaWtWPNmqIbpCLFlIRJp5zaBtMOYl0t4yDJ4uPvkXG3ub
 DgviDXJpgXIiKUCc=
X-Received: by 2002:adf:f1d0:0:b0:336:62cb:669 with SMTP id
 z16-20020adff1d0000000b0033662cb0669mr15479wro.53.1703091946193; 
 Wed, 20 Dec 2023 09:05:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPKv9p87Hi1gXc1O3F8Rc4tUhiFjTI3+/gu6wj9xqyOHLtKn6pYgiu1f7MO+62pSatp9YF8Q==
X-Received: by 2002:adf:f1d0:0:b0:336:62cb:669 with SMTP id
 z16-20020adff1d0000000b0033662cb0669mr15467wro.53.1703091945904; 
 Wed, 20 Dec 2023 09:05:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 k2-20020adfb342000000b0033678e0c99bsm26584wrd.96.2023.12.20.09.05.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 09:05:45 -0800 (PST)
Message-ID: <747c261d-f915-4cd6-8fb8-32ec667732c7@redhat.com>
Date: Wed, 20 Dec 2023 18:05:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: Replace basename with g_path_get_basename
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Khem Raj <raj.khem@gmail.com>
References: <20231220135302.932039-1-clg@redhat.com>
 <ZYMDmBbIua253Xf8@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZYMDmBbIua253Xf8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

Hello,

On 12/20/23 16:09, Zhao Liu wrote:
> Hi Cédric,
> 
> On Wed, Dec 20, 2023 at 02:53:02PM +0100, Cédric Le Goater wrote:
>> Date: Wed, 20 Dec 2023 14:53:02 +0100
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: [PATCH] vfio/container: Replace basename with g_path_get_basename
>> X-Mailer: git-send-email 2.43.0
>>
>> g_path_get_basename() is a portable utility function that has the
>> advantage of not modifing the string argument. It also fixes a compile
>> breakage with the Musl C library reported in [1].
>>
>> [1] https://lore.kernel.org/all/20231212010228.2701544-1-raj.khem@gmail.com/
>>
>> Reported-by: Khem Raj <raj.khem@gmail.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> Just one additional question, I understand that QEMU should replace all
> basename() with g_path_get_basename(), right?
> 
> I find hw/s390x/s390-ccw.c also uses basename(). Maybe I can clean it up
> to avoid potentially similar issue.

I guess so and I wonder why 3e015d815b3f didn't do the change.
Anyhow, please cc me, I can give it a try.

Thanks,

C.



> 
> Thanks,
> Zhao
> 
>>   hw/vfio/container.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 688cf23bab88f85246378bc5a7da3c51ea6b79d9..8d334f52f2438d05f632502e07ffd4dc2ec76cb5 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -869,7 +869,8 @@ static void vfio_put_base_device(VFIODevice *vbasedev)
>>   
>>   static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
>>   {
>> -    char *tmp, group_path[PATH_MAX], *group_name;
>> +    char *tmp, group_path[PATH_MAX];
>> +    g_autofree char *group_name = NULL;
>>       int ret, groupid;
>>       ssize_t len;
>>   
>> @@ -885,7 +886,7 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
>>   
>>       group_path[len] = 0;
>>   
>> -    group_name = basename(group_path);
>> +    group_name = g_path_get_basename(group_path);
>>       if (sscanf(group_name, "%d", &groupid) != 1) {
>>           error_setg_errno(errp, errno, "failed to read %s", group_path);
>>           return -errno;
>> -- 
>> 2.43.0
>>
>>
> 


