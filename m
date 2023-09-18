Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E46B7A5256
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 20:49:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiJHw-0003zL-UH; Mon, 18 Sep 2023 14:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiJHu-0003yt-85
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 14:48:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiJHo-000478-Gf
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 14:48:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 88928200C9;
 Mon, 18 Sep 2023 18:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695062874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=14t5Fa4wZ/+A8P3wBzpmNcEk5dI3kiVrE5XVDUPAhxQ=;
 b=zjKRumeh8DEbTUvn2kY6tqJy6RearK+rBhvS5Pzo/YMdE1MpcDqM8vsE1BZAOQzdBIt0ss
 vdlVc8h/wRyjWcDHpvDlcwCxa8swXBDalvK5VeNHvZDle+F0WS8dxHVyZA1P9qsk7UajBr
 0KCFNw3XEyAdDUDmyj0TS5K1ldG81ZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695062874;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=14t5Fa4wZ/+A8P3wBzpmNcEk5dI3kiVrE5XVDUPAhxQ=;
 b=IUYHMc+l3qVYwILdKO1iczYN3p5AKUXHDrt3LdpzFAnE+FmuR2njtwM/ij9JjH0amILkMh
 dH53GEJ7xHjpVWCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 141A413480;
 Mon, 18 Sep 2023 18:47:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id i0I5NFmbCGUpOgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 18 Sep 2023 18:47:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com
Subject: Re: [PATCH 15/52] migration/rdma: Ditch useless numeric error codes
 in error messages
In-Reply-To: <20230918144206.560120-16-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-16-armbru@redhat.com>
Date: Mon, 18 Sep 2023 15:47:51 -0300
Message-ID: <871qevz5bc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
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

> Several error messages include numeric error codes returned by failed
> functions:
>
> * ibv_poll_cq() returns an unspecified negative value.  Useless.
>
> * rdma_accept and rmda_get_cm_event() return -1.  Useless.
>
> * qemu_rdma_poll() returns either -1 or an unspecified negative
>   value.  Useless.
>
> * qemu_rdma_block_for_wrid(), qemu_rdma_write_flush(),
>   qemu_rdma_exchange_send(), qemu_rdma_exchange_recv(),
>   qemu_rdma_write() return a negative value that may or may not be an
>   errno value.  While reporting human-readable errno
>   information (which a number is not) can be useful, reporting an
>   error code that may or may not be an errno value is useless.
>
> Drop these error codes from the error messages.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

