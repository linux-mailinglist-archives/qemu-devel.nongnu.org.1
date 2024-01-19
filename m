Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF15E832DBB
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 18:12:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQsOb-0003S5-QR; Fri, 19 Jan 2024 12:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1rQsOZ-0003Rc-Kw
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:11:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1rQsOV-0008Ha-9E
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705684261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=teVV1G3dIhk02HiOjgb5h/E9/MZ569rnhfatZPQH/NQ=;
 b=EBy9vJ0XKX0a4eq1fg9RQTtx1TO7k9dhQnIbLgg+l+Iq7uNuRnEtO+N9OlqoLYvQBB/F+Y
 7muzfx+DFxTWhnCEzqt3s4QyxHo//CpXq0hBc7hUQbFKH4XC23WhNAb6moaBTwDWfP4sje
 9bdcikPHD/dEX1vWxJH81XBPnEaaja4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-9mqvIjuKPvudEgfmh_bdbA-1; Fri, 19 Jan 2024 12:09:23 -0500
X-MC-Unique: 9mqvIjuKPvudEgfmh_bdbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D43D7891069;
 Fri, 19 Jan 2024 17:09:22 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76E9B200BC63;
 Fri, 19 Jan 2024 17:09:22 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
 id 7BC91401E1115; Fri, 19 Jan 2024 13:14:43 -0300 (-03)
Date: Fri, 19 Jan 2024 13:14:43 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Lei Wang <lei4.wang@intel.com>
Subject: Re: Why invtsc (CPUID_APM_INVTSC) is unmigratable?
Message-ID: <Zaqf839r8TXvkIAf@tpad>
References: <825f29d7-9112-45a2-b4a3-7d3b54c3c0a2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <825f29d7-9112-45a2-b4a3-7d3b54c3c0a2@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mtosatti@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

On Fri, Jan 19, 2024 at 02:46:22PM +0800, Xiaoyao Li wrote:
> I'm wondering why CPUID_APM_INVTSC is set as unmigratable_flags. Could
> anyone explain it?


commit 68bfd0ad4a1dcc4c328d5db85dc746b49c1ec07e
Author: Marcelo Tosatti <mtosatti@redhat.com>
Date:   Wed May 14 16:30:09 2014 -0300

    target-i386: block migration and savevm if invariant tsc is exposed
    
    Invariant TSC documentation mentions that "invariant TSC will run at a
    constant rate in all ACPI P-, C-. and T-states".
    
    This is not the case if migration to a host with different TSC frequency
    is allowed, or if savevm is performed. So block migration/savevm.

So the rationale here was that without ensuring the destination host 
has the same TSC clock frequency, we can't migrate.

However, this was later extended to allow invtsc migratioon when setting
tsc-khz explicitly:

commit d99569d9d8562c480e0befab601756b0b7b5d0e0
Author: Eduardo Habkost <ehabkost@redhat.com>
Date:   Sun Jan 8 15:32:34 2017 -0200

    kvm: Allow invtsc migration if tsc-khz is set explicitly
    
    We can safely allow a VM to be migrated with invtsc enabled if
    tsc-khz is set explicitly, because:
    * QEMU already refuses to start if it can't set the TSC frequency
      to the configured value.
    * Management software is already required to keep device
      configuration (including CPU configuration) the same on
      migration source and destination.
    
    Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
    Message-Id: <20170108173234.25721-3-ehabkost@redhat.com>
    Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

And support for libvirt was added:

https://listman.redhat.com/archives/libvir-list/2017-January/141757.html

> 
> When the host supports invtsc, it can be exposed to guest.
> When the src VM has invtsc exposed, what will forbid it to be migrated to a
> dest that also supports VMs with invtsc exposed?
> 
> 


