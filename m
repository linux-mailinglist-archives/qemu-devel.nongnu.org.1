Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A127C7287B8
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 21:12:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7L2E-0003Wf-Tz; Thu, 08 Jun 2023 15:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7L2D-0003WF-8f
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 15:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7L2B-0006jl-Sp
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 15:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686251458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hzoLysFpsjNthQzP7IEtMCvBPRSJOglJD/QJs5DNj2c=;
 b=Do6l0NwhZ2c4JEQ0qfkgfnIf/mpPMC3Afca6lMIHhGlNMraezglDnZ3oOFVrjt2DKezOQn
 5wLOCXOt+2GVW6xVEjrD2ZRhmkdzJVT+wLY4Y1p7uQWZS9yjGPkeDCkxwcstM9+q0M4ujG
 AiuK3WZYprvisAJkFS4MZynPrJUgFBM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-JilEBvEaOzW7V9HqvKgiWw-1; Thu, 08 Jun 2023 15:10:56 -0400
X-MC-Unique: JilEBvEaOzW7V9HqvKgiWw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7CAF181885E;
 Thu,  8 Jun 2023 19:10:53 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C61D9E90;
 Thu,  8 Jun 2023 19:10:52 +0000 (UTC)
Date: Thu, 8 Jun 2023 14:10:50 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 libguestfs@redhat.com, qemu-block@nongnu.org, vsementsov@yandex-team.ru
Subject: Re: [Libguestfs] [PATCH v4 18/24] nbd/client: Plumb errp through
 nbd_receive_replies
Message-ID: <y2ui6myqfs2atfwrrzwxpxdxf4gfvizlqgu63jbww2glsh7udr@kbxj7bdyzna2>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-19-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608135653.2918540-19-eblake@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 08, 2023 at 08:56:47AM -0500, Eric Blake wrote:
> Instead of ignoring the low-level error just to refabricate our own
> message to pass to the caller, we can just plump the caller's errp

plumb

(at least I got it right in the subject line...)

> down to the low level.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


