Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E90B67D0AA1
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 10:35:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtkxK-000091-OC; Fri, 20 Oct 2023 04:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1qtkxB-0008WC-HK; Fri, 20 Oct 2023 04:33:59 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1qtkx6-0002hc-W4; Fri, 20 Oct 2023 04:33:57 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.249])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id B1A93208A9;
 Fri, 20 Oct 2023 08:33:47 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 20 Oct
 2023 10:33:45 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S004a9907de5-3340-4494-9c59-5172bd8e49b7,
 C3DE39B25D4A09A1EA5644DCEB8289D547B4AEB9) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Fri, 20 Oct 2023 10:33:44 +0200
From: Greg Kurz <groug@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>
CC: Juan Quintela <quintela@redhat.com>, <qemu-devel@nongnu.org>, "Stefan
 Berger" <stefanb@linux.vnet.ibm.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, <qemu-ppc@nongnu.org>, <qemu-s390x@nongnu.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>, "Ilya
 Leoshkevich" <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>, Eric
 Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>, Harsh Prateek
 Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 <qemu-block@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, "Stefan
 Weil" <sw@weilnetz.de>, <qemu-arm@nongnu.org>, Jason Wang
 <jasowang@redhat.com>, Corey Minyard <minyard@acm.org>, Leonardo Bras
 <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>, Halil Pasic <pasic@linux.ibm.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 07/13] RFC migration: icp/server is a mess
Message-ID: <20231020103344.34baea63@bahia>
In-Reply-To: <CWD3OHT178VU.3NF8B5Y5BOK1S@wheely>
References: <20231019190831.20363-1-quintela@redhat.com>
 <20231019190831.20363-8-quintela@redhat.com>
 <20231019233958.17abb488@bahia> <CWD3OHT178VU.3NF8B5Y5BOK1S@wheely>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 1055eb79-0a0f-4153-a7d7-80632a3c3abc
X-Ovh-Tracer-Id: 4281515872457365879
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjeekgddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegkeejtdevgeekieelffdvtedvvdegtdduudeigffhhffgvdfhgeejteekheefkeenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddutddpkeekrddujeelrdelrdduheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoghhrohhugheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehnphhighhgihhnsehgmhgrihhlrdgtohhmpdgurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghupdhmshhtsehrvgguhhgrthdrtghomhdpphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhthhhuthhhsehrvgguhhgrthdrtghomhdplhgvohgsrhgrshesrhgvughhrghtrdgtohhmpdhmihhnhigrrhgusegrtghmrdhorhhgpdhjrghsohifrghnghesrhgvughhrghtrdgtohhmpdhqvghmuhdqrghrmhesnhhonhhgnh
 hurdhorhhgpdhsfiesfigvihhlnhgvthiirdguvgdpmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhhgrthdrtghomhdpsghorhhnthhrrggvghgvrheslhhinhhugidrihgsmhdrtghomhdpmhgrrhhkrdgtrghvvgdqrgihlhgrnhgusehilhgrnhguvgdrtghordhukhdpqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdpjhhsnhhofiesrhgvughhrghtrdgtohhmpdhprghsihgtsehlihhnuhigrdhisghmrdgtohhmpdhhrghrshhhphgssehlihhnuhigrdhisghmrdgtohhmpdhfrghrmhgrnheslhhinhhugidrihgsmhdrtghomhdpfhgrrhhoshgrshesshhushgvrdguvgdpihhiiheslhhinhhugidrihgsmhdrtghomhdpuggrvhhiugesrhgvughhrghtrdgtohhmpdhrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhrghdpshgrmhhuvghlrdhthhhisggruhhlthesvghnshdqlhihohhnrdhorhhgpdgtmhhinhihrghrugesmhhvihhsthgrrdgtohhmpdhkrhgrgigvlhesrhgvughhrghtrdgtohhmpdhqvghmuhdqshefledtgiesnhhonhhgnhhurdhorhhgpdhqvghmuhdqphhptgesnhhonhhgnhhurdhorhhgpdhmrghrtggvlhdrrghpfhgvlhgsrghumhesghhmrghilhdrtghomhdpshhtvghfrghnsgeslhhinhhugidrvhhnvghtrdhisghmrdgtohhmpdhqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhquhhinhhtvghlrgesrhgvughhrghtrdgtohhmpdhpvghtvghrgie
 srhgvughhrghtrdgtohhmpdgurghnihgvlhhhsgegudefsehgmhgrihhlrdgtohhmpdfovfetjfhoshhtpehmohehvdelpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 20 Oct 2023 17:49:38 +1000
