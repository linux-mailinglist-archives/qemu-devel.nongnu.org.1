Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C26F489E2E6
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Apr 2024 21:03:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruGkA-0002nE-TV; Tue, 09 Apr 2024 15:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1ruGk3-0002mn-Rq
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:02:48 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1ruGjz-0007F8-NQ
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:02:47 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-615019cd427so51400007b3.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1712689362; x=1713294162; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9JT5x/b9oaUqCAXwkz87p9Kfabiba0RNb5HLj9kkfw=;
 b=T+//nVntTA77zMBttbtiEJSLllfutGXngJJNi6M/JiHm2Rbsn22/WJX80aLCdMAkUD
 tL7Yd4UFr8mog5MI0zPWjvJOKPchtAKD5WJPSJ/ERZeezaJ7WYx70iT/DZ8A9atgkC4u
 3oDCPI2BsEJ1Ya950mUWNaypC9BV8LaqLj2TasHLgW3eNjnm/wJGa2m2i5vwuDZDZw7c
 fhFhYj4aPUiEKvpOuwCZN6zqzILMldHBgedTHfnU0gXLCyX7Nd20g1VY1iUx7+liSqkR
 lIGAnu/pK2PvUTj4vI4aPQ1lp+B0ewge4kyfHXVC2XgIBfIT/RqCqsLh00LEkrtMwEGW
 Ia8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712689362; x=1713294162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9JT5x/b9oaUqCAXwkz87p9Kfabiba0RNb5HLj9kkfw=;
 b=UKEwpvqmQWMj3YBOiQMc79StBT32LW3gt8X/iAQYQwAl4dIFMediD5HOE4siy5MwQ4
 z2Fvt62CKmjd8CRHJZ4IO/WiG9ZyxbTKUxgETQtCnYiPN/A50RuBFf0ATD6/U838kuPg
 fxqe+dzkPyZ932kyfDEgLI3gcDZNENGPrDF1PlG8agK/TSzsimfsPXWVZjm5mC7O7qd3
 QGTgcGUdoFLgQoZt+zojB1SESOMXZ06rVF2yuyJKQGPh3hox8eXc3sef+m+sWJOSH+CO
 Rdw5jl1yUDG28HZfzTzirZxPUeSM6chpRH32qGn9ySvj5trNjN1NdiO5QDPfcGSxGObk
 3jUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/DNq8E2076i+aYVqN1QjugB1TtYKaOrjadKAqBw8jZB53TpRPGR734HPCCXYmXvqlPt6KZUkrPrCJJ9ufCiWTrKZ1STk=
X-Gm-Message-State: AOJu0Ywpv1Q0+6Yty7QhK+2n+c9QQj4UoygO4YRk4z1485DCWTa7ZEXJ
 qDUV2UGYsNlwolL4YxpSyvWUn8JcJcbSz9cEETlytLRMtGI079W2dthNvBbDrMqaz22nOC6yM2A
 rZJJf5HnWkUi0/KfZ33+HTlbMAPNP5yTrq4+Nsw==
X-Google-Smtp-Source: AGHT+IEhGXon713SAihpC+CGTqCe5Yi+IkEzhQrqxAFLZdzLSTS9HBsKOtlx/4EZ5ThM7PRsnpjepkyCsqvR+OR0zTE=
X-Received: by 2002:a5b:ac2:0:b0:de0:de85:e388 with SMTP id
 a2-20020a5b0ac2000000b00de0de85e388mr666317ybr.24.1712689362423; Tue, 09 Apr
 2024 12:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
 <20240405000707.2670063-3-horenchuang@bytedance.com>
 <20240405150244.00004b49@Huawei.com>
 <CAKPbEqpGM_nR+LKbsoFTviBZaKUKYqJ3zbJp9EOCJAGvuPy6aQ@mail.gmail.com>
 <20240409171204.00001710@Huawei.com>
In-Reply-To: <20240409171204.00001710@Huawei.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Tue, 9 Apr 2024 12:02:31 -0700
Message-ID: <CAKPbEqry55fc51hQ8oUC8so=PD_wWoJMEPiR-eq03BgB5q86Yw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v11 2/2] memory tier: create CPUless memory
 tiers after obtaining HMAT info
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Huang, Ying" <ying.huang@intel.com>,
 Gregory Price <gourry.memverge@gmail.com>, 
 aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org, 
 john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
 Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
 Alistair Popple <apopple@nvidia.com>,
 Srinivasulu Thanneeru <sthanneeru@micron.com>, 
 SeongJae Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linux Memory Management List <linux-mm@kvack.org>,
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, 
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org, 
 Hao Xiang <hao.xiang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=horenchuang@bytedance.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Jonathan,

