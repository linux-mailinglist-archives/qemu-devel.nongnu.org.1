Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 997A5797216
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 13:57:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeDcB-0002ik-T0; Thu, 07 Sep 2023 07:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qeDc9-0002gO-ED
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:56:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qeDc6-000897-SQ
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:56:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 81C0121869;
 Thu,  7 Sep 2023 11:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694087755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pfOzcAR04iGD3d6djnTYvgWzLMgtJ9GQVQXS98ctNWg=;
 b=HHZOBmTbPkyavNHWcmTqOJsLA+x5fytG9BNk7yJrXrsVC5MgK+kgHSLK7Fjv8ldm7R613Y
 hRJzQtkcfVkufSDiuqOJgHSy/5BMogKIfnnKB+xlahf1OfPixhN/qcyjbg4W21Adwwn06h
 aKfqoAH099Yz292kH81b14mbhgI4rS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694087755;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pfOzcAR04iGD3d6djnTYvgWzLMgtJ9GQVQXS98ctNWg=;
 b=wlzUG7de6BXUZfThaHRTdv9Ke2mgNWCFyzsdtV+/c0OtcWoHUVASmEp5fvmTyu+QpZcx4/
 D7pxNA/PvYdY8FAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1574B138F9;
 Thu,  7 Sep 2023 11:55:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6vNcNEq6+WRKCgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 07 Sep 2023 11:55:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH] migration: Unify and trace vmstate field_exists() checks
In-Reply-To: <20230906204722.514474-1-peterx@redhat.com>
References: <20230906204722.514474-1-peterx@redhat.com>
Date: Thu, 07 Sep 2023 08:55:52 -0300
Message-ID: <87ledi8aev.fsf@suse.de>
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

Peter Xu <peterx@redhat.com> writes:

> For both save/load we actually share the logic on deciding whether a field
> should exist.  Merge the checks into a helper and use it for both save and
> load.  When doing so, add documentations and reformat the code to make it
> much easier to read.
>
> The real benefit here (besides code cleanups) is we add a trace-point for
> this; this is a known spot where we can easily break migration
> compatibilities between binaries, and this trace point will be critical for
> us to identify such issues.
>
> For example, this will be handy when debugging things like:
>
> https://gitlab.com/qemu-project/qemu/-/issues/932
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/vmstate.c    | 34 ++++++++++++++++++++++++++--------
>  migration/trace-events |  1 +
>  2 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 31842c3afb..73e74ddea0 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -25,6 +25,30 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>                                     void *opaque);
>  
> +/* Whether this field should exist for either save or load the VM? */
> +static bool
> +vmstate_field_exists(const VMStateDescription *vmsd, const VMStateField *field,
> +                     void *opaque, int version_id)
> +{
> +    bool result;
> +
> +    if (field->field_exists) {
> +        /* If there's the function checker, that's the solo truth */
> +        result = field->field_exists(opaque, version_id);
> +        trace_vmstate_field_exists(vmsd->name, field->name, field->version_id,
> +                                   version_id, result);
> +    } else {
> +        /*
> +         * Otherwise, we only save/load if field version is same or older.
> +         * For example, when loading from an old binary with old version,
> +         * we ignore new fields with newer version_ids.
> +         */
> +        result = field->version_id <= version_id;

This one doesn't get a trace?

Aside from that:

Reviewed-by: Fabiano Rosas <farosas@suse.de>

