Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 329567DD68E
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:06:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxu3y-0004rX-8U; Tue, 31 Oct 2023 15:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxu3m-0004RB-6Z
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:05:54 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxu3k-0007MW-EQ
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:05:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 597D3215EE;
 Tue, 31 Oct 2023 19:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698779149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZXqVENstFHjcKmue6QkAM7ecU/rUgjsL+Q+taM4r7M=;
 b=ut3MvL+QZJ3GRB5kvvhhaEbNavjUnNy/aYOmLeRbYXCNfEIW1DbcTrKaNfGC0yfjoFpuul
 EDyAnQi8iLCsUUz/zblkwbO9y5E+6d3vT1TC8BqFiMdnXA6JFXb7THhlFS5W2szrtnibe1
 TMvPB2eZoRHQFTFgky6IqKrURXeloRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698779149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZXqVENstFHjcKmue6QkAM7ecU/rUgjsL+Q+taM4r7M=;
 b=Uxkrg+EGyK3WhXwH2JAehy10TxkAqMTYVS7mNCQ0WFayYXXS8GXtMgphzLDbHIVNVfhECJ
 OLpKsv0nDDKjffAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E04461391B;
 Tue, 31 Oct 2023 19:05:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id v2V1KgxQQWUdIwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 31 Oct 2023 19:05:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Juan
 Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
In-Reply-To: <ZUEkOb8M4fgfEITi@redhat.com>
References: <ZTjVg9NVTd0MT6mW@redhat.com> <87cyx2epsv.fsf@suse.de>
 <ZTkpllWQdLSMw3pP@redhat.com> <87cywvenbd.fsf@suse.de>
 <ZUDC4aoPZZQAF6JU@redhat.com> <878r7jdjrf.fsf@suse.de>
 <ZUEE9XP4YTJkZTv7@redhat.com> <875y2meua3.fsf@suse.de>
 <ZUEbzvRLdGjl4gl+@redhat.com> <8734xqeqly.fsf@suse.de>
 <ZUEkOb8M4fgfEITi@redhat.com>
Date: Tue, 31 Oct 2023 16:05:46 -0300
Message-ID: <87wmv2d33p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Oct 31, 2023 at 12:52:41PM -0300, Fabiano Rosas wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >
>> > I guess I'm not seeing the problem still.  A single FD is passed across
>> > from libvirt, but QEMU is free to turn that into *many* FDs for its
>> > internal use, using dup() and then setting O_DIRECT on as many/few of
>> > the dup()d FDs as its wants to.
>>=20
>> The problem is that duplicated FDs share the file status flags. If we
>> set O_DIRECT on the multifd channels and the main thread happens to do
>> an unaligned write with qemu_file_put* then the filesystem will fail
>> that write.
>
> Doh, I had forgotten that sharing.
>
> Do we have any synchronization between multifd  channels and the main
> thread ?  eg does the main thread wait for RAM sending completion
> before carrying on writing other non-RAM data ?

We do have, but the issue with that approach is that there are no rules
for adding data into the stream. Anyone could add a qemu_put_* call
right in the middle of the section for whatever reason.

That is almost a separate matter due to our current compatibility model
being based on capabilities rather than resilience of the stream
format. So extraneous data in the stream always causes the migration to
break.

But with the O_DIRECT situation we'd be adding another aspect to
this. Not only changing the code requires syncing capabilities (as it
does today), but it would also require knowing which parts of the stream
can be interrupted by new data and which cannot.

So while it would probably work, it's also a little fragile. If QEMU
were given 2 FDs or given access to the file, then only the multifd
channels would get O_DIRECT and they are guaranteed to not have
extraneous unaligned data showing up.



