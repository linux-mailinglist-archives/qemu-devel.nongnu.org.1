Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 654677C5D63
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 21:04:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqeVJ-00058m-Ge; Wed, 11 Oct 2023 15:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqeVH-00056m-6R
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 15:04:19 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqeVF-0007vu-Ho
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 15:04:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1AFC21F45A;
 Wed, 11 Oct 2023 19:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697051056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zud4DgXjqrKKYKGQ2fvDxkInpccGF5GnihiDRNlxiBI=;
 b=bLG7ySzZtB7uFotONW0PdZkcsJ84Ai+lDvipPr/fp11y6l6HETXRkBt2WA3oY7Q4XNcX3f
 SWKQrBGsIp6vUyqt35jlKXxo9ZyUwwWC8+ALkv2rANkGy4JSG+sLXFJf8ReHE4FiPBMmhu
 8H5/LjCtihFOKpheKrkVjIEy/ddgVy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697051056;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zud4DgXjqrKKYKGQ2fvDxkInpccGF5GnihiDRNlxiBI=;
 b=ByeW2B4BHnd8xoHl1qwCZw1ClQTSwL3epEpPUONj7Gt2P+CNnTvStUPeGcggj7cy13z7V2
 qLTeoq06AKIb8sCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9674C138EF;
 Wed, 11 Oct 2023 19:04:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8COpGK/xJmWVdQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 11 Oct 2023 19:04:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/4] multifd: document packet_len, next_packet_size
In-Reply-To: <20231011184358.97349-3-elena.ufimtseva@oracle.com>
References: <20231011184358.97349-1-elena.ufimtseva@oracle.com>
 <20231011184358.97349-3-elena.ufimtseva@oracle.com>
Date: Wed, 11 Oct 2023 16:04:13 -0300
Message-ID: <87a5sp0ymq.fsf@suse.de>
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

Elena Ufimtseva <elena.ufimtseva@oracle.com> writes:

> next_packet_size name is a bit misleading, so add more comments
> where its defined.
> We send data in two chunks in multifd thread:
>  - send the packet with normal (non-zero) guest pages offsets that are
>    dirty.
>    This uses the packet_len and we increment number of packets
>    for this thread that are sent;
>  - send the normal (non-zero) guest dirty pages themselves in iovs.
>    The total size of the data pointed by all iovs for this chunk
>    is next_packet_size. We do not increment the packet_num for this
>    thread when sending actual pages;
>
> When compression is enabled, next_packet_size is used to indicate
> the size of the compressed buffer on source and destination.
>
> Will be it helpful to rename it as data_size or dirty_data_size?
>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  migration/multifd.h | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/migration/multifd.h b/migration/multifd.h
> index a835643b48..37da9b68c2 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -45,7 +45,13 @@ typedef struct {
>      uint32_t pages_alloc;
>      /* non zero pages */
>      uint32_t normal_pages;
> -    /* size of the next packet that contains pages */
> +    /*
> +     * amount of data to be sent to the destination
> +     * that is calculated as
> +     *  - number of the normal guest dirty pages * page_size in non
> +     *    compression case;
> +     *  - equals of the compressed data size to be received;
> +     */
>      uint32_t next_packet_size;

So maybe "payload_size"? This one, not the "next".

Let's see what other people think, but I'm in favor of just renaming
instead of documenting. Later on the maths change and the comment might
become off-sync with the code.

