Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C35AB5991
	for <lists+qemu-devel@lfdr.de>; Tue, 13 May 2025 18:18:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEsK8-0005jf-11; Tue, 13 May 2025 12:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEsK5-0005iz-Bs
 for qemu-devel@nongnu.org; Tue, 13 May 2025 12:17:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEsK3-0003QC-Id
 for qemu-devel@nongnu.org; Tue, 13 May 2025 12:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747153058;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xrlJmq+sxj06Pce/vrGFl4DL6yT50KGGqCTzoiNbwfQ=;
 b=h+o+XToxQEBvKB0HK59T2SBAtisQzhBdUG6kt/e4BymM5TUsGzZr6are6/XF6KrMJEgVyh
 y2WoKXjYB2eiKEYhLN/6x7Dz/0afAYL/kmgrxaPKbXZrT2ZrDeLKVrGmFuXFybu9ehw3TP
 xrZQfgwVRstksNQLAnG5a8Q7IneBYy4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-EqwJaqy9O9WjiFPI_ymCpQ-1; Tue,
 13 May 2025 12:17:35 -0400
X-MC-Unique: EqwJaqy9O9WjiFPI_ymCpQ-1
X-Mimecast-MFC-AGG-ID: EqwJaqy9O9WjiFPI_ymCpQ_1747153053
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C3C2195DE0B; Tue, 13 May 2025 16:17:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9100930001A1; Tue, 13 May 2025 16:17:27 +0000 (UTC)
Date: Tue, 13 May 2025 17:17:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH for-10.1 v5 02/13] arm/cpu: Store aa64isar0/aa64zfr0 into
 the idregs arrays
Message-ID: <aCNwlHK5lNNLzxeX@redhat.com>
References: <20250409144304.912325-1-cohuck@redhat.com>
 <20250409144304.912325-3-cohuck@redhat.com>
 <aCNoEs-jQ7IUTt8q@redhat.com> <875xi4pkqp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xi4pkqp.fsf@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, May 13, 2025 at 05:56:46PM +0200, Cornelia Huck wrote:
> On Tue, May 13 2025, Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Wed, Apr 09, 2025 at 04:42:53PM +0200, Cornelia Huck wrote:
> >> From: Eric Auger <eric.auger@redhat.com>
> >> 
> >> Also add kvm add accessors for storing host features into idregs.
> >> 
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >> ---
> >>  target/arm/cpu-features.h | 57 ++++++++++++++++++++-------------------
> >>  target/arm/cpu-sysregs.h  |  4 +++
> >>  target/arm/cpu.c          | 10 +++----
> >>  target/arm/cpu.h          |  2 --
> >>  target/arm/cpu64.c        |  8 +++---
> >>  target/arm/helper.c       |  6 +++--
> >>  target/arm/hvf/hvf.c      |  3 ++-
> >>  target/arm/kvm.c          | 30 ++++++++++++++++++---
> >>  target/arm/tcg/cpu64.c    | 44 ++++++++++++++++++------------
> >>  9 files changed, 101 insertions(+), 63 deletions(-)
> >
> >> diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
> >> index 7877a3b06a8e..e89a1105904c 100644
> >> --- a/target/arm/cpu-sysregs.h
> >> +++ b/target/arm/cpu-sysregs.h
> >> @@ -39,4 +39,8 @@ extern const uint32_t id_register_sysreg[NUM_ID_IDX];
> >>  
> >>  int get_sysreg_idx(ARMSysRegs sysreg);
> >>  
> >> +#ifdef CONFIG_KVM
> >> +uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg);
> >> +#endif
> >
> > This breaks the build when KVM is disabled, and/or not available
> > on the build target architecture
> >
> > In file included from ../target/arm/cpu.h:35,
> >                  from /var/home/berrange/src/virt/qemu/include/hw/arm/digic.h:21,
> >                  from ../hw/arm/digic_boards.c:31:
> > /var/home/berrange/src/virt/qemu/target/arm/cpu-sysregs.h:42:8: error: attempt to use poisoned ‘CONFIG_KVM’
> >    42 | #ifdef CONFIG_KVM
> >       |        ^
> > In file included from /var/home/berrange/src/virt/qemu/include/exec/poison.h:7,
> >                  from /var/home/berrange/src/virt/qemu/include/qemu/osdep.h:38,
> >                  from ../hw/arm/digic_boards.c:26:
> > ./config-poison.h:185:20: note: poisoned here
> >   185 | #pragma GCC poison CONFIG_KVM
> >       |                    ^~~~~~~~~~
> > ninja: build stopped: subcommand failed.
> 
> I have already fixed that one in v6.

Ah yes, I was testing v5 as that one can apply with the KVM CPU model series

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


