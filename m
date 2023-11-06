Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B367E2724
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:38:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00iR-0008Ot-0k; Mon, 06 Nov 2023 09:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r00i4-00083q-O0
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:36:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r00hv-0000Yy-AR
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699281362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z50y1ScunVLec8koWqBe02fBnv+iocZFu4PCcLIrRu8=;
 b=NnKgN+UgFLqOgY9QSn1mE3WQYVvww8ck/+XKl8/SO1meX68kWz1rgcDVGNVL2fcgIGEoBF
 e5UsReH+7SRPO+Xlu5cfT9MrDaZx271weqpi51Qvp6Tq2lvsnqrXEiOQp3abvKTtkwFbk0
 MXYwGcbAEfxlpNL/e5pMKD3L7nxO5A8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-f6JeRlvOMO6f8Dv7g8w4eg-1; Mon, 06 Nov 2023 09:35:56 -0500
X-MC-Unique: f6JeRlvOMO6f8Dv7g8w4eg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5175685C1A4;
 Mon,  6 Nov 2023 14:35:56 +0000 (UTC)
Received: from redhat.com (unknown [10.39.195.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 174062166B26;
 Mon,  6 Nov 2023 14:35:54 +0000 (UTC)
Date: Mon, 6 Nov 2023 15:35:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 balaton@eik.bme.hu, philmd@linaro.org, shentey@gmail.com
Subject: Re: [PATCH v2 3/3] hw/ide/via: implement legacy/native mode switching
Message-ID: <ZUj5yTKBkJ99Dbxf@redhat.com>
References: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
 <20231024224056.842607-4-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024224056.842607-4-mark.cave-ayland@ilande.co.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

Am 25.10.2023 um 00:40 hat Mark Cave-Ayland geschrieben:
> Allow the VIA IDE controller to switch between both legacy and native modes by
> calling pci_ide_update_mode() to reconfigure the device whenever PCI_CLASS_PROG
> is updated.
> 
> This patch moves the initial setting of PCI_CLASS_PROG from via_ide_realize() to
> via_ide_reset(), and removes the direct setting of PCI_INTERRUPT_PIN during PCI
> bus reset since this is now managed by pci_ide_update_mode(). This ensures that
> the device configuration is always consistent with respect to the currently
> selected mode.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
> Tested-by: Bernhard Beschow <shentey@gmail.com>

As I already noted in patch 1, the interrupt handling seems to be wrong
here, it continues to use the ISA IRQ in via_ide_set_irq() even after
switching to native mode.

Other than this, the patch looks good to me.

Kevin


