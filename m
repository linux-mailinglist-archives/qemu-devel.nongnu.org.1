Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8A48414B9
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Jan 2024 21:56:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUYf8-0002Xn-HD; Mon, 29 Jan 2024 15:55:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1rUYf6-0002XL-H0
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 15:55:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1rUYf4-0006gd-KB
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 15:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706561720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9LU7HQQtwQg78KvFg4Afns0hEHW69r/RgK6v+YCUQHY=;
 b=gqc+sF2kxUac3pInlU3FynE1RhBGH/t81R3kpWJIYzsSS32pDNiyHZgnz9BxJiGFKMMu0l
 stgLyt9v3Iq6O9rO9K+JWw2x5YzWk6GfSsv0U/FNqfRod1Ca/aZycxxrzvVJhPiOOP8z/A
 spA+6b864dFXHRHHeqpEbwqzyyccp4E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635--U_Yf4nJP2K_kHxQb66epw-1; Mon, 29 Jan 2024 15:55:18 -0500
X-MC-Unique: -U_Yf4nJP2K_kHxQb66epw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8CCA85A5BE;
 Mon, 29 Jan 2024 20:55:17 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66083C2590D;
 Mon, 29 Jan 2024 20:55:17 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
 id 1C784400DFD54; Mon, 29 Jan 2024 17:54:02 -0300 (-03)
Date: Mon, 29 Jan 2024 17:54:02 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Lei Wang <lei4.wang@intel.com>
Subject: Re: Why invtsc (CPUID_APM_INVTSC) is unmigratable?
Message-ID: <ZbgQan6k5AHBwLOL@tpad>
References: <825f29d7-9112-45a2-b4a3-7d3b54c3c0a2@intel.com>
 <Zaqf839r8TXvkIAf@tpad>
 <b6950a34-0ef6-4945-9e50-5a47e86490e1@intel.com>
 <Za/doRj6sEibC64y@tpad>
 <e34d49cc-b743-4df1-9a31-96c987dc2ad3@intel.com>
 <ZbGJnbo1CJyAk61y@tpad>
 <846644e9-27c5-4d7a-b2ec-7d94ba2dcc19@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <846644e9-27c5-4d7a-b2ec-7d94ba2dcc19@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mtosatti@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jan 26, 2024 at 04:16:57PM +0800, Xiaoyao Li wrote:
> On 1/25/2024 6:05 AM, Marcelo Tosatti wrote:
> > On Wed, Jan 24, 2024 at 10:52:46PM +0800, Xiaoyao Li wrote:
> > > On 1/23/2024 11:39 PM, Marcelo Tosatti wrote:
> > > > On Sat, Jan 20, 2024 at 05:44:07PM +0800, Xiaoyao Li wrote:
> > > > > On 1/20/2024 12:14 AM, Marcelo Tosatti wrote:
> > > > > > On Fri, Jan 19, 2024 at 02:46:22PM +0800, Xiaoyao Li wrote:
> > > > > > > I'm wondering why CPUID_APM_INVTSC is set as unmigratable_flags. Could
> > > > > > > anyone explain it?
> > > > > > 
> > > > > > 
> > > > > > commit 68bfd0ad4a1dcc4c328d5db85dc746b49c1ec07e
> > > > > > Author: Marcelo Tosatti <mtosatti@redhat.com>
> > > > > > Date:   Wed May 14 16:30:09 2014 -0300
> > > > > > 
> > > > > >        target-i386: block migration and savevm if invariant tsc is exposed
> > > > > >        Invariant TSC documentation mentions that "invariant TSC will run at a
> > > > > >        constant rate in all ACPI P-, C-. and T-states".
> > > > > >        This is not the case if migration to a host with different TSC frequency
> > > > > >        is allowed, or if savevm is performed. So block migration/savevm.
> > > > > > 
> > > > > > So the rationale here was that without ensuring the destination host
> > > > > > has the same TSC clock frequency, we can't migrate.
> > > > > 
> > > > > It seems to me the concept of invtsc was extended to "tsc freq will not
> > > > > change even after the machine is live migrated". I'm not sure it is correct
> > > > > to extend the concept of invtsc.
> > > > > 
> > > > > The main reason of introducing invtsc is to tell the tsc hardware keeps
> > > > > counting (at the same rate) even at deep C state, so long as other states.
> > > > > 
> > > > > For example, a guest is created on machine A with X GHz tsc, and invtsc
> > > > > exposed (machine A can ensure the guest's tsc counts at X GHz at any state).
> > > > > If the guest is migrated to machine B with Y GHz tsc, and machine B can also
> > > > > ensure the invtsc of its guest, i.e., the guest's tsc counts at Y GHz at any
> > > > > state. IMHO, in this case, the invtsc is supported at both src and dest,
> > > > > which means it is a migratable feature. However, the migration itself fails,
> > > > > due to mismatched/different configuration of tsc freq, not due to invtsc.
> > > > > 
> > > > > > However, this was later extended to allow invtsc migratioon when setting
> > > > > > tsc-khz explicitly:
> > > > > > 
> > > > > > commit d99569d9d8562c480e0befab601756b0b7b5d0e0
> > > > > > Author: Eduardo Habkost <ehabkost@redhat.com>
> > > > > > Date:   Sun Jan 8 15:32:34 2017 -0200
> > > > > > 
> > > > > >        kvm: Allow invtsc migration if tsc-khz is set explicitly
> > > > > >        We can safely allow a VM to be migrated with invtsc enabled if
> > > > > >        tsc-khz is set explicitly, because:
> > > > > >        * QEMU already refuses to start if it can't set the TSC frequency
> > > > > >          to the configured value.
> > > > > >        * Management software is already required to keep device
> > > > > >          configuration (including CPU configuration) the same on
> > > > > >          migration source and destination.
> > > > > >        Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > > >        Message-Id: <20170108173234.25721-3-ehabkost@redhat.com>
> > > > > >        Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > > 
> > > > > But in the case that user doesn't set tsc freq explicitly, the live
> > > > > migration is likely to fail or have issues even without invtsc exposed to
> > > > > guest,
> > > > 
> > > > Depends on how the guest is using the TSC, but yes.
> > > > 
> > > > > if the destination host has a different tsc frequency than src host.
> > > > > 
> > > > > So why bother checking invtsc only?
> > > > 
> > > > Well, if invtsc is exposed to the guest, then it might use the TSC for
> > > > timekeeping purposes.
> > > > 
> > > > Therefore you don't want to fail (on the invtsc clock characteristics)
> > > > otherwise timekeeping in the guest might be problematic.
> > > > 
> > > > But this are all just heuristics.
> > > > 
> > > > Do you have a suggestion for different behaviour?
> > > 
> > > I think we need to block live migration when user doesn't specify a certain
> > > tsc frequency explicitly, regardless of invtsc.
> > 
> > Problem is if that guest is using kvmclock for timekeeping, then live migration
> > is safe (kvmclock logic will update the tsc frequency of the destination
> > host upon migration).
> > 
> 
> It surprises me kvmclock can do it. Cloud you please elaborate it a bit how
> kvmclock achieve it during migration or point me to some codes in Linux?

MSR_KVM_SYSTEM_TIME_NEW description at
Documentation/virt/kvm/x86/msr.rst and

arch/x86/kernel/pvclock.c, __pvclock_clocksource_read function.


