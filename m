Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD797BD70C
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:30:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmac-0003J3-LE; Mon, 09 Oct 2023 05:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qpmaQ-0003IW-4v
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:30:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qpmaI-0002Ko-Kx
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696843792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z8v6oUB9R0ut9RCLkxUxysZibQ9n9Oodas9HRKEGuEg=;
 b=Y5pUQFvjeDQDsqsJ06UsMrf6Cqae1zGfiyibQ8rT9D9CzaF+64nL2tuHc+GE7iiWHhLNNX
 MUXpPbwTVqurlSu6aV89xs0iT6DI3Z9Fl0jRbA9AnNzSKqTuflJsogEAT0rD1v69y6Da3B
 WDsNoi9+wHj26dxr+kV5ShCQQAsON3M=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-laeMiuoTO8CDx5JkdmYHTA-1; Mon, 09 Oct 2023 05:29:41 -0400
X-MC-Unique: laeMiuoTO8CDx5JkdmYHTA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-77576c78c11so518217085a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696843780; x=1697448580;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8v6oUB9R0ut9RCLkxUxysZibQ9n9Oodas9HRKEGuEg=;
 b=OwnGHGN9YlqnzlMmCLik5Jn5vUSktiA7EgulWK1LYxt133u8NbTCeNpVR7BD+c7oTK
 89SunTNRm0YkOvWUB+5IiS7yrwXu2T/CHCRSzYjXnE04aKjKYscJXLqcIRHKx70kv7WR
 HYf6TcyyUMZgEkOjp/59zYm5wZEnV0WDSX/0UH4W6H/XH9aU50yBXt8poJU5Omzh8NFR
 a5fQEcVp1aglf7M9aGpCtFW+AJhJN7XN35XfmHdvzyoVmghGPtDcj10RzZ5aukj+Gtmt
 bELx62ovFOK74UwJhyFknSYTkeva7ZsA1LOe0xR/bp+6jAL6k4JCDfRKWQqjQ0+Shd6v
 4XcA==
X-Gm-Message-State: AOJu0YwUCb37sDc6ZNtFVZcaxokNxwQMB1jKYn4mStcqh2W6lM4lSSaS
 Oov6HcuFskWQwqcze+yVgSKDUiuVQEnSX9uqR6PI3wz1m4uJKSSstk35fevUjcGaM8/+ZO2FUv8
 dtZMbAyUNA49FU1vkQRd67Iw=
X-Received: by 2002:a05:620a:47b6:b0:765:9391:13e7 with SMTP id
 dt54-20020a05620a47b600b00765939113e7mr14571094qkb.49.1696843780089; 
 Mon, 09 Oct 2023 02:29:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD33pSrCNhMAbgbEP/3l2jCsKlFn8MXdUK8XMB2Kq05ZlhAyE5GSRanENg4DyeGqXGa1ex2A==
X-Received: by 2002:a05:620a:47b6:b0:765:9391:13e7 with SMTP id
 dt54-20020a05620a47b600b00765939113e7mr14571087qkb.49.1696843779734; 
 Mon, 09 Oct 2023 02:29:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d2-20020a05620a158200b00767d4a3f4d9sm3400675qkk.29.2023.10.09.02.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 02:29:39 -0700 (PDT)
Message-ID: <278fd0fd-a81d-6da5-e903-71f002e17ab5@redhat.com>
Date: Mon, 9 Oct 2023 11:29:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: vIOMMU - PCI pass through to Layer 2 VMs (Nested Virtualization)
Content-Language: en-US
To: Markus Frank <m.frank@proxmox.com>, qemu-devel@nongnu.org
References: <d969606d-79bf-4ba1-849a-f2e819aaf274@proxmox.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <d969606d-79bf-4ba1-849a-f2e819aaf274@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Markus,

On 10/9/23 09:06, Markus Frank wrote:
> Hello,
> 
> I have already sent this email to qemu-discuss but I did not get a reply.
> https://lists.nongnu.org/archive/html/qemu-discuss/2023-09/msg00034.html
> Maybe someone here could help me and reply to this email or the one on
> qemu-discuss?
> 
> I would like to pass through PCI devices to Layer-2 VMs via Nested
> Virtualization.
> 
> Is there current documentation for this topic somewhere?
> 
> I used these parameters:
> -machine ...,kernel-irqchip=split
> -device intel-iommu
> 
> With these parameters PCI pass through to L2-VMs worked fine.
> 
> 
> Now I come to the part where I get confused.
> 
> https://wiki.qemu.org/Features/VT-d#With_Virtio_Devices
> Is this documentation relevant for PCI pass through? Do I need DMAR for
> virtio devices?
If you just want the host assigned devices to be protected by the
viommu, you don't need to add iommu_platform=on along with the
virtio-pci devices.
> 
> And there is also the virtio-iommu device where I also could use the
> i440fx chipset.
> https://michael2012z.medium.com/virtio-iommu-789369049443

you can use virtio-iommu with q35 machine.
> 
> When adding "-device virtio-iommu-pci" pci pass through also works
> but I get "kvm: virtio_iommu_translate no mapping for 0x1002030f000 for
> sid=240"
> when starting qemu. What could that mean?
Normally you shouldn't get any such error. This means there is no
mapping programmed by the iommu-driver for this requester id (0x240) and
this iova=0x1002030f000. But if I understand correctly this does not
prevent your device from working, correct?
> 
> What do these parameters
> "disable-legacy=on,disable-modern=off,iommu_platform=on,ats=on"
> actually do? When do I need them and on which virtio devices?
you need them if you want your virtio devices to be protected by the
viommu. Otherwise the viommu is bypassed.
> 
> And which device should I rather use: virtio-iommu or intel-iommu?
Both should be working. virtio-iommu is more recent and less used in
production than intel-iommu though.

Thanks

Eric
> 
> Thanks in advance,
> Markus
> 
> 


