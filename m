Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D688AAEFB
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Apr 2024 15:01:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxnqQ-0002EI-G8; Fri, 19 Apr 2024 08:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rxnqO-0002Dx-WF
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 08:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rxnqN-0006ri-E3
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 08:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713531594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KG351djTjx2PkJp+FNyrxCUZSA8+D2z9wHbn1nf+5Qo=;
 b=UfWiT58ivdkGT5YqTIWLI6NY+4PP640BLTUWNG6Z3/i1ssBnwZgtjwtnEOf5ylpt7Rs1re
 QHHoo3jVFlUv7DrZQLJrr0PPhcAuD9IKdhW1OQizxhkENh3wR00/Lp3+dfTxUUN+iEfw7Q
 qVPHi+vsiET5dWMJ2uZoBZAXgCU+KO4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-sYlXzKmvNaqWajrhatUcgA-1; Fri, 19 Apr 2024 08:59:51 -0400
X-MC-Unique: sYlXzKmvNaqWajrhatUcgA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C672580021A;
 Fri, 19 Apr 2024 12:59:50 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1C35112131D;
 Fri, 19 Apr 2024 12:59:48 +0000 (UTC)
Date: Fri, 19 Apr 2024 07:59:47 -0500
From: Eric Blake <eblake@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 qemu-block@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] tests/unit: Remove debug statements in
 test-nested-aio-poll.c
Message-ID: <zg6iz2vzomgnje7m3yqhwlfuv6ugha7u5xbarz3rl24jeyv7iz@nj24kj3prj7h>
References: <20240419085819.47606-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240419085819.47606-1-philmd@linaro.org>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Apr 19, 2024 at 10:58:19AM +0200, Philippe Mathieu-Daudé wrote:
> We are running this test since almost a year; it is

Grammar suggestion:

We have been running this test for almost a year;

> safe to remove its debug statements, which clutter
> CI jobs output:
> 
>   ▶  88/100 /nested-aio-poll                      OK
>   io_read 0x16bb26158
>   io_poll_true 0x16bb26158
>   > io_poll_ready
>   io_read 0x16bb26164
>   < io_poll_ready
>   io_poll_true 0x16bb26158
>   io_poll_false 0x16bb26164
>   > io_poll_ready
>   io_poll_false 0x16bb26164
>   io_poll_false 0x16bb26164
>   io_poll_false 0x16bb26164
>   io_poll_false 0x16bb26164
>   io_poll_false 0x16bb26164
>   io_poll_false 0x16bb26164
>   io_poll_false 0x16bb26164
>   io_poll_false 0x16bb26164
>   io_poll_false 0x16bb26164
>   io_read 0x16bb26164
>   < io_poll_ready
>   88/100 qemu:unit / test-nested-aio-poll        OK
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  tests/unit/test-nested-aio-poll.c | 7 -------
>  1 file changed, 7 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


