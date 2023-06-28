Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDA87409C6
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:41:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPnQ-0004eS-UZ; Wed, 28 Jun 2023 03:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEPnO-0004eF-IX
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:40:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEPnN-0003KP-4o
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687938056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rAHuvp9gHNEQgVe457TzONRKWrJHV45bn95LAtx286E=;
 b=IJeW2xa0WoTf+Kdcr2zawl0Cr8q4Lcia/i/W7l5bPDEiDvC/W1Yvb7uSQLoT6Z3whBGvxl
 e9/UTkFEnysixsZ1Re09spS37n+7Gsd70pUrTCMcXX34ZMjwsOrR7vOyjux6IYFiK/jNO4
 dVhZXxJ2MLX3KCWFp1UaFwex8iV2pDE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-VivBmpYFOAuiADVOj0mjQg-1; Wed, 28 Jun 2023 03:40:54 -0400
X-MC-Unique: VivBmpYFOAuiADVOj0mjQg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 414B31C05156;
 Wed, 28 Jun 2023 07:40:54 +0000 (UTC)
Received: from redhat.com (dhcp-192-205.str.redhat.com [10.33.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5ED940BB4D;
 Wed, 28 Jun 2023 07:40:53 +0000 (UTC)
Date: Wed, 28 Jun 2023 09:40:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 09/12] vhdx: mark more functions as coroutine_fns and
 GRAPH_RDLOCK
Message-ID: <ZJvkBHOJkvE5/5aL@redhat.com>
References: <20230601115145.196465-1-pbonzini@redhat.com>
 <20230601115145.196465-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601115145.196465-10-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 01.06.2023 um 13:51 hat Paolo Bonzini geschrieben:
> Mark functions as coroutine_fn when they are only called by other coroutine_fns
> and they can suspend.  Change calls to co_wrappers to use the non-wrapped
> functions, which in turn requires adding GRAPH_RDLOCK annotations.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

> @@ -1036,8 +1037,9 @@ exit:
>  }
>  
>  /* Perform a log write, and then immediately flush the entire log */
> -int vhdx_log_write_and_flush(BlockDriverState *bs, BDRVVHDXState *s,
> -                             void *data, uint32_t length, uint64_t offset)
> +int coroutine_fn GRAPH_RDLOCK
> +vhdx_log_write_and_flush(BlockDriverState *bs, BDRVVHDXState *s,
> +                         void *data, uint32_t length, uint64_t offset)
>  {
>      int ret = 0;
>      VHDXLogSequence logs = { .valid = true,

This is a public function, so GRAPH_RDLOCK needs to move to the header
so that callers in other source files are actually checked. I can fix
this up while applying.

Kevin


