Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F03B1CC6D
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Aug 2025 21:20:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujjfI-0003kH-9C; Wed, 06 Aug 2025 15:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujjfF-0003je-47
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 15:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujjfC-0006n5-Cp
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 15:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754507939;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/I2aVo3uOqEwJVvWHWYAMLDxxe2QbpW2QSyKxRFbj0=;
 b=VDNoR4hAWjbUe85cyTBUViR03pGk/u6bn7XwgVUA6ucfkagCA6DFPRUQQ3RGTtNIULoUDp
 mMzkJc4EXrVzvJenh9YMfUyWelaGUWSB7UCEEJV+3io+U/M5XLS7D+EKBb6i15B1x5rnji
 BStVlKYusqMg7i2kWg7oXhk2kuU1FDA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605--7PqZUnTPSS7fUL9OEAjJg-1; Wed,
 06 Aug 2025 15:18:58 -0400
X-MC-Unique: -7PqZUnTPSS7fUL9OEAjJg-1
X-Mimecast-MFC-AGG-ID: -7PqZUnTPSS7fUL9OEAjJg_1754507937
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DC1B1800359; Wed,  6 Aug 2025 19:18:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60C101956086; Wed,  6 Aug 2025 19:18:55 +0000 (UTC)
Date: Wed, 6 Aug 2025 20:18:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: Issues with pdcm in qemu 10.1-rc on migration and save/restore
Message-ID: <aJOqmxTimJ_mFCqp@redhat.com>
References: <CAATJJ0+Qq3ksRmNRDrGQLVHQ=XnsnFHxCNxUhjJfNfgwUKkDPQ@mail.gmail.com>
 <aJNDxxjeqkOLAO2r@redhat.com>
 <CAATJJ0L-E=JsKOX_E=jqraeK__jLF851DDbEx5psVkTMSppKXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAATJJ0L-E=JsKOX_E=jqraeK__jLF851DDbEx5psVkTMSppKXw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 06, 2025 at 07:57:34PM +0200, Christian Ehrhardt wrote:
> On Wed, Aug 6, 2025 at 2:00 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Wed, Aug 06, 2025 at 01:52:17PM +0200, Christian Ehrhardt wrote:
> > > Hi,
> > > I was unsure if this would be better sent to libvirt or qemu - the
> > > issue is somewhere between libvirt modelling CPUs and qemu 10.1
> > > behaving differently. I did not want to double post and gladly most of
> > > the people are on both lists - since the switch in/out of the problem
> > > is qemu 10.0 <-> 10.1 let me start here. I beg your pardon for not yet
> > > having all the answers, I'm sure I could find more with debugging, but
> > > I also wanted to report early for your awareness while we are still in
> > > the RC phase.
> > >
> > >
> > > # Problem
> > >
> > > What I found when testing migrations in Ubuntu with qemu 10.1-rc1 was:
> > >   error: operation failed: guest CPU doesn't match specification:
> > > missing features: pdcm
> > >
> > > This is behaving the same with libvirt 11.4 or the more recent 11.6.
> > > But switching back to qemu 10.0 confirmed that this behavior is new
> > > with qemu 10.1-rc.
> >
> >
> > > Without yet having any hard evidence against them I found a few pdcm
> > > related commits between 10.0 and 10.1-rc1:
> > >   7ff24fb65 i386/tdx: Don't mask off CPUID_EXT_PDCM
> > >   00268e000 i386/cpu: Warn about why CPUID_EXT_PDCM is not available
> > >   e68ec2980 i386/cpu: Move adjustment of CPUID_EXT_PDCM before
> > > feature_dependencies[] check
> > >   0ba06e46d i386/tdx: Add TDX fixed1 bits to supported CPUIDs
> > >
> > >
> > > # Caveat
> > >
> > > My test environment is in LXD system containers, that gives me issues
> > > in the power management detection
> > >   libvirtd[406]: error from service: GDBus.Error:System.Error.EROFS:
> > > Read-only file system
> > >   libvirtd[406]: Failed to get host power management capabilities
> >
> > That's harmless.
> 
> Yeah, it always was for me - thanks for confirming.
> 
> > > And the resulting host-model on a  rather old test server will therefore have:
> > >   <cpu mode='custom' match='exact' check='full'>
> > >     <model fallback='forbid'>Haswell-noTSX-IBRS</model>
> > >     <vendor>Intel</vendor>
> > >     <feature policy='require' name='vmx'/>
> > >     <feature policy='disable' name='pdcm'/>
> > >      ...
> > >
> > > But that was fine in the past, and the behavior started to break
> > > save/restore or migrations just now with the new qemu 10.1-rc.
> > >
> > > # Next steps
> > >
> > > I'm soon overwhelmed by meetings for the rest of the day, but would be
> > > curious if one has a suggestion about what to look at next for
> > > debugging or a theory about what might go wrong. If nothing else comes
> > > up I'll try to set up a bisect run tomorrow.
> >
> > Yeah, git bisect is what I'd start with.
> 
> Bisect complete, identified this commit
> 
> commit 00268e00027459abede448662f8794d78eb4b0a4
> Author: Xiaoyao Li <xiaoyao.li@intel.com>
> Date:   Tue Mar 4 00:24:50 2025 -0500
> 
>     i386/cpu: Warn about why CPUID_EXT_PDCM is not available
> 
>     When user requests PDCM explicitly via "+pdcm" without PMU enabled, emit
>     a warning to inform the user.
> 
>     Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>     Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>     Link: https://lore.kernel.org/r/20250304052450.465445-3-xiaoyao.li@intel.com
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
>  target/i386/cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> 
> 
> Which is odd as it should only add a warning right?

No, that commit message is misleading.

IIUC mark_unavailable_features() actively blocks usage of the feature,
so it is a functional change, not merely a emitting warning.

It makes me wonder if that commit was actually intended to block the
feature or not, vs merely warning ?  CC'ing those involved in the
commit.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


