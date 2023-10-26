Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 423257D7E7A
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:28:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvvhv-0000m5-11; Thu, 26 Oct 2023 04:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qvvhr-0000lj-Vz
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qvvhm-0000bg-FK
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698308821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LiXFBc8YsDvBzhxHytTZjcWCexeiPcrWUoCrLdYurNk=;
 b=JaPXutnHEWDXTi11fTnEEt8dUGjVX28da1DoXJ81QXfGOj43Fk2sz1ZNrFYvO0WwyVWL23
 PngeTpqhopxITha9IvTxnpOiLYeT2wpgrN+DQbyPSF+AGHQ4wqd9T5yZOAOuC8olUfalhD
 SnhQGgEk5CB6H41Lj6E3kJXk1okGkMM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-AfOJAuHtP6SZAVeVp_QaGw-1; Thu, 26 Oct 2023 04:26:57 -0400
X-MC-Unique: AfOJAuHtP6SZAVeVp_QaGw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E338F811E7D;
 Thu, 26 Oct 2023 08:26:56 +0000 (UTC)
Received: from redhat.com (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E8EC40C6F79;
 Thu, 26 Oct 2023 08:26:54 +0000 (UTC)
Date: Thu, 26 Oct 2023 10:26:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
Subject: Re: [PATCH v3 28/28] docs: update Xen-on-KVM documentation
Message-ID: <ZToizYcPjO0Zt52N@redhat.com>
References: <20231025145042.627381-1-dwmw2@infradead.org>
 <20231025145042.627381-29-dwmw2@infradead.org>
 <6vbpkrebc7fpypbv2t7jbs7m3suxwbqqykeomzfxpenjj2sogd@rphcppcl4inl>
 <4a10a50e5469480a82cb993dedbff10c3d777082.camel@infradead.org>
 <21e8a265-bf5a-464c-86bc-f0fd7b5eb108@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21e8a265-bf5a-464c-86bc-f0fd7b5eb108@citrix.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 25.10.2023 um 20:56 hat Andrew Cooper geschrieben:
> On 25/10/2023 7:26 pm, David Woodhouse wrote:
> > On Wed, 2023-10-25 at 13:20 -0500, Eric Blake wrote:
> >> On Wed, Oct 25, 2023 at 03:50:42PM +0100, David Woodhouse wrote:
> >>> +
> >>> +Booting Xen PV guests
> >>> +---------------------
> >>> +
> >>> +Booting PV guest kernels is possible by using the Xen PV shim (a version of Xen
> >>> +itself, designed to run inside a Xen HVM guest and provide memory management
> >>> +services for one guest alone).
> >>> +
> >>> +The Xen binary is provided as the ``-kernel`` and the guest kernel itself (or
> >>> +PV Grub image) as the ``-initrd`` image, which actually just means the first
> >>> +multiboot "module". For example:
> >>> +
> >>> +.. parsed-literal::
> >>> +
> >>> +  |qemu_system| --accel kvm,xen-version=0x40011,kernel-irqchip=split \\
> >>> +       -chardev stdio,id=char0 -device xen-console,chardev=char0 \\
> >>> +       -display none  -m 1G  -kernel xen -initrd bzImage \\
> >>> +       -append "pv-shim console=xen,pv -- console=hvc0 root=/dev/xvda1" \\
> >>> +       -drive file=${GUEST_IMAGE},if=xen
> >> Is the space between -- and console= intentionsl?
> > Yes, that one is correct. The -- is how you separate Xen's command line
> > (on the left) from the guest kernel command line (on the right).
> 
> To expand on this a bit.
> 
> Multiboot1 supports multiple modules but only a single command line.  As
> one of the modules passed to Xen is the dom0 kernel, we need some way to
> pass it's command line, hence the " -- ".

That's not right, even Multiboot 1 contains a 'string' field in the
module structure that is defined to typically hold a command line. The
exact meaning is OS dependent, so Xen could use it however it wants.

In QEMU (and I believe this is the same behaviour as in GRUB),
everything before the space in an -initrd argument is treated as a
filename to load, everything after it is just passed as the command
line.

So it would have been entirely possible to use -initrd 'bzImage
console=hvc0 root=/dev/xvda1' if Xen worked like that.

> Multiboot2 and PVH support a command line per module, which is the
> preferred way to pass the commandlines, given a choice.

Multiboot 2 seems to integrate the string in a variable length module
structure instead of just having a pointer in a fixed length one, but
the model behind it is essentially the same as before.

Kevin


