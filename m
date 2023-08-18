Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCBF780DA5
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:12:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX06n-00061P-JN; Fri, 18 Aug 2023 10:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mie@igel.co.jp>) id 1qWznv-0000Xj-VE
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 09:46:20 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mie@igel.co.jp>) id 1qWzns-0005lm-Hr
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 09:46:19 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-79a83720538so315045241.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1692366374; x=1692971174;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qTJJ4oN9U5Xs61LudGMkqKYXKm9gkPCJTChWfj4Sd7E=;
 b=USCgcG66Tyx3JAzU78vvYWrLcFvA3MOR1maNHH/hm3wMy6WNXpM8FkEJyw8mX6RYW+
 v6BVln/IP5P9gfwe8/11ldpEagzb9ToVkTjp6fHW4AgHjiTPUx9qkS+I8CCm7n3JXaa1
 PXjdxTgIWenNS5Fi/m4E2vknfxCYV+RXKIkvvcRQA3imOGgZVMGwuhSjj4rL4pnsV4/n
 qIMn/AF+rFtHDm34ASbPzX68dgYEdPvGab4y9hc0pZ560tepegaYyeNfeQt39T+U06gU
 VxacKskeEb78FIOs29uBd/SKjy+NaXDmdiuQ+9ymzzrUmgSePmqJHvAr/Lvkgx2uF1zb
 8gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692366374; x=1692971174;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qTJJ4oN9U5Xs61LudGMkqKYXKm9gkPCJTChWfj4Sd7E=;
 b=CaNUKvYYQm4aY5NXPkUv3bxUc1Kc6MgFOVviymOHQVmS/GGkF2kc8tPb6MPIXh/mPa
 eH+SnL1HDfBd1HaHeFnuQYqZxhJIQ4anrC5C0eVeYxU3Kx+RWxcDlUpJmRkb21r7+vnF
 QdRPH0/ac+Od7tJS09004nwezu1Db77bHq/rdYxuLDkqhaqENiy7JFEkmYuLtY17zb7j
 X8ffCcwagVicMabPAL6ADB67PnFNvHgWIz8DEcOHRT9P1M95eyuR2RDW5QisdVRglK7v
 CF+D8FwmQl6Qx8C/G230YtzDQQ5H+ZksfWBFYtuWN9M2jg2qnMIuPtKCUzYBSItmF1qr
 wpuw==
X-Gm-Message-State: AOJu0YwnqIExQsXq+0BLZSnwI/Dw1m6b2iliVZL+rLeGJzLO0gDLVGMz
 f9q7QxSRUdYgVbDWB9d0beK3+/K1rRmAMU5eLOGVOw==
X-Google-Smtp-Source: AGHT+IEG9LwdNeV75BjeD2AdfxnKmAUNwvWkF4JsJA8wH8EU8MtVlYK0uEMtHLQEGB2hfCJe0VPy2XQl5XQGswZG9Cs=
X-Received: by 2002:a67:f7d9:0:b0:447:48ab:cfeb with SMTP id
 a25-20020a67f7d9000000b0044748abcfebmr3333650vsp.11.1692366373940; Fri, 18
 Aug 2023 06:46:13 -0700 (PDT)
MIME-Version: 1.0
From: Shunsuke Mie <mie@igel.co.jp>
Date: Fri, 18 Aug 2023 22:46:02 +0900
Message-ID: <CANXvt5oKt=AKdqv24LT079e+6URnfqJcfTJh0ajGA17paJUEKw@mail.gmail.com>
Subject: [RFC] Proposal of QEMU PCI Endpoint test environment
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 qemu-devel@nongnu.org, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Content-Type: multipart/alternative; boundary="0000000000008c861c060332c034"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=mie@igel.co.jp; helo=mail-ua1-x92d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 18 Aug 2023 10:05:28 -0400
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

--0000000000008c861c060332c034
Content-Type: text/plain; charset="UTF-8"

Hi all,

We are proposing to add a new test syste to Linux for PCIe Endpoint. That
can be run on QEMU without real hardware. At present, partially we have
confirmed that pci-epf-test is working, but it is not yet complete.
However, we would appreciate your comments on the architecture design.

# Background
The background is as follows.

PCI Endpoint function driver is implemented using the PCIe Endpoint
framework, but it requires physical boards for testing, and it is difficult
to test sufficiently. In order to find bugs and hardware-dependent
implementations early, continuous testing is required. Since it is
difficult to automate tests that require hardware, this RFC proposes a
virtual environment for testing PCI endpoint function drivers.

# Architecture
The overview of the architecture is as follows.

  Guest 1                        Guest 2
+-------------------------+    +----------------------------+
| Linux kernel            |    | Linux kernel               |
|                         |    |                            |
| PCI EP function driver  |    |                            |
| (e.g. pci-epf-test)     |    |                            |
|-------------------------|    | PCI Device Driver          |
| (2) QEMU EPC Driver     |    | (e.g. pci_endpoint_test)   |
+-------------------------+    +----------------------------+
+-------------------------+    +----------------------------+
| QEMU                    |    | QEMU                       |
|-------------------------|    |----------------------------|
| (1) QEMU PCI EPC Device *----* (3) QEMU EPF Bridge Device |
+-------------------------+    +----------------------------+

At present, it is designed to work guests only on the same host, and
communication is done through Unix domain sockets.

