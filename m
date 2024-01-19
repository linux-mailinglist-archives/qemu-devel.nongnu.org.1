Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D384832E5B
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 18:48:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQsy2-0001s0-5r; Fri, 19 Jan 2024 12:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQsxz-0001rH-LN
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:47:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQsxv-0002pB-3f
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705686457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ycOGw+ownpgUzMGvWMdKxUPFl0FrgBPZH5QjVks0Rg=;
 b=GInP989TNUiKm4G6Kypk+uPBii2B+m3m6Aznwrtv+wE4bnn+o55ac1EjUy+sAKDcTJ2hhr
 9WO2HqQOlwjF5vHPNmE9WkmgM7TDCvPdu+8vIo0IMaB5w8JlEKpaRyFIym32iqady7vOuG
 mE1gY5LPEla/xRq5GXWsOmWpDFYVXLg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-QdltjCszOF2LcA8h3DenbQ-1; Fri, 19 Jan 2024 12:47:36 -0500
X-MC-Unique: QdltjCszOF2LcA8h3DenbQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0751C8E4144;
 Fri, 19 Jan 2024 17:47:36 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 52FC251D5;
 Fri, 19 Jan 2024 17:47:35 +0000 (UTC)
Date: Fri, 19 Jan 2024 18:47:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Ari Sundholm <ari@tuxera.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v3] block/blklogwrites: Protect mutable driver state with
 a mutex.
Message-ID: <Zaq1tkw1E2RFZm1n@redhat.com>
References: <f1960d8d-352e-4e1b-4d28-7a110e272356@tuxera.com>
 <20240119162913.2620245-1-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119162913.2620245-1-ari@tuxera.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 19.01.2024 um 17:29 hat Ari Sundholm geschrieben:
> During the review of a fix for a concurrency issue in blklogwrites,
> it was found that the driver needs an additional fix when enabling
> multiqueue, which is a new feature introduced in QEMU 9.0, as the
> driver state may be read and written by multiple threads at the same
> time, which was not the case when the driver was originally written.
> 
> Fix the multi-threaded scenario by introducing a mutex to protect the
> mutable fields in the driver state, and always having the mutex locked
> by the current thread when accessing them. Also use the mutex and a
> CoQueue to ensure that the super block is not being written to by
> multiple threads concurrently and updates are properly serialized.
> 
> Additionally, add the const qualifier to a few BDRVBlkLogWritesState
> pointer targets in contexts where the driver state is not written to.
> 
> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> 
> v1->v2: Ensure that the super block is not written to concurrently.
> v2->v3: Use a CoQueue instead of a condition variable, as the latter
> does not make the currently executing coroutine yield on entering a
> wait.
> ---
>  block/blklogwrites.c | 85 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 77 insertions(+), 8 deletions(-)

For your next series, please put the changelog between versions below
the "---" marker so that git am doesn't consider it part of the commit
message.

Thanks, applied to the block branch.

Kevin


