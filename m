Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 325F27C5671
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:11:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZwF-0004wX-Am; Wed, 11 Oct 2023 10:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qqZwD-0004w9-3t
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qqZw9-0008GP-55
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697033502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sGcsMN/2Z7KliUTkPHqRhUXU1yHEyWmmaC0LARfo/54=;
 b=OewzuwQLHjr8Nuqaqv9lfygfBM8HMzMvJVAqlY/timaPP9ot9BekRgdhLRp4aEO9USp1id
 9SXWxu4bLaEBsCqetdtrekpCbATgiyqQHFEd1iDziRPDAKGCqcJSdmpuAk4qwcME6iVCIo
 Z3pOrpciLFZXpc9sH7ypovzAClltVC4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-yn_YPab5MGy_j9lmJuQILg-1; Wed, 11 Oct 2023 10:11:41 -0400
X-MC-Unique: yn_YPab5MGy_j9lmJuQILg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4180b3a5119so80229291cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697033500; x=1697638300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sGcsMN/2Z7KliUTkPHqRhUXU1yHEyWmmaC0LARfo/54=;
 b=CDvCtY0F6ZzubC/fi2Fve7OTilHepVkoN1UpvBXXrRzadXAfCZcLn5LzzEX1sCxwao
 kbNbSObxV8qRbkCO+QTh7XuB0D4so1EDO5bPjogbYRECd6jXhU1NQRMXXrd1Svyk0gtp
 Hhuki8hapT7y5xvYpY3fG3z19kfMdVVgj8g00wiL7OFOA9fz6RoNWzkFpziT+nBDGxNs
 sa+nfgn8R2iYBbvcMvJ1c8GQ8QI4eO7yU6q6jMr7ii3Zi+sYims5R5xBrhaxMyUqqsxo
 cCUE8iObVY1slUo1YddxoqVT9rDR0Q9+NDtIosEZOZDACUN80TR5J5poIonKvUnuHNJf
 oOig==
X-Gm-Message-State: AOJu0Yz3mmOz27JwXByp4dtw4mp1HShDKAq6zavX8VJR4St75EauJ21+
 2MkKwKHy/gOKbfC+38wGrMaP9G7AHIumKaHbbS5L3V6jZzFpnZKBjWQ/7PC93VBQT4EyFuTCGiY
 lunSEco8s2yoQE8A=
X-Received: by 2002:a05:622a:174c:b0:419:b52a:4f2e with SMTP id
 l12-20020a05622a174c00b00419b52a4f2emr26054434qtk.15.1697033500557; 
 Wed, 11 Oct 2023 07:11:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiFrQzrq9KWIJyUeLRf8QI0cWOeRoEf7BNcnYqfcsSK97YaVMkah5Kv2ikrQHUNLIaXkWQeg==
X-Received: by 2002:a05:622a:174c:b0:419:b52a:4f2e with SMTP id
 l12-20020a05622a174c00b00419b52a4f2emr26054400qtk.15.1697033500131; 
 Wed, 11 Oct 2023 07:11:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 n10-20020ac8674a000000b004196a813639sm5366944qtp.17.2023.10.11.07.11.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 07:11:39 -0700 (PDT)
Message-ID: <6a24e610-df9d-baaa-a6ef-7906696586b0@redhat.com>
Date: Wed, 11 Oct 2023 16:11:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] vfio/pci: rename vfio_put_device to vfio_pci_put_device
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, chao.p.peng@intel.com
References: <20230922025223.1091821-1-zhenzhong.duan@intel.com>
 <6e3a76ea-af1f-4e45-62b5-32425b6b541f@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <6e3a76ea-af1f-4e45-62b5-32425b6b541f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10/11/23 15:02, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 22/9/23 04:52, Zhenzhong Duan wrote:
>> vfio_put_device() is a VFIO PCI specific function, rename it with
>> 'vfio_pci' prefix to avoid confusing.
> 
> Why not, but what about the other functions?

yes. Let's tackle that after the IOMMUFD earthquake :)

C.


> 
> $ git grep -F '(VFIOPCIDevice *' hw/vfio/pci.c | grep -vF ' vfio_pci_'
> hw/vfio/pci.c:51:static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
> hw/vfio/pci.c:52:static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
> hw/vfio/pci.c:53:static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
> hw/vfio/pci.c:117:static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
> hw/vfio/pci.c:175:static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:212:static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
> hw/vfio/pci.c:260:static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
> hw/vfio/pci.c:314:static void vfio_intx_disable(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:372:static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
> hw/vfio/pci.c:416:static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
> hw/vfio/pci.c:588:static void vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:595:static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:609:static void vfio_msix_enable(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:660:static void vfio_msi_enable(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:732:static void vfio_msi_disable_common(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:754:static void vfio_msix_disable(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:788:static void vfio_msi_disable(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:802:static void vfio_update_msi(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:1263:static void vfio_disable_interrupts(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:1281:static int vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
> hw/vfio/pci.c:1491:static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
> hw/vfio/pci.c:1573:static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
> hw/vfio/pci.c:1630:static void vfio_teardown_msi(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:1645:static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled)
> hw/vfio/pci.c:1654:static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
> hw/vfio/pci.c:1682:static void vfio_bars_prepare(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:1691:static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
> hw/vfio/pci.c:1717:static void vfio_bars_register(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:1726:static void vfio_bars_exit(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:1746:static void vfio_bars_finalize(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:1810:static void vfio_add_emulated_word(VFIOPCIDevice *vdev, int pos,
> hw/vfio/pci.c:1823:static void vfio_add_emulated_long(VFIOPCIDevice *vdev, int pos,
> hw/vfio/pci.c:1906:static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
> hw/vfio/pci.c:2036:static void vfio_check_pcie_flr(VFIOPCIDevice *vdev, uint8_t pos)
> hw/vfio/pci.c:2046:static void vfio_check_pm_reset(VFIOPCIDevice *vdev, uint8_t pos)
> hw/vfio/pci.c:2056:static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
> hw/vfio/pci.c:2066:static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
> hw/vfio/pci.c:2148:static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
> hw/vfio/pci.c:2196:static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:2291:static int vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
> hw/vfio/pci.c:2678:int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
> hw/vfio/pci.c:2746:static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
> hw/vfio/pci.c:2829:static void vfio_put_device(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:2865:static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:2892:static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:2924:static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
> hw/vfio/pci.c:2958:static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
> 
>> No functional change.
>>
>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/vfio/pci.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 3b2ca3c24ca2..b2d5010b9f0e 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2826,7 +2826,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>>       }
>>   }
>> -static void vfio_put_device(VFIOPCIDevice *vdev)
>> +static void vfio_pci_put_device(VFIOPCIDevice *vdev)
> 


