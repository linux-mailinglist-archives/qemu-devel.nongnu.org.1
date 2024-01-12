Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4668582C57A
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 19:33:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOML1-00076i-GW; Fri, 12 Jan 2024 13:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rOMKx-00075T-5E
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 13:32:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rOMKt-0003uG-CL
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 13:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705084374;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=UQ5xuddNpiRRFL/c5N1770aTEjaSly/JsF6BsjvYot8=;
 b=FqGtUl2PyuTTFKoem9rshgEP2tkOrY/LwHh9rtEC3Jp0KlvjdpSo9C8ZpLKdQHfevNkNC9
 OD7+z24EsbUP3G7lOGSdvkw0DS3lCNoBFR9gsFgen/A+OSPZl1jb0AOOKqyEOC7aNmcJ3n
 M7ffENBcQvPMzvK2SW9k2iEITiZGHJI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-_hinglsANKCsyBMzapxgXg-1; Fri, 12 Jan 2024 13:32:50 -0500
X-MC-Unique: _hinglsANKCsyBMzapxgXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61E681071CE1;
 Fri, 12 Jan 2024 18:32:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA3562166B33;
 Fri, 12 Jan 2024 18:32:49 +0000 (UTC)
Date: Fri, 12 Jan 2024 18:32:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: xtec@trimaso.com.mx
Cc: qemu-devel@nongnu.org
Subject: Re: Qemu setting "-cpu host" seems broken with Windows vms
Message-ID: <ZaGFz7DcDR0ZWH_f@redhat.com>
References: <8cceee40e32dab3e1913e50c221475ea@trimaso.com.mx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8cceee40e32dab3e1913e50c221475ea@trimaso.com.mx>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Dec 28, 2023 at 11:45:18AM -0600, xtec@trimaso.com.mx wrote:
> I noticed something weird when using "-cpu host" with Windows vms.
> First, I always use it along with ",hv_passthrough" as well.
> 
> First, performance: since some years ago, since prior to qemu 6.2 until
> latest 8.2, win10 and win11 vms always worked slower than expected. This
> could be noticed by comparing booting/starting times between vm and a bare
> metal installation, but I particularly measured it when installing windows
> cumulative updates through windows update. On vm, from downloading to
> finishing rebooting it always took 1.5 circa 1.5 hours, while just 40
> minutes on bare metal.
> 
> Second, and more recently, newer windows 11 23h2 seems to have big problem
> with "-cpu host".
> When trying to update from 22h2 to 23h2 I got either black screen or bsod
> after trying to reboot.
> Also, same result when trying to install 23h2 from scratch.
> This on qemu 7.1 and 8.2.
> Did a long search, and finally found the cause which also solved the problem
> for me:
> https://forum.proxmox.com/threads/new-windows-11-vm-fails-boot-after-update.137543/
> I found similar problems and similar solution in other forums as well.
> 
> So in my case, physical host cpu is intel core 11th gen; tried using
> libvirt's "virsh capabilities" to see which qemu cpu model better matched,
> and for some reason it gave Broadwell instead of newer Skylake...

Intel has many different variants of each named CPU generation, and
QEMU's CPU model only reflects one particular variant.  So it is
possible that you have a Skylake variant that lacks 1 feature flag
that QEMU's Skylake model has. This in turn causes libvirt to find
the next best named model with all flags available and in your case
libvirt decided Broadwell was best.

> Anyway, tried with "-cpu <Broadwell_model>,hv_passthrough", and this solved
> *both* problems: performance finally matched bare metal in all aspects, and
> the windows 23h2 problem was finally gone.
> 
> On IRC, it was suggested to try "-cpu host" and "disabling CPU bits" one by
> one until finding the culprit. But I don't know how to do this...

So you need to figure out which bits are different between 'Broadwell' and
'host' for your machine.

Assuming you have qemu.git checked out, you want to run

   ./scripts/qmp/qmp-shell-wrap -p  /usr/bin/qemu-system-x86_64 -display none -accel kvm

in the QMP shell now run

   query-cpu-model-expansion type=full model={'name':'Broadwell'}

and save the list of features it reports. then run

   query-cpu-model-expansion type=full model={'name':'host'}

and save the list of features it reports too.

Now diff the two feature lists.

If the diff shows that 'sse4a' was missing in Broadwell but present in
host, then try

   -cpu Broadwell,hv_passthrough,sse4a

keep appending more features on -cpu, and if you're lucky you might
hit one that triggers the problem.

Not every difference though can be controlled via -cpu flags, so it is
posible there's something inherantly different about the 'host' model
that triggers this problem.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


