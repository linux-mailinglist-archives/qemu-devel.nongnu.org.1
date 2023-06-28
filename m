Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4127409CF
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:48:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPu2-00083L-P3; Wed, 28 Jun 2023 03:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEPtz-00082W-Pr
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEPty-0004o9-BZ
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687938465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+YOIlp+x94SDvDVgDGw+Qkqy30R8jZRuFL3XOL0DwUo=;
 b=LazEr7CXH01J4LkMskavcCtqtjmGEVyT4NVbjtivY+isIPwl5h9AvHdHvZ+LYl8gIeIUxB
 4S60rmdlwIWG2WKk0VrhN8NMaT0cNaT73HajGMtdhezcDQHEgjg2jSaSNeb6I2EBx4on5d
 Qe7bEA72P2P/1kEwKIy7pVSlU608YLc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-S4KgVL5dM0OfMYNaN1579g-1; Wed, 28 Jun 2023 03:47:42 -0400
X-MC-Unique: S4KgVL5dM0OfMYNaN1579g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF9EF185A795;
 Wed, 28 Jun 2023 07:47:41 +0000 (UTC)
Received: from redhat.com (dhcp-192-205.str.redhat.com [10.33.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40873429543;
 Wed, 28 Jun 2023 07:47:41 +0000 (UTC)
Date: Wed, 28 Jun 2023 09:47:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 00/12] block: more fixes to coroutine_fn marking
Message-ID: <ZJvlnIHXA/EV19B3@redhat.com>
References: <20230601115145.196465-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601115145.196465-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 01.06.2023 um 13:51 hat Paolo Bonzini geschrieben:
> *** BLURB HERE ***
> 
> Paolo Bonzini (12):
>   file-posix: remove incorrect coroutine_fn calls
>   qed: mark more functions as coroutine_fns and GRAPH_RDLOCK
>   vpc: mark more functions as coroutine_fns and GRAPH_RDLOCK
>   bochs: mark more functions as coroutine_fns and GRAPH_RDLOCK
>   block: mark another function as coroutine_fns and GRAPH_UNLOCKED
>   cloop: mark more functions as coroutine_fns and GRAPH_RDLOCK
>   dmg: mark more functions as coroutine_fns and GRAPH_RDLOCK
>   vmdk: mark more functions as coroutine_fns and GRAPH_RDLOCK
>   vhdx: mark more functions as coroutine_fns and GRAPH_RDLOCK
>   qcow2: mark more functions as coroutine_fns and GRAPH_RDLOCK
>   block: use bdrv_co_getlength in coroutine context
>   block: use bdrv_co_debug_event in coroutine context

Thanks, applied to the block branch.

Kevin


