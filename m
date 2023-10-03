Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DE77B6B1C
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:10:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qng64-0002Uy-AU; Tue, 03 Oct 2023 10:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qng60-0002Uj-P9
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:09:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qng5y-00031x-EW
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696342192;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ZRpgf5T+VDO76esGWxknkH3LeoIcmn+DTCPHDMaBMs=;
 b=Fo7EkizhSCbh6/F+sbHasPWanqw4ctL4D6FJIdD7qsCk4avaVyAB9KTWoqjzidBs8+ktsn
 vp9GpUQUCyXm/Q+NOcGSGQSUtbH6JGAYDIq6la50OMNtW7CCsuN7f0pCcatUnkVzXbfaTd
 IGDFw7+HrpXubLQ7i+rGSQ+uwWyy/CA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-CAiPhl9mNHmVBJsdwpyAyw-1; Tue, 03 Oct 2023 10:09:51 -0400
X-MC-Unique: CAiPhl9mNHmVBJsdwpyAyw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-774309ff5e2so131984985a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 07:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696342191; x=1696946991;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ZRpgf5T+VDO76esGWxknkH3LeoIcmn+DTCPHDMaBMs=;
 b=q7eGCXICQ0mrQDBSQgMbpyb80ZfFh41GtnPjlRZwWW9V3cZUMBM+tRKPwJCsZ5uHhY
 +SVQwJe2V86QixnbA1Y7+i+vygPDzkHuCbKMeIS3WAtI5zjsrsm0oE2mF9deOgKS4Zdu
 P3e8ZJkcTDwr0bya01Dn4WvFNcOakRqrFtlCUIwBamZmWdiyIET+9P4kiB2ET/g54Y3Z
 /5XHVlAa2q6HQN0jzwNKBDUPTEbsNHxFHZAtJYqZ1U0fFEcer94UAR7FIRa0RnbMxqTm
 H1iR1hgd3k0uIEuEg6Cvdz7KuhkZbMNSR70Bn0manv8R6h/oi3SZhtbBI2B5FSmC5e5t
 xOTQ==
X-Gm-Message-State: AOJu0Yx3Lhwe/q4AH8hWSrG2PPA0UDa4l+cDkgzT/qqNBzNuKiAiQ9HB
 mk+xVw1WKrkvMX/jClI+7Vr8ZbBafkUvLPY2NtjG9KTmHuyeit8fLpNLnQSQPlOM8CUt7bsusm1
 rEKgktSdYaTvyKi8=
X-Received: by 2002:a05:620a:955:b0:76e:f149:fb43 with SMTP id
 w21-20020a05620a095500b0076ef149fb43mr13881951qkw.70.1696342190969; 
 Tue, 03 Oct 2023 07:09:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELhlAyoK6jlFcyXwj8IhPI+wEw3f1GegqNWAHnYTFOg37ZucKGSmDfhjHcUjkwaCjhjoUTNg==
X-Received: by 2002:a05:620a:955:b0:76e:f149:fb43 with SMTP id
 w21-20020a05620a095500b0076ef149fb43mr13881923qkw.70.1696342190704; 
 Tue, 03 Oct 2023 07:09:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 23-20020a05620a06d700b00767dc4c539bsm494755qky.44.2023.10.03.07.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 07:09:50 -0700 (PDT)
Message-ID: <18d495bd-115e-d716-c4ff-3763105abb4e@redhat.com>
Date: Tue, 3 Oct 2023 16:09:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 01/15] scripts/update-linux-headers: Add iommufd.h
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, peterx@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 mjrosato@linux.ibm.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-2-eric.auger@redhat.com>
 <585e22ab-fca2-004c-dd99-524cb747a1b3@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <585e22ab-fca2-004c-dd99-524cb747a1b3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Cédric,

On 10/3/23 15:50, Cédric Le Goater wrote:
> On 10/3/23 12:13, Eric Auger wrote:
>> Update the script to import iommufd.h
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>
>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
Sorry I forgot to grab it :-(

Eric
>
> Thanks,
>
> C.
>
>
>> ---
>>   scripts/update-linux-headers.sh | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/update-linux-headers.sh
>> b/scripts/update-linux-headers.sh
>> index 35a64bb501..34295c0fe5 100755
>> --- a/scripts/update-linux-headers.sh
>> +++ b/scripts/update-linux-headers.sh
>> @@ -161,7 +161,8 @@ done
>>   rm -rf "$output/linux-headers/linux"
>>   mkdir -p "$output/linux-headers/linux"
>>   for header in const.h stddef.h kvm.h vfio.h vfio_ccw.h vfio_zdev.h
>> vhost.h \
>> -              psci.h psp-sev.h userfaultfd.h memfd.h mman.h
>> nvme_ioctl.h vduse.h; do
>> +              psci.h psp-sev.h userfaultfd.h memfd.h mman.h
>> nvme_ioctl.h \
>> +              vduse.h iommufd.h; do
>>       cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
>>   done
>>   
>


