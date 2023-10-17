Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C397CC01D
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 12:05:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsgwb-0006Tn-Op; Tue, 17 Oct 2023 06:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qsgwW-0006OH-8C; Tue, 17 Oct 2023 06:04:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qsgwT-0007UT-TY; Tue, 17 Oct 2023 06:04:51 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8qMM5dRpz685Yk;
 Tue, 17 Oct 2023 18:04:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 17 Oct
 2023 11:04:45 +0100
Date: Tue, 17 Oct 2023 11:04:44 +0100
To: Alistair Francis <alistair23@gmail.com>, <qemu-devel@nongnu.org>
CC: <cbrowy@avery-design.com>, <wilfred.mallawa@wdc.com>, <mst@redhat.com>,
 <lukas@wunner.de>, <kbusch@kernel.org>, <hchkuo@avery-design.com.tw>,
 <its@irrelevant.dk>, <jiewen.yao@intel.com>, <marcel.apfelbaum@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, <qemu-block@nongnu.org>, Alistair
 Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 2/3] backends: Initial support for SPDM socket support
Message-ID: <20231017110444.000058be@Huawei.com>
In-Reply-To: <20231017052155.173577-3-alistair.francis@wdc.com>
References: <20231017052155.173577-1-alistair.francis@wdc.com>
 <20231017052155.173577-3-alistair.francis@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 17 Oct 2023 15:21:54 +1000
Alistair Francis <alistair23@gmail.com> wrote:

> From: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> 
> SPDM enables authentication, attestation and key exchange to assist in
> providing infrastructure security enablement. It's a standard published
> by the DMTF [1].
> 
> SPDM supports multiple transports, including PCIe DOE and MCTP.
> This patch adds support to QEMU to connect to an external SPDM
> instance.
> 
> SPDM support can be added to any QEMU device by exposing a
> TCP socket to a SPDM server. The server can then implement the SPDM
> decoding/encoding support, generally using libspdm [2].
> 
> This is similar to how the current TPM implementation works and means
> that the heavy lifting of setting up certificate chains, capabilities,
> measurements and complex crypto can be done outside QEMU by a well
> supported and tested library.
> 
> 1: https://www.dmtf.org/standards/SPDM
> 2: https://github.com/DMTF/libspdm
> 
> Signed-off-by: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> Signed-off-by: Chris Browy <cbrowy@avery-design.com>
> Co-developed-by: Jonathan Cameron <Jonathan.cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> [ Changes by WM
>  - Bug fixes from testing
> ]
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> [ Changes by AF:
>  - Convert to be more QEMU-ified
>  - Move to backends as it isn't PCIe specific
> ]
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

LGTM.  Will be interesting to see how this evolves as we put more
requirements on it.

Given I already signed off, I won't give another tag as that would be
extremely confusing.


