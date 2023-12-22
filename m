Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E172681C7E1
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 11:11:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGcTP-0008AU-KZ; Fri, 22 Dec 2023 05:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rGcTN-0008AH-94
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 05:09:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rGcTK-00054Y-Cu
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 05:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703239776;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hLFIHWOOwAawc5kTL5lgXEIwDtDnc5St+3Z2sKBa+64=;
 b=a/o1VmXLN0jkr265RtQ4S0FKw0O79Oo9qACVwHc8zAXFdB0/mRtJTRHk/8NZw7wAJSAvXp
 6rcc77ZXhALU4M7apuBhgyjsUrUidwzpp+jcNDrFN3VOE69liVDzthZ2BkJFJaEJjHGiQY
 lV2twfudbuxe3S4EP6nLuP1XH60J4B4=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-gsjVNaDQMzqLkOlkkt6qFg-1; Fri, 22 Dec 2023 05:09:34 -0500
X-MC-Unique: gsjVNaDQMzqLkOlkkt6qFg-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7cc06b90950so522723241.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 02:09:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703239774; x=1703844574;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hLFIHWOOwAawc5kTL5lgXEIwDtDnc5St+3Z2sKBa+64=;
 b=HJigL0gDlAZvegri87obRUiX7eEOmEPe+iVjvbvZtn+xr+w/Kz2j8CasMj6VsQpIFs
 AzX3OV5vIwG/tdgYMd+Vvg+3d2IVYWRkoPQztF4zf3FK81pk4Rqj7FxwM/wVRywxzA5i
 55+QleUd0nDUyud/LoXLS417pWK06wcPwNFe1WVNAjcah794LFnlOAsZXuRPdgzAjb5S
 XkwwvSOJsJLD8ghi853OxI77HKEIRF80eUEsc4y7aeSUQFft6+XHm4a/PdVNCtvj1/ZI
 gNJRGrPHmA6jQGMJkb4z8phdrHQbbV2I9CgKPck7p4pYo9PNICRv4TMrn0jm2FhSwiJ/
 xhbg==
X-Gm-Message-State: AOJu0Yx2P9pG/6jDWLC2A8mybNbnjqyuPTZZ1khPM5tOLIHba2Zouvse
 MIgxWDLCcNYVCIBPY1ajwZXzNC/ew/40/DfkZKoZMdQ5pN67TcBsy0IX4HWFWJWDOtG1pLKwPPS
 YMSmtfAv1BWui0pGjobZZ0E0=
X-Received: by 2002:a05:6102:3706:b0:466:8d9f:a4e8 with SMTP id
 s6-20020a056102370600b004668d9fa4e8mr667700vst.40.1703239774112; 
 Fri, 22 Dec 2023 02:09:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgxUxuHcKH4MdlEZidTy1wjkMTe8T2ZfSI2QKx06RMqgJ6RxfHIurhW5ITLnByBhRdFxGkKA==
X-Received: by 2002:a05:6102:3706:b0:466:8d9f:a4e8 with SMTP id
 s6-20020a056102370600b004668d9fa4e8mr667686vst.40.1703239773895; 
 Fri, 22 Dec 2023 02:09:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 bu12-20020a056102524c00b00466a7a6067asm17515vsb.15.2023.12.22.02.09.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Dec 2023 02:09:33 -0800 (PST)
Message-ID: <10e607e8-711e-4bfd-b876-d1a3c4451eb9@redhat.com>
Date: Fri, 22 Dec 2023 11:09:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 20/47] backends/iommufd: Introduce the iommufd object
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
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
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <be7753c5-399a-4bd5-ad7d-2b37b9cbc080@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Cédric,

On 12/21/23 22:23, Cédric Le Goater wrote:
> On 12/21/23 18:14, Eric Auger wrote:
>> Hi Cédric,
>>
>> On 12/21/23 17:00, Cédric Le Goater wrote:
>>> [ ... ]
>>>
>>>
>>>> +static void iommufd_backend_init(Object *obj)
>>>> +{
>>>> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>>>> +
>>>> +    be->fd = -1;
>>>> +    be->users = 0;
>>>> +    be->owned = true;
>>>> +    qemu_mutex_init(&be->lock);> +}
>>>> +
>>>> +static void iommufd_backend_finalize(Object *obj)
>>>> +{
>>>> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>>>> +
>>>> +    if (be->owned) {
>>>> +        close(be->fd);
>>>> +        be->fd = -1;
>>>> +    }
>>>> +}
>>>> +
>>>> +static void iommufd_backend_set_fd(Object *obj, const char *str,
>>>> Error **errp)
>>>> +{
>>>> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>>>> +    int fd = -1;
>>>> +
>>>> +    fd = monitor_fd_param(monitor_cur(), str, errp);
>>>> +    if (fd == -1) {
>>>> +        error_prepend(errp, "Could not parse remote object fd %s:",
>>>> str);
>>>> +        return;
>>>> +    }
>>>> +    qemu_mutex_lock(&be->lock);
>>>> +    be->fd = fd;
>>>> +    be->owned = false;
>>>> +    qemu_mutex_unlock(&be->lock);
>>>> +    trace_iommu_backend_set_fd(be->fd);
>>>> +}
>>>> +
>>>> +static bool iommufd_backend_can_be_deleted(UserCreatable *uc)
>>>> +{
>>>> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(uc);
>>>> +
>>>> +    return !be->users;
>>>
>>> Coverity CID 1531549 reports a concurrent data access violation because
>>> be->users is being accessed without holding the mutex.
>>>
>>> I wonder how useful is this mutex anyhow, since the code paths should
>>> be protected by the BQL lock. If you agree, I will send an update to
>>> simply drop be->lock and solve this report.
>> I am not totally comfortable with the fact BQL covers the same
>> protection? Please can you elaborate.
>
> These routines are called when a device is created which is called
> from the QEMU main thread which exits holding the BQL. It should be
> fine.

OK fine for me as well

Thanks

Eric
>
> Thanks,
>
> C.
>
>


