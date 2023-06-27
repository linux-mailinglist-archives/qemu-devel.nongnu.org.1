Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AB873FB2D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:35:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE6yX-00048n-Ul; Tue, 27 Jun 2023 07:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qE6yR-000485-2X
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qE6yO-0000xj-W9
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687865703;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y3yF6hHe+yhoHqMTDSgjyZjCkNEdtQ2Q+TjuNmOmCxI=;
 b=VSqBP9ny/JCvQt7PR0nvPxBfSUDsISj77otg1QLPzqqcz6f7H7dsossxGG1jfwk9iEUlNG
 AB6ly6WjIYVB2w/Hud5hHetKjiNsfJaP3++qrjV2XFN5G0LW0fuMS/28FqrZjSpj8wZsj9
 l7i4oXHV+pdWWMyeekqVjjrwWDwIfOg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-dG8n-mE5Mre8k1UelZ8Mag-1; Tue, 27 Jun 2023 07:34:59 -0400
X-MC-Unique: dG8n-mE5Mre8k1UelZ8Mag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EBE0104458F;
 Tue, 27 Jun 2023 11:34:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 403FB200A3AD;
 Tue, 27 Jun 2023 11:34:58 +0000 (UTC)
Date: Tue, 27 Jun 2023 12:34:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Tao Su <tao1.su@linux.intel.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com, lei4.wang@intel.com,
 qian.wen@intel.com
Subject: Re: [PATCH 6/7] target/i386: Add new CPU model EmeraldRapids
Message-ID: <ZJrJYG1dICHjKx09@redhat.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
 <20230616032311.19137-7-tao1.su@linux.intel.com>
 <20230626145610.64405831@imammedo.users.ipa.redhat.com>
 <c18ebbaf-0ea8-3cd5-9fb8-6e63add59fba@intel.com>
 <20230627104918.1a2152c6@imammedo.users.ipa.redhat.com>
 <cdbf2132-ef13-1f36-2845-2783bb515309@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdbf2132-ef13-1f36-2845-2783bb515309@intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Jun 27, 2023 at 07:25:21PM +0800, Xiaoyao Li wrote:
> On 6/27/2023 4:49 PM, Igor Mammedov wrote:
> > On Tue, 27 Jun 2023 13:54:23 +0800
> > Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> > 
> > > On 6/26/2023 8:56 PM, Igor Mammedov wrote:
> > > > On Fri, 16 Jun 2023 11:23:10 +0800
> > > > Tao Su<tao1.su@linux.intel.com>  wrote:
> > > > > From: Qian Wen<qian.wen@intel.com>
> > > > > 
> > > > > Emerald Rapids (EMR) is the next generation of Xeon server processor
> > > > > after Sapphire Rapids (SPR).
> > > > > 
> > > > > Currently, regarding the feature set that can be exposed to guest, there
> > > > > isn't any one new comparing with SPR cpu model, except that EMR has a
> > > > > different model number.
> > > > > 
> > > > > Though it's practicable to define EMR as an alias of a new version of
> > > > > SPR by only updating the model number and model name, it loses the
> > > > > flexibility when new version of EMR cpu model are needed for adding new
> > > > > features (that hasn't virtalized/supported by KVM yet).
> > > > Which begs a question, why do we need EMR model (or alias) at all
> > > > if it's the same as SPR at the moment.
> > > > 
> > > > Make new features supported 1st and only then introduce a new CPU model.
> > > 
> > > Even if no new feature (that can be virtualized and exposed to guest) in
> > > EMR compared to SPR in the end, I think it still makes sense to provide
> > > a dedicated EMR CPU model in QEMU. Because
> > > 1) User will know EMR, Intel's next generation of Xeon after SRP, is
> > > supported by QEMU, via -cpu ?/ -cpu help;
> > 
> > I don't see any benefits in misleading user by showing EMR model which is
> > nothing else but SPR one.
> > On negative side you would increase maintenance burden by introducing
> > extra versions of CPU model later. Which by itself is abusing versioning,
> > mainly used for fixing CPU bugs, by using it for adding new features.
> > 
> > > 2) It's convenient for user to create an EMR VM. People may not care
> > > that much what the difference between "-cpu SapphireRapids" with "-cpu
> > > EmeraldRapids", while they do want to create an VM which shows the CPU
> > > is EmeraldRapids.
> > > 
> > My guess would be is that you need guest to show EMR for developing EMR
> > features/guest bringup, in that case do it in your fork, and once
> > support is actually ready publish completed patches for it.
> 
> No. I meant for CSPs who want to provide an EMR virtual machine to their
> customers, or lab admin provides an EMR (virtual) machine to its user.
> 
> Without a dedicated EmeraldRapids cpu model provided by QEMU, they need to
> use something like
> 
>   -cpu SapphireRapids,model=207,model-id="Intel Xeon Processor
> (EmeraldRapids)"
>
> It's likely that no difference in supported features between SPR cpu model
> and EMR cpu model in the end. If so, will QEMU choose to provide a dedicated
> CPU model for EMR? or just document somewhere to QEMU users that "if you
> want to create an virtual machine with EMR cpu model, please go with SPR cpu
> model while changing it's model number to EMR's 207 and changing model-id to
> tell EmeraldRapids" ?

I think QEMU's answer would be to not bother trying todo this at all,
just expose '-cpu SapphireRapids', because there's no functional benefit
to overriding the model ID, when all the CPUID features are identical.

Those who have the guest to see the *perfect* functional match of the
host still have '-cpu host' available.

The named CPU models are for the case where we want a rough approximation
for a CPU generation available, to easy migration across mixed CPU clusters.
Given the intent is to have a rough approximation, there's no compelling
reason to add an exact EmeraldRapids named CPU.

> > To exaggerate you reasoning further, we should create CPU models for
> > all future planned Intel/AMD CPU as a one of currently existing in
> > QEMU right now and then sometime in future implement features that
> > actually make those models what they should be.
> 
> No, it's not the purpose. In fact, we're not adding an temporary EMR cpu
> model while planing to complement it in the future. Instead, we are adding
> an official EMR cpu model. The fact is, in terms of the features that are
> virtualizable and can be exposed to guest, there is no difference between
> SPR and EMR.
> 
> This comes to a basic question：Will QEMU provide a EMR cpu model even if no
> difference to SPR cpu model except the model number?

Historically we have generally only added new CPU models if there was
a feature difference. We've skipped adding many of the Intel models
that didn't add bring new features, on the basis that there is no
compelling functional need to have them.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


