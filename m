Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B99E47E4673
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 17:57:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0PN2-00064t-S2; Tue, 07 Nov 2023 11:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0PN1-00064Y-0o
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 11:56:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0PMx-0005Jo-69
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 11:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699376161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8cglq06SOwPhkH01HvDs0zDGKK3b/8rdNQZFdHSJShU=;
 b=OUtyuo2YkzW5Xr9ZpocI8ebrsnN3wtpNkCQkh5xa3azagS2pR/VmKxDKO3BZ2gtPyT/n3Y
 KGzi1aMwFZZ59/gw8K075uyqiQxNZyLQ7/tRtNffTWfxFntL7bz/pD6ATXoY+xiEq3RMJ9
 Fw5rfELooNy0goRSs4Nz2INpidm1Gvk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-gjioh00cMSq1ifKM1O-9lw-1; Tue,
 07 Nov 2023 11:55:57 -0500
X-MC-Unique: gjioh00cMSq1ifKM1O-9lw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CABAD38C616F;
 Tue,  7 Nov 2023 16:55:56 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC6BA2026D66;
 Tue,  7 Nov 2023 16:55:55 +0000 (UTC)
Date: Tue, 7 Nov 2023 17:55:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Niklas Cassel <nks@flawful.org>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Damien Le Moal <dlemoal@kernel.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH] hw/ide/ahci: trigger either error IRQ or regular IRQ,
 not both
Message-ID: <ZUpsGhfN2/BLpEoD@redhat.com>
References: <20231011131220.1992064-1-nks@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011131220.1992064-1-nks@flawful.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

Am 11.10.2023 um 15:12 hat Niklas Cassel geschrieben:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> According to AHCI 1.3.1, 5.3.8.1 RegFIS:Entry, if ERR_STAT is set,
> we jump to state ERR:FatalTaskfile, which will raise a TFES IRQ
> unconditionally, regardless if the I bit is set in the FIS or not.
> 
> Thus, we should never raise a normal IRQ after having sent an error
> IRQ.
> 
> NOTE: for QEMU platforms that use SeaBIOS, this patch depends on QEMU
> commit 784155cdcb02 ("seabios: update submodule to git snapshot"), and
> QEMU commit 14f5a7bae4cb ("seabios: update binaries to git snapshot").
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Thanks, applied to the block branch.

Kevin


