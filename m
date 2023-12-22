Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA1881C839
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 11:35:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGcs4-0006iw-Ot; Fri, 22 Dec 2023 05:35:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rGcs3-0006io-27
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 05:35:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rGcs1-0008LG-Cw
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 05:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703241308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2fiqxsGnqLGObmpD+1VNj3T0r9MBQVbxKDIT3A3it8=;
 b=UKX2JgnErSrOJxRcnwmle/BNOo64QzNwH/WGjSH4JyqBkEu71Et8gCZylkK6dvEd8SK+Ji
 JFSlnCPYkMDNFl2zUA/7NoJ3NyIDZjXsUXlD2otWclx2N4aFM/pB8zAtFBJzNojHLHCvMq
 Xz6lUo+Ov+74w77l9NqkbVfS/D8BszQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-rNcHvD-uOW-pcTaxrjNNDQ-1; Fri, 22 Dec 2023 05:35:03 -0500
X-MC-Unique: rNcHvD-uOW-pcTaxrjNNDQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-336937af9e9so224823f8f.0
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 02:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703241302; x=1703846102;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z2fiqxsGnqLGObmpD+1VNj3T0r9MBQVbxKDIT3A3it8=;
 b=lZeWkdcolXPIrKkEIxg9RzC90Nmk2kG8weRdDO+vYosCNqryWi62jCcPgOub+IOHi5
 902naGvGoeUJ9E0bXLwlzF4Z91WmS6u3q6hSKy7VU6yAR2d3zC9Tue9fNm2AglkRoJst
 oKkoiwVLDF/8Tsdg4AMOa4NuSj0aakJKwJ7cTaWtf/YXAVjdoLv8LBlNvIloqC8QuSfx
 V+hakWmTXOquXRWApliFdDSbbou8ipRYMgCrqo64dnuSf7B+NCswGCiBxDRjcSTa2l3p
 d/vHoIw//ALaHAl8FyUGVtE4qt23fdqODyN+3ljOACXuYkwyOjLu9TU5u2yODe4GjXcg
 h2Uw==
X-Gm-Message-State: AOJu0YwzlUuLg0Y3uQoF3GyU5XKG8PU0iKfiAo0vd5GX598SLAmT9X5R
 yd7AqhuywN9i7SxiROhiBh3dl0omCPS8rIuTWcYrz2f5Mp1g3naztvdPqWDJPW1DyoryhW1UQG7
 6TqRGqNLheWmJvri2FQEjeh0=
X-Received: by 2002:a05:6000:1b8d:b0:336:5f0f:323 with SMTP id
 r13-20020a0560001b8d00b003365f0f0323mr538230wru.69.1703241302267; 
 Fri, 22 Dec 2023 02:35:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnzDrmcaqy/y175n3nrgJFTJB5Jsjv0H1aHarh1jKIbg1+iAML/luuQzDAs0KB7C/uclgiTA==
X-Received: by 2002:a05:6000:1b8d:b0:336:5f0f:323 with SMTP id
 r13-20020a0560001b8d00b003365f0f0323mr538219wru.69.1703241301968; 
 Fri, 22 Dec 2023 02:35:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 k4-20020a5d5244000000b003368c8d120fsm2603184wrc.7.2023.12.22.02.35.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Dec 2023 02:35:01 -0800 (PST)
Message-ID: <f63b830e-5bda-4423-bf40-ea8ec589fa77@redhat.com>
Date: Fri, 22 Dec 2023 11:34:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 20/47] backends/iommufd: Introduce the iommufd object
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Yi Liu <yi.l.liu@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20231219185643.725448-1-clg@redhat.com>
 <20231219185643.725448-21-clg@redhat.com>
 <c6daa302-8da3-4931-812d-88dbb156a17a@redhat.com>
 <c9aeeb21-30cf-4f86-8ff5-0eb909830071@redhat.com>
 <be7753c5-399a-4bd5-ad7d-2b37b9cbc080@redhat.com>
 <10e607e8-711e-4bfd-b876-d1a3c4451eb9@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <10e607e8-711e-4bfd-b876-d1a3c4451eb9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

On 12/22/23 11:09, Eric Auger wrote:
> Hi Cédric,
> 
> On 12/21/23 22:23, Cédric Le Goater wrote:
>> On 12/21/23 18:14, Eric Auger wrote:
>>> Hi Cédric,
>>>
>>> On 12/21/23 17:00, Cédric Le Goater wrote:
>>>> [ ... ]
>>>>
>>>>
>>>>> +static void iommufd_backend_init(Object *obj)
>>>>> +{
>>>>> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>>>>> +
>>>>> +    be->fd = -1;
>>>>> +    be->users = 0;
>>>>> +    be->owned = true;
>>>>> +    qemu_mutex_init(&be->lock);> +}
>>>>> +
>>>>> +static void iommufd_backend_finalize(Object *obj)
>>>>> +{
>>>>> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>>>>> +
>>>>> +    if (be->owned) {
>>>>> +        close(be->fd);
>>>>> +        be->fd = -1;
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +static void iommufd_backend_set_fd(Object *obj, const char *str,
>>>>> Error **errp)
>>>>> +{
>>>>> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>>>>> +    int fd = -1;
>>>>> +
>>>>> +    fd = monitor_fd_param(monitor_cur(), str, errp);
>>>>> +    if (fd == -1) {
>>>>> +        error_prepend(errp, "Could not parse remote object fd %s:",
>>>>> str);
>>>>> +        return;
>>>>> +    }
>>>>> +    qemu_mutex_lock(&be->lock);
>>>>> +    be->fd = fd;
>>>>> +    be->owned = false;
>>>>> +    qemu_mutex_unlock(&be->lock);
>>>>> +    trace_iommu_backend_set_fd(be->fd);
>>>>> +}
>>>>> +
>>>>> +static bool iommufd_backend_can_be_deleted(UserCreatable *uc)
>>>>> +{
>>>>> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(uc);
>>>>> +
>>>>> +    return !be->users;
>>>>
>>>> Coverity CID 1531549 reports a concurrent data access violation because
>>>> be->users is being accessed without holding the mutex.
>>>>
>>>> I wonder how useful is this mutex anyhow, since the code paths should
>>>> be protected by the BQL lock. If you agree, I will send an update to
>>>> simply drop be->lock and solve this report.
>>> I am not totally comfortable with the fact BQL covers the same
>>> protection? Please can you elaborate.
>>
>> These routines are called when a device is created which is called
>> from the QEMU main thread which exits holding the BQL. It should be
>> fine.
> 
> OK fine for me as well

I pushed 2 patches on vfio-9.0 that I will send next year. Time for a
break !

Cheers,

C.


