Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 886607B03EC
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 14:25:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlTas-00084w-7p; Wed, 27 Sep 2023 08:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlTaU-0007wh-Ap
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 08:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlTaS-0002ns-Oa
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 08:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695817455;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ui2Luid4JCY1FjIkr9SfhLnJ+hzO12z2bv8czcK+hQ=;
 b=WNaBEIGdZHO9rT0+Kf6uxUkQAOJdMEWLiMFl5X1egT5J98oZS8YpGUBsjFgwf6DTScYfZr
 8GzCc5Kt5lc0rC+xXFgd8qxfmRI9PcysFWlTxn46V97vBhBRzsS7DYF7Hbio51jBwv6O3v
 iYxb7CNT7NolNpWeevA4e141b5k9I0M=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-_0p85zHaP8ixKy9vngnwAA-1; Wed, 27 Sep 2023 08:24:14 -0400
X-MC-Unique: _0p85zHaP8ixKy9vngnwAA-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-59f4f2a9ef0so186876617b3.2
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 05:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695817454; x=1696422254;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ui2Luid4JCY1FjIkr9SfhLnJ+hzO12z2bv8czcK+hQ=;
 b=F9kF0R/ouzju6ytRsR4OPUby+7h7XyEin5lB+q2Ty+fKugwx8dzPrJ8i4TaX/VEZUU
 9nZrzWYYx0zK7Bez7zon89K0DmqUWB9iHCERd9xR7G/O5LbDp7TUjrZ3GYKmUWyRBL8P
 NlVFKca5agwreZFK8ICW+HwSiR6SK5uWgkWrragkPKh4ts2cqusd9A87cVhXWZJYxmhH
 WjNJAH25U6utLeDFc88bhqmF6kA953gSQpxuw/Gizdsq9LIqCgl0SWQwJEjFNEKjw+G0
 WYby4YOxSGSA3C4BKsI5m5WXen4pMjTFpq9XfQdtnSE/tnMNu3HrEv6szKggDnGM7aXP
 W8JQ==
X-Gm-Message-State: AOJu0YzMIFi/mDT20e4q5IDKTAyB5wSJJaB0beIcocx1zCSRvuA6OdA8
 fb8eQbSrvEXxV2RW5DjS9PEjCRchntF4yu/BGpqDbJbTrgpsKgzyWD0WduT0Mfh9EaTjeWOIr9f
 f/lQ0wT+2CciIBw4=
X-Received: by 2002:a81:8246:0:b0:589:f41c:bc63 with SMTP id
 s67-20020a818246000000b00589f41cbc63mr2247392ywf.39.1695817454073; 
 Wed, 27 Sep 2023 05:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg6Ubwn7lTnlj4Nt4zyP1As2VS3nIiu8IQu+Z48VABVCZv6frWtl/ybT+MCVLPmbFGQPLUkg==
X-Received: by 2002:a81:8246:0:b0:589:f41c:bc63 with SMTP id
 s67-20020a818246000000b00589f41cbc63mr2247380ywf.39.1695817453791; 
 Wed, 27 Sep 2023 05:24:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 mn12-20020a0562145ecc00b0065af252fe88sm4119509qvb.63.2023.09.27.05.24.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 05:24:12 -0700 (PDT)
Message-ID: <dad18bf6-1e1d-15c4-fb87-7359a7a97e68@redhat.com>
Date: Wed, 27 Sep 2023 14:24:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 08/12] vfio/ap: Use vfio_[attach/detach]_device
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
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "open list:vfio-ap" <qemu-s390x@nongnu.org>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-9-zhenzhong.duan@intel.com>
 <78bc5496-a017-4f5a-a825-df992ef86016@redhat.com>
 <PH7PR11MB6722A8CD7B8CF95DA2FA92A492C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <PH7PR11MB6722A8CD7B8CF95DA2FA92A492C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 9/27/23 13:52, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Wednesday, September 27, 2023 5:16 PM
>> Subject: Re: [PATCH v2 08/12] vfio/ap: Use vfio_[attach/detach]_device
>>
>> Hi Zhenzhong,
>>
>> On 9/26/23 13:32, Zhenzhong Duan wrote:
>>> From: Eric Auger <eric.auger@redhat.com>
>>>
>>> Let the vfio-ap device use vfio_attach_device() and
>>> vfio_detach_device(), hence hiding the details of the used
>>> IOMMU backend.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  hw/vfio/ap.c | 68 +++++++++-------------------------------------------
>>>  1 file changed, 11 insertions(+), 57 deletions(-)
>>>
>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>> index 6e21d1da5a..16ea7fb3c2 100644
>>> --- a/hw/vfio/ap.c
>>> +++ b/hw/vfio/ap.c
>>> @@ -53,40 +53,6 @@ struct VFIODeviceOps vfio_ap_ops = {
>>>      .vfio_compute_needs_reset = vfio_ap_compute_needs_reset,
>>>  };
>>>
>>> -static void vfio_ap_put_device(VFIOAPDevice *vapdev)
>>> -{
>>> -    g_free(vapdev->vdev.name);
>>> -    vfio_put_base_device(&vapdev->vdev);
>>> -}
>>> -
>>> -static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
>>> -{
>>> -    GError *gerror = NULL;
>>> -    char *symlink, *group_path;
>>> -    int groupid;
>>> -
>>> -    symlink = g_strdup_printf("%s/iommu_group", vapdev->vdev.sysfsdev);
>>> -    group_path = g_file_read_link(symlink, &gerror);
>>> -    g_free(symlink);
>>> -
>>> -    if (!group_path) {
>>> -        error_setg(errp, "%s: no iommu_group found for %s: %s",
>>> -                   TYPE_VFIO_AP_DEVICE, vapdev->vdev.sysfsdev, gerror->message);
>>> -        g_error_free(gerror);
>>> -        return NULL;
>>> -    }
>>> -
>>> -    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
>>> -        error_setg(errp, "vfio: failed to read %s", group_path);
>>> -        g_free(group_path);
>>> -        return NULL;
>>> -    }
>>> -
>>> -    g_free(group_path);
>>> -
>>> -    return vfio_get_group(groupid, &address_space_memory, errp);
>>> -}
>>> -
>>>  static void vfio_ap_req_notifier_handler(void *opaque)
>>>  {
>>>      VFIOAPDevice *vapdev = opaque;
>>> @@ -189,22 +155,15 @@ static void
>> vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
>>>  static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>>  {
>>>      int ret;
>>> -    char *mdevid;
>>>      Error *err = NULL;
>>> -    VFIOGroup *vfio_group;
>>>      APDevice *apdev = AP_DEVICE(dev);
>>>      VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
>>> +    VFIODevice *vbasedev = &vapdev->vdev;
>>>
>>> -    vfio_group = vfio_ap_get_group(vapdev, errp);
>>> -    if (!vfio_group) {
>>> -        return;
>>> -    }
>>> -
>>> -    vapdev->vdev.ops = &vfio_ap_ops;
>>> -    vapdev->vdev.type = VFIO_DEVICE_TYPE_AP;
>>> -    mdevid = basename(vapdev->vdev.sysfsdev);
>>> -    vapdev->vdev.name = g_strdup_printf("%s", mdevid);
>>> -    vapdev->vdev.dev = dev;
>>> +    vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
>> I think we shall document in the commit msg the fact we use
> Yes, will do.
>
>> g_path_get_basename instead of basename here to match other device init
>> see 3e015d815b  use g_path_get_basename instead of basename
>>
>> also leak of vbasedev->name
> I free it in vfio_ap_unrealize().
is it called if realize fails?
>
> Thanks
> Zhenzhong


