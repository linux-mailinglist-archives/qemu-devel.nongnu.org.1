Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A47717E7B18
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:52:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1OAm-0001vF-LK; Fri, 10 Nov 2023 04:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r1OAk-0001ug-6t
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:51:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r1OAi-0000uy-3T
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699609887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cXJ1RxYQQ3fblx2UQui0iEWqJK8BE7cvJy7doe4Q3f0=;
 b=WFd0ETxb3Td8euQsrikLmgYrH+KladBFmObUUnkx8IBpmSxftDzc7vcir67mCn3liAsFji
 1ERXKSMefgteCaAYddzoPcOjnl9Psrq3dcX+XQU2QFl77MedyTkh3u/Vl0r0VxRA1vTTQU
 Epp2CUnGOaAv58hYgNnIeJf3otZMuok=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-z2-irTP_N1KLa6V_OHcsCg-1; Fri,
 10 Nov 2023 04:51:22 -0500
X-MC-Unique: z2-irTP_N1KLa6V_OHcsCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1714A28237C0;
 Fri, 10 Nov 2023 09:51:22 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D8E82026D68;
 Fri, 10 Nov 2023 09:51:19 +0000 (UTC)
Date: Fri, 10 Nov 2023 10:51:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Niklas Cassel <nks@flawful.org>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Damien Le Moal <dlemoal@kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH v3] hw/ide/ahci: fix legacy software reset
Message-ID: <ZU39Fus85X+625bj@redhat.com>
References: <20231108222657.117984-1-nks@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108222657.117984-1-nks@flawful.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Am 08.11.2023 um 23:26 hat Niklas Cassel geschrieben:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Legacy software contains a standard mechanism for generating a reset to a
> Serial ATA device - setting the SRST (software reset) bit in the Device
> Control register.
> 
> Serial ATA has a more robust mechanism called COMRESET, also referred to
> as port reset. A port reset is the preferred mechanism for error
> recovery and should be used in place of software reset.
> 
> Commit e2a5d9b3d9c3 ("hw/ide/ahci: simplify and document PxCI handling")
> improved the handling of PxCI, such that PxCI gets cleared after handling
> a non-NCQ, or NCQ command (instead of incorrectly clearing PxCI after
> receiving anything - even a FIS that failed to parse, which should NOT
> clear PxCI, so that you can see which command slot that caused an error).
> 
> However, simply clearing PxCI after a non-NCQ, or NCQ command, is not
> enough, we also need to clear PxCI when receiving a SRST in the Device
> Control register.
> 
> A legacy software reset is performed by the host sending two H2D FISes,
> the first H2D FIS asserts SRST, and the second H2D FIS deasserts SRST.
> 
> The first H2D FIS will not get a D2H reply, and requires the FIS to have
> the C bit set to one, such that the HBA itself will clear the bit in PxCI.
> 
> The second H2D FIS will get a D2H reply once the diagnostic is completed.
> The clearing of the bit in PxCI for this command should ideally be done
> in ahci_init_d2h() (if it was a legacy software reset that caused the
> reset (a COMRESET does not use a command slot)). However, since the reset
> value for PxCI is 0, modify ahci_reset_port() to actually clear PxCI to 0,
> that way we can avoid complex logic in ahci_init_d2h().
> 
> This fixes an issue for FreeBSD where the device would fail to reset.
> The problem was not noticed in Linux, because Linux uses a COMRESET
> instead of a legacy software reset by default.
> 
> Fixes: e2a5d9b3d9c3 ("hw/ide/ahci: simplify and document PxCI handling")
> Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Thanks, applied to the block branch.

Kevin


