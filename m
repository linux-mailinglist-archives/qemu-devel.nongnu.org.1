Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4184687F102
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Mar 2024 21:14:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmJMI-0004ur-0a; Mon, 18 Mar 2024 16:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rmJMF-0004uS-9S
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 16:13:19 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rmJMC-0007r6-Ez
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 16:13:19 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-dbed179f0faso4008825276.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1710792789; x=1711397589; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2GmiV5M2hXSbQEKR31mdypKhoX7dIAGE7+RzEV5WkEY=;
 b=jwgf/lurIrk19pIL2MLAK34n6hjgiMFeqgzZHCfU7qSP7uRNFGaehCIkMMC0d4GEm0
 Rj98KHc6oWm2RSn7fyal09gupgTE8tTjtxL1rlD9OX3beMv5aLa4RRSOZdnsVi9iuyQr
 MUgxywldQS8C7npIpt+4ITw0CV7Dd3aF8HilMoEzEqVUxTGCShEzcQIunYrpXZV7KC3s
 UQHElHtpgOKzRWGUmxhwF8eeMJcnIy4YK1HALtThYM+thAPgMn10TgCAHIFytJoA4euQ
 pquPsnwJVib67JN//9b1EuHIugHm8jIUjaDNuzn4dzj1lln8WS4YFtXTno2QVYnWyqfs
 13Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710792789; x=1711397589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2GmiV5M2hXSbQEKR31mdypKhoX7dIAGE7+RzEV5WkEY=;
 b=wPYyRqiYHSPZe+ft2lZ8bvBx5iUjyoA1tQB42EE69n5VZ1Rh5SDS5WR78YD4hRN6PF
 ptodbdeyVPmL7RGsUUZ9RaSTaSi8yvy1H1KhO9KK33D39nRw+1G1PecH2R5pAf/N9oLw
 cbfKkcR01m89JglGTDNyeKAsZ1LbX5lJ1j4qtz6TzEyIJXzvBr5tlsbu7kRGgXdwBC3r
 k1ZoWEwTpvuuZXp8Y4Q6YW37qgLg5HdIi+z5i/K9/ikfOljJ+eUiS8Mhxn1ZxEvpLJCw
 f1vfQU9wE/vvwT0FKAB3DjyDGCsPAHeVF3aKkZake4hRdmzgnlk8gYVVJek85rM0cuul
 a+jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeLhyZpg4ALjBAIYsVKfOrzHt0uOWUb3QbN0woJhIOM+nK7So/fXIH2j3bZGHkkWz01SS3RAvrQpXgrmpeX7BCfM+RAio=
X-Gm-Message-State: AOJu0Yz6epSKQdoDVcPRr0xlbyy4c6XfpsKoTSFBq1t6myRbLWgxh+fV
 luQV8u/h1HUHBRNeKnKVxt8k9oqTDH6XkmctXeAaGMzSDKCR1mjfUo8Iqv/RhE/ZCTSYyIp//he
 Z/TpBpxOl20IcrC7jtr7Kjp7+TgeLmBtl89E3sA==
X-Google-Smtp-Source: AGHT+IFETTrBJ77lnga2XTx8H37L+r3SUM9K/oqa4D1IjsNxvnj1s00F9NGDxpflePP6ZXGG+xUJkzolNGOfV0V/g0A=
X-Received: by 2002:a05:6902:2191:b0:dcf:2697:5ca3 with SMTP id
 dl17-20020a056902219100b00dcf26975ca3mr607819ybb.5.1710792789278; Mon, 18 Mar
 2024 13:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240312061729.1997111-1-horenchuang@bytedance.com>
 <20240312061729.1997111-2-horenchuang@bytedance.com>
 <874jdb4xk8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAKPbEqpTNN5GKKCXmyTv0szpL-N1pdKFZYPHCJjyhgpKZGMiWw@mail.gmail.com>
 <8734st2qu0.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <8734st2qu0.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Mon, 18 Mar 2024 13:12:58 -0700
