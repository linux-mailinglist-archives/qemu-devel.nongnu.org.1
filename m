Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F35B7A74A1
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 09:46:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiruH-0005Br-Ou; Wed, 20 Sep 2023 03:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qiruC-0005Am-AW
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:45:55 -0400
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qiru9-0007Cb-Ge
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695195949; x=1726731949;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9aISSy5Y6tM/5Mn3uS24TYyGdedLlI00cbNXlchHbQU=;
 b=HSNdF5ElFmOsVX/T4jDLvm+m+GQS5PetBLhWpG4l41DS2tHUmRbQD8gu
 tdN0hrT71/aTSMZ+/+uOivvweqhtCymUW6jDA9BREex9FhG+ie562DdJv
 5VKznWEPlTagvp+lj+/D4bZNYHwkWJZuG0w1QiHY+3SvRlv+ZHWjt/grL
 Kynwu/1v7smbL0uPHXZU5T9CTOrXohgrdbWuwQ4xGeYmRP91fFuX4Gl3P
 c+U7HJ1APMNw4MaDIdZzsatjHvPO1gO3sKZO4CCHlk/2MEuU6HqvADF+w
 LxZ/njKybD6jJezLp3pUrf8N5aYn7w/pryx+xLrRV4Px5nWjpqPPcQRcr g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="370468081"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; d="scan'208";a="370468081"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 00:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="749789384"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; d="scan'208";a="749789384"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.93.14.5])
 ([10.93.14.5])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 00:45:41 -0700
Message-ID: <1a2537e9-b70c-0d85-20f5-e8ef5c8a9bb8@intel.com>
Date: Wed, 20 Sep 2023 15:45:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@gmail.com>, Robert Beckett <bob.beckett@collabora.com>,
 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
 Xenia Ragiadakou <burzalodowa@gmail.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 "Zhang, Julia" <Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
 <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
 <BL1PR12MB5849E32A76165F1307492185E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481D2CBCFBF7BCBF427EE1EDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <701bb67c-c52d-4eb3-a6ed-f73bd5d0ff33@intel.com>
 <PH0PR12MB5481891053E37A79920991F6DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <91c3e7ec-d702-ee61-c420-59ddc8dac6dc@intel.com>
 <PH0PR12MB548118296F71CBD9158963B0DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB548118296F71CBD9158963B0DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=lingshan.zhu@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
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



On 9/20/2023 3:32 PM, Parav Pandit wrote:
>
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Wednesday, September 20, 2023 12:58 PM
>>
>> On 9/20/2023 3:10 PM, Parav Pandit wrote:
>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>> Sent: Wednesday, September 20, 2023 12:37 PM
>>>>> The problem to overcome in [1] is, resume operation needs to be
>>>>> synchronous
>>>> as it involves large part of context to resume back, and hence just
>>>> asynchronously setting DRIVER_OK is not enough.
>>>>> The sw must verify back that device has resumed the operation and
>>>>> ready to
>>>> answer requests.
>>>> this is not live migration, all device status and other information
>>>> still stay in the device, no need to "resume" context, just resume running.
>>>>
>>> I am aware that it is not live migration. :)
>>>
>>> "Just resuming" involves lot of device setup task. The device implementation
>> does not know for how long a device is suspended.
>>> So for example, a VM is suspended for 6 hours, hence the device context
>> could be saved in a slow disk.
>>> Hence, when the resume is done, it needs to setup things again and driver got
>> to verify before accessing more from the device.
>> The restore procedures should perform by the hypervisor and done before set
>> DRIVER_OK and wake up the guest.
> Which is the signal to trigger the restore? Which is the trigger in physical device when there is no hypervisor?
>
> In my view, setting the DRIVER_OK is the signal regardless of hypervisor or physical device.
> Hence the re-read is must.
Yes, as I said below, should verify by re-read.
>
>> And the hypervisor/driver needs to check the device status by re-reading.
>>>> Like resume from a failed LM.
>>>>> This is slightly different flow than setting the DRIVER_OK for the
>>>>> first time
>>>> device initialization sequence as it does not involve large restoration.
>>>>> So, to merge two ideas, instead of doing DRIVER_OK to resume, the
>>>>> driver
>>>> should clear the SUSPEND bit and verify that it is out of SUSPEND.
>>>>> Because driver is still in _OK_ driving the device flipping the SUSPEND bit.
>>>> Please read the spec, it says:
>>>> The driver MUST NOT clear a device status bit
>>>>
>>> Yes, this is why either DRIER_OK validation by the driver is needed or Jiqian's
>> synchronous new register..
>> so re-read
> Yes. re-read until set, Thanks.
>


