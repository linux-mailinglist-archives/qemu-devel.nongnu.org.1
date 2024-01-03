Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8695822ED6
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 14:45:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL1XL-0006MK-FJ; Wed, 03 Jan 2024 08:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rL1XJ-0006Lg-3O
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 08:43:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rL1XH-0004xK-9r
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 08:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704289433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7ekck1M+ZehNogXs1dQVkrQoBM66SUbw73eOF391Y8=;
 b=Bnd/Uk2C4Ra7L4Cok/ahZ8n0yw8/TwwIgM315mf9StwHH2dKS3+1EhsgIrac5/Jeq6NXbG
 9ZHzH1lTfQgLAL4ihk1W4/gT+mfIEbIdMZT+C7UTGpdmDhIRVpFK37pO6KQXfXojCZr6dn
 AupwR0NZag0c+293xTmN+uX0G3jCALw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-TeFG8fk5PMuZ08lmKGfvGQ-1; Wed, 03 Jan 2024 08:43:50 -0500
X-MC-Unique: TeFG8fk5PMuZ08lmKGfvGQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7815a60e776so878789085a.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 05:43:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704289430; x=1704894230;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s7ekck1M+ZehNogXs1dQVkrQoBM66SUbw73eOF391Y8=;
 b=X/g50lXvbrPJEIQJwa2DCrVgpcAm23YN4PJibg9WlMdQ7m54ELKMF326EOcdnkUErq
 ud+4+XrTPoBF1I3+XccBq4jWPGcQT1D9WubQ3CIXNSL1uKXZ52BpTOO7cjpZdlG7Fccp
 L0EU80xCGQRcbzKy0QIQ2OCnnZKF02Uk9SaP+/PXv+0Q13WqD7xtfjgb/XGHqCuGKwDg
 XzFc19DC/tb2Hq7fWkuz01MahdbVM8q7Ozq71gd+BC3wNoKMqpfaLj3JcI9F36MORar/
 vnZHe8vbtyrZFz0H1ShLENidn50A0V+8bfeZTrW3u7Xn4n5Wr+qXZ8ZNzPt6PioRWSio
 DJkA==
X-Gm-Message-State: AOJu0Yx/6MAIngFsLkGvxChgDZ6ezTkXHVwF9JHbcl5l6QGGpL5fMpFh
 370UTbCFKylQfkKVxR1w2iSZc+i7dT+tZxFmuwC4UZwQt7uuGD3xWHUGQyrU4n1U+dKvMNL/cq6
 M8kHiTk0modLKyb4Epd/OEIA=
X-Received: by 2002:a05:620a:1137:b0:781:bb04:f760 with SMTP id
 p23-20020a05620a113700b00781bb04f760mr6714292qkk.68.1704289430001; 
 Wed, 03 Jan 2024 05:43:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExwsn9nwV/TgEo/yKOLLbyvb170zCrwDz8lg9/KhGSGGENevuBgb/+e6GBSXVDDx6y6x6F9g==
X-Received: by 2002:a05:620a:1137:b0:781:bb04:f760 with SMTP id
 p23-20020a05620a113700b00781bb04f760mr6714281qkk.68.1704289429616; 
 Wed, 03 Jan 2024 05:43:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0?
 ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
 by smtp.gmail.com with ESMTPSA id
 r25-20020a05620a03d900b00781bdb17d8asm2460368qkm.118.2024.01.03.05.43.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 05:43:49 -0800 (PST)
Message-ID: <17266259-b7ac-4a76-9939-1bd244d43130@redhat.com>
Date: Wed, 3 Jan 2024 14:43:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] backends/iommufd: Remove check on number of backend
 users
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>
References: <20240102123210.1184293-1-clg@redhat.com>
 <20240102123210.1184293-2-clg@redhat.com>
 <SJ0PR11MB6744F8F025A15F98773483E99260A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744F8F025A15F98773483E99260A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello Zhenzhong,

On 1/3/24 02:40, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Tuesday, January 2, 2024 8:32 PM
>> To: qemu-devel@nongnu.org
>> Cc: Liu, Yi L <yi.l.liu@intel.com>; Eric Auger <eric.auger@redhat.com>; Duan,
>> Zhenzhong <zhenzhong.duan@intel.com>; Cédric Le Goater
>> <clg@redhat.com>
>> Subject: [PATCH 1/2] backends/iommufd: Remove check on number of
>> backend users
>>
>> QOM already has a ref count on objects and it will assert much
>> earlier, when INT_MAX is reached.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> IIUC, /dev/iommu is opened on demand, be->users is used to catch underflow
> or overflow due to mismatched iommufd_backend_connect/disconnect
> pairs. 
>
> It looks different from object ref count in purpose, but I agree
> a correctly written code will never trigger such overflow/underflow.

Well, we could limit the number of devices sharing the same iommufd
backend but UINT32_MAX seems really too large and the object refcount
will fail earlier anyhow. The max open files per process limit will
also be reached before, since vfio opens a /dev/vfio/devices/vfiox
file per device.

So, this check didn't seem necessary after all.
  
> So, for the series:
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

You should reply to the cover letter with your R-b tag so that
it applies on the whole series.

Thanks,

C.




> BRs.
> Zhenzhong
> 
>> ---
>> backends/iommufd.c | 5 -----
>> 1 file changed, 5 deletions(-)
>>
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index
>> ba58a0eb0d0ba9aae625c987eb728547543dba66..393c0d9a3719e3de1a6b
>> 51a8ff2e75e184badc82 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -80,11 +80,6 @@ int iommufd_backend_connect(IOMMUFDBackend
>> *be, Error **errp)
>>      int fd, ret = 0;
>>
>>      qemu_mutex_lock(&be->lock);
>> -    if (be->users == UINT32_MAX) {
>> -        error_setg(errp, "too many connections");
>> -        ret = -E2BIG;
>> -        goto out;
>> -    }
>>      if (be->owned && !be->users) {
>>          fd = qemu_open_old("/dev/iommu", O_RDWR);
>>          if (fd < 0) {
>> --
>> 2.43.0
> 


