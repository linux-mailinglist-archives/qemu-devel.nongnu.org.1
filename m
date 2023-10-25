Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEE77D6FAB
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:49:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfBB-00040E-Ug; Wed, 25 Oct 2023 10:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvfB8-000401-Ha
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:48:14 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvfB6-0006WK-Uk
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:48:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5A52121DDD;
 Wed, 25 Oct 2023 14:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698245291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=atDFOnLGSgZonzBNTuypCP3mR5NiBcjR4QghiPJgo0Y=;
 b=YFmGYSJMMeR4qxk6/ZFQxM94wtxIcHlA149EgiNyZg4LhfNn+KPSDxYj46ygIKR68nreKh
 VDSBRkEwMISulyzD2jQpoAN8FMpAgosd44Xe2aPv45ZI90iwckywOk9zR0ql8hL8+VqosS
 9aRcs5pLlAjnwRj6G6tkFcBMNS5r7Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698245291;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=atDFOnLGSgZonzBNTuypCP3mR5NiBcjR4QghiPJgo0Y=;
 b=T0MsNu3DJjjAdD83OpRDBk70XhfIEJ1k3SDiH/xj5K0PgaofFG5Un/ZLI7q//ZDSl91O3/
 Bf2Q0qYu568G3jAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFDBD138E9;
 Wed, 25 Oct 2023 14:48:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NXl0KqoqOWWEJgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 25 Oct 2023 14:48:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
In-Reply-To: <ZTja1PqWLF6U7f8n@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-29-farosas@suse.de> <ZTja1PqWLF6U7f8n@redhat.com>
Date: Wed, 25 Oct 2023 11:48:08 -0300
Message-ID: <87a5s6ep1z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -5.10
X-Spamd-Result: default: False [-5.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-1.00)[87.21%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Mon, Oct 23, 2023 at 05:36:07PM -0300, Fabiano Rosas wrote:
>> Add the direct-io migration parameter that tells the migration code to
>> use O_DIRECT when opening the migration stream file whenever possible.
>>=20
>> This is currently only used for the secondary channels of fixed-ram
>> migration, which can guarantee that writes are page aligned.
>
> When you say "secondary channels", I presume you're meaning that
> the bulk memory regions will be written with O_DIRECT, while
> general vmstate will use normal I/O on the main channel ?  If so,
> could we explain that a little more directly.

Yes, the main channel writes via QEMUFile, so no O_DIRECT. The channels
created via multifd_new_send_channel_create() have O_DIRECT enabled.

> Having a mixture of O_DIRECT and non-O_DIRECT I/O on the same
> file is a little bit of an unusual situation. It will work for
> us because we're writing to different regions of the file in
> each case.
>
> Still I wonder if it would be sane in the outgoing case to
> include a fsync() on the file in the main channel, to guarantee
> that the whole saved file is on-media at completion ? Or perhaps
> suggest in QAPI that mgmts might consider doing a fsync
> themselves ?

I think that should be present in QIOChannelFile in general. Not even
related to this series. I'll add it at qio_channel_file_close() unless
you object.


