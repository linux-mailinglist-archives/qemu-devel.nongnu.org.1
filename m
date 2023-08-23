Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B1B785F3B
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 20:08:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYsGR-0004nF-7e; Wed, 23 Aug 2023 14:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qYsGJ-0004n6-6D
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 14:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qYsGG-0004Xz-JQ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 14:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692814038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tf2Ie+DWIQIAevyeSjlBDmNqpNSvonw73Qvdoyg/S8c=;
 b=F1gIkassRBMoaUiGzpfH/F9TgBXvtdHO6oPmhsNDiztN7aidRYM0o3ByP0Cxlk6rDhVhvZ
 E6g1UKHoX9a8icA1dHZlmZ4L+uWNk7sOwZXqBeP2NAWG17XFQfi2D3IQ5k9slOh8oVlmRP
 eXshytMk41v+b9EhS6OpmhE644D2C8g=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-33OGpHzpNuiLhLNMA0IOLg-1; Wed, 23 Aug 2023 14:07:15 -0400
X-MC-Unique: 33OGpHzpNuiLhLNMA0IOLg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0725B1C0724D;
 Wed, 23 Aug 2023 18:07:15 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AAA15140E950;
 Wed, 23 Aug 2023 18:07:14 +0000 (UTC)
Date: Wed, 23 Aug 2023 13:07:13 -0500
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 23/24] qga/: spelling fixes
Message-ID: <m7vx4v4hka2remj3skhrscv54papotcaidf6kpylvlaxtr35dg@exrv3lsmjnwr>
References: <cover.1691405748.git.mjt@tls.msk.ru>
 <20230823055155.1917375-24-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823055155.1917375-24-mjt@tls.msk.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

On Wed, Aug 23, 2023 at 08:51:54AM +0300, Michael Tokarev wrote:
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qga/channel-posix.c       | 2 +-
>  qga/commands-posix-ssh.c  | 2 +-
>  qga/commands-posix.c      | 2 +-
>  qga/commands-win32.c      | 4 ++--
>  qga/main.c                | 2 +-
>  qga/vss-win32/install.cpp | 4 ++--
>  6 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


