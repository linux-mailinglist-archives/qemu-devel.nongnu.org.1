Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8388CAC5FAD
	for <lists+qemu-devel@lfdr.de>; Wed, 28 May 2025 04:48:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK6q5-00005h-KQ; Tue, 27 May 2025 22:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6pv-0008Sd-K2; Tue, 27 May 2025 22:48:11 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6pt-0004iF-S8; Tue, 27 May 2025 22:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748400490; x=1779936490;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=87MZXERdmn+bRyCDGJmocHYjWGj14nJn8uA6reJm+ns=;
 b=IvIU7ptGgU5QAsrMgrko4DL8bOnxeX8vMtkrgrwKyXdCjFD/AR7dFU0t
 KaYHondotJn9ZhyI45gtbk8gW5SiBfQUXDKuEvXAqCzAEPyMglVAMBIoO
 RsHtGKXhg8DMVUAmm2tXmZjwh0d0rZWBKlDZfmsgfuYWXciEJetVXWVAA
 SFpQrq2x4ymmbJ7bVIGfh8fOydem6jYO8gWMii2tIWW4Vsnfi39wxFHgn
 2EkCDoMdR5OjrcSwgYcQsTWM2UQcOGMs5rtaMcJZSfAlMHYbNfktGE+8z
 yGeWXXAabFhArMCAdTLBPxj+7Ls7/QoGkSpdlAP7PHsNKq9R/O7kLICzo g==;
X-CSE-ConnectionGUID: CSvWK+8aRBaJS6fWWKy1MQ==
X-CSE-MsgGUID: f/H6VJu/RMmZnazc6PihYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="54218622"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="54218622"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:48:08 -0700
X-CSE-ConnectionGUID: NpgtjjxdRQCbTzOnsjxtwA==
X-CSE-MsgGUID: 5nLhJQyETFKLjcCmb9ElFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="147943628"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:48:02 -0700
Message-ID: <b97d6748-7ec7-4f5f-b882-6cc23a0a94f6@intel.com>
Date: Wed, 28 May 2025 10:47:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/19] hw/scsi/vmw_pvscsi: Convert DeviceRealize ->
 InstanceInit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-17-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250512083948.39294-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/12/2025 4:39 PM, Philippe Mathieu-Daudé wrote:
> Simplify replacing pvscsi_realize() by pvscsi_instance_init(),
> removing the need for device_class_set_parent_realize().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/scsi/vmw_pvscsi.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index e163023d14c..7c98b1b8ea6 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -1267,21 +1267,15 @@ static const Property pvscsi_properties[] = {
>       DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
>   };
>   
> -static void pvscsi_realize(DeviceState *qdev, Error **errp)
> +static void pvscsi_instance_init(Object *obj)
>   {
> -    PVSCSIClass *pvs_c = PVSCSI_GET_CLASS(qdev);
> -    PCIDevice *pci_dev = PCI_DEVICE(qdev);
> -
> -    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
> -
> -    pvs_c->parent_dc_realize(qdev, errp);
> +    PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;
>   }
>   
>   static void pvscsi_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> -    PVSCSIClass *pvs_k = PVSCSI_CLASS(klass);
>       HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
>   
>       k->realize = pvscsi_realizefn;
> @@ -1290,8 +1284,6 @@ static void pvscsi_class_init(ObjectClass *klass, const void *data)
>       k->device_id = PCI_DEVICE_ID_VMWARE_PVSCSI;
>       k->class_id = PCI_CLASS_STORAGE_SCSI;
>       k->subsystem_id = 0x1000;
> -    device_class_set_parent_realize(dc, pvscsi_realize,
> -                                    &pvs_k->parent_dc_realize);
>       device_class_set_legacy_reset(dc, pvscsi_reset);
>       dc->vmsd = &vmstate_pvscsi;
>       device_class_set_props(dc, pvscsi_properties);
> @@ -1306,6 +1298,7 @@ static const TypeInfo pvscsi_info = {
>       .class_size    = sizeof(PVSCSIClass),
>       .instance_size = sizeof(PVSCSIState),
>       .class_init    = pvscsi_class_init,
> +    .instance_init = pvscsi_instance_init,
>       .interfaces = (const InterfaceInfo[]) {
>           { TYPE_HOTPLUG_HANDLER },
>           { INTERFACE_PCIE_DEVICE },


