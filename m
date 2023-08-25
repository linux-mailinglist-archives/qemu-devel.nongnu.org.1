Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 391677882C8
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 10:58:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZScv-0000j2-Gz; Fri, 25 Aug 2023 04:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mie@igel.co.jp>) id 1qZScq-0000iq-N3
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 04:57:04 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mie@igel.co.jp>) id 1qZScn-0004su-1y
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 04:57:04 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bf6ea270b2so6197885ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 01:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1692953818; x=1693558618;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PuYpZM6PXIOW+mhZVcLd16VhM2ysqwu49mtAIt5qLW4=;
 b=XJI+RgEwntTJURM5icHrckj7NF7KZ2u9/gATyKSnG6Hxh8S3Akyf7eGFrPzRpAwIWH
 pABtwf2Px48a0WSy4soAL0gEJiGf1ie8FxoD1Zp2QYzZLDgbSd/9OFMqoFxH0yTknBuy
 qkEGF44entkwssrw7dkxPlTeGY/d65Di/G5EjNlwxhYjDQhMx4Kq9Y0Q4PLJARcXYTjN
 yEjy4rKO/0Jh3zgn5iBdBliTWnonBowOWOQQqZklWgrJZ8OFh4QsKT65MBst5p4TUKoj
 o6LiBH7kW5acDNxsB5b+j2krPyKy0UXiZJlDBd5eyYYwoRqOmJ57AMXRzng/g7Qkph0K
 nsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692953818; x=1693558618;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PuYpZM6PXIOW+mhZVcLd16VhM2ysqwu49mtAIt5qLW4=;
 b=ZwR1cIHWEMJDx4riw6y39axfnVo2ESoalHL2EV0IPQZhsq0x6R4dQefct2GDmgAVUU
 8miJT/zDrTWMDvWy8fmThmkDtaQZm4DOoHLOwtOMwxjTdux00Rpcuf1gO0WZwcLlLbVs
 +83KKCKF/S4BHGsbwCbIQfjerkt6ytB63NnPz3nIKI/QzmCvTEXyYQCy77IN4rgzu1ZP
 u7cYfzhuEF8x+w7jqFii/Ks1VGNweG4tZCcwrr6aVpoiQCMHY1f6uZYZldRRV28tJTQX
 K1lOrLbKm9yO8swB3YyLGIzEnep+Me/a8jfO7d3WHUEj1//DnGkfkSTlmDaeSVEKJS3Z
 S0kQ==
X-Gm-Message-State: AOJu0YwBdrH93E5P97tvC3zgh8uiVb5Q/PD2aGbsFiguEzqDq47cdEa0
 0q8cogciap24IHe1umk/B5W2Qw==
X-Google-Smtp-Source: AGHT+IHYWcfQ7Kb+iZyOzphRNN53Hlx0lIarlId7bFcTsB0jDjAG/jIhpb7lPzAWrM0c65K2Dof5VQ==
X-Received: by 2002:a17:902:ea08:b0:1c0:a30e:2388 with SMTP id
 s8-20020a170902ea0800b001c0a30e2388mr9285190plg.31.1692953818594; 
 Fri, 25 Aug 2023 01:56:58 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a170902d68b00b001bf11cf2e21sm1117064ply.210.2023.08.25.01.56.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 01:56:58 -0700 (PDT)
Message-ID: <a24e048b-c1a2-78fe-9cd2-a5967e566a73@igel.co.jp>
Date: Fri, 25 Aug 2023 17:56:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
 <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>
References: <CANXvt5oKt=AKdqv24LT079e+6URnfqJcfTJh0ajGA17paJUEKw@mail.gmail.com>
 <20230823060923.GA3737@thinkpad>
From: Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <20230823060923.GA3737@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=mie@igel.co.jp; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-2.919, RCVD_IN_DNSWL_NONE=-0.0001,
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


