Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF789C04C7
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Nov 2024 12:49:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9108-0000Cx-3r; Thu, 07 Nov 2024 06:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t9102-0000CL-JA
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:48:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t90zw-0000yo-Du
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:48:27 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XkgJv4F4Jz6K5vr;
 Thu,  7 Nov 2024 19:46:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id A4D141400DD;
 Thu,  7 Nov 2024 19:48:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 7 Nov
 2024 12:48:18 +0100
Date: Thu, 7 Nov 2024 11:48:16 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>, <linuxarm@huawei.com>
CC: <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <linux-cxl@vger.kernel.org>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, "Huang
 Ying" <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH v6 14/15] bios-tables-test: Add complex SRAT / HMAT test
 for GI GP
Message-ID: <20241107114816.00004195@Huawei.com>
In-Reply-To: <20241106122707.00007552@Huawei.com>
References: <20240916171017.1841767-1-Jonathan.Cameron@huawei.com>
 <20240916174449.1843258-1-Jonathan.Cameron@huawei.com>
 <20241104110025-mutt-send-email-mst@kernel.org>
 <20241106122707.00007552@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, 6 Nov 2024 12:27:07 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 4 Nov 2024 11:00:59 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Sep 16, 2024 at 06:44:49PM +0100, Jonathan Cameron wrote:  
> > > Add a test with 6 nodes to exercise most interesting corner cases of SRAT
> > > and HMAT generation including the new Generic Initiator and Generic Port
> > > Affinity structures.  More details of the set up in the following patch
> > > adding the table data.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>    
> >   
> Was traveling for last few days, sorry for delay!
> > 
> > I could not yet figure out why, but it fails on i686 (32 bit):
> > 
> > https://gitlab.com/mstredhat/qemu/-/jobs/8262608614
> > 
> > any idea?  
> 
> Nothing immediately comes to mind. 
> I'll see what I can figure out from the generated binaries. 

My dumb bug from a messed up refactor :(  Anyhow I'm just rerunning the
test and if all fixed I'll send a series with the docs fix this and
the tests.  Pick up whatever combination makes sense now we are in
the soft freeze.

make docker-test-quick@debian-i686-cross
is not quick :)

Jonathan

