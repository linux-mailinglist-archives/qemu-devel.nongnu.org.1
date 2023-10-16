Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 993847CB174
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 19:37:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsRVx-0000ma-HL; Mon, 16 Oct 2023 13:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qsRVv-0000mQ-2Y
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 13:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qsRVn-0002e2-Ac
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 13:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697477773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lfSwnm2235wzEmGB6el+Wk9JXfY8teqBUZXENowvMa8=;
 b=athxyvzcNt04W4IjcmeVfed84koxMT8VIOXUbMPBxNWNGeRwz3EJ/ynZqfO77VIX2rVA5S
 C+WW+aFj3Si9u69ryjqTn1GNKoUB1E/smqalia8vb2jZONi8N8a/Vke2SJazq0XmkCJGgn
 eSSaRGQmPZHh70vy6sZkEpczTRyf5H0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-JRHrV4BoOsWYuH0YzpRdiw-1; Mon, 16 Oct 2023 13:36:10 -0400
X-MC-Unique: JRHrV4BoOsWYuH0YzpRdiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 735B9862F1B;
 Mon, 16 Oct 2023 17:36:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 518FA25CB;
 Mon, 16 Oct 2023 17:36:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 46D0821E6A26; Mon, 16 Oct 2023 19:36:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juan Quintela <quintela@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v3 4/4] migration/qapi: Drop @MigrationParameter enum
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-5-peterx@redhat.com>
 <87a5t8is2d.fsf@pond.sub.org> <ZRsrG5QdnEh0jiXd@x1n>
 <87ttqqiz5f.fsf@pond.sub.org> <ZS1h+pNhqyaXHDhW@x1n>
Date: Mon, 16 Oct 2023 19:36:09 +0200
In-Reply-To: <ZS1h+pNhqyaXHDhW@x1n> (Peter Xu's message of "Mon, 16 Oct 2023
 12:16:58 -0400")
Message-ID: <87v8b6eagm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

> On Mon, Oct 16, 2023 at 08:29:58AM +0200, Markus Armbruster wrote:
>> Better, because even stupider: drop the feature flags.  They have no
>> effect on internal use, and there is no external use.
>> 
>>     ##
>>     # @MigrationParameter:
>>     #
>>     # TODO: elide from generated documentation (type is used only
>>     #     internally, and not visible in QMP)
>>     #
>>     # Since: 2.4
>>     ##
>>     { 'enum': 'MigrationParameter',
>>       'data': ['announce-initial', 'announce-max',
>>                'announce-rounds', 'announce-step',
>>                'compress-level', 'compress-threads', 'decompress-threads',
>>                'compress-wait-thread', 'throttle-trigger-threshold',
>>                'cpu-throttle-initial', 'cpu-throttle-increment',
>>                'cpu-throttle-tailslow',
>>                'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
>>                'downtime-limit',
>>                'x-checkpoint-delay',
>>                'block-incremental',
>>                'multifd-channels',
>>                'xbzrle-cache-size', 'max-postcopy-bandwidth',
>>                'max-cpu-throttle', 'multifd-compression',
>>                'multifd-zlib-level', 'multifd-zstd-level',
>>                'block-bitmap-mapping',
>>                'x-vcpu-dirty-limit-period',
>>                'vcpu-dirty-limit'] }
>
> Didn't work either, unfortunately..  Compile is fine, but I still see the
> lines generated in qemu-qmp-ref.7.
>
>         MigrationParameter (Enum)
>         Values
>         announce-initial
>                 Not documented
>
>         announce-max
>                 Not documented
>
>         announce-rounds
>                 Not documented
>
>         announce-step
>                 Not documented
>
>         compress-level
>                 Not documented
>         [...]

I didn't claim these will *not* be generated :)

> Patch attached.
>
> Thanks,

Solutions:

0. Do nothing

   The QEMU QMP Reference manual documents MigrationParameter, even
   though it is not actually visible in QMP.

   The documentation source is a duplicate.

1. Dumb down MigrationParameter's doc comment (your attached patch)

   The QEMU QMP Reference manual documents MigrationParameter, even
   though it is not actually visible in QMP.  In addition to useless,
   the documentation is embarrassing: lots of "Not documented".

2. Make MigrationParameter a C enum instead of a QAPI enum (your v3
   patch)

   The QEMU QMP Reference manual doesn't uselessly document
   MigrationParameter (it still uselessly documents other internal-only
   things).

   We replace 20 lines of QAPI schema by 100 lines of C.

3. Improve the QAPI generator to generate docs only for definitions
   visible externally, and to require doc comments only then

   The QEMU QMP Reference manual doesn't uselessly document
   internal-only stuff.

   This solution doesn't exist, yet.


