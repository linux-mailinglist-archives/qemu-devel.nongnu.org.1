Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4610B9F4DB9
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Dec 2024 15:29:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYZT-0000oC-6R; Tue, 17 Dec 2024 09:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNYZD-0000jm-OG
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:28:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNYZB-0004vE-8w
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734445731;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJW9xnEDOcxQWtRflbCqPWqvmcKAnhbeHQpZcHs/d74=;
 b=XspSWEY0idWw4J1uGh11mz9o6FQLTRSaawcgEAO3SSoYDLCAS4QDA58jGn/KOdhSavm3og
 vyS+Ezc3zi1X2rf2OKS4EBVpA51m+6J7qacP9Xm57/kVztEdyWcHz0DsFK32OXnsNmd7lP
 47OgGOcEy9qPE71qxoVJrhwDKVY0I08=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-HXG03kKrNSKOfdVGjeOxYA-1; Tue,
 17 Dec 2024 09:28:50 -0500
X-MC-Unique: HXG03kKrNSKOfdVGjeOxYA-1
X-Mimecast-MFC-AGG-ID: HXG03kKrNSKOfdVGjeOxYA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8160619560B2; Tue, 17 Dec 2024 14:28:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.136])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A01A1300F9B7; Tue, 17 Dec 2024 14:28:42 +0000 (UTC)
Date: Tue, 17 Dec 2024 14:28:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PULL 3/7] x86/loader: expose unpatched kernel
Message-ID: <Z2GKmE0kxkbhs8tp@redhat.com>
References: <20241216105053.246204-1-kraxel@redhat.com>
 <20241216105053.246204-4-kraxel@redhat.com>
 <Z2GHc5qwDub89qCa@redhat.com>
 <52zucjcan5q4dwgsdchkwqi6bhdfx3ziw7ud52rratqhyzikci@3ainfgz6e4yp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52zucjcan5q4dwgsdchkwqi6bhdfx3ziw7ud52rratqhyzikci@3ainfgz6e4yp>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Dec 17, 2024 at 03:26:35PM +0100, Gerd Hoffmann wrote:
> On Tue, Dec 17, 2024 at 02:15:15PM +0000, Daniel P. Berrangé wrote:
> > On Mon, Dec 16, 2024 at 11:50:49AM +0100, Gerd Hoffmann wrote:
> > > Add a new "etc/boot/kernel" fw_cfg file, containing the kernel without
> > > the setup header patches.  Intended use is booting in UEFI with secure
> > > boot enabled, where the setup header patching breaks secure boot
> > > verification.
> > > 
> > > Needs OVMF changes too to be actually useful.
> > > 
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > Message-ID: <20240905141211.1253307-5-kraxel@redhat.com>
> > > ---
> > >  hw/i386/x86-common.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> > > index 28341b42d949..1cef3045ad83 100644
> > > --- a/hw/i386/x86-common.c
> > > +++ b/hw/i386/x86-common.c
> > > @@ -962,6 +962,9 @@ void x86_load_linux(X86MachineState *x86ms,
> > >      sev_load_ctx.setup_data = (char *)setup;
> > >      sev_load_ctx.setup_size = setup_size;
> > >  
> > > +    /* kernel without setup header patches */
> > > +    fw_cfg_add_file(fw_cfg, "etc/boot/kernel", kernel, kernel_size);
> > > +
> > 
> > How concerned should we be about the memory duplication overhead
> > from loading the kernel image twice ?
> 
> It's not loaded twice, see 214191f6b574 ("x86/loader: read complete
> kernel"), both fw_cfg entries point to the same memory block.

Ah, I see now, that's subtle :-)


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