Message-ID: <CAKPbEqophdVjDfzLOCSbKYKOLsvPr1Eyiy6U9XuTZwxjoEUTTw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/1] memory tier: acpi/hmat: create
 CPUless memory tiers after obtaining HMAT info
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, 
 tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
 Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
 Alistair Popple <apopple@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org, linux-mm@kvack.org, 
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org, 
 Hao Xiang <hao.xiang@bytedance.com>, sthanneeru@micron.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=horenchuang@bytedance.com; helo=mail-yb1-xb2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I'm working on V3. Thanks for Ying's feedback.

cc: sthanneeru@micron.com


On Thu, Mar 14, 2024 at 12:54=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>
> > On Tue, Mar 12, 2024 at 2:21=E2=80=AFAM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
> >>
> >> > The current implementation treats emulated memory devices, such as
> >> > CXL1.1 type3 memory, as normal DRAM when they are emulated as normal=
 memory
> >> > (E820_TYPE_RAM). However, these emulated devices have different
> >> > characteristics than traditional DRAM, making it important to
> >> > distinguish them. Thus, we modify the tiered memory initialization p=
rocess
> >> > to introduce a delay specifically for CPUless NUMA nodes. This delay
> >> > ensures that the memory tier initialization for these nodes is defer=
red
> >> > until HMAT information is obtained during the boot process. Finally,
> >> > demotion tables are recalculated at the end.
> >> >
> >> > * Abstract common functions into `find_alloc_memory_type()`
> >>
> >> We should move kmem_put_memory_types() (renamed to
> >> mt_put_memory_types()?) too.  This can be put in a separate patch.
> >>
> >
> > Will do! Thanks,
> >
> >
> >>
> >> > Since different memory devices require finding or allocating a memor=
y type,
> >> > these common steps are abstracted into a single function,
> >> > `find_alloc_memory_type()`, enhancing code scalability and concisene=
ss.
> >> >
> >> > * Handle cases where there is no HMAT when creating memory tiers
> >> > There is a scenario where a CPUless node does not provide HMAT infor=
mation.
> >> > If no HMAT is specified, it falls back to using the default DRAM tie=
r.
> >> >
> >> > * Change adist calculation code to use another new lock, mt_perf_loc=
k.
> >> > In the current implementation, iterating through CPUlist nodes requi=
res
> >> > holding the `memory_tier_lock`. However, `mt_calc_adistance()` will =
end up
> >> > trying to acquire the same lock, leading to a potential deadlock.
> >> > Therefore, we propose introducing a standalone `mt_perf_lock` to pro=
tect
> >> > `default_dram_perf`. This approach not only avoids deadlock but also
> >> > prevents holding a large lock simultaneously.
> >> >
> >> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> >> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> >> > ---
> >> >  drivers/acpi/numa/hmat.c     | 11 ++++++
> >> >  drivers/dax/kmem.c           | 13 +------
> >> >  include/linux/acpi.h         |  6 ++++
> >> >  include/linux/memory-tiers.h |  8 +++++
> >> >  mm/memory-tiers.c            | 70 +++++++++++++++++++++++++++++++++=
---
> >> >  5 files changed, 92 insertions(+), 16 deletions(-)
> >> >
> >> > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> >> > index d6b85f0f6082..28812ec2c793 100644
> >> > --- a/drivers/acpi/numa/hmat.c
> >> > +++ b/drivers/acpi/numa/hmat.c
> >> > @@ -38,6 +38,8 @@ static LIST_HEAD(targets);
> >> >  static LIST_HEAD(initiators);
> >> >  static LIST_HEAD(localities);
> >> >
> >> > +static LIST_HEAD(hmat_memory_types);
> >> > +
> >>
> >> HMAT isn't a device driver for some memory devices.  So I don't think =
we
> >> should manage memory types in HMAT.
> >
> > I can put it back in memory-tier.c. How about the list? Do we still
> > need to keep a separate list for storing late_inited memory nodes?
> > And how about the list name if we need to remove the prefix "hmat_"?
>
> I don't think we need a separate list for memory-less nodes.  Just
> iterate all memory-less nodes.
>

Ok. There is no need to keep a list of memory-less nodes. I will
only keep a memory_type list to manage created memory types.


