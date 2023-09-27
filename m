Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6387B07F9
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:18:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWIj-0004F3-MR; Wed, 27 Sep 2023 11:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qlWIZ-0004EB-Ot
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qlWIX-0007kZ-Cd
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695827875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TWzmkkCGCUKVLekHJqVFLLk2pKbCMFy4FAQuyWnpmDA=;
 b=GfTHcL7DCVvE1sLOkXBF+h+rfJw9qB9sp7Pw7UGoqeTUGkH2wTOJLqM9zJkXWVpPC9IbZf
 R8+QupHZnwWf6caops6tVIOKbqkhx/1Dj/tGged1NSzppN02PVkpN9edpx6kRZ+75dQB16
 yVZ2EVEQekg0ruHvulVSMEnmG3vh8D4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-EE9SMFjCNC-X7yl-2E29_Q-1; Wed, 27 Sep 2023 11:17:54 -0400
X-MC-Unique: EE9SMFjCNC-X7yl-2E29_Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4053d832d51so92537715e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 08:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695827873; x=1696432673;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TWzmkkCGCUKVLekHJqVFLLk2pKbCMFy4FAQuyWnpmDA=;
 b=ujvlOdQ5tGb2Xt/wzkqaf4BowXU8XAlh9rtitpMmySHUD+UBPVJnKrBTIV5B9DMtT7
 yosWD69YJ2xZg3MyTw1xZlhaKY5DrDAFt8hkbZN20pZC3ixZMLKWtng8zZXZSiLK/c7w
 xTBMUBv+sZA3l9SAVW9rzGF7BcOt5lxL7FDXGhcrTU5qB0L2QGZfvC15HjTxes6LGuWT
 qJ0BIDnONXqzNdYXum3geRXp/aoR7RdthtNTY1TmqrLTYyRx3NRkpOesRsVGzEqVnpAG
 V3mhJ2cbq9yo2H7/WFW8NuzSBLYLyq4DBG0470ckLGU49ojPrhZuDXK1vihzEF+TrZs/
 Jh4Q==
X-Gm-Message-State: AOJu0YyyXejXHrwjp/EngnyxVpUExxjXxIYTOdlaJJ4E1MKe4kiS6GUt
 Dh96sh8ZhIeVUxC98QBAtJ3JhPwsjlIWjR74SlDSRk48KtmDHV8HIj5Qa9vCdnR+XYVatnLKEg7
 Hz0jY6cvIa55Paws=
X-Received: by 2002:a7b:c415:0:b0:405:377f:5417 with SMTP id
 k21-20020a7bc415000000b00405377f5417mr2187406wmi.39.1695827872795; 
 Wed, 27 Sep 2023 08:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJgmezse+J1wNjE8MK59OwGZ81jMSTuFB1ykJfbs2HNLGnSoXh4Upp8w1cEnL8F5IoS3VD3w==
X-Received: by 2002:a7b:c415:0:b0:405:377f:5417 with SMTP id
 k21-20020a7bc415000000b00405377f5417mr2187383wmi.39.1695827872386; 
 Wed, 27 Sep 2023 08:17:52 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16e:b9f6:556e:c001:fe18:7e0a])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a05600c0b4300b003fe1fe56202sm18068228wmr.33.2023.09.27.08.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 08:17:51 -0700 (PDT)
Date: Wed, 27 Sep 2023 11:17:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: lixianglai <lixianglai@loongson.cn>
Cc: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Bernhard Beschow <shentey@gmail.com>, Salil Mehta <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
Message-ID: <20230927111651-mutt-send-email-mst@kernel.org>
References: <cover.1695697701.git.lixianglai@loongson.cn>
 <c2ab409710f5e0f0346727b47aaabd14537d45b8.1695697701.git.lixianglai@loongson.cn>
 <17a09b8ab65542be8561cb0480dae6bd@huawei.com>
 <20230926071055-mutt-send-email-mst@kernel.org>
 <4cc68780b63f47879d757fe604f37892@huawei.com>
 <20230926074945-mutt-send-email-mst@kernel.org>
 <54482e7486564d68926ded075ebe8c6f@huawei.com>
 <55beb69e-0adf-1bea-89ef-ebc4dabed673@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55beb69e-0adf-1bea-89ef-ebc4dabed673@loongson.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 26, 2023 at 08:49:27PM +0800, lixianglai wrote:
