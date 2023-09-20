Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BCA7A81B0
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:47:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwbC-0000LK-0Q; Wed, 20 Sep 2023 08:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiwb8-0000Kh-Dp
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:46:30 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiwb1-0003T7-Dq
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:46:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A8DAD210E0;
 Wed, 20 Sep 2023 12:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695213977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5rg7Hsb3zei0PH2DVEgAHfDLwjwW59mchFSbC+KYecQ=;
 b=bo6gF0voVuZ3RPQsghYveQG3kARhzjjccB6XavSQS+qrlZLU1nzaxV60TDweUzhldcJtsz
 IVk8dzXIfsxipxIu1QVie9bvl1jWvPjXd67n+Z1jNHH5d3m0vS9tHUaWLldn+8T/yZ2+08
 pS4kQG2zZea8HthnT3tmpArtGVlUGNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695213977;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5rg7Hsb3zei0PH2DVEgAHfDLwjwW59mchFSbC+KYecQ=;
 b=2YRqYb0fpljTJQ2AnyjtsvsTej9aPYHMBOT8Tm7/ago+mHZgu8qfE9YUewFNB1qo6A/aKm
 Czt1djwQdGK7qzCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CBA3132C7;
 Wed, 20 Sep 2023 12:46:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qEyCApnpCmWQZQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 20 Sep 2023 12:46:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Li Zhijian <lizhijian@fujitsu.com>, quintela@redhat.com,
 peterx@redhat.com, leobras@redhat.com
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: Re: [PATCH 1/2] migration: Fix rdma migration failed
In-Reply-To: <20230920090412.726725-1-lizhijian@fujitsu.com>
References: <20230920090412.726725-1-lizhijian@fujitsu.com>
Date: Wed, 20 Sep 2023 09:46:14 -0300
Message-ID: <87wmwlm2qx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

Li Zhijian <lizhijian@fujitsu.com> writes:

> From: Li Zhijian <lizhijian@cn.fujitsu.com>
>
> Destination will fail with:
> qemu-system-x86_64: rdma: Too many requests in this message (3638950032).Bailing.
>
> migrate with RDMA is different from tcp. RDMA has its own control
> message, and all traffic between RDMA_CONTROL_REGISTER_REQUEST and
> RDMA_CONTROL_REGISTER_FINISHED should not be disturbed.

Yeah, this is really fragile. We need a long term solution to this. Any
other change to multifd protocol as well as any other change to the
migration ram handling might hit this issue again.

Perhaps commit 294e5a4034 ("multifd: Only flush once each full round of
memory") should simply not have touched the stream at that point, but we
don't have any explicit safeguards to avoid interleaving flags from
different layers like that (assuming multifd is at another logical layer
than the ram handling).

I don't have any good suggestions at this moment, so for now:

Reviewed-by: Fabiano Rosas <farosas@suse.de>

