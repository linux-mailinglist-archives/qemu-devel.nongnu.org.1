Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F928247D7
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 18:54:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLRuZ-0006Ti-Sn; Thu, 04 Jan 2024 12:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLRuX-0006TZ-O9
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 12:53:41 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLRuW-00089I-5x
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 12:53:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A09022108;
 Thu,  4 Jan 2024 17:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704390818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5f037tEQk/1NTd1+0YauzBSy4MblSjoyXywuHhYfBE=;
 b=PuoEqUzwh6+TJZMT8QnHxmtPm95b6lV9v/Bc+koCEDXwBk7CH9OLlGzwfJ1zzGLVdlO/AV
 sjJktQbWgNOxvFMbODUl6vt6KuiQW5SV72vfoH7igAz/Nci9KX1whbGQEgmxtEx7vwAs6x
 isfNwotRQoOj+QLtgqdRE0coH0RvPAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704390818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5f037tEQk/1NTd1+0YauzBSy4MblSjoyXywuHhYfBE=;
 b=C0L4WjFUdFEv/J15/sduBBsylz0QZhiC/i9OuZxWH6o05Km5ZEJqVK2PnP+DhqqpcAhhSr
 Ke4h+o2o8trBt2Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704390818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5f037tEQk/1NTd1+0YauzBSy4MblSjoyXywuHhYfBE=;
 b=PuoEqUzwh6+TJZMT8QnHxmtPm95b6lV9v/Bc+koCEDXwBk7CH9OLlGzwfJ1zzGLVdlO/AV
 sjJktQbWgNOxvFMbODUl6vt6KuiQW5SV72vfoH7igAz/Nci9KX1whbGQEgmxtEx7vwAs6x
 isfNwotRQoOj+QLtgqdRE0coH0RvPAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704390818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5f037tEQk/1NTd1+0YauzBSy4MblSjoyXywuHhYfBE=;
 b=C0L4WjFUdFEv/J15/sduBBsylz0QZhiC/i9OuZxWH6o05Km5ZEJqVK2PnP+DhqqpcAhhSr
 Ke4h+o2o8trBt2Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0367913722;
 Thu,  4 Jan 2024 17:53:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m/+gLqHwlmXIdAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 04 Jan 2024 17:53:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 2/4] tests/qtest/migration: Add infrastructure to
 skip tests on older QEMUs
In-Reply-To: <ZZbqQJxdfJDLXmXz@redhat.com>
References: <20240104171857.20108-1-farosas@suse.de>
 <20240104171857.20108-3-farosas@suse.de> <ZZbqQJxdfJDLXmXz@redhat.com>
Date: Thu, 04 Jan 2024 14:53:35 -0300
Message-ID: <87plyhhtnk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7A09022108
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PuoEqUzw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=C0L4WjFU
X-Spam-Score: -5.51
X-Spamd-Result: default: False [-5.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:dkim];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
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

> On Thu, Jan 04, 2024 at 02:18:55PM -0300, Fabiano Rosas wrote:
>> We can run the migration tests with two different QEMU binaries to
>> test migration compatibility between QEMU versions. This means we'll
>> be running the tests with an older QEMU in either source or
>> destination.
>>=20
>> We need to avoid trying to test functionality that is unknown to the
>> older QEMU. This could mean new features, bug fixes, error message
>> changes, QEMU command line changes, migration API changes, etc.
>>=20
>> Add a 'since' argument to the tests that inform when the functionality
>> that is being test has been added to QEMU so we can skip the test on
>> older versions.
>>=20
>> Also add a version comparison function so we can adapt test code
>> depending on the QEMU binary version being used.
>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration-helpers.c | 11 +++++++++++
>>  tests/qtest/migration-helpers.h |  1 +
>>  tests/qtest/migration-test.c    | 29 +++++++++++++++++++++++++++++
>>  3 files changed, 41 insertions(+)
>>=20
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-hel=
pers.c
>> index 24fb7b3525..20220bfda0 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -292,3 +292,14 @@ char *resolve_machine_version(const char *alias, co=
nst char *var1,
>>=20=20
>>      return find_common_machine_version(machine_name, var1, var2);
>>  }
>> +
>> +int migration_vercmp(QTestState *who, const char *tgt_version)
>> +{
>> +    int major, minor, micro;
>> +    g_autofree char *version =3D NULL;
>> +
>> +    qtest_query_version(who, &major, &minor, &micro);
>> +    version =3D g_strdup_printf("%d.%d", major, minor + !!micro);
>> +
>> +    return strcmp(version, tgt_version);
>
> Alphabetical version comparison will fail in 2025 when we
> hit QEMU 10.0, as 10.0 will compare older than 9.0
>

Indeed, I'll fix it.

Thanks

