Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8866DA08F9C
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Jan 2025 12:41:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDOI-0003Lb-77; Fri, 10 Jan 2025 06:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tWDO2-0003IL-Uv
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:41:11 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tWDNz-0007XJ-5D
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:41:10 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV0712p1Wz6GFfG;
 Fri, 10 Jan 2025 19:39:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 0D4E8140A08;
 Fri, 10 Jan 2025 19:41:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 10 Jan
 2025 12:41:02 +0100
Date: Fri, 10 Jan 2025 11:41:00 +0000
To: Zhao Liu <zhao1.liu@intel.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-D?=
 =?ISO-8859-1?Q?aud=E9?= <philmd@linaro.org>, "Daniel P . =?ISO-8859-1?Q?B?=
 =?ISO-8859-1?Q?errang=E9?=" <berrange@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S.Tsirkin
 " <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Alireza Sanaee
 <alireza.sanaee@huawei.com>, "Sia Jee Heng" <jeeheng.sia@starfivetech.com>,
 <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v7 0/5] i386: Support SMP Cache Topology
Message-ID: <20250110114100.00002296@huawei.com>
In-Reply-To: <20250108150150.1258529-1-zhao1.liu@intel.com>
References: <20250108150150.1258529-1-zhao1.liu@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed,  8 Jan 2025 23:01:45 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> Hi folks,
> 
> This is my v7.
> 
> Compared with v6 [1], v7 dropped the "thread" level cache topology
> (cache per thread):
> 
>  - Patch 1 is the new patch to reject "thread" parameter for smp-cache.
>  - Ptach 2 dropped cache per thread support.
>  (Others remain unchanged.)
> 
> There're several reasons:
> 
>  * Currently, neither i386 nor ARM have real hardware support for per-
>    thread cache.
>  * Supporting this special cache topology on ARM requires extra effort
>    [2].

Somewhat misleading perhaps and doesn't actually matter for this series.
QEMU describes SMT threads wrongly today in DT.
Fixing that shows the Linux kernel won't boot with the right description,
Ali is working on solving that at which point we'll fix DT in QEMU
and this will all work.

Longer term I don't think there is any way to describe thread private caches
in DT but as you observe, no one builds that hardware anyway. 

Hence I'm very much in favor of this change!

Resent as yet again my email client tripped over Daniel's name and scrambled the
header so a bunch of lists rejected it.
 
Jonathan


> 
> So it is unnecessary to support it at this moment, even though per-
> thread cache might have potential scheduling benefits for VMs without
> CPU affinity.
> 
> In the future, if there is a clear demand for this feature, the correct
> approach would be to add a new control field in MachineClass.smp_props
> and enable it only for the machines that require it.
> 
> 
> This series is based on the master branch at commit aa3a285b5bc5 ("Merge
> tag 'mem-2024-12-21' of https://github.com/davidhildenbrand/qemu into
> staging").
> 
> Smp-cache support of ARM side can be found at [3].
> 
> 
> Background
> ==========
> 
> The x86 and ARM (RISCV) need to allow user to configure cache properties
> (current only topology):
>  * For x86, the default cache topology model (of max/host CPU) does not
>    always match the Host's real physical cache topology. Performance can
>    increase when the configured virtual topology is closer to the
>    physical topology than a default topology would be.
>  * For ARM, QEMU can't get the cache topology information from the CPU
>    registers, then user configuration is necessary. Additionally, the
>    cache information is also needed for MPAM emulation (for TCG) to
>    build the right PPTT. (Originally from Jonathan)
> 
> 
> About smp-cache
> ===============
> 
> The API design has been discussed heavily in [4].
> 
> Now, smp-cache is implemented as a array integrated in -machine. Though
> -machine currently can't support JSON format, this is the one of the
> directions of future.
> 
> An example is as follows:
> 
> smp_cache=smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=module,smp-cache.3.cache=l3,smp-cache.3.topology=die
> 
> "cache" specifies the cache that the properties will be applied on. This
> field is the combination of cache level and cache type. Now it supports
> "l1d" (L1 data cache), "l1i" (L1 instruction cache), "l2" (L2 unified
> cache) and "l3" (L3 unified cache).
> 
> "topology" field accepts CPU topology levels including "core", "module",
> "cluster", "die", "socket", "book", "drawer" and a special value
> "default". (Note, now, in v7, smp-cache doesn't support "thread".)
> 
> The "default" is introduced to make it easier for libvirt to set a
> default parameter value without having to care about the specific
> machine (because currently there is no proper way for machine to
> expose supported topology levels and caches).
> 
> If "default" is set, then the cache topology will follow the
> architecture's default cache topology model. If other CPU topology level
> is set, the cache will be shared at corresponding CPU topology level.
> 
> 
> [1]: Patch v6: https://lore.kernel.org/qemu-devel/20241219083237.265419-1-zhao1.liu@intel.com/
> [2]: Gap of cache per thread for ARM: https://lore.kernel.org/qemu-devel/Z3efFsigJ6SxhqMf@intel.com/#t
> [3]: ARM smp-cache: https://lore.kernel.org/qemu-devel/20250102152012.1049-1-alireza.sanaee@huawei.com/
> [4]: API disscussion: https://lore.kernel.org/qemu-devel/8734ndj33j.fsf@pond.sub.org/
> 
> Thanks and Best Regards,
> Zhao
> ---
> Alireza Sanaee (1):
>   i386/cpu: add has_caches flag to check smp_cache configuration
> 
> Zhao Liu (4):
>   hw/core/machine: Reject thread level cache
>   i386/cpu: Support module level cache topology
>   i386/cpu: Update cache topology with machine's configuration
>   i386/pc: Support cache topology in -machine for PC machine
> 
>  hw/core/machine-smp.c |  9 ++++++
>  hw/i386/pc.c          |  4 +++
>  include/hw/boards.h   |  3 ++
>  qemu-options.hx       | 30 +++++++++++++++++-
>  target/i386/cpu.c     | 71 ++++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 115 insertions(+), 2 deletions(-)
> 


