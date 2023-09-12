Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 372E379D872
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 20:12:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg7rl-0002FZ-8D; Tue, 12 Sep 2023 14:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg7ri-0002FQ-Pt
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:11:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg7rg-00087p-2z
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694542314;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bYpE3fXI9ZqacA7IFvTtwRfHFIHfoLKsW+imoQklpCY=;
 b=QxwlMyTuyGJ1iRZ+uR2bcw5Bgtjp7lMyRpxgWJEHKz/JPdWTQZNAR3XAg+KfnAHasl5xt2
 evIoZRYHww+y0yninkx2cSIsXAppAWgELHI1Jlgpmj/yFq7/x63ntUoBZ1n941sQOltZdj
 W7TfBIXOvLagdD3dKUCxgvAOybovAbk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-TusVsnwTMU2f707-b-lDig-1; Tue, 12 Sep 2023 14:11:53 -0400
X-MC-Unique: TusVsnwTMU2f707-b-lDig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B70A63806721;
 Tue, 12 Sep 2023 18:11:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F197063F9D;
 Tue, 12 Sep 2023 18:11:50 +0000 (UTC)
Date: Tue, 12 Sep 2023 19:11:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Bin Meng <bmeng@tinylab.org>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: cherry-picking something to -stable which might require other
 changes
Message-ID: <ZQCp5MXSu+su/Bmc@redhat.com>
References: <e6385fc7-0889-ea16-4fc0-337796814636@tls.msk.ru>
 <CAJSP0QUfF64wWQbbAqKpeUWGEOz6jB2ZHkmJhaRXfRDFLpD_kw@mail.gmail.com>
 <ZQCCcM1gUy3ODnyj@redhat.com>
 <4bc435cf-d6c7-885b-f806-48c961279b10@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bc435cf-d6c7-885b-f806-48c961279b10@tls.msk.ru>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Sep 12, 2023 at 09:01:43PM +0300, Michael Tokarev wrote:
> 12.09.2023 18:23, Daniel P. Berrangé wrote:
> ..
> > I tend to try to cherry-pick the dependancies in case (1) too
> > unless they are functionally invasive. Any time you manually
> > adjust a patch, you increase the likelihood that later cherry
> > picks will also require manual work. So I always favour a clean
> > cherry-pick until the point the functional risk becomes
> > unacceptable in the context of testing the change I'm pulling
> > back.
> 
> Yeah, that's exactly my thought: if something in the subsystem
> has changed, esp. when the new thing is now widely used, it is
> best to try to pick it up (unless it is a big change by itself
> or is a part of big change).
> 
> I already mentioned a trivial fix c255946e3df4 in this thread,
> which can be applied cleanly if two other no-change patches are
> in, 753ae97abc7 and dadee9e3ce6.  It is much more likely to hit
> conflicts in this area in future updates if such updates will
> happen if such renames like these two aren't picked up.
> 
> So, right in this same patch series, there's one more very similar
> change:
> 
> commit 9ff31406312500053ecb5f92df01dd9ce52e635d
> Author: Conor Dooley <conor.dooley@microchip.com>
> Date:   Thu Jul 27 15:24:17 2023 +0100
> 
>     hw/riscv: virt: Fix riscv,pmu DT node path
> 
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -719,7 +719,7 @@ static void create_fdt_pmu(RISCVVirtState *s)
>      MachineState *ms = MACHINE(s);
>      RISCVCPU hart = s->soc[0].harts[0];
> 
> -    pmu_name = g_strdup_printf("/soc/pmu");
> +    pmu_name = g_strdup_printf("/pmu");
>      qemu_fdt_add_subnode(ms->fdt, pmu_name);
>      qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu");
>      riscv_pmu_generate_fdt_node(ms->fdt, hart.cfg.pmu_num, pmu_name);
> 
> But all the nearby lines are touched by previous patch:
> 
> commit 568e0614d0979e0431a8d9dc0503a63b8b0f2d81
> Author: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Date:   Tue Jan 24 18:22:33 2023 -0300
> 
>     hw/riscv/virt.c: rename MachineState 'mc' pointers to 'ms'
> ...
>     Rename all 'mc' MachineState pointers to 'ms'. This is a very tedious
>     and mechanical patch that was produced by doing the following:
> 
>     - find/replace all 'MachineState *mc' to 'MachineState *ms';
>     - find/replace all 'mc->fdt' to 'ms->fdt';
>     - find/replace all 'mc->smp.cpus' to 'ms->smp.cpus';
>     - replace any remaining occurrences of 'mc' that the compiler complained
>     about.
> 
> This patch by Daniel is a no-code-change, it really is just a rename of
> variables.  I can rename variable back from ms to mc in the fix patch,
> or I can apply this rename first and apply the fix patch cleanly, and
> all subsequent changes will have much more chance to apply cleanly too.
> 
> What a wonderful world.. ;)
> 
> Thankfully, such cases are rare.  But we do have a few famous cases like this
> still, some of which I also mentioned in the first message in this thread.

Also this is the key reason why many reviewers will complain if patches
are too large, or contain a mixture of functional and non-functional
changes, or do two jobs at once. Bigger commits with varying & unrelated
changes makes cherry picking much more painful

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


