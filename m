Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9BE785923
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 15:27:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYnsa-0006a2-1W; Wed, 23 Aug 2023 09:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qYnsX-0006ZY-Re
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 09:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qYnsV-0007O7-JA
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 09:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692797190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GYigVke0bYoxCD0Ouxnz4kri4wZGjmGFE6xhY0/k3KY=;
 b=hZE90ToeQo5zeiS7hvNAeQYA9lS4/t9hucSWV98GN/jsWLLLjoUsU28L3FRJc/5CTo0nYy
 EueXXIfm3Ac3pUdvP7Yz4omtU9lptepvBxRprRwjLK4IgKoA8FhdkQhYExJNUrKqQZiPSR
 k31nh2WHAfeeTBmU55M2BfC+gpdc+sk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-qwpVLbyyMLmSsJSANZCD3g-1; Wed, 23 Aug 2023 09:26:27 -0400
X-MC-Unique: qwpVLbyyMLmSsJSANZCD3g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6D863C025B7;
 Wed, 23 Aug 2023 13:26:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B59CFC15BB8;
 Wed, 23 Aug 2023 13:26:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A9B1E21E690D; Wed, 23 Aug 2023 15:26:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Leonardo Bras Soares Passos
 <lsoaresp@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH for-8.2 3/4] migration/qapi: Replace
 @MigrateSetParameters with @MigrationParameters
References: <20230814221947.353093-1-peterx@redhat.com>
 <20230814221947.353093-4-peterx@redhat.com>
Date: Wed, 23 Aug 2023 15:26:25 +0200
In-Reply-To: <20230814221947.353093-4-peterx@redhat.com> (Peter Xu's message
 of "Mon, 14 Aug 2023 18:19:46 -0400")
Message-ID: <871qftx532.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

> These two structs are mostly identical besides some fields (quote from
> Daniel P. Berrang=C3=A9 in his reply):
>
>   1c1
>   < { 'struct': 'MigrationParameters',
>   ---
>   > { 'struct': 'MigrateSetParameters',
>   14,16c14,16
>   <             '*tls-creds': 'str',
>   <             '*tls-hostname': 'str',
>   <             '*tls-authz': 'str',
>   ---
>   >             '*tls-creds': 'StrOrNull',
>   >             '*tls-hostname': 'StrOrNull',
>   >             '*tls-authz': 'StrOrNull',
>
> Here the difference is @MigrateSetParameters object would allow 'null'
> values for any tls-* fields passed in.
>
> Markus used to describe why it happened to be StrOrNull, and also his
> concern on having a pure "str" type to be problematic as the reset
> indicator in the commit 01fa559826 ("migration: Use JSON null instead of =
""
> to reset parameter to default").  There, "null" is introduced for the tls
> fields even though being treated as "" (empty string) internally to match
> the code.

Suggest

  migration/qapi: Replace @MigrateSetParameters with @MigrationParameters

  migrate-set-parameters sets migration parameters, and
  query-migrate-parameters gets them.  Unsurprisingly, the former's
  argument type MigrateSetParameters is quite close to the latter's
  return type MigrationParameters.  The differences are subtle:

  1. Since migrate-set-parameters supports setting selected parameters,
     its arguments must all be optional (so you can omit the ones you
     don't want to change).  query-migrate-parameters results are also
     all optional, but almost all of them are in fact always present.

  2. For parameters @tls_creds, @tls_hostname, @tls_authz,
     migrate-set-parameters interprets special value "" as "reset to
     default".  Works, because "" is semantically invalid.  Not a
     general solution, because a semantically invalid value need not
     exist.  Markus added a general solution in commit 01fa559826
     ("migration: Use JSON null instead of "" to reset parameter to
     default").  This involved changing the type from 'str' to
     'StrOrNull'.

  3. When parameter @block-bitmap-mapping has not been set,
     query-migrate-parameters does not return it (absent optional
     member).  Clean (but undocumented).  When parameters @tls_creds,
     @tls_hostname, @tls_authz have not been set, it returns the
     semantically invalid value "".  Not so clean (and just as
     undocumented).

Items 2. and 3. need fact-checking.

> Here to deduplicate the two objects, logically it'll be safe only if we u=
se
> "StrOrNull" to replace "str" type, not vice versa.  However we may face
> difficulty using StrOrNull as part of MigrationState.parameters [1] when
> replacing existing @MigrationParameters to use StrOrNull.  With the fact
> that nobody seems to be using "null" for tls-* fields (see the long
> standing qemu crash bug on tls-authz when "null" was passed in), let's use
> "str" to represent both objects.

"May face difficulty" is insufficiently strong to justify such
incompatible change.

I'll have a look at the difficulties you mentioned in [1].  If we can
overcome them with reasonable effort, we can and should avoid the
compatibility break.  If we can't, we add proper rationale here.

> This greatly deduplicates the code not only in qapi/migration.json, but
> also in the generic migration code on handling transitions between
> StrOrNull <-> str types.
>
> [1] https://lore.kernel.org/all/ZNKfoqM0V6pcvrz%2F@x1n/
>
> Signed-off-by: Peter Xu <peterx@redhat.com>


