Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C48F37A5270
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 20:58:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiJRE-0007Tf-2y; Mon, 18 Sep 2023 14:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiJRB-0007TA-W6
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 14:57:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiJRA-0006qR-FG
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 14:57:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE83022060;
 Mon, 18 Sep 2023 18:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695063454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HSDWtE/9wGS9ZX+x+RMmDZiWUy7GnIJ0iBVWO4/YHXc=;
 b=XsU2/YMZqqP0jjy0GQyVBtzoFl+rdEyS/vYNjTu9kHj4vxP5A5kGprBzWHisWqnxyrQN4e
 pCc8KU6BnO8F2Y+lOR4aDS9Q4JVdkcEaG+mFiJi0uKOoa+WKj0IHV5D/6LsCu8HVh58Fm6
 hxgTS6fEF4D/tJimE1kBxuHjeqmmefY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695063454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HSDWtE/9wGS9ZX+x+RMmDZiWUy7GnIJ0iBVWO4/YHXc=;
 b=aR3oNJUzj0Kk954HpQ+uzuH368kg58cxFwkhwbS+Q+CNcqv4f3nmHg+bGwGNeRIhjkdzD4
 KLbLVzzm/aEQXkAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56EFD13480;
 Mon, 18 Sep 2023 18:57:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id apL5CJ6dCGVTPgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 18 Sep 2023 18:57:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com
Subject: Re: [PATCH 16/52] migration/rdma: Fix io_writev(), io_readv()
 methods to obey contract
In-Reply-To: <20230918144206.560120-17-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-17-armbru@redhat.com>
Date: Mon, 18 Sep 2023 15:57:31 -0300
Message-ID: <87wmwnxqas.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> QIOChannelClass methods qio_channel_rdma_readv() and
> qio_channel_rdma_writev() violate their method contract when
> rdma->error_state is non-zero:
>
> 1. They return whatever is in rdma->error_state then.  Only -1 will be
>    fine.  -2 will be misinterpreted as "would block".  Anything less
>    than -2 isn't defined in the contract.  A positive value would be
>    misinterpreted as success, but I believe that's not actually
>    possible.
>
> 2. They neglect to set an error then.  If something up the call stack
>    dereferences the error when failure is returned, it will crash.  If
>    it ignores the return value and checks the error instead, it will
>    miss the error.
>
> Crap like this happens when return statements hide in macros,
> especially when their uses are far away from the definition.
>
> I elected not to investigate how callers are impacted.
>
> Expand the two bad macro uses, so we can set an error and return -1.
> The next commit will then get rid of the macro altogether.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