> 
> Jonathan
> 
> >   
> > > ---
> > >  tests/qtest/bios-tables-test.c | 97 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 97 insertions(+)
> > > 
> > > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > > index 36e5c0adde..f568c4a21c 100644
> > > --- a/tests/qtest/bios-tables-test.c
> > > +++ b/tests/qtest/bios-tables-test.c
> > > @@ -1910,6 +1910,101 @@ static void test_acpi_q35_tcg_acpi_hmat_noinitiator(void)
> > >      free_test_data(&data);
> > >  }
> > >  
> > > +/* Test intended to hit corner cases of SRAT and HMAT */
> > > +static void test_acpi_q35_tcg_acpi_hmat_generic_x(void)
> > > +{
> > > +    test_data data = {};
> > > +
> > > +    data.machine = MACHINE_Q35;
> > > +    data.arch    = "x86";
> > > +    data.variant = ".acpihmat-generic-x";
> > > +    test_acpi_one(" -machine hmat=on,cxl=on"
> > > +                  " -smp 3,sockets=3"
> > > +                  " -m 128M,maxmem=384M,slots=2"
> > > +                  " -device pcie-root-port,chassis=1,id=pci.1"
> > > +                  " -device pci-testdev,bus=pci.1,"
> > > +                  "multifunction=on,addr=00.0"
> > > +                  " -device pci-testdev,bus=pci.1,addr=00.1"
> > > +                  " -device pci-testdev,bus=pci.1,id=gidev,addr=00.2"
> > > +                  " -device pxb-cxl,bus_nr=64,bus=pcie.0,id=cxl.1"
> > > +                  " -object memory-backend-ram,size=64M,id=ram0"
> > > +                  " -object memory-backend-ram,size=64M,id=ram1"
> > > +                  " -numa node,nodeid=0,cpus=0,memdev=ram0"
> > > +                  " -numa node,nodeid=1"
> > > +                  " -object acpi-generic-initiator,id=gi0,pci-dev=gidev,node=1"
> > > +                  " -numa node,nodeid=2"
> > > +                  " -object acpi-generic-port,id=gp0,pci-bus=cxl.1,node=2"
> > > +                  " -numa node,nodeid=3,cpus=1"
> > > +                  " -numa node,nodeid=4,memdev=ram1"
> > > +                  " -numa node,nodeid=5,cpus=2"
> > > +                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
> > > +                  "data-type=access-latency,latency=10"
> > > +                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
> > > +                  "data-type=access-bandwidth,bandwidth=800M"
> > > +                  " -numa hmat-lb,initiator=0,target=2,hierarchy=memory,"
> > > +                  "data-type=access-latency,latency=100"
> > > +                  " -numa hmat-lb,initiator=0,target=2,hierarchy=memory,"
> > > +                  "data-type=access-bandwidth,bandwidth=200M"
> > > +                  " -numa hmat-lb,initiator=0,target=4,hierarchy=memory,"
> > > +                  "data-type=access-latency,latency=100"
> > > +                  " -numa hmat-lb,initiator=0,target=4,hierarchy=memory,"
> > > +                  "data-type=access-bandwidth,bandwidth=200M"
> > > +                  " -numa hmat-lb,initiator=0,target=5,hierarchy=memory,"
> > > +                  "data-type=access-latency,latency=200"
> > > +                  " -numa hmat-lb,initiator=0,target=5,hierarchy=memory,"
> > > +                  "data-type=access-bandwidth,bandwidth=400M"
> > > +                  " -numa hmat-lb,initiator=1,target=0,hierarchy=memory,"
> > > +                  "data-type=access-latency,latency=500"
> > > +                  " -numa hmat-lb,initiator=1,target=0,hierarchy=memory,"
> > > +                  "data-type=access-bandwidth,bandwidth=100M"
> > > +                  " -numa hmat-lb,initiator=1,target=2,hierarchy=memory,"
> > > +                  "data-type=access-latency,latency=50"
> > > +                  " -numa hmat-lb,initiator=1,target=2,hierarchy=memory,"
> > > +                  "data-type=access-bandwidth,bandwidth=400M"
> > > +                  " -numa hmat-lb,initiator=1,target=4,hierarchy=memory,"
> > > +                  "data-type=access-latency,latency=50"
> > > +                  " -numa hmat-lb,initiator=1,target=4,hierarchy=memory,"
> > > +                  "data-type=access-bandwidth,bandwidth=800M"
> > > +                  " -numa hmat-lb,initiator=1,target=5,hierarchy=memory,"
> > > +                  "data-type=access-latency,latency=500"
> > > +                  " -numa hmat-lb,initiator=1,target=5,hierarchy=memory,"
> > > +                  "data-type=access-bandwidth,bandwidth=100M"
> > > +                  " -numa hmat-lb,initiator=3,target=0,hierarchy=memory,"
> > > +                  "data-type=access-latency,latency=20"
> > > +                  " -numa hmat-lb,initiator=3,target=0,hierarchy=memory,"
> > > +                  "data-type=access-bandwidth,bandwidth=400M"
> > > +                  " -numa hmat-lb,initiator=3,target=2,hierarchy=memory,"
> > > +                  "data-type=access-latency,latency=80"
> > > +                  " -numa hmat-lb,initiator=3,target=2,hierarchy=memory,"
> > > +                  "data-type=access-bandwidth,bandwidth=200M"
> > > +                  " -numa hmat-lb,initiator=3,target=4,hierarchy=memory,"
> > > +                  "data-type=access-latency,latency=80"
> > > +                  " -numa hmat-lb,initiator=3,target=4,hierarchy=memory,"
> > > +                  "data-type=access-bandwidth,bandwidth=200M"
> > > +                  " -numa hmat-lb,initiator=3,target=5,hierarchy=memory,"
> > > +                  "data-type=access-latency,latency=20"
> > > +                  " -numa hmat-lb,initiator=3,target=5,hierarchy=memory,"
> > > +                  "data-type=access-bandwidth,bandwidth=400M"
> > > +                  " -numa hmat-lb,initiator=5,target=0,hierarchy=memory,"
> > > +                  "data-type=access-latency,latency=20"
> > > +                  " -numa hmat-lb,initiator=5,target=0,hierarchy=memory,"
> > > +                  "data-type=access-bandwidth,bandwidth=400M"
> > > +                  " -numa hmat-lb,initiator=5,target=2,hierarchy=memory,"
> > > +                  "data-type=access-latency,latency=80"
> > > +                  " -numa hmat-lb,initiator=5,target=4,hierarchy=memory,"
> > > +                  "data-type=access-bandwidth,bandwidth=200M"
> > > +                  " -numa hmat-lb,initiator=5,target=4,hierarchy=memory,"
> > > +                  "data-type=access-latency,latency=80"
> > > +                  " -numa hmat-lb,initiator=5,target=2,hierarchy=memory,"
> > > +                  "data-type=access-bandwidth,bandwidth=200M"
> > > +                  " -numa hmat-lb,initiator=5,target=5,hierarchy=memory,"
> > > +                  "data-type=access-latency,latency=10"
> > > +                  " -numa hmat-lb,initiator=5,target=5,hierarchy=memory,"
> > > +                  "data-type=access-bandwidth,bandwidth=800M",
> > > +                  &data);
> > > +    free_test_data(&data);
> > > +}
> > > +
> > >  #ifdef CONFIG_POSIX
> > >  static void test_acpi_erst(const char *machine, const char *arch)
> > >  {
> > > @@ -2388,6 +2483,8 @@ int main(int argc, char *argv[])
> > >              qtest_add_func("acpi/q35/nohpet", test_acpi_q35_tcg_nohpet);
> > >              qtest_add_func("acpi/q35/acpihmat-noinitiator",
> > >                             test_acpi_q35_tcg_acpi_hmat_noinitiator);
> > > +            qtest_add_func("acpi/q35/acpihmat-genericx",
> > > +                           test_acpi_q35_tcg_acpi_hmat_generic_x);
> > >  
> > >              /* i386 does not support memory hotplug */
> > >              if (strcmp(arch, "i386")) {
> > > -- 
> > > 2.43.0    
> > 
> >   
> 
> 


