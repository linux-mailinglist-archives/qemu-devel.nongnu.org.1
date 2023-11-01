Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B92317DE0D3
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 13:32:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyANu-0005FT-2n; Wed, 01 Nov 2023 08:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qyANG-0005Ap-Pm
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 08:31:08 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qyAND-0002qf-6N
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 08:31:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E47611F74A;
 Wed,  1 Nov 2023 12:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698841858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDRDK3aj1a1XHPZpdC5YC06AH/uXvauaUt32Du5jdCQ=;
 b=fqPnL/TQjp7O0h0QcCxYijeUuqqSV36sqC2kOx9au/QRuXrVt10aXpF43oaolOHN1MDlnt
 tjDn5QY44TkLNtAhqoWDeCtA56p3iDH7AEMvNvp/yNCeLK1m8DK/Tyrd1zN1EsiN1AptPH
 eW2ayZp2UmqQKrauCIqojDHPbr6blXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698841858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDRDK3aj1a1XHPZpdC5YC06AH/uXvauaUt32Du5jdCQ=;
 b=y4qMPOloJ1LFxJSlUu8u5s5u5R+CRuDK788NK0d9m4SfWHRi9OQKLI2aFAKLvqARHA/ZMx
 4Vek/Qw2PpUMigBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76D781348D;
 Wed,  1 Nov 2023 12:30:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TyGgEAJFQmUZVgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 01 Nov 2023 12:30:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Juan
 Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
In-Reply-To: <ZUJDQKsg5mMqiMP0@redhat.com>
References: <ZUDC4aoPZZQAF6JU@redhat.com> <878r7jdjrf.fsf@suse.de>
 <ZUEE9XP4YTJkZTv7@redhat.com> <875y2meua3.fsf@suse.de>
 <ZUEbzvRLdGjl4gl+@redhat.com> <8734xqeqly.fsf@suse.de>
 <ZUEkOb8M4fgfEITi@redhat.com> <87wmv2d33p.fsf@suse.de>
 <ZUIav68fksPZpIJm@redhat.com> <87zfzxfz32.fsf@suse.de>
 <ZUJDQKsg5mMqiMP0@redhat.com>
Date: Wed, 01 Nov 2023 09:30:55 -0300
Message-ID: <87wmv1fyf4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Nov 01, 2023 at 09:16:33AM -0300, Fabiano Rosas wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> >
>> > So the problem with add-fd is that when requesting a FD, the monitor
>> > code masks flags with O_ACCMODE.  What if we extended it such that
>> > the monitor masked with O_ACCMODE | O_DIRECT.
>> >
>> > That would let us pass 1 plain FD and one O_DIRECT fd, and be able
>> > to ask for each separately by setting O_DIRECT or not.
>>=20
>> That would likely work. The usage gets a little more complicated, but
>> we'd be using fdset as it was intended.
>>=20
>> Should we keep the direct-io capability? If the user now needs to set
>> O_DIRECT and also set the cap, that seems a little redundant. I could
>> keep O_DIRECT in the flags (when supported) and test after open if we
>> got the flag set. If it's not set, then we remove O_DIRECT from the
>> flags and retry.
>
> While it is redundant, I like the idea of always requireing the
> direct-io capabilty to be set, as a statement of intent. There's
> a decent chance for apps to mess up with FD passing, and so by
> seeing the 'direct-io' capability we know what the app intended
> todo.

Ok. I'll go write some code then. Thanks for the help!

