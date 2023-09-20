Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EE47A7425
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 09:31:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qirfR-0005Ak-K2; Wed, 20 Sep 2023 03:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qirfM-00059B-Ox
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:30:33 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qirfI-0003eI-Sm
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695195028; x=1726731028;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=+f/SlsffWN3dCi/VtuiZU8f+moZRzVKgS6ofi5xty3Q=;
 b=ZKQNH4hHDAcRJZAyDtyh1SSz+STCGz0aJbGCggCoazFvce02h4XXvk2o
 89T+9MoASNfcgmYiUN9C/84GY7FcR1qNlrQWMVcLMIH4/AbNsPcGzOtTD
 a+nPvUY1JG5CE75/yfsiROTAwpTxWaSyYhBWIJSk1+9/odglTbJX0Xu7F
 y7oRqeCrpUAILbvQYfk2rnoNf92YyomYW8mjRHXflxFJL3ApkN+hM2/0e
 ZVCfR4tWdGY9jTWUKlIdnUI7ZgIFnkrH6QEAgKJxPTrSebPuiz4YywVRj
 CfVEK+agoGDIeSbM1EcGlhHGY/cSIwJsNFsWLYDTuX+jw0FBK2dpilvGW A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="383995577"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; d="scan'208";a="383995577"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 00:30:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="870266763"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; d="scan'208";a="870266763"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.93.14.5])
 ([10.93.14.5])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 00:30:17 -0700
Message-ID: <a636b841-1bfc-925a-406e-6c4469e7e4c6@intel.com>
Date: Wed, 20 Sep 2023 15:30:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Content-Language: en-US
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>, Parav Pandit <parav@nvidia.com>,
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
 <BL1PR12MB5849A542AA93F6ED9FEEAAF0E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <BL1PR12MB5849A542AA93F6ED9FEEAAF0E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=lingshan.zhu@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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



On 9/20/2023 3:24 PM, Chen, Jiqian wrote:
> Hi Lingshan,
> It seems you reply to the wrong email thread. They are not related to my patch.
These reply to Parva's comments.
@Parva, if you want to discuss more about live migration, please reply 
in my thread, lets don't flood here.
>
> On 2023/9/20 15:06, Zhu, Lingshan wrote:
>>
>> On 9/20/2023 2:58 PM, Parav Pandit wrote:
>>>> From: Chen, Jiqian <Jiqian.Chen@amd.com>
>>>> Sent: Wednesday, September 20, 2023 12:03 PM
>>>> If driver write 0 to reset device, can the SUSPEND bit be cleared?
>>> It must as reset operation, resets everything else and so the suspend too.
>>>
>>>> (pci_pm_resume->virtio_pci_restore->virtio_device_restore-
>>>>> virtio_reset_device)
>>>> If SUSPEND is cleared, then during the reset process in Qemu, I can't judge if
>>>> the reset request is from guest restore process or not, and then I can't change
>>>> the reset behavior.
>>> Reset should not be influenced by suspend.
>>> Suspend should do the work of suspend and reset to do the reset.
>>>
>>> The problem to overcome in [1] is, resume operation needs to be synchronous as it involves large part of context to resume back, and hence just asynchronously setting DRIVER_OK is not enough.
>>> The sw must verify back that device has resumed the operation and ready to answer requests.
>> this is not live migration, all device status and other information still stay in the device, no need to "resume" context, just resume running.
>>
>> Like resume from a failed LM.
>>> This is slightly different flow than setting the DRIVER_OK for the first time device initialization sequence as it does not involve large restoration.
>>>
>>> So, to merge two ideas, instead of doing DRIVER_OK to resume, the driver should clear the SUSPEND bit and verify that it is out of SUSPEND.
>>>
>>> Because driver is still in _OK_ driving the device flipping the SUSPEND bit.
>> Please read the spec, it says:
>> The driver MUST NOT clear a device status bit
>>
>>


