Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 795787D7325
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 20:21:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qviUV-0004wv-41; Wed, 25 Oct 2023 14:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qviUN-0004ke-Vr
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 14:20:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qviUM-0004UI-4Z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 14:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698258015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kbl9Vh12iHFjO5JwnG1NE2HG/x04t0/PepbwFFk28Kc=;
 b=eZgby2dmIebpkmRpYwdlCqqbCOLB0TekoNkiFBLTc851NtpA/W/iTufiw13zgY9OqWZ0hz
 h3mvaJcyEOJHVYnWlLPIuOdt3mQotONGhLNCUV3pv6zuf/YzhYI5BfwGrCgnuCQ14gdN0/
 xBngADYFr/H+VKT7anb82GCbI18sEi8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-MD8IH2-EMh6IsUtGtqLM8Q-1; Wed,
 25 Oct 2023 14:20:12 -0400
X-MC-Unique: MD8IH2-EMh6IsUtGtqLM8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DC1E3822E9C;
 Wed, 25 Oct 2023 18:20:11 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71065C1596D;
 Wed, 25 Oct 2023 18:20:09 +0000 (UTC)
Date: Wed, 25 Oct 2023 13:20:07 -0500
From: Eric Blake <eblake@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-block@nongnu.org, 
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
Subject: Re: [PATCH v3 28/28] docs: update Xen-on-KVM documentation
Message-ID: <6vbpkrebc7fpypbv2t7jbs7m3suxwbqqykeomzfxpenjj2sogd@rphcppcl4inl>
References: <20231025145042.627381-1-dwmw2@infradead.org>
 <20231025145042.627381-29-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025145042.627381-29-dwmw2@infradead.org>
User-Agent: NeoMutt/20231006
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Wed, Oct 25, 2023 at 03:50:42PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Add notes about console and network support, and how to launch PV guests.
> Clean up the disk configuration examples now that that's simpler, and
> remove the comment about IDE unplug on q35/AHCI now that it's fixed.
> 
> Also update stale avocado test filename in MAINTAINERS.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> +Xen paravirtual devices
> +-----------------------
> +
> +The Xen PCI platform device is enabled automatically for a Xen guest. This
> +allows a guest to unplug all emulated devices, in order to use paravirtual
> +block and network drivers instead.
> +
> +Those paravirtual Xen block, network (and console) devices can be created
> +through the command line, and/or hot-plugged.
> +
> +To provide a Xen console device, define a character device and then a device
> +of type ``xen-console`` to connect to it. For the Xen console equivalent of
> +the handy ``-serial mon:stdio`` option, for example:
> +
> +.. parsed-literal::
> +   -chardev -chardev stdio,mux=on,id=char0,signal=off -mon char0 \\
> +   -device xen-console,chardev=char0

Is -chardev supposed to appear twice here?

...
> +
> +Booting Xen PV guests
> +---------------------
> +
> +Booting PV guest kernels is possible by using the Xen PV shim (a version of Xen
> +itself, designed to run inside a Xen HVM guest and provide memory management
> +services for one guest alone).
> +
> +The Xen binary is provided as the ``-kernel`` and the guest kernel itself (or
> +PV Grub image) as the ``-initrd`` image, which actually just means the first
> +multiboot "module". For example:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| --accel kvm,xen-version=0x40011,kernel-irqchip=split \\
> +       -chardev stdio,id=char0 -device xen-console,chardev=char0 \\
> +       -display none  -m 1G  -kernel xen -initrd bzImage \\
> +       -append "pv-shim console=xen,pv -- console=hvc0 root=/dev/xvda1" \\
> +       -drive file=${GUEST_IMAGE},if=xen

Is the space between -- and console= intentionsl?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


