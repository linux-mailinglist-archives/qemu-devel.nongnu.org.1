Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 454A079E97C
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:38:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgQ3u-00037A-4D; Wed, 13 Sep 2023 09:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgQ3r-0002vE-KA
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:37:43 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgQ3o-0002b3-DU
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:37:42 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 33EA1218DF;
 Wed, 13 Sep 2023 13:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694612257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UrxPHAiTAdqqkZt89YYZrpIMjLy7KWylVk1ozP6XIvs=;
 b=GbK1LHBHQQ+MVyWcDDehaJFq2b272gWK8AkemgMhMkSh5bz/pFnRQOYiDXLSleBrE+ENJV
 f4oYEmS3+uJqP/7Z8WCIEjdyIE1B++l4Ib7tO+yLjUPiXmypgUZI99P6QoiL9awUtse8wr
 HWBcGbiKGpXQG0g5/IgZ53dQjBN5FRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694612257;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UrxPHAiTAdqqkZt89YYZrpIMjLy7KWylVk1ozP6XIvs=;
 b=QwoTgiI2PIaQ4XCCT3N7p38ayowjPjwTaCv+UIrBBEXfivvTu8EMSuEjFnqS0oZoGMHKLC
 zkjKTdLiBVm3bDCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98AFB13582;
 Wed, 13 Sep 2023 13:37:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9fERFiC7AWVESgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 13 Sep 2023 13:37:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v2 10/11] migration: Allow RECOVER->PAUSED convertion
 for dest qemu
In-Reply-To: <20230912222145.731099-11-peterx@redhat.com>
References: <20230912222145.731099-1-peterx@redhat.com>
 <20230912222145.731099-11-peterx@redhat.com>
Date: Wed, 13 Sep 2023 10:37:33 -0300
Message-ID: <871qf2kxcy.fsf@suse.de>
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

Peter Xu <peterx@redhat.com> writes:

> There's a bug on dest that if a double fault triggered on dest qemu (a
> network issue during postcopy-recover), we won't set PAUSED correctly
> because we assumed we always came from ACTIVE.
>
> Fix that by always overwriting the state to PAUSE.
>
> We could also check for these two states, but maybe it's an overkill.  We
> did the same on the src QEMU to unconditionally switch to PAUSE anyway.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

