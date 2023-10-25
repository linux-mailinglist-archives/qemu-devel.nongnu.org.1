Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAA77D6CF2
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:18:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvdlT-0002jk-EP; Wed, 25 Oct 2023 09:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvdlS-0002jW-19
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvdlQ-0005JU-AV
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698239852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KvJEZQjkRloqB4aAuTtjD5b6kDKy/toqTOMHYqWAFJU=;
 b=RtyyXF1JvEnSGYLFs1Kh7Bg8GOwrpm7yBC+Re/0DubBzGNRTLF0lxL9q0nwfCHHbiYcdTM
 ZRF/61u1t94MqHyzGt5hyem8jamiRyyMgdX3qNLGmpVGUlHOdevAfM7ugKLicF/YLJGafj
 Ogt/anLwDaRbnGUj+1A4qdkNDDm78Q4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-UQuVB1_VPuuFBdr8cHagsg-1; Wed, 25 Oct 2023 09:17:29 -0400
X-MC-Unique: UQuVB1_VPuuFBdr8cHagsg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEB6E83DDF5;
 Wed, 25 Oct 2023 13:17:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C67F1121320;
 Wed, 25 Oct 2023 13:17:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7D7EF21E6A1F; Wed, 25 Oct 2023 15:17:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,  Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: QAPI doc generator improvements (was: [PATCH v3 0/4]
 qapi/migration: Dedup migration parameter objects and fix tls-authz crash)
References: <20230905162335.235619-1-peterx@redhat.com>
 <87h6mqixya.fsf@pond.sub.org> <ZS1k3mBVHgIPrjfO@x1n>
 <87v8b5dajh.fsf@pond.sub.org>
Date: Wed, 25 Oct 2023 15:17:21 +0200
In-Reply-To: <87v8b5dajh.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 17 Oct 2023 08:32:02 +0200")
Message-ID: <87r0lig7tq.fsf_-_@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

[...]

> I can see two useful QAPI generator features:
>
> * Improved handling of missing member documentation
>
>   Problem: many members lack documentation.  We silently generate
>   documentation like
>
>       name-of-member
>           Not documented
>
>   for them.
>
>   Possible improvement: make missing member documentation a hard error,
>   create a knob to suppress the error for a type.  Open question: how to
>   best document member documentation is incomplete.
>
> * Suppress documentation for internal-only definitions
>
>   Problem: generated documentation covers everything, even types that
>   aren't visible in QMP.  The irrelevant material is distracting and
>   possibly confusing for users, and may be bothersome to maintain for
>   developers.
>
>   Possible improvement: include only the types visible in QMP in
>   documentation, similar to how we do for query-qmp-schema.  Open
>   question: what level of documentation to require for internal-only
>   types.

I expored this one, and ran into a roadblock.

I wrote a bit of code to mark the stuff we want in QMP documentation:
commands, events, and the types they use, directly or indirectly.

I then hacked QAPISchemaGenRSTVisitor.symbol() to skip entities not
so marked.

Surprisingly, this does not work: the generated QEMU QMP Reference
Manual lacks stuff that is clearly in QMP.

I double-checked, and yes, the missing stuff does get marked.  WTF?!?

I dug some, and it looks like this is due to interference between the
QEMU QMP Reference Manual (generated from qapi/qapi-schema.json) and the
QEMU Storage Daemon QMP Reference Manual (generated from
storage-daemon/qapi/qapi-schema.json).

Both qapi-schema.json include submodules from qapi/., the former all of
them, the latter only some of them.  Yes, this is a bit of a hack.

sphinx-build runs the QAPI machinery separately for each of the two.
Somehow results from one run can leak into the other one.  For instance,
type HumanReadableText is marked in one run and not the other (correct),
but its documentation is generated in *neither* run.  I suspect this is
an artifact of incremental doc building magic.

I'm shelving the idea for now.


