Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C0B7A50B6
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:12:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiHm9-0005Tz-IR; Mon, 18 Sep 2023 13:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiHm7-0005Ry-Pi
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:11:07 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiHm4-0001GM-3V
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:11:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A017121F07;
 Mon, 18 Sep 2023 17:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695057062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fs0qpoc1oCeceWn7tAWs2FiZ2n6w4K9Hansbxs5rln4=;
 b=FWDfWzKhkz6tgkjmJ74W6NidS5SFCLnGLM34OmA1EFg0uGaavUFymzlPHM73G6ZszDAecJ
 rJvG219DXtAWtJhyGf3un/PcR9zDXBO9Kq/9y4+umrkOVnAaKZf8MaUatAIcMpcDpChsNO
 834fFitUJJIVMJ13xMG/ROCzUgMCCmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695057062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fs0qpoc1oCeceWn7tAWs2FiZ2n6w4K9Hansbxs5rln4=;
 b=z2jaKNFHCs8WnHSQXvUvKhyjfrDsks5kYRtryXo113qrNc567pFyKKcXHNDjSbi4IeCjjH
 Chons+4Vb06OLNDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 325511358A;
 Mon, 18 Sep 2023 17:11:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tVxFO6WECGWcEAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 18 Sep 2023 17:11:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com
Subject: Re: [PATCH 06/52] migration/rdma: Clean up two more harmless signed
 vs. unsigned issues
In-Reply-To: <20230918144206.560120-7-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-7-armbru@redhat.com>
Date: Mon, 18 Sep 2023 14:10:59 -0300
Message-ID: <87r0mvz9ss.fsf@suse.de>
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

Markus Armbruster <armbru@redhat.com> writes:

> qemu_rdma_exchange_get_response() compares int parameter @expecting
> with uint32_t head->type.  Actual arguments are non-negative
> enumeration constants, RDMAControlHeader uint32_t member type, or
> qemu_rdma_exchange_recv() int parameter expecting.  Actual arguments
> for the latter are non-negative enumeration constants.  Change both
> parameters to uint32_t.
>
> In qio_channel_rdma_readv(), loop control variable @i is ssize_t, and
> counts from 0 up to @niov, which is size_t.  Change @i to size_t.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

just a comment...

>  static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
> -                                int expecting)
> +                                   uint32_t expecting)
>  {
>      RDMAControlHeader ready = {
>                                  .len = 0,
> @@ -2851,7 +2851,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
>      RDMAContext *rdma;
>      RDMAControlHeader head;
>      int ret = 0;
> -    ssize_t i;
> +    size_t i;
>      size_t done = 0;

It seems the idea was for 'done' to be ssize_t like in
qio_channel_rdma_writev()