> 
> Hi Salil Mehta via  And Michael S. Tsirkin:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, September 26, 2023 12:54 PM
> > > To: Salil Mehta <salil.mehta@huawei.com>
> > > Cc: xianglai li <lixianglai@loongson.cn>; qemu-devel@nongnu.org; Bernhard
> > > Beschow <shentey@gmail.com>; Salil Mehta <salil.mehta@opnsrc.net>; Xiaojuan
> > > Yang <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Igor
> > > Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>; Paolo
> > > Bonzini <pbonzini@redhat.com>; Richard Henderson
> > > <richard.henderson@linaro.org>; Eduardo Habkost <eduardo@habkost.net>;
> > > Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daudé
> > > <philmd@linaro.org>; wangyanan (Y) <wangyanan55@huawei.com>; Daniel P.
> > > Berrangé <berrange@redhat.com>; Peter Xu <peterx@redhat.com>; David
> > > Hildenbrand <david@redhat.com>; Bibo Mao <maobibo@loongson.cn>
> > > Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
> > > 
> > > On Tue, Sep 26, 2023 at 11:45:19AM +0000, Salil Mehta wrote:
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Tuesday, September 26, 2023 12:12 PM
> > > > > To: Salil Mehta <salil.mehta@huawei.com>
> > > > > Cc: xianglai li <lixianglai@loongson.cn>; qemu-devel@nongnu.org;
> > > Bernhard
> > > > > Beschow <shentey@gmail.com>; Salil Mehta <salil.mehta@opnsrc.net>;
> > > Xiaojuan
> > > > > Yang <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Igor
> > > > > Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>; Paolo
> > > > > Bonzini <pbonzini@redhat.com>; Richard Henderson
> > > > > <richard.henderson@linaro.org>; Eduardo Habkost <eduardo@habkost.net>;
> > > > > Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daudé
> > > > > <philmd@linaro.org>; wangyanan (Y) <wangyanan55@huawei.com>; Daniel P.
> > > > > Berrangé <berrange@redhat.com>; Peter Xu <peterx@redhat.com>; David
> > > > > Hildenbrand <david@redhat.com>; Bibo Mao <maobibo@loongson.cn>
> > > > > Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
> > > > > 
> > > > > On Tue, Sep 26, 2023 at 10:49:08AM +0000, Salil Mehta wrote:
> > > > > > Hi Xianglai,
> > > > > > FYI. RFC V2 is out and you can now drop the arch agnostic patches
> > > from
> > > > > > your patch-set. Please check the details in the cover letter which
> > > one
> > > > > > you need to pick and rebase from:
> > > > > > 
> > > > > > https://lore.kernel.org/qemu-devel/20230926100436.28284-1-
> > > > > salil.mehta@huawei.com/T/#t
> > > > > > I am planning to float the architecture agnostic patch-set within
> > > this
> > > > > > week which will have same patches and in same order as mentioned in
> > > > > > the cover letter. This will untie the development across different
> > > > > > architectures.
> > > > > > 
> > > > > > Many thanks
> > > > > > Salil.
> > > > > However, please get authorship info right. This claims patch has been
> > > > > codeveloped by Bernhard Beschow, xianglai li and yourself.
> > > > > Your patch claims a completely different list of authors
> > > > Yes, because those are the people who have developed the patches.
> > > > 
> > > > > with yourself being the only common author.
> > > > > Not nice.
> > > > I have already replied in the other thread. This patch has been
> > > > taken from the ARM patch-set sent in the year 2020.
> > > > 
> > > > I am not sure who is the other author and how he has contributed.
> > > > 
> > > > Co-developed-by usually points at main authors.
> > > > 
> > > 
> > > If you are not sure then find out please.
> > 
> > We really have not collaborated on anything as part of
> > this entire development of virtual CPU hotplug since the
> > year 2020?
> > 
> > I would leave it to Xianglai to answer about the person.
> > 
> 
> I did not participate in the hot swap of arm virtualized cpu.
> 
> I just referred to the patch sent by Salil Mehta to the community.
> 
> Since his patch has not been integrated into qemu's code repository,
> 
> I referred to Salil Mehta's patch to ensure that my code could run.
> 
> I added Co-developed-by in order to show respect for the achievements of his
> labor,
> 
> which is all my fault. I wrongly used Co-developed-by, and I apologize for
> that.
> 
> I will delete the first two patches until the unrelated patches in Salil
> Mehta's architecture are combined,
> 
> and then submit my own patch.
> 
> 
> Thanks,
> 
> Xianglai.

