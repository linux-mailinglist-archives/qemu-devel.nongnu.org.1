Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A666A810D91
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 10:44:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDLmD-0007vA-Sc; Wed, 13 Dec 2023 04:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rDLm9-0007u5-FO
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 04:43:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rDLm7-000829-SB
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 04:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702460605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9sfGHroYlzQeBsi8CBEnOGE0o2CZkqx6FMUCw/55+eo=;
 b=RuQr7FjN9Je9iPMkqP3VzwzzLs5Sx7vYyZS3DcMfCBLTTlydphML5RIkPBxe5+xRkxWS/i
 aEReoy9E1PtCm/1segczEODtE3piBwQD8P7bbEwD9PUwbhfPuMtMkfC2womAS9vrXlgnkL
 hiJRfe0dg765sj/1pD1ssJlY/uZ1bLI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-pQCXIKbVNTyEqUuetCm1MA-1; Wed, 13 Dec 2023 04:43:24 -0500
X-MC-Unique: pQCXIKbVNTyEqUuetCm1MA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3363101652bso711255f8f.1
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 01:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702460603; x=1703065403;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :cc:references:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9sfGHroYlzQeBsi8CBEnOGE0o2CZkqx6FMUCw/55+eo=;
 b=Kuy4BKySZygqK/Ig7OexKmtoQGc3xcfo4DhC36VJoJz2Mz17gmU+VfoHUJRfZXhzwG
 qD9NFXe88i21S6i9z1h4Owz7gzppwT6mggmjPMUrqgz/XCujz1Mp87jFUPzKBMUuUD1T
 gNJiY79Qfu2r5f9PoqbaZoeBcHdx8JyEMqLv1LGU5J366yWOQ15fbd39xSI1hv5Ui0T+
 duOCu76ctfFNl8fAuH4iYTtjEO3HRsiZeZ59UyoDDqBoyKxyaXlgu/1ydMfXQqUhNFlv
 ee/K7d6ts30sVni7dLRoooWsM+0X+wBlIYlvAmrTcqOM3LbytSuJLxbRoQnirBGMl6nU
 wq9w==
X-Gm-Message-State: AOJu0YwvHG2jINz7/NJtm36l1fVl6G5b5qBILJ3SNW/+3oVouwCoOgHa
 0byRs3IUSPKHTBcG3+25UrMQcOGvGg0TsPpvL4hogKZKUvKOCLPNcroF73UU3+XZ6XS/uNXlAig
 VN+Dx6Pq20dNu1bc=
X-Received: by 2002:a05:600c:3586:b0:40b:5e56:7b33 with SMTP id
 p6-20020a05600c358600b0040b5e567b33mr3994816wmq.124.1702460602848; 
 Wed, 13 Dec 2023 01:43:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyHYQcJ+/pvofe1WsFt1GWnuMgZ4vziX6Fw6JqkZ+di1IFS4glaNsQ7mncw4XM0aaGLtMSNA==
X-Received: by 2002:a05:600c:3586:b0:40b:5e56:7b33 with SMTP id
 p6-20020a05600c358600b0040b5e567b33mr3994808wmq.124.1702460602436; 
 Wed, 13 Dec 2023 01:43:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:6e00:7e5:5f4d:f300:5d52?
 (p200300cbc7096e0007e55f4df3005d52.dip0.t-ipconnect.de.
 [2003:cb:c709:6e00:7e5:5f4d:f300:5d52])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05600c0a0e00b0040b3867a297sm20025781wmp.36.2023.12.13.01.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 01:43:22 -0800 (PST)
Message-ID: <417ab6c2-d5c3-40ef-8f38-7ba6ef569741@redhat.com>
Date: Wed, 13 Dec 2023 10:43:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio: Add ioeventfd option for balloon
Content-Language: en-US
To: Zheyun Shen <szy0127@sjtu.edu.cn>, qemu-devel@nongnu.org
References: <20231212075058.710918-1-szy0127@sjtu.edu.cn>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231212075058.710918-1-szy0127@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Please CC the relevant maintainers, I only stumbled over that by luck.

See scripts/get_maintainer.pl


On 12.12.23 08:50, Zheyun Shen wrote:
> Traditional mmio in balloon makes qemu do balloon inflation in the same
> thread as vcpu thread.In a CPU overcommitment scenario, host may run
> more than one vcpu threads on one host thread, which makes
> madvise_dontneed_free() wait for a long time due to the function
> cond_resched() at host side.
> 
> If using SEV/ES and the kernel provided by AMD, the overhead will
> become even much larger.
> 
> With ioeventfd, the thread for host to do balloon inflation will
> be seperated from the vcpu thread, leading to better performance
> for the whole process of balloon inflation.

I didn't really look into ieventfd so far, but from what I understand, 
an iothread will take care of processing these events, instead of the 
vcpu thread.

Do you have some performance numbers?

I'll note that whatever thread calls madvise(), we're holding the BQL in 
that code and will block any other threads that need it.


> 
> Signed-off-by: Zheyun Shen <szy0127@sjtu.edu.cn>
> ---
>   hw/virtio/virtio-balloon-pci.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pci.c
> index ce2645b..7195322 100644
> --- a/hw/virtio/virtio-balloon-pci.c
> +++ b/hw/virtio/virtio-balloon-pci.c
> @@ -35,6 +35,12 @@ struct VirtIOBalloonPCI {
>       VirtIOBalloon vdev;
>   };
>   
> +static Property virtio_balloon_properties[] = {
> +    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
> +            VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, false),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>   static void virtio_balloon_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>   {
>       VirtIOBalloonPCI *dev = VIRTIO_BALLOON_PCI(vpci_dev);
> @@ -51,6 +57,7 @@ static void virtio_balloon_pci_class_init(ObjectClass *klass, void *data)
>       PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
>       k->realize = virtio_balloon_pci_realize;
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    device_class_set_props(dc, virtio_balloon_properties);
>       pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
>       pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BALLOON;
>       pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;

-- 
Cheers,

David / dhildenb



