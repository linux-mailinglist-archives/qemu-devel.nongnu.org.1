Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8BB7EA87A
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 02:55:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2idn-00064F-NH; Mon, 13 Nov 2023 20:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r2idl-000647-SF
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 20:54:57 -0500
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r2idk-0005Bb-2p
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 20:54:57 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7D6861F86B;
 Tue, 14 Nov 2023 01:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699926894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pBo53dKPw61h+01olNaP2zGU5ZjEfS9LF68JG6igfHQ=;
 b=elKYuBDcda7T6iIYD82w4qYbXulYIExaonv3icDJ+Et3toG/wh48B2q3666zIBnqEgZVbR
 6r15T0+dyncR/iB8sNI88r6pKEmux70HqJF2Gd795qOwwJOmk2g1wCFmys3GFD5XDqiiVe
 HYRAK+Y5Sss7FQLCz+E7Od04aSvJFSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699926894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pBo53dKPw61h+01olNaP2zGU5ZjEfS9LF68JG6igfHQ=;
 b=MJuaIBNx7R9KwVnr6TVacA2wjRv+SmpH0gSVl2l4P1VuIPOyf5IN20X0v3lkN6TJ8mWoEJ
 Xvg5z79wY5uu9gAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10C32132F1;
 Tue, 14 Nov 2023 01:54:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qYspM23TUmXfWQAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 14 Nov 2023 01:54:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [RFC PATCH 1/2] migration: Report error in incoming migration
In-Reply-To: <ZVJUCG9jQEjoMDWT@x1n>
References: <20231109165856.15224-1-farosas@suse.de>
 <20231109165856.15224-2-farosas@suse.de> <ZU0rqJv0IHzaY5aW@x1n>
 <87sf5dzxhj.fsf@suse.de> <ZVJUCG9jQEjoMDWT@x1n>
Date: Mon, 13 Nov 2023 22:54:51 -0300
Message-ID: <874jhp5cb8.fsf@suse.de>
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

> On Fri, Nov 10, 2023 at 07:58:00AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Thu, Nov 09, 2023 at 01:58:55PM -0300, Fabiano Rosas wrote:
>> >> We're not currently reporting the errors set with migrate_set_error()
>> >> when incoming migration fails.
>> >> 
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >> ---
>> >>  migration/migration.c | 7 +++++++
>> >>  1 file changed, 7 insertions(+)
>> >> 
>> >> diff --git a/migration/migration.c b/migration/migration.c
>> >> index 28a34c9068..cca32c553c 100644
>> >> --- a/migration/migration.c
>> >> +++ b/migration/migration.c
>> >> @@ -698,6 +698,13 @@ process_incoming_migration_co(void *opaque)
>> >>      }
>> >>  
>> >>      if (ret < 0) {
>> >> +        MigrationState *s = migrate_get_current();
>> >> +
>> >> +        if (migrate_has_error(s)) {
>> >> +            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>> >> +                error_report_err(s->error);
>> >> +            }
>> >> +        }
>> >
>> > What's the major benefit of dumping this explicitly?
>> 
>> This is incoming migration, so there's no centralized error reporting
>> aside from the useless "load of migration failed: -5". If the code has
>> not called error_report we just never see the error message.
>> 
>> > And this is not relevant to the multifd problem, correct?
>> 
>> Yes, I'm being sneaky.
>
> Trying to sneak one patch into a 2 patch series is prone to be exposed and
> lose the effect. :-)
>
> I remember we had the verbose error before. Was that lost since some
> commit?  In all cases, feel free to post that separately if you think we
> should get it back.
>
> The multifd fixes do not look like a regression either for this release. If
> so, both of them may be better next release's material?

People have complained about it on IRC and I hit it twice in a week. I
would call it a regression. However, we _do_ have an indication that it
might have been there all along since someone already tried to fix a
very similar issue, maybe even the same one. So I'm fine with punting to
the next release.

