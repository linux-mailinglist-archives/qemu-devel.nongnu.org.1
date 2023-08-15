Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 102F277D1BB
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 20:25:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVyi0-0003Te-QC; Tue, 15 Aug 2023 14:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qVyhy-0003TW-SR
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 14:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qVyhw-0005K3-SZ
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 14:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692123836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bPu1FwNzqIVsrTVLizFpvHy8bryyufCUTfI5Q2xRd2g=;
 b=DrOoEnVuc0wrBo20ZbFkYkALLRBPLaUN+Ci/OqsT1Vk8B/dNAw5hINTMmIM1AvsI3ntKzx
 mQ00kO1YpdiNOJm4VWGrUVKe7WvGCOw1L+cFmjYjJwaHqhnjJGK2eg55GuFbLMgx/l40OQ
 udhscyRo2s+mABa2D7p4s7jrrAYCMq8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-Jce67zGXO-CReJff2XKdCA-1; Tue, 15 Aug 2023 14:23:51 -0400
X-MC-Unique: Jce67zGXO-CReJff2XKdCA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 352C985D062;
 Tue, 15 Aug 2023 18:23:51 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 373BD40C207A;
 Tue, 15 Aug 2023 18:23:50 +0000 (UTC)
Date: Tue, 15 Aug 2023 13:23:48 -0500
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 5/7] softmmu/vl.c: inline include/qemu/qemu-options.h
 into vl.c
Message-ID: <vacoo3bd5kkyv2ghtpsa34fnn4ljntd3qdybjywguaea2z2vzf@phkqpivlawr6>
References: <cover.1691843673.git.mjt@tls.msk.ru>
 <acc7fd8cf5d1c6814dab77e2ad5d9dab99aefd4a.1691843673.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acc7fd8cf5d1c6814dab77e2ad5d9dab99aefd4a.1691843673.git.mjt@tls.msk.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
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

On Sat, Aug 12, 2023 at 03:47:59PM +0300, Michael Tokarev wrote:
> qemu-options.h just includes qemu-options.def with some #defines.
> We already do this in vl.c in other place. Since no other file
> includes qemu-options.h anymore, just inline it in vl.c.
> 
> This effectively reverts second half of commit 59a5264b99434.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  include/qemu/qemu-options.h | 41 -------------------------------------
>  softmmu/vl.c                | 11 +++++++++-
>  2 files changed, 10 insertions(+), 42 deletions(-)
>  delete mode 100644 include/qemu/qemu-options.h

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


