Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D399798B58
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:17:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qef65-0002wb-UB; Fri, 08 Sep 2023 13:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qef5n-0002qM-M0
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:16:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qef5j-0004S2-0z
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694193381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KyG6yYskFfylu1ISBmRUum9z6UuGCyuoOdIYi6VJ5SQ=;
 b=KgFfWdsc48wqFYmreg0h3b6jrWlJdcnk8SfP4SP3BZ1zQOIUZRMYufSXqw+4T0tvfKzttU
 fwSgXKqn2PQcGUUepjEP7q9O16Ku6G44CgsDEsuP9WsN4M3eX1i3pTBUyDulEHG+/egE8L
 mtaWYJ+5T2eTI/tGdTDGpH9FP60hi0Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-qqgqGZYhOMiyd0-YExti4g-1; Fri, 08 Sep 2023 13:16:18 -0400
X-MC-Unique: qqgqGZYhOMiyd0-YExti4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E98D08001EA;
 Fri,  8 Sep 2023 17:16:17 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FE63140E962;
 Fri,  8 Sep 2023 17:16:17 +0000 (UTC)
Date: Fri, 8 Sep 2023 19:16:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 00/51] Build system, i386 changes for 2023-09-07
Message-ID: <ZPtW4PXsVTo83IpN@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907154412.GA1550739@fedora> <ZPs3UB8W4lsOFnxW@redhat.com>
 <521ab2c6-f617-1a9e-fef6-29add2e62137@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <521ab2c6-f617-1a9e-fef6-29add2e62137@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 08.09.2023 um 18:11 hat Philippe Mathieu-Daudé geschrieben:
> Hi Kevin,
> 
> On 8/9/23 17:01, Kevin Wolf wrote:
> > Am 07.09.2023 um 17:44 hat Stefan Hajnoczi geschrieben:
> > > Applied, thanks.
> > > 
> > > Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.
> > 
> > Something in this has broken the build for me, it seems to be the
> > linux-user binary that doesn't link any more:
> > 
> >    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `cpu_x86_cpuid':
> >    /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:6180: undefined reference to `kvm_arch_get_supported_cpuid'
> 
> My patches. I can not reproduce so far,

Hm, ok. I can try to bisect it further then.

> What are your ./configure command options?

'/home/kwolf/source/qemu/configure' '--cc=clang' '--target-list=x86_64-linux-user,x86_64-softmmu,arm-softmmu,aarch64-softmmu' '--enable-debug' '--cxx=clang++' '--disable-blkio' 

Kevin

> >    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `x86_cpu_filter_features':
> >    /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7158: undefined reference to `kvm_arch_get_supported_cpuid'
> >    /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7159: undefined reference to `kvm_arch_get_supported_cpuid'
> >    /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7160: undefined reference to `kvm_arch_get_supported_cpuid'
> >    /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7161: undefined reference to `kvm_arch_get_supported_cpuid'
> >    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o:/home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7162: more undefined references to `kvm_arch_get_supported_cpuid' follow
> >    clang-15: error: linker command failed with exit code 1 (use -v to see invocation)
> > 
> > In case it makes a difference, I'm using clang on F37.
> > 
> > Kevin
> 


