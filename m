Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E61D741BF8
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 00:53:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEe0o-0001dN-VH; Wed, 28 Jun 2023 18:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qEe0n-0001d0-8m
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 18:51:45 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qEe0l-0007sr-MR
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 18:51:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 012581F45F;
 Wed, 28 Jun 2023 22:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1687992702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bpa8RBNbnpl92icVUg3N/atS+y8F1DQPRX1d6HoP4Ys=;
 b=vDkLFbEJIzZWXBHoKqvHYlq+/NKHFqPu/ygT/D7Wm3GmYvXUQYYMIgPkswK17VmfI3rOV3
 BHWGQllaBGpvphPPOmmNMmTGZl8duFZYjkDnlVXaUDW2h9SZTUDODFXMeQYF+op+JNeafG
 cxo7bk/0BhPjK0j120RaZ5mebSxirhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1687992702;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bpa8RBNbnpl92icVUg3N/atS+y8F1DQPRX1d6HoP4Ys=;
 b=i4vu/Nx8S3nKDUIPJoqJ/QjGrWBQTc2CEyLAozU7iWN0Q5mfSOwYA55orjfUnlaR7ye8vq
 LrApKPCaQbA8FXAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 854B3138E8;
 Wed, 28 Jun 2023 22:51:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9ur0E325nGT/dQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 28 Jun 2023 22:51:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH 3/7] migration: Refactor error handling in source return
 path
In-Reply-To: <20230628215002.73546-4-peterx@redhat.com>
References: <20230628215002.73546-1-peterx@redhat.com>
 <20230628215002.73546-4-peterx@redhat.com>
Date: Wed, 28 Jun 2023 19:51:39 -0300
Message-ID: <875y77qjyc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> rp_state.error was a boolean used to show error happened in return path
> thread.  That's not only duplicating error reporting (migrate_set_error),
> but also not good enough in that we only do error_report() and set it to
> true, we never can keep a history of the exact error and show it in
> query-migrate.
>
> To make this better, a few things done:
>
>   - Use error_setg() rather than error_report() across the whole lifecycle
>     of return path thread, keeping the error in an Error*.
>
>   - Use migrate_set_error() to apply that captured error to the global
>     migration object when error occured in this thread.
>
>   - With above, no need to have mark_source_rp_bad(), remove it, alongside
>     with rp_state.error itself.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

