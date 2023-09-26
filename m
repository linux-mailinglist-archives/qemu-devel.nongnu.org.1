Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF8F7AE990
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 11:49:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql4fj-0002N6-S2; Tue, 26 Sep 2023 05:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mie@igel.co.jp>) id 1ql4fg-0002Mg-H3
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 05:48:00 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mie@igel.co.jp>) id 1ql4fe-0000VJ-43
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 05:48:00 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-690bccb0d8aso6276248b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 02:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1695721675; x=1696326475;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XKP3MzLWO9YF43zV3hOBWrQ0vFnkikx+qy/eqoZksLU=;
 b=2oBGhyWVd0yaop1dc5r2X+7EqpFmOqcp7mzYPVIQuKhkUA68CJvrk6QJvFOWfM9+2t
 AH1B/leHzKRT0t2qUHlx63Dk4bfHdGRcYoZmmj9pramKYlu/VJk28clE0wQC26Lo3dOH
 xDsa7IkwOyeTlA8JWc/YrYMF05Fd8J2+EbAC9+qehO2R8Jgb5u+xE0D8kqOJAoG18lz/
 JIH9x44ZUhQtD7GRaWj43PPRG8bVbxBsX6WxgUwc/4ozpaeMuTA26hrYUDbmt8S7zKLn
 ljk/ZB5r6HXmrKG9cHvX0OAOdBiZWWQy6IeSK2Y4XAbhctBdyJ/qFKfCpTtA3ATFmNKF
 sB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695721675; x=1696326475;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XKP3MzLWO9YF43zV3hOBWrQ0vFnkikx+qy/eqoZksLU=;
 b=X3hf8iLKS2w+dsTFStPqd+dFsVtusNJ6dlGQA7VC7AMtzpPgoWgN/j7SlNJFnJ1f8x
 H5X0wlM7o+3oCJXAkRKiHt/sVQ9uaapZrciA9JNdNpUSQ/3288k5HOEGMNfAzExy7Euq
 HKCmxpcgpzaNUnpl7352v8obdgV3hLKC17e6+IoPk4TXowxav6RhQU83fhWMqT+SS27V
 NC9MJokWrjenJGlBeEZSAT5Uww785mBUGY3aEsMLaNaI77vLkUOsHQxPOoTrf10waiz+
 6tPdnZtUioNux0ZNMftL8FnP13GgF9kV50Jt3TCJ8h1qmqTrCmoWAqBtTGKFkbHUF9sC
 +VCA==
X-Gm-Message-State: AOJu0Yxd8/0sc2gwW2wj5vrgZguZ/IXFitt7lSDz+rbRnwhnq/+Kifhj
 WR1Cnr4Rr2475mhlSdKIj5lZAQ==
X-Google-Smtp-Source: AGHT+IHkkACOh7dgZFFa/QbHIqytll0Y6aTqu1t2IA0bc5L6Z2iD4zYiqDdeRy5IKT8/Mkf7zM31ag==
X-Received: by 2002:a05:6a00:80b:b0:690:d48a:2acc with SMTP id
 m11-20020a056a00080b00b00690d48a2accmr9641454pfk.29.1695721675490; 
 Tue, 26 Sep 2023 02:47:55 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 l22-20020a62be16000000b0068fe9c7b199sm5641837pff.105.2023.09.26.02.47.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 02:47:55 -0700 (PDT)
Message-ID: <fe309259-01f0-871f-4620-3a4bdc56a186@igel.co.jp>
Date: Tue, 26 Sep 2023 18:47:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
To: Kishon Vijay Abraham I <kvijayab@amd.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, vaishnav.a@ti.com
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
 <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>
References: <CANXvt5oKt=AKdqv24LT079e+6URnfqJcfTJh0ajGA17paJUEKw@mail.gmail.com>
 <d096e88e-aec5-9920-8d5a-bd8200560c2c@amd.com>
Content-Language: en-US
From: Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <d096e88e-aec5-9920-8d5a-bd8200560c2c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=mie@igel.co.jp; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001,
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


