Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C952749E52
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:57:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHPTn-0008DQ-O8; Thu, 06 Jul 2023 09:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHPTl-0008D5-QL
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:57:05 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHPTk-0002XB-3Q
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:57:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 61FE422789;
 Thu,  6 Jul 2023 13:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688651822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9rgHkJp4D75lXJNTy+ZMujUTTv2ZUzItJ/ggQ7//Jic=;
 b=NGvmr9jIS/I1sLXC9rm4GgwiRRN1UJz0VFhqzTxWI3+RSxypbI/TlqrxdIMtzrGm6qsEzc
 PfM3/WhuDecsNZeJuylm/UAIjJL3Jhcz1u13dlnlcfBY5hjNsZoqYQhxwBBAkEHQiMQPBj
 d40oLHeHy9g7lXazqB5eoMd1faPCThA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688651822;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9rgHkJp4D75lXJNTy+ZMujUTTv2ZUzItJ/ggQ7//Jic=;
 b=ny4by8bG6b5568fKbhVD1iuSofX9+2x0GsbsOIvbVdeLnRyp4NHVE+0doCSz7JL5MHY7Wu
 jx01CwngYrlBJVCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5C9E138EE;
 Thu,  6 Jul 2023 13:57:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ADYJGy3IpmSZZQAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 06 Jul 2023 13:57:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos
 <lsoaresp@redhat.com>, Juan Quintela <quintela@redhat.com>, Lukas Straub
 <lukasstraub2@web.de>, Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH v2 6/7] qemufile: Always return a verbose error
In-Reply-To: <ZKXtqxmCp2cnHf8h@x1n>
References: <20230705163502.331007-1-peterx@redhat.com>
 <20230705163502.331007-7-peterx@redhat.com> <87bkgq3tya.fsf@suse.de>
 <ZKXtqxmCp2cnHf8h@x1n>
Date: Thu, 06 Jul 2023 10:56:58 -0300
Message-ID: <87sfa1jg7p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

> On Wed, Jul 05, 2023 at 06:54:37PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > There're a lot of cases where we only have an errno set in last_error but
>> > without a detailed error description.  When this happens, try to generate
>> > an error contains the errno as a descriptive error.
>> >
>> > This will be helpful in cases where one relies on the Error*.  E.g.,
>> > migration state only caches Error* in MigrationState.error.  With this,
>> > we'll display correct error messages in e.g. query-migrate when the error
>> > was only set by qemu_file_set_error().
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  migration/qemu-file.c | 15 ++++++++++++---
>> >  1 file changed, 12 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> > index acc282654a..419b4092e7 100644
>> > --- a/migration/qemu-file.c
>> > +++ b/migration/qemu-file.c
>> > @@ -156,15 +156,24 @@ void qemu_file_set_hooks(QEMUFile *f, const QEMUFileHooks *hooks)
>> >   *
>> >   * Return negative error value if there has been an error on previous
>> >   * operations, return 0 if no error happened.
>> > - * Optional, it returns Error* in errp, but it may be NULL even if return value
>> > - * is not 0.
>> >   *
>> > + * If errp is specified, a verbose error message will be copied over.
>> >   */
>> >  int qemu_file_get_error_obj(QEMUFile *f, Error **errp)
>> >  {
>> > +    if (!f->last_error) {
>> > +        return 0;
>> > +    }
>> > +
>> > +    /* There is an error */
>> >      if (errp) {
>> > -        *errp = f->last_error_obj ? error_copy(f->last_error_obj) : NULL;
>> > +        if (f->last_error_obj) {
>> > +            *errp = error_copy(f->last_error_obj);
>> > +        } else {
>> > +            error_setg_errno(errp, -f->last_error, "Channel error");
>> 
>> There are a couple of places that do:
>> 
>>     ret = vmstate_save(f, se, ms->vmdesc);
>>     if (ret) {
>>         qemu_file_set_error(f, ret);
>>         break;
>>     }
>> 
>> and vmstate_save() can return > 0 on error. This would make this message
>> say "Unknown error". This is minor.
>> 
>> But take a look at qemu_fclose(). It can return f->last_error while the
>> function documentation says it should return negative on error.
>> 
>> Should we make qemu_file_set_error() check 'ret' and always set a
>> negative value for f->last_error?
>
> Yeah, maybe we can add a sanity check, but logically it's better we just
> fix vmstate_save() to make sure it always returns a <0 error.
>
> It seems to me there're so many hooks in vmstate_save_state_v() that it can
> return random things.  What's the one you spot?  If it's an obvious issue
> we can fix them.

I see at least:
    ret = field->info->put(f, curr_elem, size, field, vmdesc_loop);
with put_power() from target/arm/machine.c returning 1.

Since vmstate_save_state_v() is quite involved I don't think we should
block this series because of it. I can do a closer audit and send a
separate patch with it.

So:

Reviewed-by: Fabiano Rosas <farosas@suse.de>


