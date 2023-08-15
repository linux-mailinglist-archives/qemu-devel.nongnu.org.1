Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D5277CCE2
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 14:47:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVtSD-0001me-UF; Tue, 15 Aug 2023 08:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qVtSB-0001m4-PS; Tue, 15 Aug 2023 08:47:19 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qVtS5-0005EV-Q8; Tue, 15 Aug 2023 08:47:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 222771F38D;
 Tue, 15 Aug 2023 12:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692103632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DWZkXO2IjjdinkHE9wP+I3jGuunCyBN1OU7XgaU36UM=;
 b=ym7wzt4QYgKCjcFaYfuZaRmYTxJlecaoedJ1oXpvuO/9lrsZj+ACLzMqrK66nOC2p/KXXk
 OU07/PT7Lk9okNw10KtW8EDyVTAZjGtxRZcfbDLCj4KvW5hs8U2ADE1Lz5vRd+pBzsh09A
 hncvLZg1aA2WQLti8dJq+GWmKWXi6oY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692103632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DWZkXO2IjjdinkHE9wP+I3jGuunCyBN1OU7XgaU36UM=;
 b=fzBKk8DuRL2UGhMrSHSr0bCUuCz8PI6sLbQK4r/nlIPHHbGNTEWYXQylEwbj55S1uRltDK
 2RkOxRcwlxc6T2Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A56FF13909;
 Tue, 15 Aug 2023 12:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TXbGG89z22SFIQAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 15 Aug 2023 12:47:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Leonardo Bras Soares Passos
 <lsoaresp@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 peterx@redhat.com, Juan Quintela <quintela@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH for-8.2 1/4] migration/qmp: Fix crash on setting
 tls-authz with null
In-Reply-To: <20230814221947.353093-2-peterx@redhat.com>
References: <20230814221947.353093-1-peterx@redhat.com>
 <20230814221947.353093-2-peterx@redhat.com>
Date: Tue, 15 Aug 2023 09:47:09 -0300
Message-ID: <87bkf8mq0i.fsf@suse.de>
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

Peter Xu <peterx@redhat.com> writes:

> QEMU will crash if anyone tries to set tls-authz (which is a type
> StrOrNull) with 'null' value.  Fix it in the easy way by converting it to
> qstring just like the other two tls parameters.
>
> Cc: qemu-stable@nongnu.org # v4.0+
> Fixes: d2f1d29b95 ("migration: add support for a "tls-authz" migration parameter")
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