On 2023/09/21 18:11, Kishon Vijay Abraham I wrote:
> +Vaishnav
>
> Hi Shunsuke,
>
> On 8/18/2023 7:16 PM, Shunsuke Mie wrote:
>> Hi all,
>>
>> We are proposing to add a new test syste to Linux for PCIe Endpoint. 
>> That
>> can be run on QEMU without real hardware. At present, partially we have
>> confirmed that pci-epf-test is working, but it is not yet complete.
>> However, we would appreciate your comments on the architecture design.
>>
>> # Background
>> The background is as follows.
>>
>> PCI Endpoint function driver is implemented using the PCIe Endpoint
>> framework, but it requires physical boards for testing, and it is 
>> difficult
>> to test sufficiently. In order to find bugs and hardware-dependent
>> implementations early, continuous testing is required. Since it is
>> difficult to automate tests that require hardware, this RFC proposes a
>> virtual environment for testing PCI endpoint function drivers.
>
> This would be quite useful and thank you for attempting it! I would 
> like to compare other mechanisms available in-addition to QEMU before 
> going with the QEMU approach.

I got it. I'll make a table to compare some methods that includes 
greybus to realize this emulation environment.


Best,

Shunsuke

> Though I don't understand this fully, Looking at 
> https://osseu2023.sched.com/event/1OGk8/emulating-devices-in-linux-using-greybus-subsystem-vaishnav-mohandas-achath-texas-instruments, 
> Vaishnav seems to solve the same problem using greybus for multiple 
> type s of devices.
>
> Vaishnav, we'd wait for your OSS presentation but do you have any 
> initial thoughts on how greybus could be used to test PCIe endpoint 
> drivers?
>
> Thanks,
> Kishon
>
>>
>> # Architecture
>> The overview of the architecture is as follows.
>>
>>    Guest 1                        Guest 2
>> +-------------------------+    +----------------------------+
>> | Linux kernel            |    | Linux kernel               |
>> |                         |    |                            |
>> | PCI EP function driver  |    |                            |
>> | (e.g. pci-epf-test)     |    |                            |
>> |-------------------------|    | PCI Device Driver          |
>> | (2) QEMU EPC Driver     |    | (e.g. pci_endpoint_test)   |
>> +-------------------------+    +----------------------------+
>> +-------------------------+    +----------------------------+
>> | QEMU                    |    | QEMU                       |
>> |-------------------------|    |----------------------------|
>> | (1) QEMU PCI EPC Device *----* (3) QEMU EPF Bridge Device |
>> +-------------------------+    +----------------------------+
>>
>> At present, it is designed to work guests only on the same host, and
>> communication is done through Unix domain sockets.
>>
>> The three parts shown in the figure were introduced this time.
>>
>> (1) QEMU PCI Endpoint Controller(EPC) Device
>> PCI Endpoint Controller implemented as QEMU PCI device.
>> (2) QEMU PCI Endpoint Controller(EPC) Driver
>> Linux kernel driver that drives the device (1). It registers a epc 
>> device
>> to linux kernel and handling each operations for the epc device.
>> (3) QEMU PCI Endpoint function(EPF) Bridge Device
>> QEMU PCI device that cooperates with (1) and performs accesses to pci
>> configuration space, BAR and memory space to communicate each guests, 
>> and
>> generates interruptions to the guest 1.
>>
>> Each projects are:
>> (1), (3) https://github.com/ShunsukeMie/qemu/tree/epf-bridge/v1 
>> <https://github.com/ShunsukeMie/qemu/tree/epf-bridge/v1>
>> files: hw/misc/{qemu-epc.{c,h}, epf-bridge.c}
>> (2) https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc 
>> <https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc>
>> files: drivers/pci/controller/pcie-qemu-ep.c
>>
>> # Protocol
>>
>> PCI, PCIe has a layer structure that includes Physical, Data Lane and
>> Transaction. The communicates between the bridge(3) and controller (1)
>> mimic the Transaction. Specifically, a protocol is implemented for
>> exchanging fd for communication protocol version check and 
>> communication,
>> in addition to the interaction equivalent to PCIe Transaction Layer 
>> Packet
>> (Read and Write of I/O, Memory, Configuration space and Message). In my
>> mind, we need to discuss the communication mor.
>>
>> We also are planning to post the patch set after the code is 
>> organized and
>> the protocol discussion is matured.
>>
>> Best regards,
>> Shunsuke

