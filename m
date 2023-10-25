Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D78017D6DD7
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:59:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveNv-000295-IY; Wed, 25 Oct 2023 09:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qveNr-00021b-6n
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:57:19 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qveNp-0004Xj-B7
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:57:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 874A41FF65;
 Wed, 25 Oct 2023 13:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698242235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ju02q1qN9w2dQlQjVSou/fIBjKlEQBP1X97nhjywxOQ=;
 b=Qv1vFohV7FgoPfOkdPbSWX8G/vRq7obLSt2gEjKHKsjrAAeyB8fa9AswO0xC+VZzd6VdlZ
 Iu4pQHUZZZDNwTBKd1dZLi83OHl0THc62QGI7mnCmkbT/HrmnHuODvNVzIcoaWw8XM1B4V
 2y0ld825EPZAP1GZXPjOxj71SlBHJc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698242235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ju02q1qN9w2dQlQjVSou/fIBjKlEQBP1X97nhjywxOQ=;
 b=HRtWJNE3dItsuAxrrHiL8LpD2fpYonagin3u1Ccpz3G/RbHnKLKatfE6fzhTdU7LomcZjK
 R7qQpgaJe9PgkSAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 178E013524;
 Wed, 25 Oct 2023 13:57:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 92svNboeOWVdDgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 25 Oct 2023 13:57:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 06/29] migration: Add auto-pause capability
In-Reply-To: <ZTjWV9wQ5obKTpOG@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-7-farosas@suse.de> <ZTjWV9wQ5obKTpOG@redhat.com>
Date: Wed, 25 Oct 2023 10:57:12 -0300
Message-ID: <87y1fqerev.fsf@suse.de>
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Oct 23, 2023 at 05:35:45PM -0300, Fabiano Rosas wrote:
>> Add a capability that allows the management layer to delegate to QEMU
>> the decision of whether to pause a VM and perform a non-live
>> migration. Depending on the type of migration being performed, this
>> could bring performance benefits.
>
> I'm not really see what problem this is solving.
>

Well, this is the fruit of your discussion with Peter Xu in the previous
version of the patch.

To recap: he thinks QEMU is doing useless work with file migrations
because they are always asynchronous. He thinks we should always pause
before doing fixed-ram migration. You said that libvirt would rather use
fixed-ram for a more broad set of savevm-style commands, so you'd rather
not always pause. I'm trying to cater to both of your wishes. This new
capability is the middle ground I came up with.

So fixed-ram would always pause the VM, because that is the primary
use-case, but libvirt would be allowed to say: don't pause this time.

> Mgmt apps are perfectly capable of pausing the VM before issuing
> the migrate operation.
>

Right. But would QEMU be allowed to just assume that if a VM is paused
at the start of migration it can then go ahead and skip all dirty page
mechanisms?

Without pausing, we're basically doing *live* migration into a static
file that will be kept on disk for who knows how long before being
restored on the other side. We could release the src QEMU resources (a
bit) earlier if we paused the VM beforehand.

We're basically talking about whether we want the VM to be usable in the
(hopefully) very short time between issuing the migration command and
the migration being finished. We might be splitting hairs here, but we
need some sort of consensus.

