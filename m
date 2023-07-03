Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F277460AF
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:25:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGMLI-0007XO-15; Mon, 03 Jul 2023 12:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qGML6-0007X2-FF
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qGML4-0004Fj-RV
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688401425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8wvIYhrHHWXcu19EWo/5hYqCsuHjFQ9V/PuFjM3iEk=;
 b=e8ihZ7D41D1ynMJFtZfRXG28RUKRZFMQlN4sFBCdg9oDHZPGMeurZujel4IHUiBYdKHabS
 GzN1wdAG+qxWy7SBy1vSZneie31/+/FelJhiM12ztLSXmX4NUOG+jmeX5jYBEVZaOYlXdD
 ptuEYBldYilUOb7eytOElau9My4esss=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-j_21aEvfO5-Xp0BJMseDhQ-1; Mon, 03 Jul 2023 12:23:44 -0400
X-MC-Unique: j_21aEvfO5-Xp0BJMseDhQ-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-793fbd392c2so710240241.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 09:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688401424; x=1690993424;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P8wvIYhrHHWXcu19EWo/5hYqCsuHjFQ9V/PuFjM3iEk=;
 b=eYiZ3LVojhnYNa4RO31MGZApLmM1CBUUJp2fo0U9216ZTN198S5ZLwlY3Vl6r1eQRK
 WN9dlB9M5lcT6pEH372vU92z1BkwZ2evilHY/b+g05WS51fygDVf9VMZrU2k0/UbFoPa
 hrQrIftvQJsnICkQ01LcBiP+dpBlnrp8fhA68RxEPb9oH9hXY5TL/1SPpqPFZ5Qu2tUb
 AKSGpeDetBYuEoS9nOZhOihEKoZvlnrtA0taZcHb6aPkZ1OLagminP739uNXPW2wy2eV
 hw9MUnjr2NTktaheAdJbzPih7GDfKUHqgwhbfCfbA2BF4K3O9puoprrHtreL43Jj1gDg
 wJ6A==
X-Gm-Message-State: ABy/qLaTTticsiPDcSqMcyGm4xiuVtFAl0GlYLQxYy4pt/n/7ytoBfI4
 +DQn8FaoM3HEW7rurALBgwUz0W6LFIlBGnX44zGtT3CfXmnLNa0kW7nDYmlsCIbwBu412zuV+Q6
 tOTpm19SD1OavkmE=
X-Received: by 2002:a05:6102:50c:b0:443:5b77:dfc9 with SMTP id
 l12-20020a056102050c00b004435b77dfc9mr5205229vsa.18.1688401423985; 
 Mon, 03 Jul 2023 09:23:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF3VnH7/ORY1qiaADP2XW8Cciv/YiIWkCz2f/NTwGhukslC3MSrMgVU6fi6xRI5uYXO2tBQZw==
X-Received: by 2002:a05:6102:50c:b0:443:5b77:dfc9 with SMTP id
 l12-20020a056102050c00b004435b77dfc9mr5205217vsa.18.1688401423784; 
 Mon, 03 Jul 2023 09:23:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a0cf909000000b00636047c276csm6269716qvn.126.2023.07.03.09.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 09:23:43 -0700 (PDT)
Message-ID: <a6f961c2-803d-3979-a767-63d2e1f494c4@redhat.com>
Date: Mon, 3 Jul 2023 18:23:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 1/4] linux-headers: Update for vfio capability
 reporting AtomicOps
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, robin@streamhpc.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org
References: <20230519215739.402729-1-alex.williamson@redhat.com>
 <20230519215739.402729-2-alex.williamson@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230519215739.402729-2-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/19/23 23:57, Alex Williamson wrote:
> This is a partial linux-headers update for illustrative and testing
> purposes only, NOT FOR COMMIT.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
I am preparing a vfio-next tree including these changes plus a linux-headers
update. I am just waiting for the 6.5-rc1 tag to be pushed.

Thanks,

C.

>   linux-headers/linux/vfio.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 4a534edbdcba..443a8851e156 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -240,6 +240,20 @@ struct vfio_device_info {
>   #define VFIO_DEVICE_INFO_CAP_ZPCI_UTIL		3
>   #define VFIO_DEVICE_INFO_CAP_ZPCI_PFIP		4
>   
> +/*
> + * The following VFIO_DEVICE_INFO capability reports support for PCIe AtomicOp
> + * completion to the root bus with supported widths provided via flags.
> + */
> +#define VFIO_DEVICE_INFO_CAP_PCI_ATOMIC_COMP	5
> +struct vfio_device_info_cap_pci_atomic_comp {
> +	struct vfio_info_cap_header header;
> +	__u32 flags;
> +#define VFIO_PCI_ATOMIC_COMP32	(1 << 0)
> +#define VFIO_PCI_ATOMIC_COMP64	(1 << 1)
> +#define VFIO_PCI_ATOMIC_COMP128	(1 << 2)
> +	__u32 reserved;
> +};
> +
>   /**
>    * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
>    *				       struct vfio_region_info)


