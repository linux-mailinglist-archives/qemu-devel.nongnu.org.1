Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ADB7CD70A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:52:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt2I6-0008Iq-O6; Wed, 18 Oct 2023 04:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qt2Hv-0007jf-TG
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qt2Ht-0001E3-TA
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697619139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2QqvfO0DgHUb1b4lvzB4Y2b9lzIz4ZUlzP/607LhnMw=;
 b=Ml9anxPBOssje1txKxT/Jfj+F9Y9rHEFh9P6Ctl0E7h6s4mYdwstsX+9urlKWUfOdFBs25
 aR2atHWnpWO9RCnt7tQU8ZyF0fezK8kC3otUX63qRRnNGYUdy0akHAjM6gdl/+dH5X0hVP
 zxYvJ7XSkOq+IXN7SyuKJOl9QbEoiZQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-7wigXbIkP_i32babYPld5g-1; Wed, 18 Oct 2023 04:52:14 -0400
X-MC-Unique: 7wigXbIkP_i32babYPld5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2347D28AC1EA;
 Wed, 18 Oct 2023 08:52:14 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB252C15BB8;
 Wed, 18 Oct 2023 08:52:11 +0000 (UTC)
Date: Wed, 18 Oct 2023 10:52:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Subject: Re: [PATCH 11/12] hw/xen: automatically assign device index to block
 devices
Message-ID: <ZS+cutIjulWBQakk@redhat.com>
References: <20231016151909.22133-1-dwmw2@infradead.org>
 <20231016151909.22133-12-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016151909.22133-12-dwmw2@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

Am 16.10.2023 um 17:19 hat David Woodhouse geschrieben:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> There's no need to force the user to assign a vdev. We can automatically
> assign one, starting at xvda and searching until we find the first disk
> name that's unused.
> 
> This means we can now allow '-drive if=xen,file=xxx' to work without an
> explicit separate -driver argument, just like if=virtio.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Actually, how does this play together with xen_config_dev_blk()? This
looks like it tried to implement a very similar thing (which is IF_XEN
even already existed).

Are we now trying to attach each if=xen disk twice in the 'xenpv'
machine? Or if something prevents this, is it dead code?

I think in both cases, we would want to delete that function and remove
the loop that calls it in xen_init_pv()?

Kevin


