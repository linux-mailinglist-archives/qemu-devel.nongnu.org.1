Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A627B6DEC
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 18:03:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnhpn-0007Ll-Vr; Tue, 03 Oct 2023 12:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Cj2E=FR=gmail.com=cz172638@kernel.org>)
 id 1qngRB-0005yn-VC
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:31:49 -0400
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Cj2E=FR=gmail.com=cz172638@kernel.org>)
 id 1qngR5-0007cK-RK
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:31:49 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id AC9E6B81A32;
 Tue,  3 Oct 2023 14:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD7EC433C8;
 Tue,  3 Oct 2023 14:31:26 +0000 (UTC)
Date: Tue, 3 Oct 2023 16:31:23 +0200
From: Jiri Kastner <cz172638@gmail.com>
To: Shunsuke Mie <mie@igel.co.jp>
Cc: Vaishnav Achath <vaishnav.a@ti.com>,
 Kishon Vijay Abraham I <kvijayab@amd.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <levon@movementarian.org>,
 William Henderson <william.henderson@nutanix.com>
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
Message-ID: <20231003143123.esavo6i6pq7ian3h@seskpc0236u.linux.cat.com>
References: <CANXvt5oKt=AKdqv24LT079e+6URnfqJcfTJh0ajGA17paJUEKw@mail.gmail.com>
 <d096e88e-aec5-9920-8d5a-bd8200560c2c@amd.com>
 <fe309259-01f0-871f-4620-3a4bdc56a186@igel.co.jp>
 <1269bf62-d67f-9f61-0139-dc20d23a9b5e@ti.com>
 <61d82a6b-ab8a-06cc-9514-0baac736f92f@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61d82a6b-ab8a-06cc-9514-0baac736f92f@igel.co.jp>
Received-SPF: pass client-ip=145.40.68.75;
 envelope-from=SRS0=Cj2E=FR=gmail.com=cz172638@kernel.org;
 helo=ams.source.kernel.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, NML_ADSP_CUSTOM_MED=0.9,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Oct 2023 12:01:14 -0400
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

hi shunsuke, all,
what about vfio-user + qemu?

qemu already has libvfio-user as submodule.
there is ongoing work to add qemu vfio-user client functionality.

adding people involved to loop, not sure if i forgot somebody.

regards
jiri

