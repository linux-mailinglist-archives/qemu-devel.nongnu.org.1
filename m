Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 665407C6A71
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:07:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqsaY-0004QI-Oz; Thu, 12 Oct 2023 06:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqsaW-0004Q3-Rv
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqsaU-0000EJ-73
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697105197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ni7ESr4ZFEwg2/RAGMxDk5GIZopbL5MLt4WFZtGDUls=;
 b=hIDtOzPZv9olJ+wUsHQvHNASNPaXU+TtmYrgdtvjIuJwp+977mctc8bpmCAKmAmgDaT7mI
 ojnES38CAV6thbTuBOU7KJn66GTbZs4Q7/9U2ic23V26GYvhzeBklwEf9f2ir+7mOfg/wX
 VL8bnn1ARZCBT0xMq1fv7K78nn3/xso=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-679-VZ_Bsq0zN6G87Vz5KnsKQQ-1; Thu, 12 Oct 2023 06:06:23 -0400
X-MC-Unique: VZ_Bsq0zN6G87Vz5KnsKQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D33E811E7D;
 Thu, 12 Oct 2023 10:06:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BA2140C6CA2;
 Thu, 12 Oct 2023 10:06:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5F70821E6A1F; Thu, 12 Oct 2023 12:06:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org,  Fam Zheng <fam@euphon.net>,  Eric Blake
 <eblake@redhat.com>,  libvir-list@redhat.com,  Leonardo Bras
 <leobras@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 4/4] migration: Deprecate old compression method
References: <20231011204711.9744-1-quintela@redhat.com>
 <20231011204711.9744-5-quintela@redhat.com>
Date: Thu, 12 Oct 2023 12:06:22 +0200
In-Reply-To: <20231011204711.9744-5-quintela@redhat.com> (Juan Quintela's
 message of "Wed, 11 Oct 2023 22:47:11 +0200")
Message-ID: <87jzrsyx29.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Juan Quintela <quintela@redhat.com> writes:

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/about/deprecated.rst |   8 +++
>  qapi/migration.json       | 102 ++++++++++++++++++++++++--------------
>  migration/options.c       |  13 +++++
>  3 files changed, 86 insertions(+), 37 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index e46f3df376..b92621996f 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -441,3 +441,11 @@ Please see "QMP invocation for live storage migration with
>  ``driver-mirror`` + NBD" in docs/interop/live-block-operations.rst for
>  a detailed explanation.
>  
> +old compression method (since 8.2)
> +''''''''''''''''''''''''''''''''''
> +
> +Compression method fails too much.  Too many races.  We are going to
> +remove it if nobody fixes it.  For starters, migration-test
> +compression tests are disabled becase they fail randomly.  If you need
> +compression, use multifd compression methods.
> +
> diff --git a/qapi/migration.json b/qapi/migration.json
> index bf6e1ac5b5..549306fa76 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -243,7 +243,9 @@
>  #
>  # @compression: migration compression statistics, only returned if
>  #     compression feature is on and status is 'active' or 'completed'
> -#     (Since 3.1)
> +#     This feature is unreliable and not tested. It is recommended to
> +#     use multifd migration instead, which offers an alternative
> +#     reliable and tested compression implementation.  (Since 3.1)
>  #
>  # @socket-address: Only used for tcp, to know what the real port is
>  #     (Since 4.0)
> @@ -271,8 +273,11 @@
>  #
>  # Features:
>  #
> -# @deprecated: @disk migration is deprecated.  Use driver-mirror
> -#     with NBD instead.
> +# @deprecated: @disk migration is deprecated.  Use driver-mirror with
> +#     NBD instead.  @compression is unreliable and untested. It is
> +#     recommended to use multifd migration, which offers an
> +#     alternative compression implementation that is reliable and
> +#     tested.

Again, single deprecation note under "Features:", please.

>  #
>  # Since: 0.14
>  ##
> @@ -290,7 +295,7 @@
>             '*blocked-reasons': ['str'],
>             '*postcopy-blocktime': 'uint32',
>             '*postcopy-vcpu-blocktime': ['uint32'],
> -           '*compression': 'CompressionStats',
> +           '*compression': { 'type': 'CompressionStats', 'features': ['deprecated'] },
>             '*socket-address': ['SocketAddress'],
>             '*dirty-limit-throttle-time-per-round': 'uint64',
>             '*dirty-limit-ring-full-time': 'uint64'} }
> @@ -445,7 +450,8 @@
>  #     compress and xbzrle are both on, compress only takes effect in
>  #     the ram bulk stage, after that, it will be disabled and only
>  #     xbzrle takes effect, this can help to minimize migration
> -#     traffic.  The feature is disabled by default.  (since 2.4 )
> +#     traffic.  The feature is disabled by default.  Obsolete.  Use

Some places call it "deprecated", others "obsolete".  Best to always use
"deprecated".

More of the same below.

> +#     multifd compression methods if needed. (since 2.4 )
>  #
>  # @events: generate events for each migration state change (since 2.4
>  #     )

[...]

Migration has grown way too many options.  Thanks for pruning them back
some.


