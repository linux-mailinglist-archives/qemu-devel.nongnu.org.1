Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F867719943
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 12:18:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4fNO-0001Lv-7G; Thu, 01 Jun 2023 06:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4fNI-0001LO-67
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 06:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4fNF-00037F-87
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 06:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685614659;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qNcMLbMB+M/UiQW5N8WcSoOX0hLqXoFVHZoOZgRsTeo=;
 b=K6UAHsbntWW+YSQO4VCGG217dL8O1d6G++KXqJhNISQhlkm+IpRMhmbk+otZn60MNwvS7T
 wAFMGTAWFG8iI0gSHBa2dqcrfvqpp9Sub7kF66gHKE4BT9PygpVpjIFQ7VwUVBGB4eK/XQ
 P0DtiMgm1KYeZlwX1pyePbIaNjlptjw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-lwN0LN_INRyI60u3xkYU5A-1; Thu, 01 Jun 2023 06:17:36 -0400
X-MC-Unique: lwN0LN_INRyI60u3xkYU5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A7BC3813F26;
 Thu,  1 Jun 2023 10:17:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A982F40C6EC4;
 Thu,  1 Jun 2023 10:17:33 +0000 (UTC)
Date: Thu, 1 Jun 2023 11:17:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, imammedo@redhat.com, jusual@redhat.com,
 jon.grimm@amd.com, santosh.Shukla@amd.com,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2] pc: q35: Bump max_cpus to 1024
Message-ID: <ZHhwOrfXMjjOmcAK@redhat.com>
References: <20230531225127.331998-1-suravee.suthikulpanit@amd.com>
 <39a49814-28d8-ffc8-42b4-3af14bb9dd47@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39a49814-28d8-ffc8-42b4-3af14bb9dd47@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 01, 2023 at 11:09:45AM +0100, Joao Martins wrote:
> 
> 
> On 31/05/2023 23:51, Suravee Suthikulpanit wrote:
> > Since KVM_MAX_VCPUS is currently defined to 1024 for x86 as shown in
> > arch/x86/include/asm/kvm_host.h, update QEMU limits to the same number.
> > 
> > In case KVM could not support the specified number of vcpus, QEMU would
> > return the following error message:
> > 
> >   qemu-system-x86_64: kvm_init_vcpu: kvm_get_vcpu failed (xxx): Invalid argument
> > 
> > Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > ---
> > 
> > Changes from V1:
> > (https://lore.kernel.org/all/YnkDGsIi1vFvXmiP@redhat.com/T/)
> >  * Bump from 512 to KVM_MAX_VCPUS (per Igor's suggestion)
> > 
> > Note:
> >  From the last discussion, Daniel mentioned that SMBIO 2.1 tables might
> >  cause overflow at approx 720 CPUs, and it might require using the
> >  SMBIO 3.0 entry point. Also, we might need to change the default for
> >  the x86 machine type to SMBIO 3.0. However, I do not know the status
> >  of this.
> > 
> I suspect smbios 3.0 (64-bit entry point) is already supported.
> 
> With current qemu and all the smbios fixes in the last cycle, perhaps this is
> mainly just setting smbios_entry_point_type to SMBIOS_ENTRY_POINT_TYPE_64 if
> MachineState::smp::max_cpus is bigger than 720 (e.g. in pc_q35_init()?)

The need for the 64-bit entry point depends on a combination of RAM config
and CPU count. IMHO we need to unconditionally switch the latest machine
types to use the 64-bit entry point by default, rather than trying to infer
some special condition to dynamically change on the fly.

Before doing that we need confirmation that our firmware builds in qemu.git
(SeaBIOS and EDK2) will be happy with the 64-bit EP. I suspect they should
be fine by now, but I've CC'd Gerd to confirm.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


