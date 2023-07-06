Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7E2749E28
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:51:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHPNg-0004Dh-JJ; Thu, 06 Jul 2023 09:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHPNe-0004DG-Iu
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:50:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHPNa-0000SF-EG
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:50:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9EE4C1F747;
 Thu,  6 Jul 2023 13:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688651439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/DXJ3Tt24aq4SSGIIPH8+iUP2GONiBRKY/vu5KJE00=;
 b=QR4BpdInkAP6a3DBKwwZE3Wf0TeANGUpB3nh2q1fFrV7Zv/FU1/D61iqfeibbx9p3zm+n4
 W5AlZcCuUIXy6cGy3igB17kEU2ydnyt+HdPJ/FlN7EGvlzB0zAcK/S5HWyWHZ3nH92MaAF
 eYj+nXgCEVEwZYwda5z4Wl0F1ZPTn1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688651439;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/DXJ3Tt24aq4SSGIIPH8+iUP2GONiBRKY/vu5KJE00=;
 b=Br02fg2AeVgDwvGz0vq5GSJuxI3mcVcuWG+XfS7DWYh7f4dx4WugoSjQqcGKLmg6AjdOyl
 E3/xD0tn7IH+8+Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 105B2138EE;
 Thu,  6 Jul 2023 13:50:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BDE2Lq7GpmR7YgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 06 Jul 2023 13:50:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos
 <lsoaresp@redhat.com>, Juan Quintela <quintela@redhat.com>, Lukas Straub
 <lukasstraub2@web.de>, Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH v2 7/7] migration: Provide explicit error message for
 file shutdowns
In-Reply-To: <ZKXv+1eoDDlWj812@x1n>
References: <20230705163502.331007-1-peterx@redhat.com>
 <20230705163502.331007-8-peterx@redhat.com> <878rbu3tgm.fsf@suse.de>
 <ZKXv+1eoDDlWj812@x1n>
Date: Thu, 06 Jul 2023 10:50:34 -0300
Message-ID: <87v8exjgid.fsf@suse.de>
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

> On Wed, Jul 05, 2023 at 07:05:13PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Provide an explicit reason for qemu_file_shutdown()s, which can be
>> > displayed in query-migrate when used.
>> >
>> 
>> Can we consider this to cover the TODO:
>> 
>>  * TODO: convert to propagate Error objects instead of squashing
>>  * to a fixed errno value
>> 
>> or would that need something fancier?
>
> The TODO seems to say we want to allow qemu_file_shutdown() to report an
> Error* when anything wrong happened (e.g. shutdown() failed)?  While this
> patch was trying to store a specific error string so when query migration
> later it'll show up to the user.  If so, IMHO they're two things.
>

Ok, just making sure.

>> 
>> > This will make e.g. migrate-pause to display explicit error descriptions,
>> > from:
>> >
>> > "error-desc": "Channel error: Input/output error"
>> >
>> > To:
>> >
>> > "error-desc": "Channel is explicitly shutdown by the user"
>> >
>> > in query-migrate.
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  migration/qemu-file.c | 5 ++++-
>> >  1 file changed, 4 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> > index 419b4092e7..ff605027de 100644
>> > --- a/migration/qemu-file.c
>> > +++ b/migration/qemu-file.c
>> > @@ -87,7 +87,10 @@ int qemu_file_shutdown(QEMUFile *f)
>> >       *      --> guest crash!
>> >       */
>> >      if (!f->last_error) {
>> > -        qemu_file_set_error(f, -EIO);
>> > +        Error *err = NULL;
>> > +
>> > +        error_setg(&err, "Channel is explicitly shutdown by the user");
>> 
>> It is good that we can grep this message. However, I'm confused about
>> who the "user" is meant to be here and how are they implicated in this
>> error.
>
> Ah, here the user is who sends the "migrate-pause" command, according to
> the example of the commit message.
>

That's where I'm confused. There are 15 callsites for
qemu_file_shutdown(). Only 2 of them are from migrate-pause. So I'm
missing the logical step that links migrate-pause with this
error_setg(). Are you assuming that the race described will only happen
with migrate-pause and the other invocations would have set an error
already?

