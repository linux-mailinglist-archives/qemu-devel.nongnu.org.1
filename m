Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0456C7BFDA8
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 15:37:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqCuE-0000IC-Fu; Tue, 10 Oct 2023 09:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqCuB-0000Hw-9g
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:36:11 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqCu9-0005zb-BM
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:36:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B1ED01F38A;
 Tue, 10 Oct 2023 13:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696944967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gLafUYVUwsyJgfrtM9mjrv8RoV2SKTwOqyeCAnyfVCM=;
 b=ma20Z+GqhNtcWlgGhjTZ6lBP5ESxqfJOb7ZMuKpmxQrzUJUHd2z1283tm5GavSDGIkyHgE
 vkJvijae55L8aTJbsZIVXBlyWVLkzksqdbiV23hpyrpUDxTw1J92jmmpkeCclqU1y4+8zo
 CTqSi97EBPOsouQOl0GpmHVCWPGDFUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696944967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gLafUYVUwsyJgfrtM9mjrv8RoV2SKTwOqyeCAnyfVCM=;
 b=HrR4xYVhj17mbYMaPEeztMk+fUV6FZ+QT7gNXlIm/euJN9HRsrmYFjApLvhbXFwW0IdisG
 LJaw74yuuNDL/rCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AF821358F;
 Tue, 10 Oct 2023 13:36:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZXSJAkdTJWU5bAAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 10 Oct 2023 13:36:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Dmitry Frolov <frolov@swemel.ru>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org, Dmitry Frolov <frolov@swemel.ru>
Subject: Re: [PATCH v1] migration: fix RAMBlock add NULL check
In-Reply-To: <20231010104851.802947-1-frolov@swemel.ru>
References: <20231010104851.802947-1-frolov@swemel.ru>
Date: Tue, 10 Oct 2023 10:36:04 -0300
Message-ID: <87o7h6sipn.fsf@suse.de>
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

Dmitry Frolov <frolov@swemel.ru> writes:

> qemu_ram_block_from_host() may return NULL, which will be dereferenced w/o
> check. Usualy return value is checked for this function.
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: c7c0e72408df5e7821c0e995122fb2fe0ac001f1 ("migration/ram: Handle RAM block resizes during precopy")
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>  migration/ram.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index e4bfd39f08..bd4b7574e1 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4281,6 +4281,11 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
>      RAMBlock *rb = qemu_ram_block_from_host(host, false, &offset);
>      Error *err = NULL;
>  
> +    if (!rb) {
> +        error_report("RAM block not found");
> +        return;
> +    }
> +
>      if (migrate_ram_is_ignored(rb)) {
>          return;
>      }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

