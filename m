Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8807D3AF0
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwyQ-0006yY-G5; Mon, 23 Oct 2023 11:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quwyD-0006xX-N6
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:35:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quwyA-0003JH-VK
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:35:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C37C1FE28;
 Mon, 23 Oct 2023 15:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698075353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rrx41nNI7ACFAwZJ59YbADNR+osusJ9tbnTGj5JlbOU=;
 b=DKF8+13xeRtWzD6UmpEv74Ir7KMcJ6QtJU/54SdDCmiUuTSrFypc3mPhOy5V4cLzFwqN12
 fyh9zeqjbYVyhsJmXDzT+aw8M3kIFzN2odJL7m2RH4xigmJ4h8AaU1kH0N+NwnXdODKmfL
 UprEeCvGoLRHfCJuWDeLPU2UPVthTnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698075353;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rrx41nNI7ACFAwZJ59YbADNR+osusJ9tbnTGj5JlbOU=;
 b=jrjL3PA1AnPM8YzZC5mzrVsFpYbeqUN4KLqbB/xJ5W8bQjoWnjb5xwWv9tjLg5MYcjnUK9
 ro/klANMsK96yJCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3A3B132FD;
 Mon, 23 Oct 2023 15:35:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jIdPL9iSNmXGFQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 15:35:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH RFC 4/7] migration: Drop MultiFDSendParams.quit and
 cleanup error paths
In-Reply-To: <ZTaI8vJpGeOQSfZH@x1n>
References: <20231022201211.452861-1-peterx@redhat.com>
 <20231022201211.452861-5-peterx@redhat.com> <87jzrdz9gr.fsf@suse.de>
 <ZTaI8vJpGeOQSfZH@x1n>
Date: Mon, 23 Oct 2023 12:35:50 -0300
Message-ID: <875y2xz6zt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -6.07
X-Spamd-Result: default: False [-6.07 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-1.97)[94.87%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
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

> Fabiano,
>
> On Mon, Oct 23, 2023 at 11:42:28AM -0300, Fabiano Rosas wrote:
>> > diff --git a/migration/multifd.c b/migration/multifd.c
>> > index 33fb21d0e4..9d458914a9 100644
>> > --- a/migration/multifd.c
>> > +++ b/migration/multifd.c
>> > @@ -411,10 +411,6 @@ static int multifd_send_pages(QEMUFile *f)
>> >      MultiFDSendParams *p = NULL; /* make happy gcc */
>> >      MultiFDPages_t *pages = multifd_send_state->pages;
>> >  
>> > -    if (qatomic_read(&multifd_send_state->exiting)) {
>> > -        return -1;
>> > -    }
>> > -
>> 
>> I'd keep this. This function can be called from outside of multifd code
>> so the channels could be completely gone already.
>
> I can definitely add it back; nothing hurts.  But I want to make sure I
> didn't miss some point.
>
> Do you have a specific path that could trigger what you said?

I don't, just thought of being conservative since this is a multifd
external API (of sorts).