The three parts shown in the figure were introduced this time.

(1) QEMU PCI Endpoint Controller(EPC) Device
PCI Endpoint Controller implemented as QEMU PCI device.
(2) QEMU PCI Endpoint Controller(EPC) Driver
Linux kernel driver that drives the device (1). It registers a epc device
to linux kernel and handling each operations for the epc device.
(3) QEMU PCI Endpoint function(EPF) Bridge Device
QEMU PCI device that cooperates with (1) and performs accesses to pci
configuration space, BAR and memory space to communicate each guests, and
generates interruptions to the guest 1.

Each projects are:
(1), (3) https://github.com/ShunsukeMie/qemu/tree/epf-bridge/v1
files: hw/misc/{qemu-epc.{c,h}, epf-bridge.c}
(2) https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc
files: drivers/pci/controller/pcie-qemu-ep.c

# Protocol

PCI, PCIe has a layer structure that includes Physical, Data Lane and
Transaction. The communicates between the bridge(3) and controller (1)
mimic the Transaction. Specifically, a protocol is implemented for
exchanging fd for communication protocol version check and communication,
in addition to the interaction equivalent to PCIe Transaction Layer Packet
(Read and Write of I/O, Memory, Configuration space and Message). In my
mind, we need to discuss the communication mor.

We also are planning to post the patch set after the code is organized and
the protocol discussion is matured.

Best regards,
Shunsuke

--0000000000008c861c060332c034
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br><br>We are proposing to add a new test syste to=
 Linux for PCIe Endpoint. That<br>can be run on QEMU without real hardware.=
 At present, partially we have<br>confirmed that pci-epf-test is working, b=
ut it is not yet complete.<br>However, we would appreciate your comments on=
 the architecture design.<br><br># Background<br>The background is as follo=
ws.<br><br>PCI Endpoint function driver is implemented using the PCIe Endpo=
int<br>framework, but it requires physical boards for testing, and it is di=
fficult<br>to test sufficiently. In order to find bugs and hardware-depende=
nt<br>implementations early, continuous testing is required. Since it is<br=
>difficult to automate tests that require hardware, this RFC proposes a<br>=
virtual environment for testing PCI endpoint function drivers.<br><br># Arc=
hitecture<br>The overview of the architecture is as follows.<br><br>=C2=A0 =
Guest 1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Guest 2<br>+-------------------------+ =C2=A0 =C2=A0+-----=
-----------------------+<br>| Linux kernel =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 =C2=A0| Linux kernel=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|<br>| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|<br>| PCI EP function driver =C2=A0| =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|<br>| (e.g. pci-epf-test) =C2=A0 =C2=A0 | =C2=A0 =C2=A0| =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|<br>|-------------------------| =C2=A0 =C2=A0| PCI Device Dri=
ver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>| (2) QEMU EPC Driver =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0| (e.g. pci_endpoint_test) =C2=A0 |<br>+----------------=
---------+ =C2=A0 =C2=A0+----------------------------+<br>+----------------=
---------+ =C2=A0 =C2=A0+----------------------------+<br>| QEMU =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0|=
 QEMU =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |<br>|-------------------------| =C2=A0 =C2=A0|--------------------=
--------|<br>| (1) QEMU PCI EPC Device *----* (3) QEMU EPF Bridge Device |<=
br>+-------------------------+ =C2=A0 =C2=A0+----------------------------+<=
br><br>At present, it is designed to work guests only on the same host, and=
<br>communication is done through Unix domain sockets.<br><br>The three par=
ts shown in the figure were introduced this time.<br><br>(1) QEMU PCI Endpo=
int Controller(EPC) Device<br>PCI Endpoint Controller implemented as QEMU P=
CI device.<br>(2) QEMU PCI Endpoint Controller(EPC) Driver<br>Linux kernel =
driver that drives the device (1). It registers a epc device<br>to linux ke=
rnel and handling each operations for the epc device.<br>(3) QEMU PCI Endpo=
int function(EPF) Bridge Device<br>QEMU PCI device that cooperates with (1)=
 and performs accesses to pci<br>configuration space, BAR and memory space =
to communicate each guests, and<br>generates interruptions to the guest 1.<=
br><br>Each projects are:<br>(1), (3) <a href=3D"https://github.com/Shunsuk=
eMie/qemu/tree/epf-bridge/v1">https://github.com/ShunsukeMie/qemu/tree/epf-=
bridge/v1</a><br>files: hw/misc/{qemu-epc.{c,h}, epf-bridge.c}<br>(2) <a hr=
ef=3D"https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc">https=
://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc</a><br>files: dri=
vers/pci/controller/pcie-qemu-ep.c<br><br># Protocol<br><br>PCI, PCIe has a=
 layer structure that includes Physical, Data Lane and<br>Transaction. The =
communicates between the bridge(3) and controller (1)<br>mimic the Transact=
ion. Specifically, a protocol is implemented for<br>exchanging fd for commu=
nication protocol version check and communication,<br>in addition to the in=
teraction equivalent to PCIe Transaction Layer Packet<br>(Read and Write of=
 I/O, Memory, Configuration space and Message). In my<br>mind, we need to d=
iscuss the communication mor.<br><br>We also are planning to post the patch=
 set after the code is organized and<br>the protocol discussion is matured.=
<br><br>Best regards,<br>Shunsuke<br></div>

--0000000000008c861c060332c034--

