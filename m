Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E777A94B5
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:24:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJfD-0001ND-H7; Thu, 21 Sep 2023 09:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjJf9-0001FS-0D
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:24:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjJf3-0004dN-TT
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695302644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=upHgUiLHR/8zmMg0nGfbeD7YyehW5V3oCC5pXFSpqR0=;
 b=PLZzVyR28E08eadM8CPquCkT+ynqiOT899ZE0kLZCw+4Yz1ZyFSYk7W8r8N3IgMYqx8Fm3
 xcu6lPfeHGu7oZYRXlFHCwBMDTajCkpfqi9kmF/w5ufwNGnEBIaMC/mFMTtchGhWE0kgRj
 uMMHvJtBYqSKOtjcJ021fq+lp3vxBFs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-9jqLhdm5N2iM1h7mDld3_Q-1; Thu, 21 Sep 2023 09:24:03 -0400
X-MC-Unique: 9jqLhdm5N2iM1h7mDld3_Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe1521678fso7427645e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 06:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695302642; x=1695907442;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=upHgUiLHR/8zmMg0nGfbeD7YyehW5V3oCC5pXFSpqR0=;
 b=sd+rHpJzmqn9aC5m0g20ExEMPunnFm3iv/m5ZHHj6OLmUqAJ1e0On308ialEksB2CR
 4f0dX5X0/Dly9C/xjza4LDUTcCMyK194sGojNYdHl77gOSg8SGU3+MsF7uV0ZimrHQqc
 cS1g79peHUUsWfaI2DTw2Ylsdf2AQocRVhO4ekiNsZMCwNXnP9rl837sR0+0N5kKqwmc
 jOpIQH3en5NFZ0uPmLTMnnd/IDwY0EYndz8SB5mYROcnwyYq4xJyGMCIVGYWRJxTsNrA
 6U52agRTa9VyN2UvQzyZF8dt+cYh1ev6QIGypoxJG7F4YIKNQ+gn/ukMz/vTJHVGb283
 JpQg==
X-Gm-Message-State: AOJu0YyzW51oaurfG6UQ2d8jtMHdH/oXjp61r+hyW5byPPINIDZRkGI8
 BK/UvwmjPHR0IObcEgz9A9uh2X8P2tBMzQY4UPXQwMcgLz7KzilTHS7yZ4drP9xP8AZuqAwa39B
 PgKXBzVdRBmU8c8o=
X-Received: by 2002:a5d:62c5:0:b0:314:15a8:7879 with SMTP id
 o5-20020a5d62c5000000b0031415a87879mr5090042wrv.34.1695302642148; 
 Thu, 21 Sep 2023 06:24:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeOkHIS2gUjScTVBm57FFUkLrIOBJ21THx3Nj/7H/0bwuCJPAcemvJgIGZID3cAknBYzycOA==
X-Received: by 2002:a5d:62c5:0:b0:314:15a8:7879 with SMTP id
 o5-20020a5d62c5000000b0031415a87879mr5090012wrv.34.1695302641800; 
 Thu, 21 Sep 2023 06:24:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a5d49d0000000b0031c5b380291sm1771703wrs.110.2023.09.21.06.24.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 06:24:01 -0700 (PDT)
Message-ID: <d3a705a2-ad15-4a7f-4c78-2473b6be4e1e@redhat.com>
Date: Thu, 21 Sep 2023 15:24:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 12/22] vfio/ccw: Use vfio_[attach/detach]_device
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
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "open list:vfio-ccw" <qemu-s390x@nongnu.org>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-13-zhenzhong.duan@intel.com>
 <ff418562-245e-2c7a-01a8-060ee970f195@redhat.com>
 <SJ0PR11MB67444F764D47D887D7FA8D6A92F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67444F764D47D887D7FA8D6A92F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 9/21/23 15:00, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Thursday, September 21, 2023 8:20 PM
>> Subject: Re: [PATCH v1 12/22] vfio/ccw: Use vfio_[attach/detach]_device
>>
>> On 8/30/23 12:37, Zhenzhong Duan wrote:
>>> From: Eric Auger <eric.auger@redhat.com>
>>>
>>> Let the vfio-ccw device use vfio_attach_device() and
>>> vfio_detach_device(), hence hiding the details of the used
>>> IOMMU backend.
>>>
>>> Also now all the devices have been migrated to use the new
>>> vfio_attach_device/vfio_detach_device API, let's turn the
>>> legacy functions into static functions, local to container.c.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>
>> Zhenzhong,
>>
>> Could you please resend 1-12 independantly as a prereq series for iommufd
>> support ? I think there wouldn't be much to say and they could be merged
>> pretty quickly.
> 
> Got it, will do.
> Note I want to replace "[PATCH v1 06/22] vfio/common: Add a vfio device iterator"
> with vfio_device_list which will be used by both BEs, that may need some time.

Sure. Not today :) When you can.

Thanks,

C.


