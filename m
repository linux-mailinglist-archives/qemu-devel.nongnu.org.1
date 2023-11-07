Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF0E7E3B54
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 12:50:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Kal-0006Q4-2e; Tue, 07 Nov 2023 06:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r0Kad-0006O1-F5
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:49:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r0Kab-0004Xx-Pk
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699357788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ggcpIgWDmzHQK3ZMctOveHXyjE46XiU6NhYFuTUDKD8=;
 b=VqmVEDPTLbMb4g2JdQ/tRtbCL2TcbDKPPgbLsonLE7yBUDZIal1TuuaDXNwzaQauX5+K8r
 hytDinSP88mV8kt/+06oEYL7/xLoG2fISmQz5eiCwevXGTynRLwiZIuDKpk5k+bANAX9kF
 fIkK5j4HWPKQgNr+1JBRt7p5GfOwmCo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623--ABvdnV1MemEOCG-r0UKRA-1; Tue,
 07 Nov 2023 06:49:11 -0500
X-MC-Unique: -ABvdnV1MemEOCG-r0UKRA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C1913813BC8;
 Tue,  7 Nov 2023 11:49:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35E241121308;
 Tue,  7 Nov 2023 11:49:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 544F71800DDB; Tue,  7 Nov 2023 12:49:09 +0100 (CET)
Date: Tue, 7 Nov 2023 12:49:09 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Dario Faggioli <dfaggioli@suse.com>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PULL 4/6] seabios: update binaries to git snapshot
Message-ID: <rdyjajgmgmk3kfbmnufqkws662xhsitcg6yx74qlczclx3i3pz@ftfqmcm7jtp4>
References: <20231010112610.2618091-1-kraxel@redhat.com>
 <20231010112610.2618091-5-kraxel@redhat.com>
 <30a82b23-ded6-f03a-727c-ed6f86657a34@suse.de>
 <terqy6i5rs6ui4wwbzmwlqi2v72c6qfl62nnu2ifgbkbrrz3z4@mneyylwzf6fo>
 <8aa3d259-6dd5-ebf7-8989-66b967434773@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa3d259-6dd5-ebf7-8989-66b967434773@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Hi, thanks for the response,
> 
> just to be sure, this is a regression (it worked fine prior to the seabios update).

Yes.

> Address sizes:                      43 bits physical, 48 bits virtual

OK.

> [    0.881472] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    0.882262] pci 0000:00:01.0:   bridge window [io  0x1000-0x1fff]
> [    0.886991] pci 0000:00:01.0:   bridge window [mem 0xfe800000-0xfe9fffff]
> [    0.890308] pci 0000:00:01.0:   bridge window [mem 0xe1a000000000-0xe1bfffffffff 64bit pref]

This is the change btw, the 64-bit mmio window is moved.
Apparently we got 48 bits guest physical address space.

> [    8.331290] vmap allocation for size 211106232541184 failed: use vmalloc=<size> to increase size.
> [    8.332666] virtio-pci 0000:01:00.0: virtio_pci: unable to map virtio 56@0 on bar 4
> [    8.334166] virtio-pci: probe of 0000:01:00.0 failed with error -22

And here things go wrong.  The size is /way/ off (bar 4 is 16k).

Can you try to reduce the guest physical address space?
Try 46 instead of 48 first, if that doesn't help try
smaller values.

qemu command line:
  -cpu host,host-phys-bits-limit=46

libvirt xml:
  <cpu ...>
    <maxphysaddr mode='emulate' bits='46'/>
  </cpu>

take care,
  Gerd