On 2023/08/23 15:09, Manivannan Sadhasivam wrote:
> On Fri, Aug 18, 2023 at 10:46:02PM +0900, Shunsuke Mie wrote:
>> Hi all,
>>
>> We are proposing to add a new test syste to Linux for PCIe Endpoint. That
>> can be run on QEMU without real hardware. At present, partially we have
>> confirmed that pci-epf-test is working, but it is not yet complete.
>> However, we would appreciate your comments on the architecture design.
>>
>> # Background
>> The background is as follows.
>>
>> PCI Endpoint function driver is implemented using the PCIe Endpoint
>> framework, but it requires physical boards for testing, and it is difficult
>> to test sufficiently. In order to find bugs and hardware-dependent
>> implementations early, continuous testing is required. Since it is
>> difficult to automate tests that require hardware, this RFC proposes a
>> virtual environment for testing PCI endpoint function drivers.
>>
> This sounds exciting to me and yes, it is going to be really helpful for
> validating EP framework as a whole.
>
>> # Architecture
>> The overview of the architecture is as follows.
>>
>>    Guest 1                        Guest 2
>> +-------------------------+    +----------------------------+
>> | Linux kernel            |    | Linux kernel               |
>> |                         |    |                            |
>> | PCI EP function driver  |    |                            |
>> | (e.g. pci-epf-test)     |    |                            |
>> |-------------------------|    | PCI Device Driver          |
>> | (2) QEMU EPC Driver     |    | (e.g. pci_endpoint_test)   |
>> +-------------------------+    +----------------------------+
>> +-------------------------+    +----------------------------+
>> | QEMU                    |    | QEMU                       |
>> |-------------------------|    |----------------------------|
>> | (1) QEMU PCI EPC Device *----* (3) QEMU EPF Bridge Device |
>> +-------------------------+    +----------------------------+
>>
>> At present, it is designed to work guests only on the same host, and
>> communication is done through Unix domain sockets.
>>
>> The three parts shown in the figure were introduced this time.
>>
>> (1) QEMU PCI Endpoint Controller(EPC) Device
>> PCI Endpoint Controller implemented as QEMU PCI device.
>> (2) QEMU PCI Endpoint Controller(EPC) Driver
>> Linux kernel driver that drives the device (1). It registers a epc device
>> to linux kernel and handling each operations for the epc device.
>> (3) QEMU PCI Endpoint function(EPF) Bridge Device
>> QEMU PCI device that cooperates with (1) and performs accesses to pci
>> configuration space, BAR and memory space to communicate each guests, and
>> generates interruptions to the guest 1.
>>
> I'm not very familiar with Qemu, but why can't the existing Qemu PCIe host
> controller devices used for EP communication? I mean, what is the need for a
> dedicated EPF bridge device (3) in host? (Guest 2 as per your diagram).
>
> Is that because you use socket communication between EP and host?

At least, the part that communicates with (1) is necessary, but I don't 
know if
the current implementation is appropriate. In addition, there is a 
performance
issue, so I am currently investigating QEMU more. e.g. pci emulation, 
shared-memory, etc.

I'd like to improve and submit a next rfc.

Thanks,

Shunsuke Mie

> - Mani
>
>> Each projects are:
>> (1), (3) https://github.com/ShunsukeMie/qemu/tree/epf-bridge/v1
>> files: hw/misc/{qemu-epc.{c,h}, epf-bridge.c}
>> (2) https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc
>> files: drivers/pci/controller/pcie-qemu-ep.c
>>
>> # Protocol
>>
>> PCI, PCIe has a layer structure that includes Physical, Data Lane and
>> Transaction. The communicates between the bridge(3) and controller (1)
>> mimic the Transaction. Specifically, a protocol is implemented for
>> exchanging fd for communication protocol version check and communication,
>> in addition to the interaction equivalent to PCIe Transaction Layer Packet
>> (Read and Write of I/O, Memory, Configuration space and Message). In my
>> mind, we need to discuss the communication mor.
>>
>> We also are planning to post the patch set after the code is organized and
>> the protocol discussion is matured.
>>
>> Best regards,
>> Shunsuke

