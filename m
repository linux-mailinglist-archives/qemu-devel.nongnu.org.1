Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B157C7C7D1C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 07:42:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrAvY-0000ys-DU; Fri, 13 Oct 2023 01:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrAvV-0000yQ-OG
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 01:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrAvU-0004b0-6W
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 01:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697175691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bAxhjDGqnv+nu8hOWG1QB//SuLv2pySb5YWm5uCoUs4=;
 b=aFV6Ze9wMKbt1L/iTUwoTuzpMqpKvxtjqaQKTu2paSZ5LQ2cRup6wDj3ZMPomYTWP0LtZo
 4MfJlzhGJ5Bzjwdrz4yHc3PBUFmABRbi+zQU+klWN9cZRky03nGlC7Mzhwuvns2alIPg/G
 z+IBPzAzPjkiJ/wUzQQ3V+pGhfi90Ac=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-BbgZjCirOmawsEUPHro4lw-1; Fri, 13 Oct 2023 01:41:29 -0400
X-MC-Unique: BbgZjCirOmawsEUPHro4lw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBEAA29AB40C;
 Fri, 13 Oct 2023 05:41:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CAEDE4021CE;
 Fri, 13 Oct 2023 05:41:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C331421E6A21; Fri, 13 Oct 2023 07:41:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juan Quintela <quintela@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v3 3/4] migration/qapi: Replace @MigrateSetParameters
 with @MigrationParameters
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-4-peterx@redhat.com>
 <87fs30is78.fsf@pond.sub.org> <ZRsff7Lmy7TnggK9@x1n>
 <87sf6k2dax.fsf@pond.sub.org> <ZSVoK6YMgNzrDYGQ@x1n>
 <878r8ajngg.fsf@pond.sub.org> <ZSWvYgKcGXlucXx6@x1n>
 <875y3dixzp.fsf@pond.sub.org> <ZSgXnb7pr3Ru6v+b@x1n>
Date: Fri, 13 Oct 2023 07:41:27 +0200
In-Reply-To: <ZSgXnb7pr3Ru6v+b@x1n> (Peter Xu's message of "Thu, 12 Oct 2023
 11:58:21 -0400")
Message-ID: <8734yfjczc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Wed, Oct 11, 2023 at 06:28:26AM +0200, Markus Armbruster wrote:

[...]

>> >> If the migration object is accessible with qom-set, then that's another
>> >> way to assign null values.
>> >
>> > I see what you meant.  IMHO we just don't need to worry on breaking that as
>> > I am not aware of anyone using that to set migration parameters, and I
>> > think the whole idea of migration_properties is for debugging.  The only
>> > legal way an user should set migration parameters should be via QMP, afaik.
>> 
>> No matter the intended purpose of an interface, its meaning should be
>> clear.  If we accept null, what does it mean?
>
> IMHO here it means anything parsed from migration_properties will be a
> qstring and impossible to be a qnull, at least if with that of my (probably
> unmature, or even wrong..) fix:
>
> https://lore.kernel.org/all/ZRsff7Lmy7TnggK9@x1n/
>
> +static bool string_input_start_alternate(Visitor *v, const char *name,
> +                                         GenericAlternate **obj, size_t size,
> +                                         Error **errp)
> +{
> +    *obj = g_malloc0(size);
> +    (*obj)->type = QTYPE_QSTRING;          <---------------- constantly set to string type
> +    return true;
> +}
>
> I think it means when we parse the string, we'll always go with:
>
> visit_type_StrOrNull():
>     switch ((*obj)->type) {
>     case QTYPE_QSTRING:
>         ok = visit_type_str(v, name, &(*obj)->u.s, errp);
>         break;
>
> Finally, parse_type_str().
>
> So it'll be impossible to specify null for -global migration.tls_*=XXX.

Only because -global can't do null.  Changes the moment we improve it to
support JSON values.  We already improved several other CLI options that
way.

> I suppose it's fine then?  Because it actually matches with previous when
> it was still a string, and we use empty string to show tls disabled.
>
> Thanks,


