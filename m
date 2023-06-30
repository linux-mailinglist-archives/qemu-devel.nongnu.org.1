Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B03AB743E0F
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 16:58:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFFZ2-0005Fp-00; Fri, 30 Jun 2023 10:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qFFZ0-0005Fh-1F
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 10:57:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qFFYy-0003Zu-Ds
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 10:57:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A05621838;
 Fri, 30 Jun 2023 14:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688137049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MmjtWnAGDc47GehtNzSfAek6JqMWtLV+3zSyh8tM44c=;
 b=W86+Zyg4WksWGKqezlCvW9nO2885Q7V0BiG2LWXf0GQtMIS45e9xv51HZ7iumpmqEkoYHI
 7Np0j35U9MQhQMG2XY6VoCSOGmzJtpMeoUIPC5IecU/hVJ0yHXeYDcHAP47y4EZnRX0CwD
 WACTg0JUBsAWnMBLsrHYZFTEHfEoWhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688137049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MmjtWnAGDc47GehtNzSfAek6JqMWtLV+3zSyh8tM44c=;
 b=/zHf5e5DPzQ6omrgQGna3YVacGsjl6vC/SciBYMv87hQIjPhEQ6/gFQUNMFXfYrYIuLKW7
 Gik4EDqu9g5hCVDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDE9F13915;
 Fri, 30 Jun 2023 14:57:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4sIgLFjtnmS3DwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 30 Jun 2023 14:57:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Steve
 Sistare <steven.sistare@oracle.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 1/6] migration: Set migration status early in incoming side
In-Reply-To: <ZJ3ZCBwljzRP+Lqh@x1n>
References: <20230628165542.17214-1-farosas@suse.de>
 <20230628165542.17214-2-farosas@suse.de> <ZJ3ZCBwljzRP+Lqh@x1n>
Date: Fri, 30 Jun 2023 11:57:26 -0300
Message-ID: <87a5whq9pl.fsf@suse.de>
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

> On Wed, Jun 28, 2023 at 01:55:37PM -0300, Fabiano Rosas wrote:
>> We are sending a migration event of MIGRATION_STATUS_SETUP at
>> qemu_start_incoming_migration but never actually setting the state.
>> 
>> This creates a window between qmp_migrate_incoming and
>> process_incoming_migration_co where the migration status is still
>> MIGRATION_STATUS_NONE. Calling query-migrate during this time will
>> return an empty response even though the incoming migration command
>> has already been issued.
>> 
>> Commit 7cf1fe6d68 ("migration: Add migration events on target side")
>> has added support to the 'events' capability to the incoming part of
>> migration, but chose to send the SETUP event without setting the
>> state. I'm assuming this was a mistake.
>> 
>> To avoid introducing a change in behavior, we need to keep sending the
>> SETUP event, even if the 'events' capability is not set. Add the
>> force-emit-setup-event migration property to enable it.
>
> This is so unfortunate... since qemu 2.4.....
>
> Does it mean that when cap-events is set we can send duplicated events?
>

Not with current code because this event was the only one sent directly
without setting the state first, so migrate_generate_event() never runs.

And not with this patch because I'm not sending the event if
migrate_events() is true because it will already be sent by
migrate_generate_event().

> The fix makes sense to me in general, butt I'm curious whether we can fix
> it without having a compat bit doing the wrong thing, even if having the
> risk of breaking someone, with the hope that the only thing he/she needs to
> do is to enable the cap-events if didn't.  I'd consider that if e.g. as
> long as libvirt is fine.  Does anyone know how libvirt handles this?
>

I agree that it would be cleaner for us to just break compatibility and
hope for the best. Any process waiting for the event would hang, but
simply enabling the capability would fix it.

I see libvirt knows about the 'events' capability but I couldn't
determine if it is enabled by default. I'll have to take a deeper look.


