Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDC57D6CFC
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:20:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvdn5-0003TY-KS; Wed, 25 Oct 2023 09:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvdn3-0003TN-MB
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:19:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvdn0-0005W8-Om
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:19:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A164B21B40;
 Wed, 25 Oct 2023 13:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698239952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/F9HkR6QaUSDqa6nxkrI210cpXq0VCIbO5oZSj38gj8=;
 b=WRKaz1z1pmqCy4xR5pNSIXSyelPqLpvmTfmHBP3hBln9vDNL1nGnJHSzi1pWY85iFyuKCT
 PmjZ+gTyf3Pln2CwG4eIU+XqWBe7Xfy2xxFdigHnmfRUyygRHm1HL8vB9/CqqC726PUwZf
 j7jqAbckb+7bCsWjtIDC3U4JwXlG2AI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698239952;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/F9HkR6QaUSDqa6nxkrI210cpXq0VCIbO5oZSj38gj8=;
 b=KEptjL9KzIxl/E9NsXEad/wdryrN1kHlatKeuDpmwIg9VGeB3ftgbXvGMGs++uoARthnxW
 DRDphEpzpX+jgVDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33CF313524;
 Wed, 25 Oct 2023 13:19:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9PtqANAVOWXcdgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 25 Oct 2023 13:19:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 02/29] tests/qtest: Move QTestMigrationState to libqtest
In-Reply-To: <ZTjrVt3IrUZa7P2u@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-3-farosas@suse.de> <ZTjrVt3IrUZa7P2u@redhat.com>
Date: Wed, 25 Oct 2023 10:19:09 -0300
Message-ID: <875y2ug7qq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

> On Mon, Oct 23, 2023 at 05:35:41PM -0300, Fabiano Rosas wrote:
>> Move the QTestMigrationState into QTestState so we don't have to pass
>> it around to the wait_for_* helpers anymore. Since QTestState is
>> private to libqtest.c, move the migration state struct to libqtest.h
>> and add a getter.
>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/libqtest.c          | 14 ++++++++++
>>  tests/qtest/libqtest.h          | 23 ++++++++++++++++
>>  tests/qtest/migration-helpers.c | 18 +++++++++++++
>>  tests/qtest/migration-helpers.h |  8 +++---
>>  tests/qtest/migration-test.c    | 47 +++++++++------------------------
>>  5 files changed, 72 insertions(+), 38 deletions(-)
>>=20
>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>> index f33a210861..f7e85486dc 100644
>> --- a/tests/qtest/libqtest.c
>> +++ b/tests/qtest/libqtest.c
>> @@ -87,6 +87,7 @@ struct QTestState
>>      GList *pending_events;
>>      QTestQMPEventCallback eventCB;
>>      void *eventData;
>> +    QTestMigrationState *migration_state;
>
> It feels wrong to have something called MigrationState in the
> general qtest code. In the end there's nothing particularly
> migration related about this though.
>
> With that in mind, we could just rename it to "QTestEventState"
> instead.
>

Ok, will do.

>>  };
>>=20=20
>>  static GHookList abrt_hooks;
>> @@ -500,6 +501,8 @@ static QTestState *qtest_init_internal(const char *q=
emu_bin,
>>          s->irq_level[i] =3D false;
>>      }
>>=20=20
>> +    s->migration_state =3D g_new0(QTestMigrationState, 1);
>> +
>>      /*
>>       * Stopping QEMU for debugging is not supported on Windows.
>>       *
>> @@ -601,6 +604,7 @@ void qtest_quit(QTestState *s)
>>      close(s->fd);
>>      close(s->qmp_fd);
>>      g_string_free(s->rx, true);
>> +    g_free(s->migration_state);
>>=20=20
>>      for (GList *it =3D s->pending_events; it !=3D NULL; it =3D it->next=
) {
>>          qobject_unref((QDict *)it->data);
>> @@ -854,6 +858,11 @@ void qtest_qmp_set_event_callback(QTestState *s,
>>      s->eventData =3D opaque;
>>  }
>>=20=20
>> +void qtest_qmp_set_migration_callback(QTestState *s, QTestQMPEventCallb=
ack cb)
>> +{
>> +    qtest_qmp_set_event_callback(s, cb, s->migration_state);
>> +}
>> +
>>  QDict *qtest_qmp_event_ref(QTestState *s, const char *event)
>>  {
>>      while (s->pending_events) {
>> @@ -1906,3 +1915,8 @@ bool mkimg(const char *file, const char *fmt, unsi=
gned size_mb)
>>=20=20
>>      return ret && !err;
>>  }
>> +
>> +QTestMigrationState *qtest_migration_state(QTestState *s)
>> +{
>> +    return s->migration_state;
>> +}
>> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
>> index 6e3d3525bf..0421a1da24 100644
>> --- a/tests/qtest/libqtest.h
>> +++ b/tests/qtest/libqtest.h
>> @@ -23,6 +23,20 @@
>>=20=20
>>  typedef struct QTestState QTestState;
>>=20=20
>> +struct QTestMigrationState {
>> +    bool stop_seen;
>> +    bool resume_seen;
>> +};
>> +typedef struct QTestMigrationState QTestMigrationState;
>> +
>> +/**
>> + * qtest_migration_state:
>> + * @s: #QTestState instance to operate on.
>> + *
>> + * Returns: #QTestMigrationState instance.
>> + */
>> +QTestMigrationState *qtest_migration_state(QTestState *s);
>> +
>>  /**
>>   * qtest_initf:
>>   * @fmt: Format for creating other arguments to pass to QEMU, formatted
>> @@ -288,6 +302,15 @@ typedef bool (*QTestQMPEventCallback)(QTestState *s=
, const char *name,
>>  void qtest_qmp_set_event_callback(QTestState *s,
>>                                    QTestQMPEventCallback cb, void *opaqu=
e);
>>=20=20
>> +/**
>> + * qtest_qmp_set_migration_callback:
>> + * @s: #QTestSTate instance to operate on
>> + * @cb: callback to invoke for events
>> + *
>> + * Like qtest_qmp_set_event_callback, but includes migration state even=
ts
>> + */
>> +void qtest_qmp_set_migration_callback(QTestState *s, QTestQMPEventCallb=
ack cb);
>> +
>>  /**
>>   * qtest_qmp_eventwait:
>>   * @s: #QTestState instance to operate on.
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-hel=
pers.c
>> index fd3b94efa2..cffa525c81 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -92,6 +92,24 @@ void migrate_set_capability(QTestState *who, const ch=
ar *capability,
>>                               capability, value);
>>  }
>>=20=20
>> +void wait_for_stop(QTestState *who)
>> +{
>> +    QTestMigrationState *state =3D qtest_migration_state(who);
>> +
>> +    if (!state->stop_seen) {
>> +        qtest_qmp_eventwait(who, "STOP");
>> +    }
>> +}
>> +
>> +void wait_for_resume(QTestState *who)
>> +{
>> +    QTestMigrationState *state =3D qtest_migration_state(who);
>> +
>> +    if (!state->resume_seen) {
>> +        qtest_qmp_eventwait(who, "RESUME");
>> +    }
>> +}
>
> I'd be included to put them into the libqtest.c file too eg
>
>   qtest_wait_for_resume/qtst_wait_for_stop
>

Haven't I done this already? It must have gotten lost in the various
rebases.

Thanks


