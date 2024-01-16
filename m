Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8427E82F209
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 17:00:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPlqU-00076Q-QV; Tue, 16 Jan 2024 10:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rPlqR-00075T-Io; Tue, 16 Jan 2024 10:59:19 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rPlqP-0005go-3Z; Tue, 16 Jan 2024 10:59:19 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TDtsm5pwvz67NNV;
 Tue, 16 Jan 2024 23:56:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id A1F26140A36;
 Tue, 16 Jan 2024 23:59:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Jan
 2024 15:59:12 +0000
Date: Tue, 16 Jan 2024 15:59:11 +0000
To: Salil Mehta <salil.mehta@huawei.com>
CC: Gavin Shan <gshan@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "andrew.jones@linux.dev"
 <andrew.jones@linux.dev>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "ardb@kernel.org" <ardb@kernel.org>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, zhukeqian
 <zhukeqian1@huawei.com>, "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, "jiakernel2@gmail.com"
 <jiakernel2@gmail.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>
Subject: Re: [PATCH RFC V2 04/37] arm/virt,target/arm: Machine init time
 change common to vCPU {cold|hot}-plug
Message-ID: <20240116155911.00004fe1@Huawei.com>
In-Reply-To: <de871e3d7b8f440b93b20c734fe5b7a8@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-5-salil.mehta@huawei.com>
 <1c5fa24c-6bf3-750f-4f22-087e4a9311af@redhat.com>
 <de871e3d7b8f440b93b20c734fe5b7a8@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 2 Oct 2023 17:12:43 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> Hi Gavin,
> 
> > From: Gavin Shan <gshan@redhat.com>
> > Sent: Wednesday, September 27, 2023 7:29 AM
> > To: Salil Mehta <salil.mehta@huawei.com>; qemu-devel@nongnu.org; qemu-
> > arm@nongnu.org
> > Cc: maz@kernel.org; jean-philippe@linaro.org; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; lpieralisi@kernel.org;
> > peter.maydell@linaro.org; richard.henderson@linaro.org;
> > imammedo@redhat.com; andrew.jones@linux.dev; david@redhat.com;
> > philmd@linaro.org; eric.auger@redhat.com; will@kernel.org; ardb@kernel.org;
> > oliver.upton@linux.dev; pbonzini@redhat.com; mst@redhat.com;
> > rafael@kernel.org; borntraeger@linux.ibm.com; alex.bennee@linaro.org;
> > linux@armlinux.org.uk; darren@os.amperecomputing.com;
> > ilkka@os.amperecomputing.com; vishnu@os.amperecomputing.com;
> > karl.heubaum@oracle.com; miguel.luis@oracle.com; salil.mehta@opnsrc.net;
> > zhukeqian <zhukeqian1@huawei.com>; wangxiongfeng (C)
> > <wangxiongfeng2@huawei.com>; wangyanan (Y) <wangyanan55@huawei.com>;
> > jiakernel2@gmail.com; maobibo@loongson.cn; lixianglai@loongson.cn
> > Subject: Re: [PATCH RFC V2 04/37] arm/virt,target/arm: Machine init time
> > change common to vCPU {cold|hot}-plug
> > 
> > Hi Salil,
> > 
> > On 9/26/23 20:04, Salil Mehta wrote:  
> > > Refactor and introduce the common logic required during the  
> > initialization of  
> > > both cold and hot plugged vCPUs. Also initialize the *disabled* state of the
> > > vCPUs which shall be used further during init phases of various other components
> > > like GIC, PMU, ACPI etc as part of the virt machine initialization.
> > >
> > > KVM vCPUs corresponding to unplugged/yet-to-be-plugged QOM CPUs are kept in
> > > powered-off state in the KVM Host and do not run the guest code. Plugged vCPUs
> > > are also kept in powered-off state but vCPU threads exist and is kept sleeping.
> > >
> > > TBD:
> > > For the cold booted vCPUs, this change also exists in the arm_load_kernel()
> > > in boot.c but for the hotplugged CPUs this change should still remain part of
> > > the pre-plug phase. We are duplicating the powering-off of the cold booted CPUs.
> > > Shall we remove the duplicate change from boot.c?
> > >
> > > Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
> > > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > > Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> > > Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> > > Reported-by: Gavin Shan <gavin.shan@redhat.com>
> > > [GS: pointed the assertion due to wrong range check]
> > > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > > ---
> > >   hw/arm/virt.c      | 149 ++++++++++++++++++++++++++++++++++++++++-----
> > >   target/arm/cpu.c   |   7 +++
> > >   target/arm/cpu64.c |  14 +++++
> > >   3 files changed, 156 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > index 0eb6bf5a18..3668ad27ec 100644
> > > --- a/hw/arm/virt.c
> > > +++ b/hw/arm/virt.c
> > > @@ -221,6 +221,7 @@ static const char *valid_cpus[] = {
> > >       ARM_CPU_TYPE_NAME("max"),
> > >   };
> > >
> > > +static CPUArchId *virt_find_cpu_slot(MachineState *ms, int vcpuid);
> > >   static int virt_get_socket_id(const MachineState *ms, int cpu_index);
> > >   static int virt_get_cluster_id(const MachineState *ms, int cpu_index);
> > >   static int virt_get_core_id(const MachineState *ms, int cpu_index);
> > > @@ -2154,6 +2155,14 @@ static void machvirt_init(MachineState *machine)
> > >           exit(1);
> > >       }
> > >
> > > +    finalize_gic_version(vms);
> > > +    if (tcg_enabled() || hvf_enabled() || qtest_enabled() ||
> > > +        (vms->gic_version < VIRT_GIC_VERSION_3)) {
> > > +        machine->smp.max_cpus = smp_cpus;
> > > +        mc->has_hotpluggable_cpus = false;
> > > +        warn_report("cpu hotplug feature has been disabled");
> > > +    }
> > > +  
> > 
> > Comments needed here to explain why @mc->has_hotpluggable_cpus is set to false.
> > I guess it's something related to TODO list, mentioned in the cover letter.  
> 
> 
> I can put a comment explaining the checks as to why feature has been disabled.
> BTW, isn't code self-explanatory here?

Would be good to gate that warn_report() on whether any attempt to enable
CPU hotplug has been made if (max_cpus > smp for example).
Right now it's noise on a lot of pre existing configurations.


