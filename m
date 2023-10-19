Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B37D7CF699
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:22:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtR6D-0003vd-3H; Thu, 19 Oct 2023 07:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qtR61-0003ux-VZ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:21:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qtR60-0008Dp-7X
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697714503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wJbjQEX6r4FVtVGUs3f8q9Y8qBJ81kVTcIhxYAo3Mqk=;
 b=I4Fy1zkXJ+i4ar6jj/tCSAnfPsq/o7f5vphWb2XTK3zXgc9GChMpEbAmnYWsa1OqvYRasU
 hdpyxqMNqJBxQoW54IIBp2+yOdkNkoMBkJUCK0x1Tzn1Uup8W+iqM/wvDGasyBVsAAWh3Q
 +TPFC0SFg6J3CiQU5MSEHzsn32QJ5Bg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-SK7vo6K2NX2TQ2jYrduzJQ-1; Thu, 19 Oct 2023 07:21:40 -0400
X-MC-Unique: SK7vo6K2NX2TQ2jYrduzJQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57E82801234;
 Thu, 19 Oct 2023 11:21:39 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D792A492BFB;
 Thu, 19 Oct 2023 11:21:36 +0000 (UTC)
Date: Thu, 19 Oct 2023 13:21:35 +0200
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
Message-ID: <ZTERPwrbUJf7kty2@redhat.com>
References: <20231016151909.22133-1-dwmw2@infradead.org>
 <20231016151909.22133-12-dwmw2@infradead.org>
 <ZS+cutIjulWBQakk@redhat.com>
 <950f3a62dfcecce902037f95575f1013697a5925.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <950f3a62dfcecce902037f95575f1013697a5925.camel@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

Am 18.10.2023 um 12:52 hat David Woodhouse geschrieben:
> > Actually, how does this play together with xen_config_dev_blk()? This
> > looks like it tried to implement a very similar thing (which is IF_XEN
> > even already existed).
> 
> Ah yes, thanks for spotting that! I hadn't been looking at the xenfv
> 
> > Are we now trying to attach each if=xen disk twice in the 'xenpv'
> > machine? Or if something prevents this, is it dead code.
> 
> I suspect we end up creating them twice (and probably thus failing to
> lock the backing file).
>
> [...]
>
> ... but this just reinforces what I said there about "if
> qmp_device_add() can find the damn bus and do this right, why do we
> have to litter it through platform code?"

Indeed, if you can do -device, it's always the best option. For block
devices not the least because it gives you a way to use -blockdev with
it. I'm happy whenever I see a drive_get() call go away.

Kevin


