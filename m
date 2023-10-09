Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 016A67BDAA0
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 14:04:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpoyc-0002vw-In; Mon, 09 Oct 2023 08:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qpoyR-0002qy-A2
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:03:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qpoyJ-0006cy-9p
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696852970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pUwhWc3FpVAzAcwD8P3CxCpQ9BklIsWaDkwIVOEn9pU=;
 b=ay8bW4xxPgtaJPIRD+awsB6KWjyQbaJsL0BGC/qpkYkbofn23LxyYUTg83xC/awUrFq1wm
 rsXrQDzRETtELSZaOFKsz9gw9BiA5F8y6xDZh54goPfFsIAu/dODTBoZP6m3HECf24ZWEn
 OANrY5hTkw87g98L8YseRXmXXFIXdCg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-p1oJxtZPPwmDsksICxtHfg-1; Mon, 09 Oct 2023 08:02:48 -0400
X-MC-Unique: p1oJxtZPPwmDsksICxtHfg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-774105e8c7fso561427885a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 05:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696852967; x=1697457767;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pUwhWc3FpVAzAcwD8P3CxCpQ9BklIsWaDkwIVOEn9pU=;
 b=E6e2fgzAWqAHeSHua2jfdgiFSgOPqLAY3njNZpd7RgyELcTN4Km5XIs+mao7+mAc7u
 ueJLjzIaQ3le2IgkiPQQlpzr1Iz6Qkz1AEpj0uEW+0C3v1fbhVnNP4Tfay4bTaZAC4mk
 VdFNMyva5A0hJ+lZgA+RE92IZI4xzs5OVHflJS8Xb1LGUWJkm1wiQ+elHT0Z6CGSG4ma
 y5NTdtTpONzm+y6d/765AVO2sfZ+MFkfSo7Oz962w4u9w506Sp2dgSpcMur6KcAp49bw
 dJaWNqig72g2JBkcu6UzhQLHq6KCZAj/7+hPcc9nn2u37cq/1Zhxc27PC03aSjaThdnH
 9mdQ==
X-Gm-Message-State: AOJu0YwSehn61CGgRG4S4WTQSoLbWXr4cEcGJpPts64YEC2EReFz7F/V
 +6pkigWE6+DSc5NRVO8IhsDXBgAS+bX0V8zHSIEVmSIsaWI6PYKohvS9b/jbKMtSXQY4fwmZGnd
 yCmq9d9Ct1qdVlyLbsQzIgi4=
X-Received: by 2002:a37:ac01:0:b0:774:1641:d60f with SMTP id
 e1-20020a37ac01000000b007741641d60fmr16437543qkm.41.1696852967178; 
 Mon, 09 Oct 2023 05:02:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfBx/TKNOkDoHmH17kgZUFbr1G4XVpd/t1I257iUdLGG+KvkfdZVELGh2HM0IseYMkhufKTg==
X-Received: by 2002:a37:ac01:0:b0:774:1641:d60f with SMTP id
 e1-20020a37ac01000000b007741641d60fmr16437511qkm.41.1696852966782; 
 Mon, 09 Oct 2023 05:02:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 f26-20020a05620a12fa00b007758aad4b64sm3466944qkl.9.2023.10.09.05.02.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 05:02:46 -0700 (PDT)
Message-ID: <5c772303-ccbd-7b58-1da2-ba41fcae6d3a@redhat.com>
Date: Mon, 9 Oct 2023 14:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: vIOMMU - PCI pass through to Layer 2 VMs (Nested Virtualization)
Content-Language: en-US
To: Markus Frank <m.frank@proxmox.com>, qemu-devel@nongnu.org
References: <d969606d-79bf-4ba1-849a-f2e819aaf274@proxmox.com>
 <278fd0fd-a81d-6da5-e903-71f002e17ab5@redhat.com>
 <7a056242-6d7a-4ebc-8bc4-e75dcd8ebdc7@proxmox.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <7a056242-6d7a-4ebc-8bc4-e75dcd8ebdc7@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
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

Hi,
On 10/9/23 12:25, Markus Frank wrote:
> Hi Eric,
> 
> thanks for the quick answer.
> 
> On 10/9/23 11:29, Eric Auger wrote:
>> Hi Markus,
>>
>> On 10/9/23 09:06, Markus Frank wrote:
>>> Hello,
>>>
>>> I have already sent this email to qemu-discuss but I did not get a
>>> reply.
>>> https://lists.nongnu.org/archive/html/qemu-discuss/2023-09/msg00034.html
>>> Maybe someone here could help me and reply to this email or the one on
>>> qemu-discuss?
>>>
>>> I would like to pass through PCI devices to Layer-2 VMs via Nested
>>> Virtualization.
>>>
>>> Is there current documentation for this topic somewhere?
>>>
>>> I used these parameters:
>>> -machine ...,kernel-irqchip=split
>>> -device intel-iommu
>>>
>>> With these parameters PCI pass through to L2-VMs worked fine.
>>>
>>>
>>> Now I come to the part where I get confused.
>>>
>>> https://wiki.qemu.org/Features/VT-d#With_Virtio_Devices
>>> Is this documentation relevant for PCI pass through? Do I need DMAR for
>>> virtio devices?
>> If you just want the host assigned devices to be protected by the
>> viommu, you don't need to add iommu_platform=on along with the
>> virtio-pci device>>
>>> And there is also the virtio-iommu device where I also could use the
>>> i440fx chipset.
>>> https://michael2012z.medium.com/virtio-iommu-789369049443
>>
>> you can use virtio-iommu with q35 machine.
> Yes I know. I meant that intel-iommu does not support i440fx and
> virtio-iommu does.

>>>
>>> When adding "-device virtio-iommu-pci" pci pass through also works
>>> but I get "kvm: virtio_iommu_translate no mapping for 0x1002030f000 for
>>> sid=240"
>>> when starting qemu. What could that mean?
>> Normally you shouldn't get any such error. This means there is no
>> mapping programmed by the iommu-driver for this requester id (0x240) and
>> this iova=0x1002030f000. But if I understand correctly this does not
>> prevent your device from working, correct?
> Yes. I didn't notice any problems. How could I find out what the
> requester id 0x240 refers to?
on your guest issue lspci and look at the end points BDF that matches
0x240.
>>>
>>> What do these parameters
>>> "disable-legacy=on,disable-modern=off,iommu_platform=on,ats=on"
>>> actually do? When do I need them and on which virtio devices?
>> you need them if you want your virtio devices to be protected by the
>> viommu. Otherwise the viommu is bypassed.
> Okay, so iommu_platform=on is more of a decision you should make per
> virtio-pci device.
> So simplified the advantage is more isolation and the disadvantage is
> less performance?
yes setting iommu_platform forces the driver to use the DMA API.

Eric
>>>
>>> And which device should I rather use: virtio-iommu or intel-iommu?
>> Both should be working. virtio-iommu is more recent and less used in
>> production than intel-iommu though.
>>
>> Thanks
>>
>> Eric
>>>
>>> Thanks in advance,
>>> Markus
>>>
>>>
>>
>>
> 


