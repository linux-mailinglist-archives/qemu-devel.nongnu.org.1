Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A475749055
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 23:55:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHASU-0007CU-F1; Wed, 05 Jul 2023 17:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHASR-0007C1-S2
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:54:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHASQ-0000xS-AE
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:54:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5FBC621F3E;
 Wed,  5 Jul 2023 21:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688594080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5CCCffy8ynJl/oQU+chXPWdPGzu/o82Sk1hhBkw29/U=;
 b=ZnkwRpjvhoNUz43ATcaCFwH9XJ3f6d53j+ZDQcjBRVi/H/8XHmh93ozSyJ5L+Zxqjx3ArR
 3zE1wQ5fhLcPYtDmEOziUvmXV/fENddJg+WHlL2vbEf86dCg2d+zmvQzTPJOpfcyZnFw/D
 XFb3HSGRgfKCd1LqwSeOj0e9wv0zd3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688594080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5CCCffy8ynJl/oQU+chXPWdPGzu/o82Sk1hhBkw29/U=;
 b=UH6BiT2Y2PrvEY1KFmmMj26uIvOmghceUUdz0PtUMLq81nG996HsVoOK3G1BlykkHU8N+o
 nF3am7+Z1IcYrHBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E09A9134F3;
 Wed,  5 Jul 2023 21:54:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id H6L4J5/mpWQ0VAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 05 Jul 2023 21:54:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Leonardo Bras Soares Passos <lsoaresp@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Lukas Straub <lukasstraub2@web.de>, Laszlo Ersek
 <lersek@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v2 6/7] qemufile: Always return a verbose error
In-Reply-To: <20230705163502.331007-7-peterx@redhat.com>
References: <20230705163502.331007-1-peterx@redhat.com>
 <20230705163502.331007-7-peterx@redhat.com>
Date: Wed, 05 Jul 2023 18:54:37 -0300
Message-ID: <87bkgq3tya.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> There're a lot of cases where we only have an errno set in last_error but
> without a detailed error description.  When this happens, try to generate
> an error contains the errno as a descriptive error.
>
> This will be helpful in cases where one relies on the Error*.  E.g.,
> migration state only caches Error* in MigrationState.error.  With this,
> we'll display correct error messages in e.g. query-migrate when the error
> was only set by qemu_file_set_error().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/qemu-file.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index acc282654a..419b4092e7 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -156,15 +156,24 @@ void qemu_file_set_hooks(QEMUFile *f, const QEMUFileHooks *hooks)
>   *
>   * Return negative error value if there has been an error on previous
>   * operations, return 0 if no error happened.
> - * Optional, it returns Error* in errp, but it may be NULL even if return value
> - * is not 0.
>   *
> + * If errp is specified, a verbose error message will be copied over.
>   */
>  int qemu_file_get_error_obj(QEMUFile *f, Error **errp)
>  {
> +    if (!f->last_error) {
> +        return 0;
> +    }
> +
> +    /* There is an error */
>      if (errp) {
> -        *errp = f->last_error_obj ? error_copy(f->last_error_obj) : NULL;
> +        if (f->last_error_obj) {
> +            *errp = error_copy(f->last_error_obj);
> +        } else {
> +            error_setg_errno(errp, -f->last_error, "Channel error");

There are a couple of places that do:

    ret = vmstate_save(f, se, ms->vmdesc);
    if (ret) {
        qemu_file_set_error(f, ret);
        break;
    }

and vmstate_save() can return > 0 on error. This would make this message
say "Unknown error". This is minor.

But take a look at qemu_fclose(). It can return f->last_error while the
function documentation says it should return negative on error.

Should we make qemu_file_set_error() check 'ret' and always set a
negative value for f->last_error?

