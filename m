Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC207257C8
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 10:34:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6obf-0002H9-0P; Wed, 07 Jun 2023 04:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q6obb-0002Gt-V5
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:33:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q6obT-0003DS-4U
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686126793;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uy0770qaMWedsor4n7Mdoy4+YnmmOBTHH5nAqV7e7U4=;
 b=OG/x96TY20hI9lYIXKgU6MceOw8Q99T/SKCIbtug/rxlKE9vyStewoM1StUlhAikWEX8pX
 9hugCk0vyGxDLsogi3jNwGK+Wqa5drirO2aaKzixyoies65YoZISUswUHlypR+vkTmNvE6
 Hef/k57vLGW5cTAMGTxw6G075JpCmY8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-VzUu4XmuPpOUQoK43xfNEQ-1; Wed, 07 Jun 2023 04:33:08 -0400
X-MC-Unique: VzUu4XmuPpOUQoK43xfNEQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F225101A590;
 Wed,  7 Jun 2023 08:33:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B859F477F61;
 Wed,  7 Jun 2023 08:33:04 +0000 (UTC)
Date: Wed, 7 Jun 2023 09:33:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, imammedo@redhat.com, jusual@redhat.com,
 dfaggioli@suse.com, joao.m.martins@oracle.com, jon.grimm@amd.com,
 santosh.Shukla@amd.com
Subject: Re: [PATCH v5 3/3] pc: q35: Bump max_cpus to 1024
Message-ID: <ZIBAvooWylaNQ5Lb@redhat.com>
References: <20230607024939.703991-1-suravee.suthikulpanit@amd.com>
 <20230607024939.703991-4-suravee.suthikulpanit@amd.com>
 <81b16f60-87d6-3043-3f1c-d77f1bf8a1c4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81b16f60-87d6-3043-3f1c-d77f1bf8a1c4@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jun 07, 2023 at 10:26:59AM +0200, Philippe Mathieu-Daudé wrote:
> On 7/6/23 04:49, Suravee Suthikulpanit wrote:
> > Since KVM_MAX_VCPUS is currently defined to 1024 for x86 as shown in
> > arch/x86/include/asm/kvm_host.h, update QEMU limits to the same number.
> > 
> > In case KVM could not support the specified number of vcpus, QEMU would
> > return the following error message:
> > 
> >    qemu-system-x86_64: kvm_init_vcpu: kvm_get_vcpu failed (xxx): Invalid argument
> 
> Odd, we already check the upper limit with KVM_CAP_NR_VCPUS.
> See in kvm_init():
> 
>     /* check the vcpu limits */
>     soft_vcpus_limit = kvm_recommended_vcpus(s);
>     hard_vcpus_limit = kvm_max_vcpus(s);
> 
> When testing your series I get:
> 
> qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested (1024)
> exceeds the recommended cpus supported by KVM (710)
> 
> $ uname -srvp
> Linux 5.15.0-71-generic #78-Ubuntu SMP Tue Apr 18 09:00:29 UTC 2023 x86_64

That's a relatively old kernel. With latest kernels, the 'recommended cpus'
limit reported will match the number of CPUs in your host, so for me it
always complains for smp > 12.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


