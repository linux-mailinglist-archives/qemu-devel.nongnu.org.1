Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2517A5035
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:02:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiHd5-0007KV-3R; Mon, 18 Sep 2023 13:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiHcz-0007GO-QD
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:01:45 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiHcy-0007gJ-97
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:01:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 15AE31FFF3;
 Mon, 18 Sep 2023 17:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695056498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=30PW/R8fLotPcp3kIjDgvacMfEm4SUzFbKQhZUdeWjU=;
 b=FKtp4MvZrZu4rC/Dt4PClhgRxY+6E7ZNkGi9PhBBsp0/mpHrnz1roFnXHvOGnufAJBnh+D
 UsbVpkrJIryGB3ZCXCVBAQmJXWJ4yelQY8GEeLBmbkHQNP0MHeB9QQe+mUkSYsr31pAK+h
 8lZCnM4D7bJ8ROBYctSk8ipglQnCtsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695056498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=30PW/R8fLotPcp3kIjDgvacMfEm4SUzFbKQhZUdeWjU=;
 b=XqcyfWypwKFNkuOcvEUiKayQAMGVW3NPmSisJXU8zKMdX/kTUycdMF7vNpDpGBCDQW3tpJ
 lW5UV8xJel/xsjAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BE5E1358A;
 Mon, 18 Sep 2023 17:01:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SN/DGXGCCGWXDAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 18 Sep 2023 17:01:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com
Subject: Re: [PATCH 04/52] migration/rdma: Drop fragile wr_id formatting
In-Reply-To: <20230918144206.560120-5-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-5-armbru@redhat.com>
Date: Mon, 18 Sep 2023 14:01:35 -0300
Message-ID: <87wmwnza8g.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> wrid_desc[] uses 4001 pointers to map four integer values to strings.
>
> print_wrid() accesses wrid_desc[] out of bounds when passed a negative
> argument.  It returns null for values 2..1999 and 2001..3999.
>
> qemu_rdma_poll() and qemu_rdma_block_for_wrid() print wrid_desc[wr_id]
> and passes print_wrid(wr_id) to tracepoints.  Could conceivably crash
> trying to format a null string.  I believe access out of bounds is not
> possible.
>
> Not worth cleaning up.  Dumb down to show just numeric wr_id.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

