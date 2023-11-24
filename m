Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F847F79B3
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 17:50:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6ZN0-0007Ur-Nb; Fri, 24 Nov 2023 11:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r6ZMw-0007UL-WD
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 11:49:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r6ZMr-0001VB-W3
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 11:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700844564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFcwlNtkePlAyP/m8K1zHN5LCZ/p2hhP0du0J3Hrumw=;
 b=A5eIKeYJmcWl43XtVjDUiiatX3JNrQZ9OiNjKZbvQoNXsslKhBFGaTCx2PxaN3Xc8vHJt7
 5ZGALHy2AivGKEDH2xkKZHPf66AciYFP+MlyrGKURsmwfUwzLh4cktg3AhF5dqlJwzHxe5
 VTUMQ+qflLuHuA3xIYzRkKSOH8jR2bw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-ZhTxTMLjNYyrCUBKO8PIzw-1; Fri, 24 Nov 2023 11:49:22 -0500
X-MC-Unique: ZhTxTMLjNYyrCUBKO8PIzw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A943101A53B;
 Fri, 24 Nov 2023 16:49:22 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67DD6492BFA;
 Fri, 24 Nov 2023 16:49:21 +0000 (UTC)
Date: Fri, 24 Nov 2023 17:49:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: =?utf-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
Cc: hreitz@redhat.com, qemu-block@nongnu.org, sdl.qemu@linuxtesting.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] block/monitor: blk_bs() return value check
Message-ID: <ZWDUEOutdtCNLOW_@redhat.com>
References: <20231124113037.2477645-1-frolov@swemel.ru>
 <ZWCf3hoaNHaWNECw@redhat.com>
 <53dc30ea-1156-f91f-736f-62ddc9401d68@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53dc30ea-1156-f91f-736f-62ddc9401d68@swemel.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 24.11.2023 um 15:05 hat Дмитрий Фролов geschrieben:
> 
> 
> On 24.11.2023 16:06, Kevin Wolf wrote:
> > Am 24.11.2023 um 12:30 hat Dmitry Frolov geschrieben:
> > > blk_bs() may return NULL, which will be dereferenced without a check in
> > > bdrv_commit().
> > > 
> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > > 
> > > Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> > Do you have a reproducer for a crash?
> Actually, there was no crash. This problem was found by static analyzer.
> > As far as I can see, it will not be dereferenced, because
> > blk_is_available() returns false and we return an error before
> > calling bdrv_commit():
> As I see, there are 2 reasons, why blk_bs() may return NULL:
> blk->root == NULL or blk->root->bs == NULL

blk->root->bs == NULL shouldn't happen, but the code we're looking at is
safe even for this case.

> At the same time, blk_is_available() checks for
> blk_co_is_inserted(blk) and blk_dev_is_tray_open(blk).
> Does it also guarantee that blk->root and blk->root->bs are not NULL?
> This is not really obvious.

blk_co_is_inserted() does, it returns false for blk_bs(blk) == NULL.

> Maybe, in this case, it makes sense to check blk->root before of
> checking blk_is_available()?

Checking blk->root and those few other things is a really common thing
that most operations do, which is why we have blk_is_available() to
check all of this. If we did the checks before calling it, we wouldn't
need blk_is_available() any more.

Kevin


