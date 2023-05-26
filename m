Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8B771273B
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 15:10:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2XCJ-0003su-1e; Fri, 26 May 2023 09:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q2XCG-0003sU-Ua
 for qemu-devel@nongnu.org; Fri, 26 May 2023 09:09:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q2XCE-0007Fc-T4
 for qemu-devel@nongnu.org; Fri, 26 May 2023 09:09:32 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 95AB221A8C;
 Fri, 26 May 2023 13:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1685106567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JIw/ICAfqN+6CgXaOD5GPuoA+RNsEeENtXrf6Gdq/Yw=;
 b=BFjooTnoaKHXNHNeFE3WjBtrc4OLDJ4WSJt+yEdrUUlAKe5HAOp98z+wp4B8H55waoqJ4W
 TMqV9GASrEyecOZfoWUS9CI5hjZIEh8GDijAoQ1suDQ3w62Tzyp3oeLg/v3RHgycCBOxUf
 Va+HIFu79SWIVWY9WuZLS565ZLZwt60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1685106567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JIw/ICAfqN+6CgXaOD5GPuoA+RNsEeENtXrf6Gdq/Yw=;
 b=WcuwdOpScgUxFZoG8NKQFBgkdywho4aUBSEyh7kkuGttOEucuOcCNCATIcsyE22KQsui3J
 OApX4tXY3bAGgRAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19F1113A21;
 Fri, 26 May 2023 13:09:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XjJVNIavcGTSXgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 26 May 2023 13:09:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan
 Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH 2/2] meson: Add static glib dependency for
 initrd-stress.img
In-Reply-To: <ZHCLfsReGU8nOkUE@redhat.com>
References: <20230525212044.30222-1-farosas@suse.de>
 <20230525212044.30222-3-farosas@suse.de> <ZHCLfsReGU8nOkUE@redhat.com>
Date: Fri, 26 May 2023 10:09:24 -0300
Message-ID: <87edn39r3v.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, May 25, 2023 at 06:20:44PM -0300, Fabiano Rosas wrote:
>> We recently moved glib detection code to meson but the static libs
>> were left out. Add a specific dependency for stress.c which is linked
>> statically.
>>=20
>> $ make V=3D1 tests/migration/initrd-stress.img
>>=20
>> before:
>>  cc -m64 -mcx16 -o tests/migration/stress ... -static -Wl,--start-group
>>  /usr/lib64/libglib-2.0.so -Wl,--end-group
>>  ...
>>  bin/ld: attempted static link of dynamic object `/usr/lib64/libglib-2.0=
.so'
>>=20
>> after:
>>  cc -m64 -mcx16 -o tests/migration/stress ... -static -pthread
>>  -Wl,--start-group -lm /usr/lib64/libpcre.a -lglib-2.0 -Wl,--end-group
>>=20
>> Fixes: fc9a809e0d ("build: move glib detection and workarounds to meson")
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/migration/meson.build | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tests/migration/meson.build b/tests/migration/meson.build
>> index dd562355a1..ac71f13290 100644
>> --- a/tests/migration/meson.build
>> +++ b/tests/migration/meson.build
>> @@ -1,9 +1,11 @@
>>  sysprof =3D dependency('sysprof-capture-4', required: false)
>> +glib_static =3D dependency('glib-2.0', version: glib_req_ver, required:=
 false,
>> +                         method: 'pkg-config', static: true)
>
> Since required: false, the result might be "not found", which means
> we'll still hit the linker error. I think we need to surround the
> 'executable()' bit in
>
>   if glib_static.found()
>      ...
>   endif
>=20=20=20

Right, but this time it would be a helpful linker error that would tell
you what you are actually missing. Since this is "build_by_default:
false" I think we're better off letting the error through.

