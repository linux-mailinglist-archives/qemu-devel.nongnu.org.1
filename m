Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3CC78580D
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 14:50:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYnIo-0004d6-U9; Wed, 23 Aug 2023 08:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manivannan.sadhasivam@linaro.org>)
 id 1qYh3f-0000dX-Up
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 02:09:35 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manivannan.sadhasivam@linaro.org>)
 id 1qYh3d-0002Ij-W2
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 02:09:35 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68a440a8a20so2654730b3a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 23:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692770972; x=1693375772;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ATCAJFKLfXtFZZdNcoAUWUHorxMWbDxPKwz1+kw/lXs=;
 b=MkLvLUTXO6ji+Qy81/ecWrUNnY1eSV1MmWmdRR/VOmrpaaX5ZVB00vssu2ioH0B27u
 xDKW3lj4TVgqxS511cYVxqqFL4JcOn8WoCO86wtjzl6pqddMh9S7n6kzADk9aONZc7h8
 gSCQU3CgPDaktkuM4S8vwPXehbQ0OMnU/g3uwYceIl8osAghgVlT5tKJQ42CBQr2rr0R
 VNdAtwDjriYLSjN69wUYxw9k/RzDcQPrPY9U8yWJhwHr5HM87gpreiXzs8Afp42vpTPQ
 WL0q4qv6T0kvW5kcXffVbPfonD72MNg9IVyUb616azDK8k3mr1c9N5RU1TC73AURVwb3
 TbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692770972; x=1693375772;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ATCAJFKLfXtFZZdNcoAUWUHorxMWbDxPKwz1+kw/lXs=;
 b=bSWeFZnhWavvNpbuPJ+S2vOItkSp6MzHMLoIYZC6MFFz4NbWUxIBf82EcvwS9QhQ7L
 O/RfL9Ip6lq6Ay70ksvnIctDQxMTuNO0znsHnKX9Iwh3+r4SG2n6Is2H3bk4oN0ZhT1V
 DZQBSDww7J8n0dK1IT0bJO/jqMS2aogWoiGjfU0CPeCZmKAm0jZ+pGDkajiD7wUYk1I1
 Qx3neGoVP94UOGlYqxEc74TQYuEXyY+hckK8xB4UaCjlDrgHzQaWZu3ivzQfQYxVp504
 bJV7DxqCqOnnAjGlsHwcfUP3sSxnr33n2qyGwzL9fJ7HNvdKw+vwQ2mn8oGzp4LohXmq
 Kq1w==
X-Gm-Message-State: AOJu0YyGLYXTOkJw21nRIJIf3seL0fYwdwvC3SAdVp6HwC3gRUmqrPG5
 IV3PPlJJwTLcuB0Hm0M1Sqv7
X-Google-Smtp-Source: AGHT+IG5ljrBsC2BjV14MxK8/e1gQvN4DhIyk6RWM1LXLp9afKRPfKEpYyhvKdWXhWmi9bbecOklIA==
X-Received: by 2002:a05:6a00:15d4:b0:68b:e29c:b62 with SMTP id
 o20-20020a056a0015d400b0068be29c0b62mr73350pfu.28.1692770972051; 
 Tue, 22 Aug 2023 23:09:32 -0700 (PDT)
Received: from thinkpad ([117.206.119.53]) by smtp.gmail.com with ESMTPSA id
 v24-20020a62a518000000b0064d47cd116esm2785771pfm.161.2023.08.22.23.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 23:09:31 -0700 (PDT)
Date: Wed, 23 Aug 2023 11:39:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shunsuke Mie <mie@igel.co.jp>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
Message-ID: <20230823060923.GA3737@thinkpad>
References: <CANXvt5oKt=AKdqv24LT079e+6URnfqJcfTJh0ajGA17paJUEKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXvt5oKt=AKdqv24LT079e+6URnfqJcfTJh0ajGA17paJUEKw@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=manivannan.sadhasivam@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 23 Aug 2023 08:49:36 -0400
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

On Fri, Aug 18, 2023 at 10:46:02PM +0900, Shunsuke Mie wrote:
> Hi all,
> 
> We are proposing to add a new test syste to Linux for PCIe Endpoint. That
> can be run on QEMU without real hardware. At present, partially we have
> confirmed that pci-epf-test is working, but it is not yet complete.
> However, we would appreciate your comments on the architecture design.
> 
> # Background
> The background is as follows.
> 
> PCI Endpoint function driver is implemented using the PCIe Endpoint
> framework, but it requires physical boards for testing, and it is difficult
> to test sufficiently. In order to find bugs and hardware-dependent
> implementations early, continuous testing is required. Since it is
> difficult to automate tests that require hardware, this RFC proposes a
> virtual environment for testing PCI endpoint function drivers.
> 

This sounds exciting to me and yes, it is going to be really helpful for
validating EP framework as a whole.

> # Architecture
> The overview of the architecture is as follows.
> 
>   Guest 1                        Guest 2
> +-------------------------+    +----------------------------+
> | Linux kernel            |    | Linux kernel               |
> |                         |    |                            |
> | PCI EP function driver  |    |                            |
> | (e.g. pci-epf-test)     |    |                            |
> |-------------------------|    | PCI Device Driver          |
> | (2) QEMU EPC Driver     |    | (e.g. pci_endpoint_test)   |
> +-------------------------+    +----------------------------+
> +-------------------------+    +----------------------------+
> | QEMU                    |    | QEMU                       |
> |-------------------------|    |----------------------------|
> | (1) QEMU PCI EPC Device *----* (3) QEMU EPF Bridge Device |
> +-------------------------+    +----------------------------+
> 
> At present, it is designed to work guests only on the same host, and
> communication is done through Unix domain sockets.
> 
> The three parts shown in the figure were introduced this time.
> 
> (1) QEMU PCI Endpoint Controller(EPC) Device
> PCI Endpoint Controller implemented as QEMU PCI device.
> (2) QEMU PCI Endpoint Controller(EPC) Driver
> Linux kernel driver that drives the device (1). It registers a epc device
> to linux kernel and handling each operations for the epc device.
> (3) QEMU PCI Endpoint function(EPF) Bridge Device
> QEMU PCI device that cooperates with (1) and performs accesses to pci
> configuration space, BAR and memory space to communicate each guests, and
> generates interruptions to the guest 1.
> 

I'm not very familiar with Qemu, but why can't the existing Qemu PCIe host
controller devices used for EP communication? I mean, what is the need for a
dedicated EPF bridge device (3) in host? (Guest 2 as per your diagram).

Is that because you use socket communication between EP and host?

- Mani

> Each projects are:
> (1), (3) https://github.com/ShunsukeMie/qemu/tree/epf-bridge/v1
> files: hw/misc/{qemu-epc.{c,h}, epf-bridge.c}
> (2) https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc
> files: drivers/pci/controller/pcie-qemu-ep.c
> 
> # Protocol
> 
> PCI, PCIe has a layer structure that includes Physical, Data Lane and
> Transaction. The communicates between the bridge(3) and controller (1)
> mimic the Transaction. Specifically, a protocol is implemented for
> exchanging fd for communication protocol version check and communication,
> in addition to the interaction equivalent to PCIe Transaction Layer Packet
> (Read and Write of I/O, Memory, Configuration space and Message). In my
> mind, we need to discuss the communication mor.
> 
> We also are planning to post the patch set after the code is organized and
> the protocol discussion is matured.
> 
> Best regards,
> Shunsuke

-- 
மணிவண்ணன் சதாசிவம்

