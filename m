Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7582B74D60E
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:57:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIqRO-0007Qy-97; Mon, 10 Jul 2023 08:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qIqRN-0007Qm-68
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qIqRL-0008Cn-7X
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688993789;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=g25diQAjso4EoMu37E2/EbPAznM0FaInXGl+wyI8PA0=;
 b=Wx0ZxLP8BJT+NIi4Xb07PReZGPFym2dxedAKMLAPM4GJ3mWGDRVfi50qx0XS8uMtgZftQq
 BikXvIBo4CfUvaUUivqBIHGUOoW7sTvWxAG30qr8r93taWCotSK2C8IiYWxE4aWT8Hnlfj
 T1uk6nAmHQQtH2NikI7RoIklELXawOA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-EBnD3zEaP8K4DpBPeyo7ZA-1; Mon, 10 Jul 2023 08:56:26 -0400
X-MC-Unique: EBnD3zEaP8K4DpBPeyo7ZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 521612A5956A;
 Mon, 10 Jul 2023 12:56:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE75B145414C;
 Mon, 10 Jul 2023 12:56:25 +0000 (UTC)
Date: Mon, 10 Jul 2023 13:56:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: strace showing QEMU process doing >99% ppoll
Message-ID: <ZKv/9wM/nHPeaflB@redhat.com>
References: <db5140a2-6947-564b-afba-e0edda31c515@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <db5140a2-6947-564b-afba-e0edda31c515@proxmox.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jul 10, 2023 at 02:34:10PM +0200, Fiona Ebner wrote:

> > Thread 14 (Thread 0x7efd24d54700 (LWP 1153824) "iou-wrk-50948"):
> > #0  0x0000000000000000 in ?? ()
> > Backtrace stopped: Cannot access memory at address 0x0
> > 
> > Thread 13 (Thread 0x7efd1ffff700 (LWP 1148438) "iou-wrk-50949"):
> > #0  0x0000000000000000 in ?? ()
> > Backtrace stopped: Cannot access memory at address 0x0
> > 
> > Thread 12 (Thread 0x7efd1ffff700 (LWP 1133766) "iou-wrk-50949"):
> > #0  0x0000000000000000 in ?? ()
> > Backtrace stopped: Cannot access memory at address 0x0
> > 
> > Thread 11 (Thread 0x7efd24d54700 (LWP 2639435) "iou-wrk-50948"):
> > #0  0x0000000000000000 in ?? ()
> > Backtrace stopped: Cannot access memory at address 0x0

These thread names look suprising/interestnig to me - 'iou-wrk-XXXXXX'.

I can't immediately see any code in QEMU creates threads with this
naming convention.

Possibly it could be from a library that QEMU is linking to, but I'm
not finding relevant google hits for this search string 'iou-wrk'.

Does Proxmox have any local patches to QEMU that are relevant ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