On Tue, Apr 9, 2024 at 9:12=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 5 Apr 2024 15:43:47 -0700
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
>
> > On Fri, Apr 5, 2024 at 7:03=E2=80=AFAM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Fri,  5 Apr 2024 00:07:06 +0000
> > > "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
> > >
> > > > The current implementation treats emulated memory devices, such as
> > > > CXL1.1 type3 memory, as normal DRAM when they are emulated as norma=
l memory
> > > > (E820_TYPE_RAM). However, these emulated devices have different
> > > > characteristics than traditional DRAM, making it important to
> > > > distinguish them. Thus, we modify the tiered memory initialization =
process
> > > > to introduce a delay specifically for CPUless NUMA nodes. This dela=
y
> > > > ensures that the memory tier initialization for these nodes is defe=
rred
> > > > until HMAT information is obtained during the boot process. Finally=
,
> > > > demotion tables are recalculated at the end.
> > > >
> > > > * late_initcall(memory_tier_late_init);
> > > > Some device drivers may have initialized memory tiers between
> > > > `memory_tier_init()` and `memory_tier_late_init()`, potentially bri=
nging
> > > > online memory nodes and configuring memory tiers. They should be ex=
cluded
> > > > in the late init.
> > > >
> > > > * Handle cases where there is no HMAT when creating memory tiers
> > > > There is a scenario where a CPUless node does not provide HMAT info=
rmation.
> > > > If no HMAT is specified, it falls back to using the default DRAM ti=
er.
> > > >
> > > > * Introduce another new lock `default_dram_perf_lock` for adist cal=
culation
> > > > In the current implementation, iterating through CPUlist nodes requ=
ires
> > > > holding the `memory_tier_lock`. However, `mt_calc_adistance()` will=
 end up
> > > > trying to acquire the same lock, leading to a potential deadlock.
> > > > Therefore, we propose introducing a standalone `default_dram_perf_l=
ock` to
> > > > protect `default_dram_perf_*`. This approach not only avoids deadlo=
ck
> > > > but also prevents holding a large lock simultaneously.
> > > >
> > > > * Upgrade `set_node_memory_tier` to support additional cases, inclu=
ding
> > > >   default DRAM, late CPUless, and hot-plugged initializations.
> > > > To cover hot-plugged memory nodes, `mt_calc_adistance()` and
> > > > `mt_find_alloc_memory_type()` are moved into `set_node_memory_tier(=
)` to
> > > > handle cases where memtype is not initialized and where HMAT inform=
ation is
> > > > available.
> > > >
> > > > * Introduce `default_memory_types` for those memory types that are =
not
> > > >   initialized by device drivers.
> > > > Because late initialized memory and default DRAM memory need to be =
managed,
> > > > a default memory type is created for storing all memory types that =
are
> > > > not initialized by device drivers and as a fallback.
> > > >
> > > > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > > > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > > > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > >
> > > Hi - one remaining question. Why can't we delay init for all nodes
> > > to either drivers or your fallback late_initcall code.
> > > It would be nice to reduce possible code paths.
> >
> > I try not to change too much of the existing code structure in
> > this patchset.
> >
> > To me, postponing/moving all memory tier registrations to
> > late_initcall() is another possible action item for the next patchset.
> >
> > After tier_mem(), hmat_init() is called, which requires registering
> > `default_dram_type` info. This is when `default_dram_type` is needed.
> > However, it is indeed possible to postpone the latter part,
> > set_node_memory_tier(), to `late_init(). So, memory_tier_init() can
> > indeed be split into two parts, and the latter part can be moved to
> > late_initcall() to be processed together.
> >
> > Doing this all memory-type drivers have to call late_initcall() to
> > register a memory tier. I=E2=80=99m not sure how many they are?
> >
> > What do you guys think?
>
> Gut feeling - if you are going to move it for some cases, move it for
> all of them.  Then we only have to test once ;)
>
> J

Thank you for your reminder! I agree~ That's why I'm considering
changing them in the next patchset because of the amount of changes.
And also, this patchset already contains too many things.

> >
> > >
> > > Jonathan
> > >
> > >
> > > > ---
> > > >  mm/memory-tiers.c | 94 +++++++++++++++++++++++++++++++++++--------=
----
> > > >  1 file changed, 70 insertions(+), 24 deletions(-)
> > > >
> > > > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > > > index 516b144fd45a..6632102bd5c9 100644
> > > > --- a/mm/memory-tiers.c
> > > > +++ b/mm/memory-tiers.c
> > >
> > >
> > >
> > > > @@ -855,7 +892,8 @@ static int __init memory_tier_init(void)
> > > >        * For now we can have 4 faster memory tiers with smaller adi=
stance
> > > >        * than default DRAM tier.
> > > >        */
> > > > -     default_dram_type =3D alloc_memory_type(MEMTIER_ADISTANCE_DRA=
M);
> > > > +     default_dram_type =3D mt_find_alloc_memory_type(MEMTIER_ADIST=
ANCE_DRAM,
> > > > +                                                   &default_memory=
_types);
> > > >       if (IS_ERR(default_dram_type))
> > > >               panic("%s() failed to allocate default DRAM tier\n", =
__func__);
> > > >
> > > > @@ -865,6 +903,14 @@ static int __init memory_tier_init(void)
> > > >        * types assigned.
> > > >        */
> > > >       for_each_node_state(node, N_MEMORY) {
> > > > +             if (!node_state(node, N_CPU))
> > > > +                     /*
> > > > +                      * Defer memory tier initialization on
> > > > +                      * CPUless numa nodes. These will be initiali=
zed
> > > > +                      * after firmware and devices are initialized=
.
> > >
> > > Could the comment also say why we can't defer them all?
> > >
> > > (In an odd coincidence we have a similar issue for some CPU hotplug
> > >  related bring up where review feedback was move all cases later).
> > >
> > > > +                      */
> > > > +                     continue;
> > > > +
> > > >               memtier =3D set_node_memory_tier(node);
> > > >               if (IS_ERR(memtier))
> > > >                       /*
> > >
> >
> >
>


--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

