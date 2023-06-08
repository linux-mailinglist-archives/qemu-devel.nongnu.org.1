Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 647D77282C2
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:33:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Gh8-0005S1-Aq; Thu, 08 Jun 2023 10:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7Gh7-0005Rc-CA
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:32:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7Gh5-0005Wt-Sk
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686234770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0SL9Dgw0OfIcLOjUXWjK1U7eIZGp0Mi+7+wRFtmKQUc=;
 b=jD1fiBxr0DHmN8BXkAo1sbNKs6/1Th4/KLW/wuAAZcZLFqIavQUOvT5TVKWhsnpe2M1n/e
 R64JnEyeXoAeO4NFKY81bEN1eunP1CNjC6XTzeRfaXR5pEiDW+foGz8WxlLavzVFmg9YQ4
 7eluWX4G19JtMwugh5kY3TezLRSwVK8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-2wTC9VChNHKgMtewXfkcWQ-1; Thu, 08 Jun 2023 10:32:47 -0400
X-MC-Unique: 2wTC9VChNHKgMtewXfkcWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 018971C03D84;
 Thu,  8 Jun 2023 14:32:47 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B88989E90;
 Thu,  8 Jun 2023 14:32:45 +0000 (UTC)
Date: Thu, 8 Jun 2023 09:32:44 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 libguestfs@redhat.com, qemu-block@nongnu.org, vsementsov@yandex-team.ru
Subject: Re: [Libguestfs] [PATCH v4 05/24] nbd: s/handle/cookie/ to match NBD
 spec
Message-ID: <4gdnjqspbumzid6p4gxsuke6eiit7ax3557oblfn56bjq5qdal@oszetutr66rc>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608135653.2918540-6-eblake@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 08, 2023 at 08:56:34AM -0500, Eric Blake wrote:
> Externally, libnbd exposed the 64-bit opaque marker for each client
> NBD packet as the "cookie", because it was less confusing when
> contrasted with 'struct nbd_handle *' holding all libnbd state.  It
> also avoids confusion between the nown 'handle' as a way to identify a

noun

> packet and the verb 'handle' for reacting to things like signals.
> Upstream NBD changed their spec to favor the name "cookie" based on
> libnbd's recommendations[1], so we can do likewise.
> 
> [1] https://github.com/NetworkBlockDevice/nbd/commit/ca4392eb2b
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


