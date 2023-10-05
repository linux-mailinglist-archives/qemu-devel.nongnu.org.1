Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2F57BA978
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 20:51:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoTRO-00044K-43; Thu, 05 Oct 2023 14:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoTRM-000445-1e
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoTRK-0007fv-43
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696531872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=axYjMWjXmUISRFCqSGv9WXRrxaXT+DuoIR0/UoWykWo=;
 b=J9n2CgITOZM1nF1v/0/GagsCh6IpjZf0/2ysyGMP6hnN9fAjI1A/1+k/JHnW+9ji8odN+W
 +T6NbCeBSbM8rcMHcSvNKmYTLJEjmpDtTaT4MRJUKSdTaXDO7zKeF21bbFrn6iiDZNIo94
 fl5QRVR+1RYxm0+rQ+KbwVat/LyNhxE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-JWScfCPKM36VmfKhg0mX7g-1; Thu, 05 Oct 2023 14:51:09 -0400
X-MC-Unique: JWScfCPKM36VmfKhg0mX7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C62B41875044;
 Thu,  5 Oct 2023 18:51:08 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35F9A215670B;
 Thu,  5 Oct 2023 18:51:08 +0000 (UTC)
Date: Thu, 5 Oct 2023 13:51:06 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jsnow@redhat.com, 
 crosa@redhat.com, kwolf@redhat.com, hreitz@redhat.com
Subject: Re: [PATCH v6 03/14] scripts/cpu-x86-uarch-abi.py: use .command()
 instead of .cmd()
Message-ID: <lojq5n4pofh4d3jrveqprde4k4rjkrv2qoorkfi7brq73tghgd@saowakelbwzl>
References: <20231005135550.331657-1-vsementsov@yandex-team.ru>
 <20231005135550.331657-4-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005135550.331657-4-vsementsov@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 05, 2023 at 04:55:39PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Here we don't expect a failure. In case on failure we'll crash on

s/case on/case of/

> trying to access ['return']. Let's better use .command() that clearly
> raise on failure.

Maybe: s/Let's better /Better is to/; s/raise/raises/

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  scripts/cpu-x86-uarch-abi.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


