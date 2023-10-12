Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B377C65E4
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 08:50:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqpUu-0000Ef-DJ; Thu, 12 Oct 2023 02:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qqpUr-0000Ds-Uu
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 02:48:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qqpUq-0003Ad-AU
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 02:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697093315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5EDA50ufq9/kOtFg+ub4Fe73qnUX4GM+Djb7OcHqWU=;
 b=B6WC+HCb0dsmcdxsfQHL15fK7rcrGt91B/PNS02WLPAvgFjKM6S1SKhig2VrikS8lA/nvw
 GIhB7k99c7HpcM+i1XBTPx+b087X7qlr/acx6iJTgeIt/EvTCaWn5MtNb6mBEjIYiGD8Tc
 niCZnwd7oNFiMIJ1Eq9ABYyczYIUGb0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-KS28oOf4NRiY3lI8GiW9lA-1; Thu, 12 Oct 2023 02:48:23 -0400
X-MC-Unique: KS28oOf4NRiY3lI8GiW9lA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77435bbb71dso72098485a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 23:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697093302; x=1697698102;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z5EDA50ufq9/kOtFg+ub4Fe73qnUX4GM+Djb7OcHqWU=;
 b=dTk/6Xob3XE8DO64bflxd7lA0lZJsr3IWdsjPGDYzh4dusfG1q2RuHFqx+Q1YE280t
 GV/0NKsOCOR/GUzUOseOeDDu7y/8DZ0ak1PKmVIQiAwPnfkBrUe+345GcWFRDHGfOAc4
 ann3JTCd0iY9L/MmreDko7xlt7W5aDuXxtYkDoqrxR5cn0PdvzsNUhFzTdHiZ2vRbw0F
 LwfNDfIlsPaLw5+cgBnuOw9CPpsy1H8ch3HXUuDh5vtWGzWzI5rIpFIwVYDja+ojhd7S
 uX1BxwlN72iqMqAUu/X32A3UuxdL9ZUgytvqG2Ts08KS6W9FaUT4AeJm2wN93fojs+W+
 /Pzw==
X-Gm-Message-State: AOJu0YwWv/QBFXobPTSHftGOHikU7jMg2uMxkWHRg84TjXrAQKTSln9I
 CakP3ej71u8TEOYjqu2taCRrCtKu9X954cw6GkyydcjClLzztqfZ38txTmVxEEMetT+ZOzdYjcC
 WS9w57Ht4USiMNlU=
X-Received: by 2002:a05:620a:d5c:b0:76f:1f05:e994 with SMTP id
 o28-20020a05620a0d5c00b0076f1f05e994mr19296504qkl.64.1697093302594; 
 Wed, 11 Oct 2023 23:48:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0iYQ5rH4AUngPCkUrg0W6mXlzClutlWfiGn8blhrEEPZgdTkxSVv7hIEoBFNtWAI5sj/03Q==
X-Received: by 2002:a05:620a:d5c:b0:76f:1f05:e994 with SMTP id
 o28-20020a05620a0d5c00b0076f1f05e994mr19296490qkl.64.1697093302281; 
 Wed, 11 Oct 2023 23:48:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 c7-20020ae9e207000000b00774133fb9a3sm5808931qkc.114.2023.10.11.23.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 23:48:21 -0700 (PDT)
Message-ID: <2172988b-c5b9-bb94-2ea1-905903bb958b@redhat.com>
Date: Thu, 12 Oct 2023 08:48:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] vfio/pci: Remove vfio_detach_device from vfio_realize
 error path
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, zhenzhong.duan@intel.com,
 yi.l.liu@intel.com, yanghliu@redhat.com
References: <20231011200934.549735-1-eric.auger@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231011200934.549735-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 10/11/23 22:09, Eric Auger wrote:
> In vfio_realize, on the error path, we currently call
> vfio_detach_device() after a successful vfio_attach_device.
> While this looks natural, vfio_instance_finalize also induces
> a vfio_detach_device(), and it seems to be the right place
> instead as other resources are released there which happen
> to be a prerequisite to a successful UNSET_CONTAINER.
> 
> So let's rely on the finalize vfio_detach_device call to free
> all the relevant resources.
> 
> Fixes: a28e06621170 ("vfio/pci: Introduce vfio_[attach/detach]_device")
> Reported-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> This applies on top of vfio-next

Applied to vfio-next.

> Note I am not sure the SHA1 of
> vfio/pci: Introduce vfio_[attach/detach]_device
> is stable.

It should if I only rebase on master. If I need to re-apply, I will drop
the Fixes tag.

Thanks,

C.



> ---
>   hw/vfio/pci.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 40ae46266e..6e3f6aba28 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3115,7 +3115,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       vfio_populate_device(vdev, &err);
>       if (err) {
>           error_propagate(errp, err);
> -        goto out_detach;
> +        goto error;
>       }
>   
>       /* Get a copy of config space */
> @@ -3125,7 +3125,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       if (ret < (int)MIN(pci_config_size(&vdev->pdev), vdev->config_size)) {
>           ret = ret < 0 ? -errno : -EFAULT;
>           error_setg_errno(errp, -ret, "failed to read device config space");
> -        goto out_detach;
> +        goto error;
>       }
>   
>       /* vfio emulates a lot for us, but some bits need extra love */
> @@ -3144,7 +3144,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       if (vdev->vendor_id != PCI_ANY_ID) {
>           if (vdev->vendor_id >= 0xffff) {
>               error_setg(errp, "invalid PCI vendor ID provided");
> -            goto out_detach;
> +            goto error;
>           }
>           vfio_add_emulated_word(vdev, PCI_VENDOR_ID, vdev->vendor_id, ~0);
>           trace_vfio_pci_emulated_vendor_id(vbasedev->name, vdev->vendor_id);
> @@ -3155,7 +3155,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       if (vdev->device_id != PCI_ANY_ID) {
>           if (vdev->device_id > 0xffff) {
>               error_setg(errp, "invalid PCI device ID provided");
> -            goto out_detach;
> +            goto error;
>           }
>           vfio_add_emulated_word(vdev, PCI_DEVICE_ID, vdev->device_id, ~0);
>           trace_vfio_pci_emulated_device_id(vbasedev->name, vdev->device_id);
> @@ -3166,7 +3166,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       if (vdev->sub_vendor_id != PCI_ANY_ID) {
>           if (vdev->sub_vendor_id > 0xffff) {
>               error_setg(errp, "invalid PCI subsystem vendor ID provided");
> -            goto out_detach;
> +            goto error;
>           }
>           vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_VENDOR_ID,
>                                  vdev->sub_vendor_id, ~0);
> @@ -3177,7 +3177,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       if (vdev->sub_device_id != PCI_ANY_ID) {
>           if (vdev->sub_device_id > 0xffff) {
>               error_setg(errp, "invalid PCI subsystem device ID provided");
> -            goto out_detach;
> +            goto error;
>           }
>           vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_ID, vdev->sub_device_id, ~0);
>           trace_vfio_pci_emulated_sub_device_id(vbasedev->name,
> @@ -3210,7 +3210,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       vfio_msix_early_setup(vdev, &err);
>       if (err) {
>           error_propagate(errp, err);
> -        goto out_detach;
> +        goto error;
>       }
>   
>       vfio_bars_register(vdev);
> @@ -3326,8 +3326,6 @@ out_deregister:
>   out_teardown:
>       vfio_teardown_msi(vdev);
>       vfio_bars_exit(vdev);
> -out_detach:
> -    vfio_detach_device(vbasedev);
>   error:
>       error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
>   }


