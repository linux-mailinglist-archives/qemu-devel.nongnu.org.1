Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 504C27B9D50
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 15:28:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoOMi-00075K-Eu; Thu, 05 Oct 2023 09:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qoOMc-00072v-DN
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:26:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qoOMJ-0000J8-HA
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:26:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CD78D21875;
 Thu,  5 Oct 2023 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696512331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EePAU8Kb9bJydQic4yCtvXVOI6HJ6cQ/QBynIu5197A=;
 b=Kd14n6f6DjcxkEPAxKMcIezmVG9b/K/fOP2lNYUWaP8gjx4HzYKUS4qpEQDKlE40jN9FLv
 wPb8rG0Con50MkyZXIh80tCH9gcwCB6yqRlzITLmMRaFYEmj6f/n4Dd4zVNyBkrltJVgOW
 4NBejFYV4GIp3WUYsjW7JqJW0reuSWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696512331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EePAU8Kb9bJydQic4yCtvXVOI6HJ6cQ/QBynIu5197A=;
 b=Cz/36DCApUgSjczb2drmzYI9K9dg8hOfoA13mI5AQGnI6p7ggxX+G6P2i3QWD5mWTs/R3S
 lw54pNM/AGOiIBDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 627E413438;
 Thu,  5 Oct 2023 13:25:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Sf3WC0u5HmV5CwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 05 Oct 2023 13:25:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>, Xiaohui Li
 <xiaohli@redhat.com>
Subject: Re: [PATCH v3 08/10] migration: Allow network to fail even during
 recovery
In-Reply-To: <20231004220240.167175-9-peterx@redhat.com>
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-9-peterx@redhat.com>
Date: Thu, 05 Oct 2023 10:25:29 -0300
Message-ID: <87bkddfbg6.fsf@suse.de>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> Normally the postcopy recover phase should only exist for a super short
> period, that's the duration when QEMU is trying to recover from an
> interrupted postcopy migration, during which handshake will be carried out
> for continuing the procedure with state changes from PAUSED -> RECOVER ->
> POSTCOPY_ACTIVE again.
>
> Here RECOVER phase should be super small, that happens right after the
> admin specified a new but working network link for QEMU to reconnect to
> dest QEMU.
>
> However there can still be case where the channel is broken in this small
> RECOVER window.
>
> If it happens, with current code there's no way the src QEMU can got kicked
> out of RECOVER stage. No way either to retry the recover in another channel
> when established.
>
> This patch allows the RECOVER phase to fail itself too - we're mostly
> ready, just some small things missing, e.g. properly kick the main
> migration thread out when sleeping on rp_sem when we found that we're at
> RECOVER stage.  When this happens, it fails the RECOVER itself, and
> rollback to PAUSED stage.  Then the user can retry another round of
> recovery.
>
> To make it even stronger, teach QMP command migrate-pause to explicitly
> kick src/dst QEMU out when needed, so even if for some reason the migration
> thread didn't got kicked out already by a failing rethrn-path thread, the
> admin can also kick it out.
>
> This will be an super, super corner case, but still try to cover that.
>
> One can try to test this with two proxy channels for migration:
>
>   (a) socat unix-listen:/tmp/src.sock,reuseaddr,fork tcp:localhost:10000
>   (b) socat tcp-listen:10000,reuseaddr,fork unix:/tmp/dst.sock
>
> So the migration channel will be:
>
>                       (a)          (b)
>   src -> /tmp/src.sock -> tcp:10000 -> /tmp/dst.sock -> dst
>
> Then to make QEMU hang at RECOVER stage, one can do below:
>
>   (1) stop the postcopy using QMP command postcopy-pause
>   (2) kill the 2nd proxy (b)
>   (3) try to recover the postcopy using /tmp/src.sock on src
>   (4) src QEMU will go into RECOVER stage but won't be able to continue
>       from there, because the channel is actually broken at (b)
>
> Before this patch, step (4) will make src QEMU stuck in RECOVER stage,
> without a way to kick the QEMU out or continue the postcopy again.  After
> this patch, (4) will quickly fail qemu and bounce back to PAUSED stage.
>
> Admin can also kick QEMU from (4) into PAUSED when needed using
> migrate-pause when needed.
>
> After bouncing back to PAUSED stage, one can recover again.
>
> Reported-by: Xiaohui Li <xiaohli@redhat.com>
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2111332
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

