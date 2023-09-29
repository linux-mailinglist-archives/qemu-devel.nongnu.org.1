Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0A27B3195
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 13:41:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmBrL-0000dD-5V; Fri, 29 Sep 2023 07:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qmBr7-0000cv-I2
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 07:40:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qmBr1-0003NM-6x
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 07:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695987618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gaEi0tUbkDLWUecCql1tlJMIw8XRkHfAHx6XuS+niyA=;
 b=ULCVPJlFyau/nXyoNiQuJi5TWSovAhrUxKlzgrccK9tOrG5wOnq/PL6mhh/sS6K3NtP7uF
 j9XnGSPcgJUjLRFvVAqSwLhz6yUKZpeorEKzBWlOpTz2aAyt+3POh3IRirTgpygu++VyhX
 OUqyTLSIRVK17Ua0EVoC6l6ObCzo6dA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-tgFAaoXiNWm1zty2rNSc2Q-1; Fri, 29 Sep 2023 07:40:16 -0400
X-MC-Unique: tgFAaoXiNWm1zty2rNSc2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 578D88032FE;
 Fri, 29 Sep 2023 11:40:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 275762026D4B;
 Fri, 29 Sep 2023 11:40:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9358D1800638; Fri, 29 Sep 2023 13:40:14 +0200 (CEST)
Date: Fri, 29 Sep 2023 13:40:14 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/display/ramfb: plug slight guest-triggerable leak on
 mode setting
Message-ID: <4blobb4y57lsu5352nzsuxctqikgciijymrzaxoucxq3kuzh5q@xkepiwobqbhb>
References: <20230919131955.27223-1-lersek@redhat.com>
 <7ee37181-526e-2b6a-6b42-09340a9e70a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ee37181-526e-2b6a-6b42-09340a9e70a9@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Sep 27, 2023 at 05:45:25PM +0200, Laszlo Ersek wrote:
> On 9/19/23 15:19, Laszlo Ersek wrote:
> > The fw_cfg DMA write callback in ramfb prepares a new display surface in
> > QEMU; this new surface is put to use ("swapped in") upon the next display
> > update. At that time, the old surface (if any) is released.
> > 
> > If the guest triggers the fw_cfg DMA write callback at least twice between
> > two adjacent display updates, then the second callback (and further such
> > callbacks) will leak the previously prepared (but not yet swapped in)
> > display surface.

[ ... ]

> >      s->width = width;
> >      s->height = height;
> > +    qemu_free_displaysurface(s->ds);
> >      s->ds = surface;
> >  }
> >  
> 
> Ping.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd


