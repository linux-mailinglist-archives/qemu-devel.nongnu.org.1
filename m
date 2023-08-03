Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1358976ED78
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:02:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRZpl-0007sL-Em; Thu, 03 Aug 2023 11:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qRZpH-0007Nc-Cx
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:01:26 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qRZp2-0007ea-91
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:01:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5DE971F45A;
 Thu,  3 Aug 2023 15:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691074862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WeST5YqksXbuORG6IVANosk0DaoZ+di2PK0C+j8xe5o=;
 b=dHUkdpu7/A3DPR9dEodG8TxUF5GzOxN5uXTruWuaeM59HMHDwOxXXaRMeBAquU1FcdFYs/
 jWzQ2Jp/Map6kMB2jBXbwkPQlJuXctpteV9scmZ39g13Ai1/GpWGnAjiQE2gMcBhknRnj1
 tWpJPpNnnw3LH4p5JVaZJCULaUa0BeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691074862;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WeST5YqksXbuORG6IVANosk0DaoZ+di2PK0C+j8xe5o=;
 b=E7eZB2onwWlvm6T24nLnaqY+njGYo2+t+cex7OQ/0hN+I0KSnGnUah2JZNitSLxtaybOMP
 uo2KkYxq8B2BauCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5841134B0;
 Thu,  3 Aug 2023 15:01:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GKiTKy3By2RPIgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 03 Aug 2023 15:01:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Wei Wang
 <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 2/2] migration: Replace the return path retry logic
In-Reply-To: <ZMrAH2U8GOV/FwNS@x1n>
References: <20230802143644.7534-1-farosas@suse.de>
 <20230802143644.7534-3-farosas@suse.de> <ZMp+DsWuAZHr5Sj/@x1n>
 <871qglcisi.fsf@suse.de> <ZMrAH2U8GOV/FwNS@x1n>
Date: Thu, 03 Aug 2023 12:00:59 -0300
Message-ID: <87v8dwb26s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

> On Wed, Aug 02, 2023 at 05:04:45PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> >> +        if (await_return_path_close_on_source(s)) {
>> >> +            trace_migration_return_path_pause_err();
>> >> +            return MIG_THR_ERR_FATAL;
>> >> +        }
>> >
>> > I see that here on return path failures we'll bail out, and actually it's
>> > against the instinction (that when pause it should have failed, so it's
>> > weird why it's returning 0).
>> >
>> > So how about above suggestion, plus here we just call
>> > await_return_path_close_on_source(), without caring about the retval?
>> 
>> So you are suggesting to remove the knowledge of the retry entirely from
>> the thread. It just reports the error and the postcopy_pause takes the
>> responsibility of ignoring it when we want to retry... It could be
>> clearer that way indeed.
>
> That error doesn't really important IMHO here, because the to-dst-file
> should have already errored out anyway.
>
> I just think it cleaner if we reset rp_error only until the new thread
> created.
>

ok

>> 
>> It would trigger when a rp error happened that wasn't related to the
>> QEMUFile. If we go with your suggestion above, then this goes away.
>
> With your current patch where rp_error seems to be always reset when thread
> quit, if that's true then it'll 100% happen that this will not trigger.
>
> But yeah this is a trivial spot, feel free to choose the best if you plan
> to reorganize this patch a bit.  Thanks.

My patch just resets the error when doing postcopy and the error is a
QEMUFile error. The header validation at the start of the loop could
still set rp_state.error and return without going through the postcopy
retry:

        if (header_type >= MIG_RP_MSG_MAX ||
            header_type == MIG_RP_MSG_INVALID) {
            error_report("RP: Received invalid message 0x%04x length 0x%04x",
                         header_type, header_len);
            mark_source_rp_bad(ms);
            goto out;
        }