On Tue, Oct 03, 2023 at 01:56:03PM +0900, Shunsuke Mie wrote:
> Hi Vaishnav,
> 
> On 2023/09/26 21:40, Vaishnav Achath wrote:
> > Hi Kishon, all,
> > 
> > On 26/09/23 15:17, Shunsuke Mie wrote:
> > > On 2023/09/21 18:11, Kishon Vijay Abraham I wrote:
> > > > +Vaishnav
> > > > 
> > > > Hi Shunsuke,
> > > > 
> > > > On 8/18/2023 7:16 PM, Shunsuke Mie wrote:
> > > > > Hi all,
> > > > > 
> > > > > We are proposing to add a new test syste to Linux for PCIe Endpoint. That
> > > > > can be run on QEMU without real hardware. At present, partially we have
> > > > > confirmed that pci-epf-test is working, but it is not yet complete.
> > > > > However, we would appreciate your comments on the architecture design.
> > > > > 
> > > > > # Background
> > > > > The background is as follows.
> > > > > 
> > > > > PCI Endpoint function driver is implemented using the PCIe Endpoint
> > > > > framework, but it requires physical boards for testing, and it is difficult
> > > > > to test sufficiently. In order to find bugs and hardware-dependent
> > > > > implementations early, continuous testing is required. Since it is
> > > > > difficult to automate tests that require hardware, this RFC proposes a
> > > > > virtual environment for testing PCI endpoint function drivers.
> > > > This would be quite useful and thank you for attempting it! I would like to
> > > > compare other mechanisms available in-addition to QEMU before going with the
> > > > QEMU approach.
> > > I got it. I'll make a table to compare some methods that includes greybus to
> > > realize this emulation environment.
> > > 
> > > 
> > > Best,
> > > 
> > > Shunsuke
> > > 
> > > > Though I don't understand this fully, Looking at
> > > > https://osseu2023.sched.com/event/1OGk8/emulating-devices-in-linux-using-greybus-subsystem-vaishnav-mohandas-achath-texas-instruments, Vaishnav seems to solve the same problem using greybus for multiple type s of devices.
> > > > 
> > > > Vaishnav, we'd wait for your OSS presentation but do you have any initial
> > > > thoughts on how greybus could be used to test PCIe endpoint drivers?
> > > > 
> > Apologies for the delay, I don't think greybus can be used for PCIe testing as
> > there is no greybus equivalent for PCIe[1], it can only be used for relatively
> > simpler devices today, I guess roadtest(UML based)[2] could be an alternative in
> > this case.
> 
> Thank you for your comment.
> 
> To my understanding, the roadtest uses UML and it interact with hardware
> model written in python to do testing. This would be grate for automated
> testing to test drivers and subsystems.
> 
> For this PCIe endpoint, I think we need to hosts, one that works as a PCIe
> endpoint and one that is a PCIe Root Complex to it. Is it possible to
> realize the system?
> like:
> UML + PCIe endpoint function driver <-> python HW model (PCI Endpoint
> controller) <-> UML + pci driver for the function
> 
> 
> As another option, I'm considering the feasibility of dummy PCIe EPC driver.
> It works as a PCIe EPC device in kernel and show pci device according to the
> PCIe endpoint function driver to the same host. so It could be realize a
> single host and test the function driver.
> 
> 
> Best,
> 
> Shunsuke
> 
> > 1 -
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/greybus
> > 2 - https://lore.kernel.org/lkml/YjN1ksNGujV611Ka@sirena.org.uk/
> > 
> > Thanks and Regards,
> > Vaishnav
> > 
> > > > Thanks,
> > > > Kishon
> > > > 
> > > > > # Architecture
> > > > > The overview of the architecture is as follows.
> > > > > 
> > > > >     Guest 1                        Guest 2
> > > > > +-------------------------+    +----------------------------+
> > > > > | Linux kernel            |    | Linux kernel               |
> > > > > |                         |    |                            |
> > > > > | PCI EP function driver  |    |                            |
> > > > > | (e.g. pci-epf-test)     |    |                            |
> > > > > |-------------------------|    | PCI Device Driver          |
> > > > > | (2) QEMU EPC Driver     |    | (e.g. pci_endpoint_test)   |
> > > > > +-------------------------+    +----------------------------+
> > > > > +-------------------------+    +----------------------------+
> > > > > | QEMU                    |    | QEMU                       |
> > > > > |-------------------------|    |----------------------------|
> > > > > | (1) QEMU PCI EPC Device *----* (3) QEMU EPF Bridge Device |
> > > > > +-------------------------+    +----------------------------+
> > > > > 
> > > > > At present, it is designed to work guests only on the same host, and
> > > > > communication is done through Unix domain sockets.
> > > > > 
> > > > > The three parts shown in the figure were introduced this time.
> > > > > 
> > > > > (1) QEMU PCI Endpoint Controller(EPC) Device
> > > > > PCI Endpoint Controller implemented as QEMU PCI device.
> > > > > (2) QEMU PCI Endpoint Controller(EPC) Driver
> > > > > Linux kernel driver that drives the device (1). It registers a epc device
> > > > > to linux kernel and handling each operations for the epc device.
> > > > > (3) QEMU PCI Endpoint function(EPF) Bridge Device
> > > > > QEMU PCI device that cooperates with (1) and performs accesses to pci
> > > > > configuration space, BAR and memory space to communicate each guests, and
> > > > > generates interruptions to the guest 1.
> > > > > 
> > > > > Each projects are:
> > > > > (1), (3) https://github.com/ShunsukeMie/qemu/tree/epf-bridge/v1
> > > > > <https://github.com/ShunsukeMie/qemu/tree/epf-bridge/v1>
> > > > > files: hw/misc/{qemu-epc.{c,h}, epf-bridge.c}
> > > > > (2) https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc
> > > > > <https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc>
> > > > > files: drivers/pci/controller/pcie-qemu-ep.c
> > > > > 
> > > > > # Protocol
> > > > > 
> > > > > PCI, PCIe has a layer structure that includes Physical, Data Lane and
> > > > > Transaction. The communicates between the bridge(3) and controller (1)
> > > > > mimic the Transaction. Specifically, a protocol is implemented for
> > > > > exchanging fd for communication protocol version check and communication,
> > > > > in addition to the interaction equivalent to PCIe Transaction Layer Packet
> > > > > (Read and Write of I/O, Memory, Configuration space and Message). In my
> > > > > mind, we need to discuss the communication mor.
> > > > > 
> > > > > We also are planning to post the patch set after the code is organized and
> > > > > the protocol discussion is matured.
> > > > > 
> > > > > Best regards,
> > > > > Shunsuke

