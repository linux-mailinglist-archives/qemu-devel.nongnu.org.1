Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85009775E99
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 14:12:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTi2B-0003l5-UT; Wed, 09 Aug 2023 08:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qTi27-0003kR-P8
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 08:11:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qTi25-0004nf-1D
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 08:11:23 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RLTMK4CQtz6J7Ms;
 Wed,  9 Aug 2023 20:07:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 13:11:06 +0100
Date: Wed, 9 Aug 2023 13:11:04 +0100
To: Alistair Francis <alistair23@gmail.com>
CC: <qemu-devel@nongnu.org>, <hchkuo@avery-design.com.tw>,
 <cbrowy@avery-design.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC v1 0/3]  Initial support for SPDM
Message-ID: <20230809131104.00006ea1@Huawei.com>
In-Reply-To: <cover.1691509717.git.alistair.francis@wdc.com>
References: <cover.1691509717.git.alistair.francis@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue,  8 Aug 2023 11:51:21 -0400
Alistair Francis <alistair23@gmail.com> wrote:

> The Security Protocol and Data Model (SPDM) Specification defines
> messages, data objects, and sequences for performing message exchanges
> over a variety of transport and physical media.
>  - https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.3.0.pdf
> 
> This series is a very initial start on adding SPDM support to QEMU.
> 
> This series uses libspdm [1] which is a reference implementation of
> SPDM.
> 
> The series starts by adding support for building and linking with
> libspdm. It then progresses to handling SPDM requests in the NVMe device
> over the PCIe DOE protocol.
> 
> This is a very early attempt. The code quality is not super high, the C
> code hasn't been tested at all. This is really just an RFC to see if
> QEMU will accept linking with libspdm.
> 
> So, the main question is, how do people feel about linking with libspdm
> to support SPDM?
> 
> 1: https://github.com/DMTF/libspdm

Hi Alastair,

For reference / background we've had SPDM support for CXL emulated devices
in our staging tree for quite a while - it's not upstream because of
exactly this question (+ no one had upstreaming this as a high priority
as out of tree was fine for developing the kernel stack - it's well
isolated in the code so there was little cost in rebasing this feature)
- and because libspdm is packaged by almost no one. There were problems
building it with external crypto libraries etc.

Looks like you have had a lot more success than I ever did in getting that
to work. I tried a few times in the past and ended up sticking with
the Avery design folks approach of a socket connection to spdm-emu
Given you cc'd them I'm guessing you came across that work which is what
we used for testing the kernel code Lukas is working on currently.

https://lore.kernel.org/qemu-devel/20210629132520.00000d1f@Huawei.com/

https://gitlab.com/jic23/qemu/-/commit/9864fb29979e55c1e37c20edf00907d9524036e8

So I think we have 2 choices here.
1) Do what you have done and build the library as you are doing.
 - Can fix a version - so don't care if they change the ABI etc other
   than needing to move the version QEMU uses forwards when we need
   to for new features.
 - Cert management is going to add a lot of complexity into QEMU.
   I've not looked at how much infrastructure we can reuse from elsewhere.
   Maybe this is a solved problem.

2) Keep the SPDM emulation external.
 - I'm not sure the socket protocol used by spdm-emu is fixed in stone
   as people tend to change both ends.
 - Cert management and protocol options etc are already available.

Personally I prefer the control option 1 gives us, even if it's a lot more
code.  Option 2 also rather limits our ability to do anything with
the encrypted data as well. It's fine if the aim is just verification
of simple flows, but if we need to inject particular measurements etc
it doesn't really work.

Jonathan



> 
> Alistair Francis (3):
>   subprojects: libspdm: Initial support
>   hw: nvme: ctrl: Initial support for DOE
>   hw: nvme: ctrl: Process SPDM requests
> 
>  meson.build                   | 78 +++++++++++++++++++++++++++++++++++
>  hw/nvme/nvme.h                |  4 ++
>  include/hw/pci/pcie_doe.h     |  1 +
>  hw/nvme/ctrl.c                | 35 ++++++++++++++++
>  .gitmodules                   |  3 ++
>  meson_options.txt             |  3 ++
>  scripts/meson-buildoptions.sh |  3 ++
>  subprojects/.gitignore        |  1 +
>  subprojects/libspdm.wrap      |  5 +++
>  9 files changed, 133 insertions(+)
>  create mode 100644 subprojects/libspdm.wrap
> 


