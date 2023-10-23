Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B7E7D385E
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 15:46:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quvFt-00032J-Mh; Mon, 23 Oct 2023 09:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1quvFp-00031l-VJ
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1quvFo-00087w-Eu
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698068759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PRwDvjlRKO8xrlwJvcJXG0QiFBX/VuVy6rRUymKs+DU=;
 b=LEzQPwiNkc1yz9w0HNvBEwxU6PndrGS8P0kRkjiXAKLO8fZuhOBcoNgPJcwXs6NNUfnImb
 ld6GgJFU6YvG8pR9GkcZjY1JUfiN930wvOGDi5SVJWU3w5m7sAcGOKl184oYYcgu2w8K3B
 msQFWkd/KRpNsvChNWrz/DM0oguawas=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-mjSKRdUpPyGnGYhKh02Sbg-1; Mon, 23 Oct 2023 09:45:55 -0400
X-MC-Unique: mjSKRdUpPyGnGYhKh02Sbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F555101AA75;
 Mon, 23 Oct 2023 13:45:55 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EBF01C060B6;
 Mon, 23 Oct 2023 13:45:52 +0000 (UTC)
Date: Mon, 23 Oct 2023 15:45:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 11/12] hw/xen: automatically assign device index to block
 devices
Message-ID: <ZTZ5D2wZXkDQanbQ@redhat.com>
References: <20231016151909.22133-1-dwmw2@infradead.org>
 <20231016151909.22133-12-dwmw2@infradead.org>
 <20231018093239.3d525fd8@imammedo.users.ipa.redhat.com>
 <3f3487af227dcdce7afb37e8406d5ce8dcdbf55f.camel@infradead.org>
 <20231023113002.0e83c209@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023113002.0e83c209@imammedo.users.ipa.redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 23.10.2023 um 11:30 hat Igor Mammedov geschrieben:
> On Wed, 18 Oct 2023 09:32:47 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
> 
> > On Wed, 2023-10-18 at 09:32 +0200, Igor Mammedov wrote:
> > > On Mon, 16 Oct 2023 16:19:08 +0100
> > > David Woodhouse <dwmw2@infradead.org> wrote:
> > >   
> > > > From: David Woodhouse <dwmw@amazon.co.uk>
> > > >   
> > > 
> > > is this index a user (guest) visible?  
> > 
> > Yes. It defines what block device (e.g. /dev/xvda) the disk appears as
> > in the guest. In the common case, it literally encodes the Linux
> > major/minor numbers. So xvda (major 202) is 0xca00, xvdb is 0xca10 etc.
> 
> that makes 'index' an implicit ABI and a subject to versioning
> when the way it's assigned changes (i.e. one has to use versioned
> machine types to keep older versions working the they used to).
> 
> From what I remember it's discouraged to make QEMU invent
> various IDs that are part of ABI (guest or mgmt side).
> Instead it's preferred for mgmt side/user to provide that explicitly.
> 
> Basically you are trading off manageability/simplicity at QEMU
> level with CLI usability for human user.
> I don't care much as long as it is hidden within xen code base,
> but maybe libvirt does.

-drive is mostly a convenience option for human users anyway. Management
tools should use a combination of -blockdev and -device.

Kevin


