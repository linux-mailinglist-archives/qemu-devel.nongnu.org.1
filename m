Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C351680A676
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 16:03:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBcN2-0003KX-Br; Fri, 08 Dec 2023 10:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rBcN0-0003K5-5d
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 10:02:26 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rBcMy-0000kw-Gm
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 10:02:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A2DA21C7B;
 Fri,  8 Dec 2023 15:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702047742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mDLt1KrLlCAT3fJ10wonFfR5PW07O6DC7/0/anZ3ucY=;
 b=BxTOhU4j7sroZ0OyZfUyvGyqAcPaU3MoCtTDiYzSzHp/JJx14zlmDCrN2vUJ+7PvtY6L0o
 iuju2OE5jrAgLR6p/rSc4Ir3oozop9Ouna6uwoNoTYjr9aboLWHZX0h6MJP/1mTJ1ZJfPH
 2iawLPk/QzKQczADCxoirOvh+9Xl1fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702047742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mDLt1KrLlCAT3fJ10wonFfR5PW07O6DC7/0/anZ3ucY=;
 b=kBlz+w0KRxkyS+nRbn5SbVIaA//r/8MSr3pke5gAjMsGnoNK7A3h2kdKTgfbLPNLhibUmw
 +CIeT3DUzhjx0+CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702047742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mDLt1KrLlCAT3fJ10wonFfR5PW07O6DC7/0/anZ3ucY=;
 b=BxTOhU4j7sroZ0OyZfUyvGyqAcPaU3MoCtTDiYzSzHp/JJx14zlmDCrN2vUJ+7PvtY6L0o
 iuju2OE5jrAgLR6p/rSc4Ir3oozop9Ouna6uwoNoTYjr9aboLWHZX0h6MJP/1mTJ1ZJfPH
 2iawLPk/QzKQczADCxoirOvh+9Xl1fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702047742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mDLt1KrLlCAT3fJ10wonFfR5PW07O6DC7/0/anZ3ucY=;
 b=kBlz+w0KRxkyS+nRbn5SbVIaA//r/8MSr3pke5gAjMsGnoNK7A3h2kdKTgfbLPNLhibUmw
 +CIeT3DUzhjx0+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0455C12FF7;
 Fri,  8 Dec 2023 15:02:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mxgBL/0vc2X5cwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 08 Dec 2023 15:02:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas
 Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 2/5] tests/qtest/migration: Add infrastructure to
 skip tests on older QEMUs
In-Reply-To: <20231207155809.25673-3-farosas@suse.de>
References: <20231207155809.25673-1-farosas@suse.de>
 <20231207155809.25673-3-farosas@suse.de>
Date: Fri, 08 Dec 2023 12:02:19 -0300
Message-ID: <87zfykybyc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: 6.48
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BxTOhU4j;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kBlz+w0K;
 dmarc=pass (policy=none) header.from=suse.de;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-14.01 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_SPF_SOFTFAIL(0.00)[~all:c];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+];
 DMARC_POLICY_ALLOW(0.00)[suse.de,none];
 RCPT_COUNT_SEVEN(0.00)[9]; MX_GOOD(-0.01)[];
 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 WHITELIST_DMARC(-7.00)[suse.de:D:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -14.01
X-Rspamd-Queue-Id: 7A2DA21C7B
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

Fabiano Rosas <farosas@suse.de> writes:

> We can run the migration tests with two different QEMU binaries to
> test migration compatibility between QEMU versions. This means we'll
> be running the tests with an older QEMU in either source or
> destination.
>
> We need to avoid trying to test functionality that is unknown to the
> older QEMU. This could mean new features, bug fixes, error message
> changes, QEMU command line changes, migration API changes, etc.
>
> Add a 'since' argument to the tests that inform when the functionality
> that is being test has been added to QEMU so we can skip the test on
> older versions.
>
> Also add a version comparison function so we can adapt test code
> depending on the QEMU binary version being used.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-helpers.c | 11 +++++++++++
>  tests/qtest/migration-helpers.h |  1 +
>  tests/qtest/migration-test.c    | 28 ++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
>
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 24fb7b3525..d21f5cd8c0 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -292,3 +292,14 @@ char *resolve_machine_version(const char *alias, const char *var1,
>  
>      return find_common_machine_version(machine_name, var1, var2);
>  }
> +
> +int migration_vercmp(QTestState *who, const char *tgt_version)
> +{
> +    int major, minor, micro;
> +    g_autofree char *version = NULL;
> +
> +    qtest_query_version(who, &major, &minor, &micro);
> +    version = g_strdup_printf("%d.%d.%d", major, minor, micro);

I just noticed this is not right. I need to increment the minor when
there's a micro to account for the versions in between releases. The
whole point of this series is to test a X.Y.0 release vs. a X.Y.Z
development branch.

> +
> +    return strcmp(version, tgt_version);
> +}