I see. The correct way is to simply keep the original author.
I don't know what you used to apply the patch but e.g. git am
will do exactly that for you.
Add your own S.O.B at the bottom and you are all set.


> 
> > 
> > > And to help you stop guessing at the rules:
> > > 
> > > Documentation/process/submitting-patches.rst
> > > 
> > > 	Co-developed-by: states that the patch was co-created by multiple
> > > developers;
> > > 	it is used to give attribution to co-authors (in addition to the
> > > author
> > > 	attributed by the From: tag) when several people work on a single
> > > patch.  Since
> > > 	Co-developed-by: denotes authorship, every Co-developed-by: must be
> > > immediately
> > > 	followed by a Signed-off-by: of the associated co-author.  Standard
> > > sign-off
> > > 	procedure applies, i.e. the ordering of Signed-off-by: tags should
> > > reflect the
> > > 	chronological history of the patch insofar as possible, regardless of
> > > whether
> > > 	the author is attributed via From: or Co-developed-by:.  Notably, the
> > > last
> > > 	Signed-off-by: must always be that of the developer submitting the
> > > patch.
> > 
> > Sure, ARM patch-set follows exactly above rules.
> > 
> > 
> > 
> > > > > > > From: xianglai li <lixianglai@loongson.cn>
> > > > > > > Sent: Tuesday, September 26, 2023 10:54 AM
> > > > > > > To: qemu-devel@nongnu.org
> > > > > > > Cc: Bernhard Beschow <shentey@gmail.com>; Salil Mehta
> > > > > > > <salil.mehta@opnsrc.net>; Salil Mehta <salil.mehta@huawei.com>;
> > > > > Xiaojuan
> > > > > > > Yang <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>;
> > > > > Michael S.
> > > > > > > Tsirkin <mst@redhat.com>; Igor Mammedov <imammedo@redhat.com>; Ani
> > > > > Sinha
> > > > > > > <anisinha@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
> > > > > > > Henderson <richard.henderson@linaro.org>; Eduardo Habkost
> > > > > > > <eduardo@habkost.net>; Marcel Apfelbaum
> > > <marcel.apfelbaum@gmail.com>;
> > > > > > > Philippe Mathieu-Daudé <philmd@linaro.org>; wangyanan (Y)
> > > > > > > <wangyanan55@huawei.com>; Daniel P. Berrangé <berrange@redhat.com>;
> > > > > Peter
> > > > > > > Xu <peterx@redhat.com>; David Hildenbrand <david@redhat.com>; Bibo
> > > Mao
> > > > > > > <maobibo@loongson.cn>
> > > > > > > Subject: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
> > > > > > > 
> > > > > > > CPUs Control device(\\_SB.PCI0) register interface for the x86 arch
> > > > > > > is based on PCI and is IO port based and hence existing cpus AML
> > > code
> > > > > > > assumes _CRS objects would evaluate to a system resource which
> > > > > describes
> > > > > > > IO Port address.
> > > > > > > But on Loongarch arch CPUs control device(\\_SB.PRES) register
> > > > > interface
> > > > > > > is memory-mapped hence _CRS object should evaluate to system
> > > resource
> > > > > > > which describes memory-mapped base address.
> > > > > > > 
> > > > > > > This cpus AML code change updates the existing interface of the
> > > build
> > > > > cpus
> > > > > > > AML
> > > > > > > function to accept both IO/MEMORY type regions and update the _CRS
> > > > > object
> > > > > > > correspondingly.
> > > > > > > 
> > > > > > > Co-authored-by: "Bernhard Beschow" <shentey@gmail.com>
> > > > > > > Co-authored-by: "Salil Mehta" <salil.mehta@opnsrc.net>
> > > > > > > Co-authored-by: "Salil Mehta" <salil.mehta@huawei.com>
> > > > > > > Cc: "Bernhard Beschow" <shentey@gmail.com>
> > > > > > > Cc: "Salil Mehta" <salil.mehta@huawei.com>
> > > > > > > Cc: "Salil Mehta" <salil.mehta@opnsrc.net>
> > > > > > > Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> > > > > > > Cc: Song Gao <gaosong@loongson.cn>
> > > > > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > > > > Cc: Igor Mammedov <imammedo@redhat.com>
> > > > > > > Cc: Ani Sinha <anisinha@redhat.com>
> > > > > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > > > > Cc: Richard Henderson <richard.henderson@linaro.org>
> > > > > > > Cc: Eduardo Habkost <eduardo@habkost.net>
> > > > > > > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > > > > > Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
> > > > > > > Cc: Yanan Wang <wangyanan55@huawei.com>
> > > > > > > Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> > > > > > > Cc: Peter Xu <peterx@redhat.com>
> > > > > > > Cc: David Hildenbrand <david@redhat.com>
> > > > > > > Cc: Bibo Mao <maobibo@loongson.cn>
> > > > > > > Signed-off-by: xianglai li <lixianglai@loongson.cn>
> > > > > > > ---
> > > > > > >   hw/acpi/cpu.c         | 20 +++++++++++++++-----
> > > > > > >   hw/i386/acpi-build.c  |  3 ++-
> > > > > > >   include/hw/acpi/cpu.h |  5 +++--
> > > > > > >   3 files changed, 20 insertions(+), 8 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> > > > > > > index 5bad983928..0afa04832e 100644
> > > > > > > --- a/hw/acpi/cpu.c
> > > > > > > +++ b/hw/acpi/cpu.c
> > > > > > > @@ -6,6 +6,7 @@
> > > > > > >   #include "qapi/qapi-events-acpi.h"
> > > > > > >   #include "trace.h"
> > > > > > >   #include "sysemu/numa.h"
> > > > > > > +#include "hw/acpi/cpu_hotplug.h"
> > > > > > > 
> > > > > > >   #define OVMF_CPUHP_SMI_CMD 4
> > > > > > > 
> > > > > > > @@ -332,9 +333,10 @@ const VMStateDescription vmstate_cpu_hotplug =
> > > {
> > > > > > >   #define CPU_FW_EJECT_EVENT "CEJF"
> > > > > > > 
> > > > > > >   void build_cpus_aml(Aml *table, MachineState *machine,
> > > > > CPUHotplugFeatures
> > > > > > > opts,
> > > > > > > -                    build_madt_cpu_fn build_madt_cpu, hwaddr
> > > io_base,
> > > > > > > +                    build_madt_cpu_fn build_madt_cpu, hwaddr
> > > > > mmap_io_base,
> > > > > > >                       const char *res_root,
> > > > > > > -                    const char *event_handler_method)
> > > > > > > +                    const char *event_handler_method,
> > > > > > > +                    AmlRegionSpace rs)
> > > > > > >   {
> > > > > > >       Aml *ifctx;
> > > > > > >       Aml *field;
> > > > > > > @@ -359,14 +361,22 @@ void build_cpus_aml(Aml *table, MachineState
> > > > > > > *machine, CPUHotplugFeatures opts,
> > > > > > >           aml_append(cpu_ctrl_dev, aml_mutex(CPU_LOCK, 0));
> > > > > > > 
> > > > > > >           crs = aml_resource_template();
> > > > > > > -        aml_append(crs, aml_io(AML_DECODE16, io_base, io_base, 1,
> > > > > > > +        if (rs == AML_SYSTEM_IO) {
> > > > > > > +            aml_append(crs, aml_io(AML_DECODE16, mmap_io_base,
> > > > > > > mmap_io_base, 1,
> > > > > > >                                  ACPI_CPU_HOTPLUG_REG_LEN));
> > > > > > > +        } else {
> > > > > > > +            aml_append(crs, aml_memory32_fixed(mmap_io_base,
> > > > > > > +                               ACPI_CPU_HOTPLUG_REG_LEN,
> > > > > AML_READ_WRITE));
> > > > > > > +        }
> > > > > > > +
> > > > > > >           aml_append(cpu_ctrl_dev, aml_name_decl("_CRS", crs));
> > > > > > > 
> > > > > > > +        g_assert(rs == AML_SYSTEM_IO || rs == AML_SYSTEM_MEMORY);
> > > > > > >           /* declare CPU hotplug MMIO region with related access
> > > fields
> > > > > */
> > > > > > >           aml_append(cpu_ctrl_dev,
> > > > > > > -            aml_operation_region("PRST", AML_SYSTEM_IO,
> > > > > aml_int(io_base),
> > > > > > > -                                 ACPI_CPU_HOTPLUG_REG_LEN));
> > > > > > > +            aml_operation_region("PRST", rs,
> > > > > > > +                                         aml_int(mmap_io_base),
> > > > > > > +
> > > ACPI_CPU_HOTPLUG_REG_LEN));
> > > > > > >           field = aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK,
> > > > > > >                             AML_WRITE_AS_ZEROS);
> > > > > > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > > > > > index 863a939210..7016205d15 100644
> > > > > > > --- a/hw/i386/acpi-build.c
> > > > > > > +++ b/hw/i386/acpi-build.c
> > > > > > > @@ -1550,7 +1550,8 @@ build_dsdt(GArray *table_data, BIOSLinker
> > > > > *linker,
> > > > > > >               .fw_unplugs_cpu = pm->smi_on_cpu_unplug,
> > > > > > >           };
> > > > > > >           build_cpus_aml(dsdt, machine, opts, pc_madt_cpu_entry,
> > > > > > > -                       pm->cpu_hp_io_base, "\\_SB.PCI0",
> > > > > "\\_GPE._E02");
> > > > > > > +                       pm->cpu_hp_io_base, "\\_SB.PCI0",
> > > > > "\\_GPE._E02",
> > > > > > > +                       AML_SYSTEM_IO);
> > > > > > >       }
> > > > > > > 
> > > > > > >       if (pcms->memhp_io_base && nr_mem) {
> > > > > > > diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> > > > > > > index bc901660fb..601f644e57 100644
> > > > > > > --- a/include/hw/acpi/cpu.h
> > > > > > > +++ b/include/hw/acpi/cpu.h
> > > > > > > @@ -60,9 +60,10 @@ typedef void (*build_madt_cpu_fn)(int uid, const
> > > > > > > CPUArchIdList *apic_ids,
> > > > > > >                                     GArray *entry, bool
> > > force_enabled);
> > > > > > >   void build_cpus_aml(Aml *table, MachineState *machine,
> > > > > CPUHotplugFeatures
> > > > > > > opts,
> > > > > > > -                    build_madt_cpu_fn build_madt_cpu, hwaddr
> > > io_base,
> > > > > > > +                    build_madt_cpu_fn build_madt_cpu, hwaddr
> > > > > mmap_io_base,
> > > > > > >                       const char *res_root,
> > > > > > > -                    const char *event_handler_method);
> > > > > > > +                    const char *event_handler_method,
> > > > > > > +                    AmlRegionSpace rs);
> > > > > > > 
> > > > > > >   void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList
> > > > > > > ***list);
> > > > > > > 
> > > > > > > --
> > > > > > > 2.39.1
> > > > > > > 


