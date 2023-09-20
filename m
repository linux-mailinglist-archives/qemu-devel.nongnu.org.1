Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5387A7EC1
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:20:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwBf-0006PT-NZ; Wed, 20 Sep 2023 08:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qiwBQ-0006NR-7W
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qiwBK-0006CL-D7
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695212388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YSuQu9ddjrQyc/AbeIi+o47iF9B7lS9+duhKVXsSNKE=;
 b=Ud/nuKnUKERtEs/vUEsbUgF5yOMNPXwr+1cqWyZJnsLCHBMWkRTDRHMAHlZgSIH+3YuxhV
 YhP0FYo9cMqLI1vQ5P+zKARNXJP6pYkxYzpvDKoI22hzA7U/k+gTzQz36FBAW11t8S7s1/
 ieIyf8l7qL/naNdA3hGXK/Q9JlWb41I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-KAKo_Lu3NgO9-Ww02KCb9A-1; Wed, 20 Sep 2023 08:19:47 -0400
X-MC-Unique: KAKo_Lu3NgO9-Ww02KCb9A-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76f04a5b09eso819022585a.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 05:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695212387; x=1695817187;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YSuQu9ddjrQyc/AbeIi+o47iF9B7lS9+duhKVXsSNKE=;
 b=go/dv0hoSZxDcCUwsTHXSU9Ibc7hmWL7xPJD2eyAdRBpildvMfbrPCzUcDcwT8sP+W
 PfuyABAG9TdHghmASe5J/pwPwt7cEtUCmK0OeKg5qmn+iDwIPoiTqbeQEfXrmBaeZSIZ
 PPzFUfca1bfTNjKtBK5dRsNhVeKlUHxKDMbxBPCnfwTdpCuPW1O7F9z0W0Bu3RjFnENK
 B0L6QBqMNVO3rUyloPjt9k3j8mUZ/PvuMr811S91FIocGfFXV4iK61qbO/x+gXY+nmTM
 aGik8vZTTSVcXmlOdFyvEYe2O6u6eI/wsMQkp9jkp5RgLYHD89c0Rdx6rhdn5FZHe9mZ
 mc2A==
X-Gm-Message-State: AOJu0YzAHuIqihKYO0fLmVc8S0jvrXcrD97bpVwlgR/3ZT5PEaYht/kL
 z6FaFg8nTioqLweexp2M8Oa+uvp0Qsj3KJt3qOboUKRFu+MdU4j5unyXo+KB+l7Wx6E3pIZqleh
 LY29O7NnwHc3wDLc=
X-Received: by 2002:a05:6214:118e:b0:64c:9d23:8f55 with SMTP id
 t14-20020a056214118e00b0064c9d238f55mr1981766qvv.58.1695212386936; 
 Wed, 20 Sep 2023 05:19:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpOnPNJ+LzIZ6nRP+j5JKIL2u0HkORXwlDzRTOll5WJBFLXa2txppugUlQDXuPX1Da0tfElQ==
X-Received: by 2002:a05:6214:118e:b0:64c:9d23:8f55 with SMTP id
 t14-20020a056214118e00b0064c9d238f55mr1981753qvv.58.1695212386629; 
 Wed, 20 Sep 2023 05:19:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a0ce3d1000000b006585e3ed4f8sm1267501qvl.25.2023.09.20.05.19.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Sep 2023 05:19:46 -0700 (PDT)
Message-ID: <664d3338-c280-6d16-b03e-bb235931ce99@redhat.com>
Date: Wed, 20 Sep 2023 14:19:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 15/22] Add iommufd configure option
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
 <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
 <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 9/20/23 05:42, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Wednesday, September 20, 2023 1:08 AM
>> Subject: Re: [PATCH v1 15/22] Add iommufd configure option
>>
>> On 8/30/23 12:37, Zhenzhong Duan wrote:
>>> This adds "--enable-iommufd/--disable-iommufd" to enable or disable
>>> iommufd support, enabled by default.
>>
>> Why would someone want to disable support at compile time ? It might
> 
> For those users who only want to support legacy container feature?
> Let me know if you still prefer to drop this patch, I'm fine with that.

I think it is too early.

>> have been useful for dev but now QEMU should self-adjust at runtime
>> depending only on the host capabilities AFAIUI. Am I missing something ?
> 
> IOMMUFD doesn't support all features of legacy container, so QEMU
> doesn't self-adjust at runtime by checking if host supports IOMMUFD.
> We need to specify it explicitly to use IOMMUFD as below:
> 
>      -object iommufd,id=iommufd0
>      -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0

OK. I am not sure this is the correct interface yet. At first glance,
I wouldn't introduce a new object for a simple backend depending on a
kernel interface. I would tend to prefer a "iommu-something" property
of the vfio-pci device with string values: "legacy", "iommufd", "default"
and define the various interfaces (the ops you proposed) for each
depending on the user preference and the capabilities of the host and
possibly the device.

I might be wrong and this might have been discussed before. If so, it
should go in the cover letter with other things : what is this patchset
providing to VFIO (multiple iommu backends), how it is reaching that
goal, how is it organized, how do we deal with the special case (spapr),
what's the user interface, etc.


   
Thanks,

C.


> Thanks
> Zhenzhong
> 