"Nicholas Piggin" <npiggin@gmail.com> wrote:

> On Fri Oct 20, 2023 at 7:39 AM AEST, Greg Kurz wrote:
> > On Thu, 19 Oct 2023 21:08:25 +0200
> > Juan Quintela <quintela@redhat.com> wrote:
> >
> > > Current code does:
> > > - register pre_2_10_vmstate_dummy_icp with "icp/server" and instance
> > >   dependinfg on cpu number
> > > - for newer machines, it register vmstate_icp with "icp/server" name
> > >   and instance 0
> > > - now it unregisters "icp/server" for the 1st instance.
> > > 
> > > This is wrong at many levels:
> > > - we shouldn't have two VMSTATEDescriptions with the same name
> > > - In case this is the only solution that we can came with, it needs to
> > >   be:
> > >   * register pre_2_10_vmstate_dummy_icp
> > >   * unregister pre_2_10_vmstate_dummy_icp
> > >   * register real vmstate_icp
> > > 
> > > As the initialization of this machine is already complex enough, I
> > > need help from PPC maintainers to fix this.
> > > 
> > > Volunteers?
> > > 
> > > CC: Cedric Le Goater <clg@kaod.org>
> > > CC: Daniel Henrique Barboza <danielhb413@gmail.com>
> > > CC: David Gibson <david@gibson.dropbear.id.au>
> > > CC: Greg Kurz <groug@kaod.org>
> > > 
> > > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > > ---
> > >  hw/ppc/spapr.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index cb840676d3..8531d13492 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -143,7 +143,12 @@ static bool pre_2_10_vmstate_dummy_icp_needed(void *opaque)
> > >  }
> > >  
> > >  static const VMStateDescription pre_2_10_vmstate_dummy_icp = {
> > > -    .name = "icp/server",
> > > +    /*
> > > +     * Hack ahead.  We can't have two devices with the same name and
> > > +     * instance id.  So I rename this to pass make check.
> > > +     * Real help from people who knows the hardware is needed.
> > > +     */
> > > +    .name = "pre-2.10-icp/server",
> > >      .version_id = 1,
> > >      .minimum_version_id = 1,
> > >      .needed = pre_2_10_vmstate_dummy_icp_needed,
> >
> > I guess this fix is acceptable as well and a lot simpler than
> > reverting the hack actually. Outcome is the same : drop
> > compat with pseries-2.9 and older.
> >
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> 
> So the reason we can't have duplicate names registered, aside from it
> surely going bad if we actually send or receive a stream at the point
> they are registered, is the duplcate check introduced in patch 9? But
> before that, this hack does seem to actually work because the duplicate
> is unregistered right away.
> 

Correct.

> If I understand the workaround, there is an asymmetry in the migration
> sequence in that receiving an unexpected object would cause a failure,
> but going from newer to older would just skip some "expected" objects
> and that didn't cause a problem. So you only have to deal with ignoring
> the unexpected ones going form older to newer.
> 

Correct.

> Side question, is it possible to flag the problem of *not* receiving
> an object that you did expect? That might be a source of bugs too.
> 

AFAICR we try to only migrate state that differs from reset : the
destination cannot really assume it will receive anything for a
given device.

> Anyway, I wonder if we could fix this spapr problem by adding a special
> case wild card instance matcher to ignore it? It's still a bit hacky
> but maybe a bit nicer. I don't mind deprecating the machine soon if
> you want to clear the wildcard hack away soon, but it would be nice to
> separate the deprecation and removal from the fix, if possible.
> 
> This patch is not tested but hopefully helps illustrate the idea.
> 

I'm not sure this will fly with older QEMUs that don't know about
VMSTATE_INSTANCE_ID_WILD... but I'll let Juan comment on that.

> Thanks,
> Nick
> 

Cheers,

--
Greg

> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 1a31fb7293..8ce03edefa 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1205,6 +1205,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>  bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque);
>  
>  #define  VMSTATE_INSTANCE_ID_ANY  -1
> +#define  VMSTATE_INSTANCE_ID_WILD -2
>  
>  /* Returns: 0 on success, -1 on failure */
>  int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index cb840676d3..2418899dd4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -155,16 +155,10 @@ static const VMStateDescription pre_2_10_vmstate_dummy_icp = {
>      },
>  };
>  
> -static void pre_2_10_vmstate_register_dummy_icp(int i)
> +static void pre_2_10_vmstate_register_dummy_icp(void)
>  {
> -    vmstate_register(NULL, i, &pre_2_10_vmstate_dummy_icp,
> -                     (void *)(uintptr_t) i);
> -}
> -
> -static void pre_2_10_vmstate_unregister_dummy_icp(int i)
> -{
> -    vmstate_unregister(NULL, &pre_2_10_vmstate_dummy_icp,
> -                       (void *)(uintptr_t) i);
> +    vmstate_register(NULL, VMSTATE_INSTANCE_ID_WILD,
> +                     &pre_2_10_vmstate_dummy_icp, NULL);
>  }
>  
>  int spapr_max_server_number(SpaprMachineState *spapr)
> @@ -2665,12 +2659,10 @@ static void spapr_init_cpus(SpaprMachineState *spapr)
>      }
>  
>      if (smc->pre_2_10_has_unused_icps) {
> -        for (i = 0; i < spapr_max_server_number(spapr); i++) {
> -            /* Dummy entries get deregistered when real ICPState objects
> -             * are registered during CPU core hotplug.
> -             */
> -            pre_2_10_vmstate_register_dummy_icp(i);
> -        }
> +        /* Dummy entries get deregistered when real ICPState objects
> +         * are registered during CPU core hotplug.
> +         */
> +        pre_2_10_vmstate_register_dummy_icp();
>      }
>  
>      for (i = 0; i < possible_cpus->len; i++) {
> @@ -3873,21 +3865,9 @@ void spapr_core_release(DeviceState *dev)
>  static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
>  {
>      MachineState *ms = MACHINE(hotplug_dev);
> -    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
>      CPUCore *cc = CPU_CORE(dev);
>      CPUArchId *core_slot = spapr_find_cpu_slot(ms, cc->core_id, NULL);
>  
> -    if (smc->pre_2_10_has_unused_icps) {
> -        SpaprCpuCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
> -        int i;
> -
> -        for (i = 0; i < cc->nr_threads; i++) {
> -            CPUState *cs = CPU(sc->threads[i]);
> -
> -            pre_2_10_vmstate_register_dummy_icp(cs->cpu_index);
> -        }
> -    }
> -
>      assert(core_slot);
>      core_slot->cpu = NULL;
>      qdev_unrealize(dev);
> @@ -3968,10 +3948,8 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
>  {
>      SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
>      MachineClass *mc = MACHINE_GET_CLASS(spapr);
> -    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
>      SpaprCpuCore *core = SPAPR_CPU_CORE(OBJECT(dev));
>      CPUCore *cc = CPU_CORE(dev);
> -    CPUState *cs;
>      SpaprDrc *drc;
>      CPUArchId *core_slot;
>      int index;
> @@ -4018,13 +3996,6 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
>                             &error_abort);
>          }
>      }
> -
> -    if (smc->pre_2_10_has_unused_icps) {
> -        for (i = 0; i < cc->nr_threads; i++) {
> -            cs = CPU(core->threads[i]);
> -            pre_2_10_vmstate_unregister_dummy_icp(cs->cpu_index);
> -        }
> -    }
>  }
>  
>  static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 497ce02bd7..f33449e208 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -989,6 +989,10 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc)
>          trace_savevm_section_skip(se->idstr, se->section_id);
>          return 0;
>      }
> +    if (se->instance_id == VMSTATE_INSTANCE_ID_WILD) {
> +        warn_report("Wildcard vmstate entry must set needed=false");
> +        return 0;
> +    }
>  
>      trace_savevm_section_start(se->idstr, se->section_id);
>      save_section_header(f, se, QEMU_VM_SECTION_FULL);
> @@ -1731,13 +1735,16 @@ int qemu_save_device_state(QEMUFile *f)
>  
>  static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id)
>  {
> +    SaveStateEntry *se_wild = NULL;
>      SaveStateEntry *se;
>  
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> -        if (!strcmp(se->idstr, idstr) &&
> -            (instance_id == se->instance_id ||
> -             instance_id == se->alias_id))
> -            return se;
> +        if (!strcmp(se->idstr, idstr)) {
> +            if (instance_id == se->instance_id || instance_id == se->alias_id)
> +                return se;
> +            if (se->instance_id == VMSTATE_INSTANCE_ID_WILD)
> +                se_wild = se;
> +        }
>          /* Migrating from an older version? */
>          if (strstr(se->idstr, idstr) && se->compat) {
>              if (!strcmp(se->compat->idstr, idstr) &&
> @@ -1746,7 +1753,7 @@ static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id)
>                  return se;
>          }
>      }
> -    return NULL;
> +    return se_wild;
>  }
>  
>  enum LoadVMExitCodes {



-- 
Greg

