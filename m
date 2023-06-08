Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5AA72827D
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:18:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7GSq-0006Dq-LP; Thu, 08 Jun 2023 10:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7GSo-000691-Mo
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7GSn-00028L-4m
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686233888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XGHlzgs+fYkxfQJSWv2RkJ00Hak79mZOAJWc0CDpNCI=;
 b=YPVGT90Zg3MjuHPiofnqXKnr85er8LV3XrBGTmCWNFilvXb9vEESZU+weoLuOI0MFlcxbC
 MxIrg8UmcxMxPPzglpXvJ1GPWYSF+9LzqQNDbYWhRak7EWLPaEs1lnV9mtu1tsCOHWb5wW
 VtkjwBOkOKvlopDxMoIGqywzEcb16h0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-9_7CGSUzP7W9FBS9M5AjvQ-1; Thu, 08 Jun 2023 10:18:03 -0400
X-MC-Unique: 9_7CGSUzP7W9FBS9M5AjvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8688382C97E;
 Thu,  8 Jun 2023 14:17:59 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 224AF2166B25;
 Thu,  8 Jun 2023 14:17:59 +0000 (UTC)
Date: Thu, 8 Jun 2023 09:17:57 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 libguestfs@redhat.com, qemu-block@nongnu.org, vsementsov@yandex-team.ru
Subject: Re: [Libguestfs] [PATCH v4 02/24] nbd: Consistent typedef usage in
 header
Message-ID: <jo2eqbij3xyku4n5hm2ftahzymkimjulpm6kmjh47lbec4t3ov@y4m4ypbhm4ie>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608135653.2918540-3-eblake@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 08, 2023 at 08:56:31AM -0500, Eric Blake wrote:
> We had a mix of struct declarataions followed by typedefs, and direct

declarations

> struct definitions as part of a typedef.  Pick a single style.  Also
> float a couple of opaque typedefs earlier in the file, as a later
> patch wants to refer NBDExport* in NBDRequest.  No semantic impact.

The curse of writing a commit message and then rebasing to a different
idea; in patch 22, I had originally intended to make NBDMetaContexts a
concrete type in nbd.h (which depends on NBDExport*, and would be
directly used in NBDRequest, which in turn is declared before the
pre-patch mention of NBDExport), but then changed my mind to instead
have NBDMetaContexts itself also be an opaque type with NBDRequest
only using NBDMetaContexts*.  And I missed floating the typedef for
NBDClientConnection to the same point, because we somewhat separated
opaque types along the lines of which .c files provide various
functions and opaque types.

> @@ -26,24 +26,25 @@
>  #include "qapi/error.h"
>  #include "qemu/bswap.h"
> 
> +typedef struct NBDExport NBDExport;
> +typedef struct NBDClient NBDClient;
> +

Preferences on how I should tweak that aspect of this patch?  Options:

- Don't float NBDExport or NBDClient, and drop that part of the commit
  message.  However, the later patch that adds the typedef for
  NBDMetaContexts still has to do it earlier than the definition of
  NBDRequest, rather than alongside the other opaque types relevant to
  server.c

- Also float NBDClientConnection up here, and reword the commit
  message along the lines of: Also float forward declarations of
  opaque types to the top of the file, rather than interspersed with
  function declarations, which will help a future patch that wants to
  expose yet another opaque type that will be referenced in
  NBDRequest.

- something else?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


