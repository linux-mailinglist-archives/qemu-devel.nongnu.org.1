Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 638007A828A
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 15:02:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwqH-00038F-0u; Wed, 20 Sep 2023 09:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiwqE-000384-J3
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:02:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiwqC-0007AR-6z
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:02:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4AAFE21A83;
 Wed, 20 Sep 2023 13:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695214922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aHbLn2/CymABjgA1ytErZ6xbbfSFVt1JimUjVXlKreo=;
 b=fLHwNqlJ2MWV/kz4KKO0Gsrpe4yMMWWT0CMKZTsWYjQQU2t0MD2Qy7ztuC4BxCm0eG6eUa
 4JrpFOtJlurjiOATWnUaKJIVoGWvePjM99bewGr5Hsl+I+dgRRcZT/4cGQk4d84lznM0rm
 XLBCI7faFVW6A5Q+DVwUstjNIACdalo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695214922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aHbLn2/CymABjgA1ytErZ6xbbfSFVt1JimUjVXlKreo=;
 b=9vX7QWAvJCsjarTCZhjIPjXjzSXAyOzvnZSQYNIv3+J1tihC1cOcjpS0ocxrLJ/NdjJ7gb
 5jzO1WrWiW/2WrDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1E16132C7;
 Wed, 20 Sep 2023 13:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BdHWJkntCmUKbwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 20 Sep 2023 13:02:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Li Zhijian <lizhijian@fujitsu.com>, quintela@redhat.com,
 peterx@redhat.com, leobras@redhat.com
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: Re: [PATCH 2/2] migration/rdma: zore out head.repeat to make the
 error more clear
In-Reply-To: <20230920090412.726725-2-lizhijian@fujitsu.com>
References: <20230920090412.726725-1-lizhijian@fujitsu.com>
 <20230920090412.726725-2-lizhijian@fujitsu.com>
Date: Wed, 20 Sep 2023 10:01:59 -0300
Message-ID: <87ttrpm20o.fsf@suse.de>
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

Li Zhijian <lizhijian@fujitsu.com> writes:

> From: Li Zhijian <lizhijian@cn.fujitsu.com>
>
> Previously, we got a confusion error that complains
> the RDMAControlHeader.repeat:
> qemu-system-x86_64: rdma: Too many requests in this message (3638950032).Bailing.
>
> Actually, it's caused by an unexpected RDMAControlHeader.type.
> After this patch, error will become:
> qemu-system-x86_64: Unknown control message QEMU FILE
>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  migration/rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index a2a3db35b1..3073d9953c 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2812,7 +2812,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
>          size_t remaining = iov[i].iov_len;
>          uint8_t * data = (void *)iov[i].iov_base;
>          while (remaining) {
> -            RDMAControlHeader head;
> +            RDMAControlHeader head = {};
>  
>              len = MIN(remaining, RDMA_SEND_INCREMENT);
>              remaining -= len;

I'm struggling to see how head is used before we set the type a couple
of lines below. Could you expand on it?

Also, a smoke test could have caught both issues early on. Is there any
reason for not having any?

