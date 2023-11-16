Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAB87EE1E8
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 14:49:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3cj8-0007s9-3o; Thu, 16 Nov 2023 08:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r3cj5-0007qm-Rv
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:48:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r3cj4-0006CE-4R
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700142489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kFnG1gfwFvJcoSbbuifYbBJRPIpCL1ErGKrW6lGazqk=;
 b=Y/BjDbBksqRLvKekVqoKArdBbeWacU1xTKzhbreOZnFzF1UrrVAazhP5xL1FpsZ78xq8kk
 aepjFYua6Sys/4iWhmrUpJ/xkGzRyDKDUldddFOlRWPpYtHSYS/VjN9eBEMlHFywpCIBuM
 V5MYyA1JKgUPI2KWwNeTuygvg3fq7cQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-wGvOdZxZPjmWMiF0M9dpaA-1; Thu, 16 Nov 2023 08:48:04 -0500
X-MC-Unique: wGvOdZxZPjmWMiF0M9dpaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD19E185A781;
 Thu, 16 Nov 2023 13:48:03 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B274C15881;
 Thu, 16 Nov 2023 13:48:02 +0000 (UTC)
Date: Thu, 16 Nov 2023 14:48:01 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 balaton@eik.bme.hu, philmd@linaro.org, shentey@gmail.com
Subject: Re: [PATCH v3 0/4] ide: implement simple legacy/native mode
 switching for PCI IDE controllers
Message-ID: <ZVYdkaQ5DcTHxhnJ@redhat.com>
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 16.11.2023 um 11:33 hat Mark Cave-Ayland geschrieben:
> This series adds a simple implementation of legacy/native mode switching for PCI
> IDE controllers and updates the via-ide device to use it.
> 
> The approach I take here is to add a new pci_ide_update_mode() function which handles
> management of the PCI BARs and legacy IDE ioports for each mode to avoid exposing
> details of the internal logic to individual PCI IDE controllers.
> 
> As noted in [1] this is extracted from a local WIP branch I have which contains
> further work in this area. However for the moment I've kept it simple (and
> restricted it to the via-ide device) which is good enough for Zoltan's PPC
> images whilst paving the way for future improvements after 8.2.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg05403.html
> 
> v3:
> - Rebase onto master
> - Move ide_portio_list[] and ide_portio_list2[] to IDE core to prevent duplication in
>   hw/ide/pci.c
> - Don't zero BARs when switching from native mode to legacy mode, instead always force
>   them to read zero as suggested in the PCI IDE specification (note: this also appears
>   to fix the fuloong2e machine booting from IDE)
> - Add comments in pci_ide_update_mode() suggested by Kevin
> - Drop the existing R-B and T-B tags: whilst this passes my local tests, the behaviour
>   around zero BARs feels different enough here

Thanks, applied to the block branch.

Kevin


