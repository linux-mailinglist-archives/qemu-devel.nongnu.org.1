Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 612497B0138
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 12:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlRNg-0001XZ-IH; Wed, 27 Sep 2023 06:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlRNe-0001X8-2m
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlRNY-0002f7-U7
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695808968;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKNlrbuCZagse3wg/iDPHla6lTb5yNxYbxSF3wM+CJI=;
 b=SRNkaTrl1gIrnHJ8g/SKscBPQDxrHuOUDMtreOMPEmiCtm6BosHlgr2BICbXf1m/nwipMB
 8lTYGxUORbv6+WDTnEVILRnRgV+RnL4Ejvh9V6dT6NDJHOKz63R5ImR+dmRaVPreG6IqnE
 FkDISqsZYXb1yGij86WczwmRvbzoUUw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-JB6w3wB-PZaGK7Bq9LW2ng-1; Wed, 27 Sep 2023 06:02:47 -0400
X-MC-Unique: JB6w3wB-PZaGK7Bq9LW2ng-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6557c921deeso180038706d6.2
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 03:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695808966; x=1696413766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sKNlrbuCZagse3wg/iDPHla6lTb5yNxYbxSF3wM+CJI=;
 b=P1USKyI6dUeL/tSyjT0EjM8ZjPPClLFnjBuBrF6IjFoeWXSCskHHXR3brk9Y+PFJYm
 f135KEegKv7X7SfUCwCMERSblQCKWsdQKuW5mhJXYRTKdsV67dAcqZY9TIs8Lq0LfX6Y
 eRtwPIjfMZ/nZ6tLZpbTo15Z7DOkcVP8zDvXOSEqJu2WNrZwrYKt1oHmkPduM4Y+wjVS
 VgXuZgxq6Ms6LZHjmAaG+V/viivRuDTXrDsHjNrzfJI6LS8ySy1NKkZe27RWqCn/9RJv
 1SR+AjZNikSRw6dHgijVg0hyUKc1YJUoKoUP8HByXUNvt7USkfLAoOBRZl+04mcPX2SY
 qmoA==
X-Gm-Message-State: AOJu0Yw6+ASrU61F0n6Ko69Bp/j4SeznMrVhbRMoc0iBn7uOdSv8W66m
 M3Sv95AjkJtPM9sorF7q7XGXB1S/c2MVm/PoE3adnFCjF2E1GxW675G7e67uxzh2QVk2V3QCqB0
 J4oBuKZSgCufHArQ=
X-Received: by 2002:a0c:f10a:0:b0:65b:8ce:1bd4 with SMTP id
 i10-20020a0cf10a000000b0065b08ce1bd4mr1461318qvl.51.1695808966667; 
 Wed, 27 Sep 2023 03:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQj5tF6tmb51+SWJB7aVX3/obUCsr1g/ZABDtwC9vIxllzcgFrwMtvVA0CZp3iAxB23cG7yg==
X-Received: by 2002:a0c:f10a:0:b0:65b:8ce:1bd4 with SMTP id
 i10-20020a0cf10a000000b0065b08ce1bd4mr1461303qvl.51.1695808966378; 
 Wed, 27 Sep 2023 03:02:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a0ce44b000000b00647386a3234sm3408696qvm.85.2023.09.27.03.02.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 03:02:45 -0700 (PDT)
Message-ID: <e142765f-3080-5ecb-5393-b564cef2d7dd@redhat.com>
Date: Wed, 27 Sep 2023 12:02:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 06/12] vfio/pci: Introduce vfio_[attach/detach]_device
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-7-zhenzhong.duan@intel.com>
 <0c11b6c6-1ae5-c116-7938-0c99ccfc87ae@redhat.com>
 <PH7PR11MB67228C4D41CD0DB1E3C9001992C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <PH7PR11MB67228C4D41CD0DB1E3C9001992C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 9/27/23 11:58, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Wednesday, September 27, 2023 3:36 PM
