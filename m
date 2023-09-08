Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E998C798B78
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:23:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qefCO-0000Eg-M5; Fri, 08 Sep 2023 13:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qefCL-0000EP-6p
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qefCE-0006iO-1G
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694193785;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBRqMtuxxfB/lHxJNCYqlzo+xSpvJmuma2QgbOnHZh4=;
 b=gNHw5gD042sUhoJK9HOKlRWooRHA5SsX/5C9JDDndz2wh5cS3SGmwejE6DX1bVIoP0wuUQ
 yfWzGI+BrSLnqvuCJBYh8oAkw1qrXQqeAX5txwMfKEP66Xl6BTMwqPJJWbAAlYAA1/azI3
 4XfkP7OJySDATVdQvw/f5BkLXe4NRDU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-F6oFHC8tMrCS2GvXB0cohQ-1; Fri, 08 Sep 2023 13:23:00 -0400
X-MC-Unique: F6oFHC8tMrCS2GvXB0cohQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B516281CC25;
 Fri,  8 Sep 2023 17:23:00 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B641D2026D2B;
 Fri,  8 Sep 2023 17:22:59 +0000 (UTC)
Date: Fri, 8 Sep 2023 18:22:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 00/51] Build system, i386 changes for 2023-09-07
Message-ID: <ZPtYcbB2pPd2SjuU@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907154412.GA1550739@fedora> <ZPs3UB8W4lsOFnxW@redhat.com>
 <521ab2c6-f617-1a9e-fef6-29add2e62137@linaro.org>
 <ZPtW4PXsVTo83IpN@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZPtW4PXsVTo83IpN@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 08, 2023 at 07:16:16PM +0200, Kevin Wolf wrote:
> Am 08.09.2023 um 18:11 hat Philippe Mathieu-Daudé geschrieben:
> > Hi Kevin,
> > 
> > On 8/9/23 17:01, Kevin Wolf wrote:
> > > Am 07.09.2023 um 17:44 hat Stefan Hajnoczi geschrieben:
> > > > Applied, thanks.
> > > > 
> > > > Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.
> > > 
> > > Something in this has broken the build for me, it seems to be the
> > > linux-user binary that doesn't link any more:
> > > 
> > >    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `cpu_x86_cpuid':
> > >    /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:6180: undefined reference to `kvm_arch_get_supported_cpuid'
> > 
> > My patches. I can not reproduce so far,

Given the missing function name, I'm assuming the problem is this commit:

[quote]
Subject: [PULL 42/51] target/i386: Remove unused KVM stubs

From: Philippe Mathieu-Daudé <philmd@linaro.org>

All these functions:

 - kvm_arch_get_supported_cpuid()
 - kvm_has_smm(()
 - kvm_hyperv_expand_features()
 - kvm_set_max_apic_id()

are called after checking for kvm_enabled(), which is
false when KVM is not built. Since the compiler elides
these functions, their stubs are not used and can be
removed.
[/quote]

> Hm, ok. I can try to bisect it further then.
> 
> > What are your ./configure command options?
> 
> '/home/kwolf/source/qemu/configure' '--cc=clang' '--target-list=x86_64-linux-user,x86_64-softmmu,arm-softmmu,aarch64-softmmu' '--enable-debug' '--cxx=clang++' '--disable-blkio' 

--enable-debug results in "-O0" being used for optimization.

I bet this stops the compiler from eliding the functions
as claimed by the commit above. IOW, we do in fact still
need these stubs.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


