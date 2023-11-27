Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B837F9C6D
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 10:13:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Xer-00028k-4t; Mon, 27 Nov 2023 04:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r7Xeo-00028X-0d
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 04:11:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r7Xem-0002sO-3O
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 04:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701076313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j302ZBbwFQxBJJrGISYPDX4ZHSsTteSAGmu0Rfx5AEg=;
 b=N7yF4i7GyNNXSkJrFpvoveWBliP0ADfwOeT/1wMu3fvk4G2ylU11j0dlsBF+e14+CCFaoY
 5cWZJ78nzeGsuE/2eyqcefYuSe2bb+Hx5OXMIDGdn0zU6x7LgUox9VNF5LwEdFBlgJTXnU
 hBc39SRAykO+llMqrpsE6GYUsCCfsXA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-H99qLxM1N7qYlzLvAnsIfA-1; Mon, 27 Nov 2023 04:11:51 -0500
X-MC-Unique: H99qLxM1N7qYlzLvAnsIfA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c6f3cd892cso44629181fa.3
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 01:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701076310; x=1701681110;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j302ZBbwFQxBJJrGISYPDX4ZHSsTteSAGmu0Rfx5AEg=;
 b=OEQys5J77k0EDvswArgWASnxdXMoj7WeRRpVSQBzxuvn4piQkjqKOPWBLVEfJfzcMq
 gEdI9WcjRuafqaUJURaeHvjLQJ8+y6gBv7pQkwBBl9lp9lbgN7F/8/5sf/UtfLar98+S
 Pt0bgZNmhU0hnd+IbW7tMqYmqJGI9q8L2FljSCqyWeRWKV5GVnCVF98AWJ1KoNlF+r4g
 bs2wNA9dswUc3jKyoitSB7r0zYLnVHKebWqZHTqdKBQSIywg8jAvq+Eyu0f8V8quUyxX
 miEyu5RxvqR8NeNuXV6JV29k//2LB2nZPR/5S9kdtVT8+Sq0ueRVohPgHMycRrgeJPO3
 Vxsw==
X-Gm-Message-State: AOJu0YwjgVMeL8R0MAbHLodiFyCN91ML+twZGk1RY+nYvvQWRufWC86r
 abIOr+bDJ/IwJsuWe7JoEZIEL/QLSWy4cqDvWRS44parZml0TeXMD5zdGPXTZzfV/GIPlKY6oAP
 6rSFvddppwo0gulA=
X-Received: by 2002:a05:651c:905:b0:2c9:9904:6608 with SMTP id
 e5-20020a05651c090500b002c999046608mr4574715ljq.14.1701076310550; 
 Mon, 27 Nov 2023 01:11:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGILqhPtidNYDIZR0vp4noRLPnJLjJ+6hdGU8OQLaVAgrmXz2t7bAGq1rWzVIrRaBqMxAbeEg==
X-Received: by 2002:a05:651c:905:b0:2c9:9904:6608 with SMTP id
 e5-20020a05651c090500b002c999046608mr4574701ljq.14.1701076310277; 
 Mon, 27 Nov 2023 01:11:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a05600c4e0500b003feae747ff2sm13968695wmq.35.2023.11.27.01.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 01:11:49 -0800 (PST)
Message-ID: <53966853-640a-4581-a08d-8b452afc4c2a@redhat.com>
Date: Mon, 27 Nov 2023 10:11:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pcie_sriov: Remove g_new assertion
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
References: <20231123075630.12057-1-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231123075630.12057-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 11/23/23 08:56, Akihiko Odaki wrote:
> g_new() aborts if the allocation fails so it returns NULL only if the
> requested allocation size is zero. register_vfs() makes such an
> allocation if NumVFs is zero so it should not assert that g_new()
> returns a non-NULL value.
> 
> Fixes: 7c0fa8dff8 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
> Buglink: https://issues.redhat.com/browse/RHEL-17209
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/pci/pcie_sriov.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index 5ef8950940..a1fe65f5d8 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -178,7 +178,6 @@ static void register_vfs(PCIDevice *dev)
>       num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
>   
>       dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
> -    assert(dev->exp.sriov_pf.vf);
>   
>       trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
>                                PCI_FUNC(dev->devfn), num_vfs);


