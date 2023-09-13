Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5871D79E20D
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:28:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgLCc-0002og-QO; Wed, 13 Sep 2023 04:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgLCb-0002oX-2P
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgLCY-0005WG-9g
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694593581;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qyideyPRIQV+X/FGO4m/PhGms/irdUmq9FY+SbkaL40=;
 b=Mb4p8T7SzJbUjFoWKEAwCkcdUojZ42XOhstonEvBJfia/z5iPt9kxcpLm2IhqlIrsxVmGy
 vFYv96+vt5QWdXyeaEoarrMttW59/uYrOXA+PguhzyoQYfgR+V7/v6l4ppcwAVOjRkS1Z8
 3aUIOVrW+RmtqTB8UaWYTKwbl1m8VtA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-ZD5DkSfENoinm7XyHhVYSg-1; Wed, 13 Sep 2023 04:26:18 -0400
X-MC-Unique: ZD5DkSfENoinm7XyHhVYSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE0C888B7A2;
 Wed, 13 Sep 2023 08:26:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF62240C6EA8;
 Wed, 13 Sep 2023 08:26:16 +0000 (UTC)
Date: Wed, 13 Sep 2023 09:26:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-discuss <qemu-discuss@nongnu.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] hw/i386/pc_piix: Mark the machine types from version 1.4
 to 1.7 as deprecated
Message-ID: <ZQFyJnRyVJXP/eLX@redhat.com>
References: <20220117191639.278497-1-thuth@redhat.com>
 <YeXNoKzsFeIPSy6E@redhat.com>
 <44b4ce3f-030a-993a-b959-e8e722c7cee4@redhat.com>
 <3cc2c925-d2a8-36f4-28b6-db391b5bbf38@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cc2c925-d2a8-36f4-28b6-db391b5bbf38@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

On Wed, Sep 13, 2023 at 08:33:01AM +0200, Philippe Mathieu-Daudé wrote:
> On 18/1/22 09:49, Thomas Huth wrote:
> > On 17/01/2022 21.12, Daniel P. Berrangé wrote:
> > > On Mon, Jan 17, 2022 at 08:16:39PM +0100, Thomas Huth wrote:
> > > > The list of machine types grows larger and larger each release ... and
> > > > it is unlikely that many people still use the very old ones for live
> > > > migration. QEMU v1.7 has been released more than 8 years ago, so most
> > > > people should have updated their machines to a newer version in those
> > > > 8 years at least once. Thus let's mark the very old 1.x machine types
> > > > as deprecated now.
> > > 
> > > What criteria did you use for picking v1.7 as the end point ?
> > 
> > I picked everything starting with a "1." this time ;-)
> > 
> > No, honestly, since we don't have a deprecation policy in place yet,
> > there was no real good criteria around this time. For the machine types
> > < 1.3 there was a bug with migration, so these machine types could not
> > be used for reliable migration anymore anyway. But for the newer machine
> > types, we likely have to decide by other means indeed.
> > 
> > > I'm fine with the idea of aging out machine types, but I'd like us
> > > to explain the criteria we use for this, so that we can set clear
> > > expectations for users. I'm not a fan of adhoc decisions that have
> > > different impact every time we randomly decide to apply them.
> > > 
> > > A simple rule could be time based - eg we could say
> > > 
> > >    "we'll keep machine type versions for 5 years or 15 releases."
> > > 
> > > one factor is how long our downstream consumers have been keeping
> > > machines around for.
> > > 
> > > In RHEL-9 for example, the oldest machine is "pc-i440fx-rhel7.6.0"
> > > which IIUC is derived from QEMU 2.12.0. RHEL-9 is likely to rebase
> > > QEMU quite a few times over the coming years, so that 2.12.0 version
> > > sets an example baseline for how long machines might need to live for.
> > > That's 4 years this April, and could potentially be 6-7 years by the
> > > time RHEL-9 stops rebasing QEMU.
> > 
> > Yeah, 5 years still seemed a little bit short to me, that's one of the
> > reasons why I did not add more machine types in my patch here. I think
> > with 7 or 8 years, we should be on the safe side.
> > 
> > Any other opinions? And if we agree on an amount of years, where should
> > we document this? At the top of docs/about/deprecated.rst?
> 
> I suppose x86 being the oldest, x86 maintainers have to comment, but
> 5 years should be enough from sysadmins to migrate their VMs, isn't it?
> (No need to migrate from 1 -> 8, they can do 1 -> 3 -> 5 -> 8, right?)

You can't change guest hardware during migrate. So whether you go direct
from 1 -> 8, or go from 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7 -> 8, you're
going to have the same guest hardware before and after every step.


If someone is using upstream QEMU, I'm sceptical they will successfully
live migrate over QEMU versions spanning 5+ years. While we make a pretty
decent effort at ensuring back compat, and fixing problems, we've had
a number of mistakes over the years, that were caught in RHEL downstream
testing.

If someone is using RHEL QEMU (or another vendor who's putting in alot
of effort at live migration testing), then I can see them spanning over
5 years for a VM deployment. Of course they *should* have VM reboots over
that timeframe to deploy new kernels for example, so they will have had
opportunities to update the machine type, but it does not mean they have
actually done so.

The pc-i440fx-rhel7.6.0 machine type I mentioned earlier in the thread is
a bit of an unusual case, as that has lasted longer than intended (RHEL-7,
RHEL-8, and RHEL-9). Normally our downstream policy is for machine types
to last 2 major RHEL releases, so you can deploy on N and later upgrade
the VM to N+1 without a reboot for re-configuration.

Now in the case of RHEL we don't use upstream QEMU machines types, so we
don't actually care when QEMU deprecates and deletes old machine types.

What matter is whether there are any internal tunable knobs that were
used in the pc_compat_*_fn() functions that get deleted as a result
of their usage going away.  For example our rhel7.6.0 machine type uses

    m->async_pf_vmexit_disable = true;
    m->smbus_no_migration_support = true;
    m->deprecation_reason = rhel_old_machine_deprecation;
    pcmc->pvh_enabled = false;
    pcmc->default_cpu_version = CPU_VERSION_LEGACY;
    pcmc->kvmclock_create_always = false;
    pcmc->pci_root_uid = 1;
    pcmc->legacy_no_rng_seed = true;
    pcmc->enforce_amd_1tb_hole = false;

Deleting any of those upstream is what would impact us downstream.


Personally I think we could make a case for QEMU upstream only
preserving machine types for 5 years, on the basis that people
interested in longer lifetimes should be using a vendor supported
QEMU. Upstream community just doesn't have the resources todo the
level of testing needed to provide such long life guarantees on
migration compat.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


