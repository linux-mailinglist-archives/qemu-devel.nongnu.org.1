Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C35897F3376
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 17:17:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5TPy-00008l-5j; Tue, 21 Nov 2023 11:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r5TPi-0008Vo-9T
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:15:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r5TPc-0007P4-N9
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700583343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NnucUi+/R0BaZHjCDwL8D6nQ+zvNgcWUydNL3ywRI0A=;
 b=V08Orv8nNrYzkWKODk9BSdrhzHgCNLRNmNyd3tgiFIUCH9NXMQhjFUrQqXtUqeqoEeHiSA
 DE7b2zueTSvHcc5ZniROKW+KSvAVpl/y0T8zYcF+CtMJ1/gdrhCrkOn5Rv72jKGBMmx+aR
 pxPdX51583kzq2nK8pNswue9cOwJ4Ao=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-0SgrcFmOM06iwd7t96cpmA-1; Tue,
 21 Nov 2023 11:15:39 -0500
X-MC-Unique: 0SgrcFmOM06iwd7t96cpmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6D411C0758A;
 Tue, 21 Nov 2023 16:15:38 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E3A240C6EB9;
 Tue, 21 Nov 2023 16:15:37 +0000 (UTC)
Date: Tue, 21 Nov 2023 10:15:35 -0600
From: Eric Blake <eblake@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Dan Hoffman <dhoff749@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH v3] hw/i386: fix short-circuit logic with non-optimizing
 builds
Message-ID: <viiqn6gyn25xitens3ft4mp4lditlcrswstugct42t2kvpw6pi@3ftcrbxmuo3e>
References: <20231119203116.3027230-1-dhoff749@gmail.com>
 <3c44d5a5-818b-46b6-a07f-af655a060032@linaro.org>
 <CAFXChKJrXAop188pTFcU0YNPocn_KyiAXiqWoES2F0_==VyO+Q@mail.gmail.com>
 <20231120042116-mutt-send-email-mst@kernel.org>
 <9282a606-794a-432c-8b56-fedf6af67768@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9282a606-794a-432c-8b56-fedf6af67768@linaro.org>
User-Agent: NeoMutt/20231103
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Nov 20, 2023 at 11:20:52AM +0100, Philippe Mathieu-Daudé wrote:
> (Cc'ing Eric)
> 
> On 20/11/23 10:28, Michael S. Tsirkin wrote:
> > On Sun, Nov 19, 2023 at 07:34:58PM -0600, Dan Hoffman wrote:
> > > As far as I can tell, yes. Any optimization level above O0 does not have this
> > > issue (on this version of Clang, at least)
> > 
> > Aha, this is with -O0. That makes sense.
> 
> But then, why the other cases aren't problematic?
> 
> $ git grep -E ' (&&|\|\|) !?kvm_enabled'
> hw/arm/boot.c:1228:    assert(!(info->secure_board_setup && kvm_enabled()));

This one's obvious; no kvm_*() calls in the assert.

> hw/i386/microvm.c:270:        (mms->rtc == ON_OFF_AUTO_AUTO &&
> !kvm_enabled())) {

Ones like this require reading context to see whether the if() block
guarded any kvm_*() calls for the linker to elide - but still a fairly
easy audit.

> > > 
> > >      I'm surprised the order of conditions matters for code elision...
> > > 
> > >      > Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
> > >      > ---
> > >      >   hw/i386/x86.c | 15 ++++++++++++---
> > >      >   1 file changed, 12 insertions(+), 3 deletions(-)
> > >      >
> > >      > diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> > >      > index b3d054889bb..2b6291ad8d5 100644
> > >      > --- a/hw/i386/x86.c
> > >      > +++ b/hw/i386/x86.c
> > >      > @@ -131,8 +131,12 @@ void x86_cpus_init(X86MachineState *x86ms, int
> > >      default_cpu_version)
> > >      >       /*
> > >      >        * Can we support APIC ID 255 or higher?  With KVM, that requires
> > >      >        * both in-kernel lapic and X2APIC userspace API.
> > >      > +     *
> > >      > +     * kvm_enabled() must go first to ensure that kvm_* references are
> > >      > +     * not emitted for the linker to consume (kvm_enabled() is
> > >      > +     * a literal `0` in configurations where kvm_* aren't defined)
> > >      >        */
> > >      > -    if (x86ms->apic_id_limit > 255 && kvm_enabled() &&
> > >      > +    if (kvm_enabled() && x86ms->apic_id_limit > 255 &&
> > >      >           (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {

Indeed, if clang -O0 treats 'if (cond1 && 0 && cond2)' differently
than 'if (0 && cond1 && cond2)' for purposes of eliding the code for
cond2, that seems like a blatant missed optimization that we should be
reporting to the clang folks.

While this patch may solve the immediate issue, it does not scale - if
we ever have two separate guards that can both be independently
hard-coded to 0 based on configure-time decisions, but which are both
used as guards in the same expression, it will become impossible to
avoid a '(cond1 && 0 && cond2)' scenario across all 4 possible
configurations of those two guards.

I have no objection to the patch, but it would be nice if the commit
message could point to a clang bug report, if one has been filed.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


