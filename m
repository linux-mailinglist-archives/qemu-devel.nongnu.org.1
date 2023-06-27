Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E26D473FC43
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:55:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8Du-0006Xr-Gp; Tue, 27 Jun 2023 08:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qE8Dl-0006Wv-F0
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:55:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qE8Dh-0004nR-Ff
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:54:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C1681F8B9;
 Tue, 27 Jun 2023 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1687870496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oQYBvp5vcDY2/3V2znHH4MzxQeXRYB9Ujc04RGumPYI=;
 b=VPshZVOb59qayhGXa6j39t/hZyFjSSONFge0TrLRgDD9M0vQKEKR53yMGVc3g29GxoErOC
 fp1kVcEkfab9i0W6ysNXxmrbW60IbyenH0Xjth6Hm1fOjdnlkG4s6UjdKfqdmu95N3lC6J
 nkaRPo0dDPDGgKEjbps+/Dep9BJB4yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1687870496;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oQYBvp5vcDY2/3V2znHH4MzxQeXRYB9Ujc04RGumPYI=;
 b=ZHNmJmsOb/l2ACJ9XVqBIS1Us4KjB/C0OilwGAdAz34NJJvuAKr/5EYTKZ2USTiH64xu6E
 aRiapg+cMzJqLHAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90CA313276;
 Tue, 27 Jun 2023 12:54:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ASf3Fh/cmmSTWAAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 27 Jun 2023 12:54:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Peter Xu
 <peterx@redhat.com>, Steve Sistare <steven.sistare@oracle.com>, Nikolay
 Borisov <nborisov@suse.com>, Leonardo Bras <leobras@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/6] tests/qtest: migration-test: Add tests for
 file-based migration
In-Reply-To: <ZJqmvBzeZox2nrXs@redhat.com>
References: <20230626182210.8792-1-farosas@suse.de>
 <20230626182210.8792-7-farosas@suse.de> <ZJqmvBzeZox2nrXs@redhat.com>
Date: Tue, 27 Jun 2023 09:54:53 -0300
Message-ID: <875y799iaq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Jun 26, 2023 at 03:22:10PM -0300, Fabiano Rosas wrote:
>> From: Nikolay Borisov <nborisov@suse.com>
>>=20
>> Add basic tests for file-based migration.
>>=20
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration-test.c | 66 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 66 insertions(+)
>>=20
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index acb778a8cd..5a77257a53 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -763,6 +763,7 @@ static void test_migrate_end(QTestState *from, QTest=
State *to, bool test_dest)
>>      cleanup("migsocket");
>>      cleanup("src_serial");
>>      cleanup("dest_serial");
>> +    cleanup("migfile");
>>  }
>>=20=20
>>  #ifdef CONFIG_GNUTLS
>> @@ -1460,11 +1461,28 @@ static void test_precopy_common(MigrateCommon *a=
rgs)
>>               */
>>              wait_for_migration_complete(from);
>>=20=20
>> +            /*
>> +             * For file based migration the target must begin its
>> +             * migration after the source has finished.
>> +             */
>> +            if (strstr(connect_uri, "file:")) {
>> +                migrate_incoming_qmp(to, connect_uri, "{}");
>> +            }
>> +
>>              if (!got_src_stop) {
>>                  qtest_qmp_eventwait(from, "STOP");
>>              }
>>          } else {
>>              wait_for_migration_complete(from);
>> +
>> +            /*
>> +             * For file based migration the target must begin its
>> +             * migration after the source has finished.
>> +             */
>> +            if (strstr(connect_uri, "file:")) {
>> +                migrate_incoming_qmp(to, connect_uri, "{}");
>> +            }
>> +
>>              /*
>>               * Must wait for dst to finish reading all incoming
>>               * data on the socket before issuing 'cont' otherwise
>> @@ -1682,6 +1700,46 @@ static void test_precopy_unix_compress_nowait(voi=
d)
>>      test_precopy_common(&args);
>>  }
>>=20=20
>> +static void test_precopy_file(void)
>> +{
>> +    g_autofree char *uri =3D g_strdup_printf("file:%s/migfile", tmpfs);
>
> There's no unlink(), so I presume you're relying on the entire 'tmpfs'
> being recursively deleted ?
>

The first hunk adds a call to cleanup(), which has the unlink().

>> +    MigrateCommon args =3D {
>> +        .connect_uri =3D uri,
>> +        .listen_uri =3D "defer",
>> +    };
>> +
>> +    test_precopy_common(&args);
>> +}
>> +
>> +static void test_precopy_file_offset(void)
>> +{
>> +    g_autofree char *uri =3D g_strdup_printf("file:%s/migfile,offset=3D=
0x1000",
>> +                                           tmpfs);
>> +    MigrateCommon args =3D {
>> +        .connect_uri =3D uri,
>> +        .listen_uri =3D "defer",
>> +    };
>> +
>> +    test_precopy_common(&args);
>
> There ought to be something here that values 0->0x1000 bytes are
> all zeroes in the file.
>

Good idea, thanks.


