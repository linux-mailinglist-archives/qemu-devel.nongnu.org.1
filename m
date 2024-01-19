Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B4F832764
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 11:11:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQloc-00020B-3N; Fri, 19 Jan 2024 05:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQloZ-0001wX-VP
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 05:09:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQloY-0007Eh-5F
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 05:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705658969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Migo7T0jQKXV0XcEd9xW1k66AHKgKw42yZhBkgGG2ys=;
 b=AbhGEHY+F6KkQnhehxcKwrYsDrj7IZcItbv+fi/6i/uCqnUqnSXiCSQ2OrbUr+0wGi2uFI
 +VyRuMpCD/Mbuc9q38bh9zY1NeCezEHyfmHK54scNSiMSSn8Ual7DL89Oj28izuHR21fW2
 sO6qnrKO8ZveT1lusE3AVXBfFAgS7NY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-x1kt7xAyM2yDBWZoYPV-WQ-1; Fri,
 19 Jan 2024 05:09:25 -0500
X-MC-Unique: x1kt7xAyM2yDBWZoYPV-WQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DADF1C0CCA2;
 Fri, 19 Jan 2024 10:09:24 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 484F32166B33;
 Fri, 19 Jan 2024 10:09:22 +0000 (UTC)
Date: Fri, 19 Jan 2024 11:09:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Marc Zyngier <maz@kernel.org>, Andrew Jones <ajones@ventanamicro.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 qemu-arm@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v3 13/14] hw/arm: Prefer arm_feature(AARCH64) over
 object_property_find(aarch64)
Message-ID: <ZapH_23WyMrcH72f@redhat.com>
References: <20240110195329.3995-1-philmd@linaro.org>
 <20240110195329.3995-14-philmd@linaro.org>
 <ff57e1f5-ea78-459e-b51c-48040483bdea@linaro.org>
 <865y009p6b.wl-maz@kernel.org>
 <585e091b-d75c-408c-bc19-72728ff45e6f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <585e091b-d75c-408c-bc19-72728ff45e6f@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 11.01.2024 um 11:08 hat Philippe Mathieu-Daudé geschrieben:
> On 11/1/24 10:47, Marc Zyngier wrote:
> > On Thu, 11 Jan 2024 09:39:18 +0000,
> > Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> > > 
> > > On 10/1/24 20:53, Philippe Mathieu-Daudé wrote:
> > > > The "aarch64" property is added to ARMCPU when the
> > > > ARM_FEATURE_AARCH64 feature is available. Rather than
> > > > checking whether the QOM property is present, directly
> > > > check the feature.
> > > > 
> > > > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > ---
> > > >    hw/arm/virt.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > > index 49ed5309ff..a43e87874c 100644
> > > > --- a/hw/arm/virt.c
> > > > +++ b/hw/arm/virt.c
> > > > @@ -2140,7 +2140,7 @@ static void machvirt_init(MachineState *machine)
> > > >            numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
> > > >                              &error_fatal);
> > > >    -        aarch64 &= object_property_get_bool(cpuobj, "aarch64",
> > > > NULL);
> > > > +        aarch64 &= arm_feature(cpu_env(cs), ARM_FEATURE_AARCH64);
> > > 
> > > So after this patch there are no more use of the ARMCPU "aarch64"
> > > property from code. Still it is exposed via the qom-tree. Thus it
> > > can be set (see aarch64_cpu_set_aarch64). I could understand one
> > > flip this feature to create a custom CPU (as a big-LITTLE setup
> > > as Marc mentioned on IRC), but I don't understand what is the
> > > expected behavior when this is flipped at runtime. Can that
> > > happen in real hardware (how could the guest react to that...)?
> > 
> > I don't think it makes any sense to do that while a guest is running
> > (and no HW I'm aware of would do this). However, it all depends what
> > you consider "run time". You could imagine creating a skeletal VM with
> > all features, and then apply a bunch of changes before the guest
> > actually runs.
> 
> Thanks, this makes sense and confirms my guess.
> 
> > I don't know enough about the qom-tree and dynamic manipulation of
> > these properties though, and I'm likely to be wrong about the expected
> > usage model.
> 
> Kevin, Markus, this seems a good example of QOM "config" property that
> is RW *before* Realize and should become RO *after* it.
> 
> QDev properties has PropertyInfo::realized_set_allowed set to false by
> default, but here this property is added at the QOM (lower) layer, so
> there is no such check IIUC.

You can take almost any other config property and it will show the same
pattern. This is the normal case (and one of the reasons why the current
way of doing QOM properties isn't great).

As you say, qdev tries to take care of this. In pure QOM properties, the
property setter must have manually implemented checks, and perhaps not
very surprisingly, people tend to forget to add them.

> Should "aarch64" become a static QDev property instead (registered via
> device_class_set_props -> qdev_class_add_property)?
> 
> This just an analyzed example, unfortunately there are many more...

target/arm/cpu64.c already seems to use a wild mix of ways to add
properties, so maybe it wouldn't make things worse...

It's good to look at such devices because it shows how hard QAPIfication
of all devices would become (fortunately the subset we're really
interested in most is user creatable devices, and I don't think users
can create CPUs with -device even though they look like it and are
mentioned in -device help?).

The basic requirement for QAPIfication is that each type has a fixed
list of properties. This is easy with devices that create their
properties with a single device_class_set_props(), but devices that
directly create properties, some of them conditional, and spread across
several different functions, it becomes hard to see what the real list
of properties is.

Even worse, there are properties whose creation depends on runtime
options like which accelerator is used ("pauth-impdef" and
"pauth-qarma3" exist only for TCG). There is no way to write a schema
for that. In QAPI, you can have it optional and return an error if it's
set when it shouldn't be, but the existence of the property itself can't
(currently?) depend on runtime options.

Kevin


