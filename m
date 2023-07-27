Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 400BA7655E5
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 16:26:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP18Q-0002qj-QX; Thu, 27 Jul 2023 09:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qP18L-0002lo-AH
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 09:34:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qP18J-0005h0-V1
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 09:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690464863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u9OKLanArLR49faLk9/RCvu5CBo5R/BtnlnNa6g5ruo=;
 b=E6xI30YPzDIK9bMezagl5k59fk0+9q1/TvF2OAF+2Jn41XcOOLdGaCxcE3kOWcZ2xwznLU
 3uEmVQrffxYNbv71cg0Qe5llqB3+rDZRRiUA7wPniKJo+pTsbTK84kjWPA/4FUHkv593n9
 tif5MXa0Vqh1/KIJCs0CnwqQOELLcgo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-kSMC8SxKOmCxUR4E63E_Vg-1; Thu, 27 Jul 2023 09:34:18 -0400
X-MC-Unique: kSMC8SxKOmCxUR4E63E_Vg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABA7F28088A6;
 Thu, 27 Jul 2023 13:34:17 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08A01200B409;
 Thu, 27 Jul 2023 13:34:16 +0000 (UTC)
Date: Thu, 27 Jul 2023 08:34:15 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v2 1/1] qemu-nbd: regression with arguments passing into
 nbd_client_thread()
Message-ID: <e2dyrwl5vq2h3wpvwkp2vggg5fgtr2dg7dppcrljpa5vivhalq@co7x4xprtcel>
References: <20230727105828.324314-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727105828.324314-1-den@openvz.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

On Thu, Jul 27, 2023 at 12:58:28PM +0200, Denis V. Lunev wrote:
> Unfortunately
>     commit 03b67621445d601c9cdc7dfe25812e9f19b81488
>     Author: Denis V. Lunev <den@openvz.org>
>     Date:   Mon Jul 17 16:55:40 2023 +0200
>     qemu-nbd: pass structure into nbd_client_thread instead of plain char*
> has introduced a regression. struct NbdClientOpts resides on stack inside
> 'if' block. This specifically means that this stack space could be reused
> once the execution will leave that block of the code.
> 
> This means that parameters passed into nbd_client_thread could be
> overwritten at any moment.
> 
> The patch moves the data to the namespace of main() function effectively
> preserving it for the whole process lifetime.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: <qemu-stable@nongnu.org>
> ---
> Changes from v1:
> - fixed compilation without HAVE_NBD_DEVICE (i.e. for Win/BSD)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