> >
> >> Instead, if the memory_type of a
> >> node isn't set by the driver, we should manage it in memory-tier.c as
> >> fallback.
> >>
> >
> > Do you mean some device drivers may init memory tiers between
> > memory_tier_init() and late_initcall(memory_tier_late_init);?
> > And this is the reason why you mention to exclude
> > "node_memory_types[nid].memtype !=3D NULL" in memory_tier_late_init().
> > Is my understanding correct?
>
> Yes.
>

Thanks.

> >> >  static DEFINE_MUTEX(target_lock);
> >> >
> >> >  /*
> >> > @@ -149,6 +151,12 @@ int acpi_get_genport_coordinates(u32 uid,
> >> >  }
> >> >  EXPORT_SYMBOL_NS_GPL(acpi_get_genport_coordinates, CXL);
> >> >
> >> > +struct memory_dev_type *hmat_find_alloc_memory_type(int adist)
> >> > +{
> >> > +     return find_alloc_memory_type(adist, &hmat_memory_types);
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(hmat_find_alloc_memory_type);
> >> > +
> >> >  static __init void alloc_memory_initiator(unsigned int cpu_pxm)
> >> >  {
> >> >       struct memory_initiator *initiator;
> >> > @@ -1038,6 +1046,9 @@ static __init int hmat_init(void)
> >> >       if (!hmat_set_default_dram_perf())
> >> >               register_mt_adistance_algorithm(&hmat_adist_nb);
> >> >
> >> > +     /* Post-create CPUless memory tiers after getting HMAT info */
> >> > +     memory_tier_late_init();
> >> > +
> >>
> >> This should be called in memory-tier.c via
> >>
> >> late_initcall(memory_tier_late_init);
> >>
> >> Then, we don't need hmat to call it.
> >>
> >
> > Thanks. Learned!
> >
> >
> >> >       return 0;
> >> >  out_put:
> >> >       hmat_free_structures();
> >> > diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> >> > index 42ee360cf4e3..aee17ab59f4f 100644
> >> > --- a/drivers/dax/kmem.c
> >> > +++ b/drivers/dax/kmem.c
> >> > @@ -55,21 +55,10 @@ static LIST_HEAD(kmem_memory_types);
> >> >
> >> >  static struct memory_dev_type *kmem_find_alloc_memory_type(int adis=
t)
> >> >  {
> >> > -     bool found =3D false;
> >> >       struct memory_dev_type *mtype;
> >> >
> >> >       mutex_lock(&kmem_memory_type_lock);
> >> > -     list_for_each_entry(mtype, &kmem_memory_types, list) {
> >> > -             if (mtype->adistance =3D=3D adist) {
> >> > -                     found =3D true;
> >> > -                     break;
> >> > -             }
> >> > -     }
> >> > -     if (!found) {
> >> > -             mtype =3D alloc_memory_type(adist);
> >> > -             if (!IS_ERR(mtype))
> >> > -                     list_add(&mtype->list, &kmem_memory_types);
> >> > -     }
> >> > +     mtype =3D find_alloc_memory_type(adist, &kmem_memory_types);
> >> >       mutex_unlock(&kmem_memory_type_lock);
> >> >
> >> >       return mtype;
> >> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> >> > index b7165e52b3c6..3f927ff01f02 100644
> >> > --- a/include/linux/acpi.h
> >> > +++ b/include/linux/acpi.h
> >> > @@ -434,12 +434,18 @@ int thermal_acpi_critical_trip_temp(struct acp=
i_device *adev, int *ret_temp);
> >> >
> >> >  #ifdef CONFIG_ACPI_HMAT
> >> >  int acpi_get_genport_coordinates(u32 uid, struct access_coordinate =
*coord);
> >> > +struct memory_dev_type *hmat_find_alloc_memory_type(int adist);
> >> >  #else
> >> >  static inline int acpi_get_genport_coordinates(u32 uid,
> >> >                                              struct access_coordinat=
e *coord)
> >> >  {
> >> >       return -EOPNOTSUPP;
> >> >  }
> >> > +
> >> > +static inline struct memory_dev_type *hmat_find_alloc_memory_type(i=
nt adist)
> >> > +{
> >> > +     return NULL;
> >> > +}
> >> >  #endif
> >> >
> >> >  #ifdef CONFIG_ACPI_NUMA
> >> > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tie=
rs.h
> >> > index 69e781900082..4bc2596c5774 100644
> >> > --- a/include/linux/memory-tiers.h
> >> > +++ b/include/linux/memory-tiers.h
> >> > @@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
> >> >  int mt_set_default_dram_perf(int nid, struct access_coordinate *per=
f,
> >> >                            const char *source);
> >> >  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist=
);
> >> > +struct memory_dev_type *find_alloc_memory_type(int adist,
> >> > +                                                     struct list_he=
ad *memory_types);
> >> > +void memory_tier_late_init(void);
> >> >  #ifdef CONFIG_MIGRATION
> >> >  int next_demotion_node(int node);
> >> >  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets=
);
> >> > @@ -136,5 +139,10 @@ static inline int mt_perf_to_adistance(struct a=
ccess_coordinate *perf, int *adis
> >> >  {
> >> >       return -EIO;
> >> >  }
> >> > +
> >> > +static inline void memory_tier_late_init(void)
> >> > +{
> >> > +
> >> > +}
> >> >  #endif       /* CONFIG_NUMA */
> >> >  #endif  /* _LINUX_MEMORY_TIERS_H */
> >> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> >> > index 0537664620e5..79f748d60e6f 100644
> >> > --- a/mm/memory-tiers.c
> >> > +++ b/mm/memory-tiers.c
> >> > @@ -6,6 +6,7 @@
> >> >  #include <linux/memory.h>
> >> >  #include <linux/memory-tiers.h>
> >> >  #include <linux/notifier.h>
> >> > +#include <linux/acpi.h>
> >> >
> >> >  #include "internal.h"
> >> >
> >> > @@ -35,6 +36,7 @@ struct node_memory_type_map {
> >> >  };
> >> >
> >> >  static DEFINE_MUTEX(memory_tier_lock);
> >> > +static DEFINE_MUTEX(mt_perf_lock);
> >>
> >> Please add comments about what it protects.  And put it near the data
> >> structure it protects.
> >>
> >
> > Where is better for me to add comments for this? Code? Patch descriptio=
n?
> > Will put it closer to the protected data. Thanks.
>
> Just put the comments at the above of the lock in the source code.
>

Got it. Thanks!

>
> >
> >
> >> >  static LIST_HEAD(memory_tiers);
> >> >  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
> >> >  struct memory_dev_type *default_dram_type;
> >> > @@ -623,6 +625,58 @@ void clear_node_memory_type(int node, struct me=
mory_dev_type *memtype)
> >> >  }
> >> >  EXPORT_SYMBOL_GPL(clear_node_memory_type);
> >> >
> >> > +struct memory_dev_type *find_alloc_memory_type(int adist, struct li=
st_head *memory_types)
> >> > +{
> >> > +     bool found =3D false;
> >> > +     struct memory_dev_type *mtype;
> >> > +
> >> > +     list_for_each_entry(mtype, memory_types, list) {
> >> > +             if (mtype->adistance =3D=3D adist) {
> >> > +                     found =3D true;
> >> > +                     break;
> >> > +             }
> >> > +     }
> >> > +     if (!found) {
> >> > +             mtype =3D alloc_memory_type(adist);
> >> > +             if (!IS_ERR(mtype))
> >> > +                     list_add(&mtype->list, memory_types);
> >> > +     }
> >> > +
> >> > +     return mtype;
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(find_alloc_memory_type);
> >> > +
> >> > +static void memory_tier_late_create(int node)
> >> > +{
> >> > +     struct memory_dev_type *mtype =3D NULL;
> >> > +     int adist =3D MEMTIER_ADISTANCE_DRAM;
> >> > +
> >> > +     mt_calc_adistance(node, &adist);
> >> > +     if (adist !=3D MEMTIER_ADISTANCE_DRAM) {
> >>
> >> We can manage default_dram_type() via find_alloc_memory_type()
> >> too.
> >>
> >> And, if "node_memory_types[node].memtype =3D=3D NULL", we can call
> >> mt_calc_adistance(node, &adist) and find_alloc_memory_type() in
> >> set_node_memory_tier().  Then, we can cover hotpluged memory node too.
> >>
> >> > +             mtype =3D hmat_find_alloc_memory_type(adist);
> >> > +             if (!IS_ERR(mtype))
> >> > +                     __init_node_memory_type(node, mtype);
> >> > +             else
> >> > +                     pr_err("Failed to allocate a memory type at %s=
()\n", __func__);
> >> > +     }
> >> > +
> >> > +     set_node_memory_tier(node);
> >> > +}
> >> > +
> >> > +void memory_tier_late_init(void)
> >> > +{
> >> > +     int nid;
> >> > +
> >> > +     mutex_lock(&memory_tier_lock);
> >> > +     for_each_node_state(nid, N_MEMORY)
> >> > +             if (!node_state(nid, N_CPU))
> >>
> >> We should exclude "node_memory_types[nid].memtype !=3D NULL".  Some me=
mory
> >> nodes may be onlined by some device drivers and setup memory tiers
> >> already.
> >>
> >> > +                     memory_tier_late_create(nid);
> >> > +
> >> > +     establish_demotion_targets();
> >> > +     mutex_unlock(&memory_tier_lock);
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(memory_tier_late_init);
> >> > +
> >> >  static void dump_hmem_attrs(struct access_coordinate *coord, const =
char *prefix)
> >> >  {
> >> >       pr_info(
> >> > @@ -636,7 +690,7 @@ int mt_set_default_dram_perf(int nid, struct acc=
ess_coordinate *perf,
> >> >  {
> >> >       int rc =3D 0;
> >> >
> >> > -     mutex_lock(&memory_tier_lock);
> >> > +     mutex_lock(&mt_perf_lock);
> >> >       if (default_dram_perf_error) {
> >> >               rc =3D -EIO;
> >> >               goto out;
> >> > @@ -684,7 +738,7 @@ int mt_set_default_dram_perf(int nid, struct acc=
ess_coordinate *perf,
> >> >       }
> >> >
> >> >  out:
> >> > -     mutex_unlock(&memory_tier_lock);
> >> > +     mutex_unlock(&mt_perf_lock);
> >> >       return rc;
> >> >  }
> >> >
> >> > @@ -700,7 +754,7 @@ int mt_perf_to_adistance(struct access_coordinat=
e *perf, int *adist)
> >> >           perf->read_bandwidth + perf->write_bandwidth =3D=3D 0)
> >> >               return -EINVAL;
> >> >
> >> > -     mutex_lock(&memory_tier_lock);
> >> > +     mutex_lock(&mt_perf_lock);
> >> >       /*
> >> >        * The abstract distance of a memory node is in direct proport=
ion to
> >> >        * its memory latency (read + write) and inversely proportiona=
l to its
> >> > @@ -713,7 +767,7 @@ int mt_perf_to_adistance(struct access_coordinat=
e *perf, int *adist)
> >> >               (default_dram_perf.read_latency + default_dram_perf.wr=
ite_latency) *
> >> >               (default_dram_perf.read_bandwidth + default_dram_perf.=
write_bandwidth) /
> >> >               (perf->read_bandwidth + perf->write_bandwidth);
> >> > -     mutex_unlock(&memory_tier_lock);
> >> > +     mutex_unlock(&mt_perf_lock);
> >> >
> >> >       return 0;
> >> >  }
> >> > @@ -836,6 +890,14 @@ static int __init memory_tier_init(void)
> >> >        * types assigned.
> >> >        */
> >> >       for_each_node_state(node, N_MEMORY) {
> >> > +             if (!node_state(node, N_CPU))
> >> > +                     /*
> >> > +                      * Defer memory tier initialization on CPUless=
 numa nodes.
> >> > +                      * These will be initialized when HMAT informa=
tion is
> >>
> >> HMAT is platform specific, we should avoid to mention it in general co=
de
> >> if possible.
> >>
> >
> > Will fix! Thanks,
> >
> >
> >> > +                      * available.
> >> > +                      */
> >> > +                     continue;
> >> > +
> >> >               memtier =3D set_node_memory_tier(node);
> >> >               if (IS_ERR(memtier))
> >> >                       /*
> >>
>
> --
> Best Regards,
> Huang, Ying



--
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