>> Subject: Re: [PATCH v2 06/12] vfio/pci: Introduce vfio_[attach/detach]_device
>>
>> Hi Zhenzhong,
>>
>> On 9/26/23 13:32, Zhenzhong Duan wrote:
>>> From: Eric Auger <eric.auger@redhat.com>
>>>
>>> We want the VFIO devices to be able to use two different
>>> IOMMU backends, the legacy VFIO one and the new iommufd one.
>>>
>>> Introduce vfio_[attach/detach]_device which aim at hiding the
>>> underlying IOMMU backend (IOCTLs, datatypes, ...).
>>>
>>> Once vfio_attach_device completes, the device is attached
>>> to a security context and its fd can be used. Conversely
>>> When vfio_detach_device completes, the device has been
>>> detached from the security context.
>>>
>>> At the moment only the implementation based on the legacy
>>> container/group exists. Let's use it from the vfio-pci device.
>>> Subsequent patches will handle other devices.
>> you may add: no functional change intended
> Will do.
>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  include/hw/vfio/vfio-common.h |  3 ++
>>>  hw/vfio/common.c              | 68 +++++++++++++++++++++++++++++++++++
>>>  hw/vfio/pci.c                 | 50 +++-----------------------
>>>  hw/vfio/trace-events          |  2 +-
>>>  4 files changed, 77 insertions(+), 46 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index c4e7c3b4a7..12fbfbc37d 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -225,6 +225,9 @@ void vfio_put_group(VFIOGroup *group);
>>>  struct vfio_device_info *vfio_get_device_info(int fd);
>>>  int vfio_get_device(VFIOGroup *group, const char *name,
>>>                      VFIODevice *vbasedev, Error **errp);
>>> +int vfio_attach_device(char *name, VFIODevice *vbasedev,
>>> +                       AddressSpace *as, Error **errp);
>>> +void vfio_detach_device(VFIODevice *vbasedev);
>>>
>>>  int vfio_kvm_device_add_fd(int fd, Error **errp);
>>>  int vfio_kvm_device_del_fd(int fd, Error **errp);
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 959b1362bb..7f3798b152 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -2611,3 +2611,71 @@ int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
>>>      }
>>>      return vfio_eeh_container_op(container, op);
>>>  }
>>> +
>>> +static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
>>> +{
>>> +    char *tmp, group_path[PATH_MAX], *group_name;
>>> +    int ret, groupid;
>>> +    ssize_t len;
>>> +
>>> +    tmp = g_strdup_printf("%s/iommu_group", vbasedev->sysfsdev);
>>> +    len = readlink(tmp, group_path, sizeof(group_path));
>>> +    g_free(tmp);
>>> +
>>> +    if (len <= 0 || len >= sizeof(group_path)) {
>>> +        ret = len < 0 ? -errno : -ENAMETOOLONG;
>>> +        error_setg_errno(errp, -ret, "no iommu_group found");
>>> +        return ret;
>>> +    }
>>> +
>>> +    group_path[len] = 0;
>>> +
>>> +    group_name = basename(group_path);
>>> +    if (sscanf(group_name, "%d", &groupid) != 1) {
>>> +        error_setg_errno(errp, errno, "failed to read %s", group_path);
>>> +        return -errno;
>>> +    }
>>> +    return groupid;
>>> +}
>>> +
>>> +int vfio_attach_device(char *name, VFIODevice *vbasedev,
>>> +                       AddressSpace *as, Error **errp)
>>> +{
>>> +    int groupid = vfio_device_groupid(vbasedev, errp);
>>> +    VFIODevice *vbasedev_iter;
>>> +    VFIOGroup *group;
>>> +    int ret;
>>> +
>>> +    if (groupid < 0) {
>>> +        return groupid;
>>> +    }
>>> +
>>> +    trace_vfio_attach_device(vbasedev->name, groupid);
>> hum looking at that again, I was confused by the fact we passed the name
>> arg in
>>
>> vfio_attach_device() whereas vbasedev->name was already filled. Looking at pci
>> vfio_realize()
>> both are sometimes different
>>
>>    if (!qemu_uuid_is_null(&vdev->vf_token)) {
>>        qemu_uuid_unparse(&vdev->vf_token, uuid);
>>        name = g_strdup_printf("%s vf_token=%s", vbasedev->name, uuid);
>>    } else {
>>        name = g_strdup(vbasedev->name);
>>    }
>> This may be worth a doc comment.
> Yes, agree this is confusing. Just want to ask about the doc comment?
> Should I create a vfio doc or just a small comment on call site of vfio_attach_device()?
I meant a comment associated to this vfio_attach_device helper
indicating what is the purpose/semantic of name versus vbasedev->name

See my last comment on the ccw conversion which is even more confusing now to me :-(

Eric

>
> Thanks
> Zhenzhong


