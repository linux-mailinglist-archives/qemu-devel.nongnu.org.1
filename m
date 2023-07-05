Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19327748F70
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 22:55:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH9Vw-0001Iw-EI; Wed, 05 Jul 2023 16:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qH9Vm-0001IK-Oi
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 16:54:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qH9Vk-0001sS-Tz
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 16:54:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 223911FE30;
 Wed,  5 Jul 2023 20:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688590442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=atRG0X2nJf0i2X54TOpJc+S1AXfT5R9EYfNBH/uAyxg=;
 b=UdgG5QvhAQtwDFqZFhztnviS5UCDoUmTXMvtEgFFsoJSGZkhpNBXPnCHTxGj+mSvJMDkaN
 WEWc+8Ej/1FBfdNn23RTGOKztSih5IZgqPoOtxEspP/ErWK/LDEAh9xiqwRp+NzCOLEJ89
 n7hu0TxxzB4eClvMCR7/FPFiBDKd0xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688590442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=atRG0X2nJf0i2X54TOpJc+S1AXfT5R9EYfNBH/uAyxg=;
 b=vYkrW1+QVwgfc4+r/CZD1Vx2J93L/rTzHf/ePGOZ/z8b+Hha2CQL7mX51KuZsL4MjzstYL
 Zs+zLyOurFK1pqDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FA1A13460;
 Wed,  5 Jul 2023 20:54:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id M/2bGmnYpWRTOwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 05 Jul 2023 20:54:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Leonardo Bras Soares Passos <lsoaresp@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Lukas Straub <lukasstraub2@web.de>, Laszlo Ersek
 <lersek@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v2 2/7] migration: Let migrate_set_error() take ownership
In-Reply-To: <20230705163502.331007-3-peterx@redhat.com>
References: <20230705163502.331007-1-peterx@redhat.com>
 <20230705163502.331007-3-peterx@redhat.com>
Date: Wed, 05 Jul 2023 17:53:59 -0300
Message-ID: <87h6qi3wrc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
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

> migrate_set_error() used one error_copy() so it always copy an error.
> However that's not the major use case - the major use case is one would
> like to pass the error to migrate_set_error() without further touching the
> error.
>
> It can be proved if we see most of the callers are freeing the error
> explicitly right afterwards.  There're a few outliers (only if when the
> caller) where we can use error_copy() explicitly there.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

