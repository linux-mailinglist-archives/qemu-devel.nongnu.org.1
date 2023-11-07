Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AB37E3A32
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:45:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0JYw-0006wu-E6; Tue, 07 Nov 2023 05:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0JYq-0006vy-Nh
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:43:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0JYn-0000de-SO
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699353831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vHvQHwWHrIyhCwP3EQMBxhE2cn/RVQIL4TLCR7FFoWI=;
 b=R9FK9esJahA4fFicX3+8mSYykY7YOQBwnl6+xxP/n/B6kdWgm+QulXj7slyHKjISyDVY5u
 8RMWmn5iIXZothxZmV4A9LzFY0US3d8NjaRRibjn707Zlu5uTIQ8L3ZNa2NQBMtdGzTSid
 7mi2m8J8l7gbqXHfjIgfgLefgGySGN0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-9Tmg6Yp6PmicDVJ8JxtZgA-1; Tue, 07 Nov 2023 05:43:47 -0500
X-MC-Unique: 9Tmg6Yp6PmicDVJ8JxtZgA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 867DD185A783;
 Tue,  7 Nov 2023 10:43:46 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 786D125C0;
 Tue,  7 Nov 2023 10:43:45 +0000 (UTC)
Date: Tue, 7 Nov 2023 11:43:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org,
 shentey@gmail.com
Subject: Re: [PATCH v2 3/3] hw/ide/via: implement legacy/native mode switching
Message-ID: <ZUoU4FltYjFXdWZm@redhat.com>
References: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
 <20231024224056.842607-4-mark.cave-ayland@ilande.co.uk>
 <ZUj5yTKBkJ99Dbxf@redhat.com>
 <509075f4-38d2-578b-b4f4-770c3b000ae8@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <509075f4-38d2-578b-b4f4-770c3b000ae8@eik.bme.hu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 06.11.2023 um 17:13 hat BALATON Zoltan geschrieben:
> On Mon, 6 Nov 2023, Kevin Wolf wrote:
> > Am 25.10.2023 um 00:40 hat Mark Cave-Ayland geschrieben:
> > > Allow the VIA IDE controller to switch between both legacy and native modes by
> > > calling pci_ide_update_mode() to reconfigure the device whenever PCI_CLASS_PROG
> > > is updated.
> > > 
> > > This patch moves the initial setting of PCI_CLASS_PROG from via_ide_realize() to
> > > via_ide_reset(), and removes the direct setting of PCI_INTERRUPT_PIN during PCI
> > > bus reset since this is now managed by pci_ide_update_mode(). This ensures that
> > > the device configuration is always consistent with respect to the currently
> > > selected mode.
> > > 
> > > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > Tested-by: Bernhard Beschow <shentey@gmail.com>
> > 
> > As I already noted in patch 1, the interrupt handling seems to be wrong
> > here, it continues to use the ISA IRQ in via_ide_set_irq() even after
> > switching to native mode.
> 
> That's a peculiarity of this via-ide device. It always uses 14/15 legacy
> interrupts even in native mode and guests expect that so using native
> interrupts would break pegasos2 guests. This was discussed and tested
> extensively before.

This definitely needs a comment to explain the situation then because
this is in violation of the spec. If real hardware behaves like this,
it's what we should do, of course, but it's certainly unexpected and we
should explicitly document it to avoid breaking it later when someone
touches the code who doesn't know about this peculiarity.

Kevin


