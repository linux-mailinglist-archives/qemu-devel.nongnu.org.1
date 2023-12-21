Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB58681B1E6
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 10:17:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGFAG-0004rM-6m; Thu, 21 Dec 2023 04:16:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rGFAA-0004qk-ER
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 04:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rGFA0-0007d3-AL
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 04:16:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703150165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZqntXpcSBi1Xcxbm14Zg4XSjh2ouxM42s6hSSYsLMo=;
 b=LFLzn1N6o1FhbkiYRHwynrQrMqAwAeGGs+eDDQPHGy2I2KzuFdl0L+qcgFgi594cMdng38
 FWBgW5yja7LT70J5aN7NwWkElJKSToga8hE8pUC0UFkCZOgR3KiPr6HoaDEI2yru/CAl5G
 O2rCnmx0xG4Wn31CnQ+4PKUb1vXSaFE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-RBwBk7QjP12ckPK5m3MFXw-1; Thu, 21 Dec 2023 04:16:03 -0500
X-MC-Unique: RBwBk7QjP12ckPK5m3MFXw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-336695c70b9so305010f8f.2
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 01:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703150162; x=1703754962;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lZqntXpcSBi1Xcxbm14Zg4XSjh2ouxM42s6hSSYsLMo=;
 b=Yl181PTThqG9kL0t9YBkp6oTbS21KFbkHgr4+387Z65xbeUKcnAcZjb58JzGkgsSdF
 eUnss2qRZKmEh/MIuPVqjhAarnjrwDu/dxdRnwmcNO9pUrGuk0z/yMschaqELDtTAY5H
 zCamwtFrN1PZ7jCVmDuDawL6JF465B12PUrGqCWzZnAKKs6xeUdP5UKBog2wR3qJumkg
 JpTGstlJquTB0pGsxevc2jGnHD2+RI/YDzuVTj0B5Xc6ELFdj8h4ZS/dhW1eg8lbOBVp
 cHktMFKbpjRMcCcz4hAzMAz6iFiH/Izzyl5zbJOjcu5wVscD2EVDW7Pvt9qUUmv1XAto
 Heaw==
X-Gm-Message-State: AOJu0YxK2h3vamVmj1UKI/JTzLb9PSp+kScWgARKazb59xN2lWAWQIaC
 /e4imp4/hzsI9iZ8C9lsoMSgb68sEweWjYh+W8fL7FfVVqLYNi+x2NoYUOTkhfXGo2g9XthBJl+
 GxgE6Y7mv9Kz2xpo=
X-Received: by 2002:a05:600c:5023:b0:40b:5e22:2e0 with SMTP id
 n35-20020a05600c502300b0040b5e2202e0mr276520wmr.76.1703150161732; 
 Thu, 21 Dec 2023 01:16:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy0UjlfZlwiGwEhuxlIftctOgjpeV/fIX358b2I2s0Ci3H8AIMMJsMdBKvsOsZR6aV5bhgaA==
X-Received: by 2002:a05:600c:5023:b0:40b:5e22:2e0 with SMTP id
 n35-20020a05600c502300b0040b5e2202e0mr276513wmr.76.1703150161419; 
 Thu, 21 Dec 2023 01:16:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a5d49d2000000b00336751cd4ebsm1541403wrs.72.2023.12.21.01.16.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 01:16:00 -0800 (PST)
Message-ID: <51941699-5f1e-4f61-adb8-dba79af7d55d@redhat.com>
Date: Thu, 21 Dec 2023 10:15:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/iommufd: Remove the use of stat() to check file
 existence
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20231221080957.1081077-1-clg@redhat.com>
 <SJ0PR11MB6744B077E851815942C260C69295A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744B077E851815942C260C69295A@SJ0PR11MB6744.namprd11.prod.outlook.com>
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

Hello Zhenzhong

On 12/21/23 09:55, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Thursday, December 21, 2023 4:10 PM
>> Subject: [PATCH] vfio/iommufd: Remove the use of stat() to check file
>> existence
>>
>> Using stat() before opening a file or a directory can lead to a
>> time-of-check to time-of-use (TOCTOU) filesystem race, which is
>> reported by coverity as a Security best practices violations. The
>> sequence could be replaced by open and fdopendir but it doesn't add
>> much in this case. Simply use opendir to avoid the race.
>>
>> Fixes: CID 1531551
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> Thanks for fixing, Reviewed-by: Zhenzhong Duan <Zhenzhong.duan@intel.com>

It seems that tools like b4 need the R-b tag, and probably other
tags, to be at the beginning of a new line. So, just repeating :

Reviewed-by: Zhenzhong Duan <Zhenzhong.duan@intel.com>


Thanks,

C.



> 
> BRs.
> Zhenzhong
> 
>> ---
>> hw/vfio/iommufd.c | 6 ------
>> 1 file changed, 6 deletions(-)
>>
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index
>> d4c586e842def8f04d3a914843f5eece2c75ea30..9bfddc1360895413176a9f
>> 170e29e89027384a66 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -121,17 +121,11 @@ static int iommufd_cdev_getfd(const char
>> *sysfs_path, Error **errp)
>>      DIR *dir = NULL;
>>      struct dirent *dent;
>>      gchar *contents;
>> -    struct stat st;
>>      gsize length;
>>      int major, minor;
>>      dev_t vfio_devt;
>>
>>      path = g_strdup_printf("%s/vfio-dev", sysfs_path);
>> -    if (stat(path, &st) < 0) {
>> -        error_setg_errno(errp, errno, "no such host device");
>> -        goto out_free_path;
>> -    }
>> -
>>      dir = opendir(path);
>>      if (!dir) {
>>          error_setg_errno(errp, errno, "couldn't open directory %s", path);
>> --
>> 2.43.0
> 


