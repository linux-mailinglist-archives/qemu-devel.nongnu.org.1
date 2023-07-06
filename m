Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 093E774A082
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 17:10:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHQbC-0005eD-B0; Thu, 06 Jul 2023 11:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHQb9-0005da-L1
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 11:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHQb7-0001T5-Tr
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 11:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688656124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GAIMTyu1BIHEBauyXkMmX5L59y7lTNjXLOi6GtqGxR8=;
 b=UVQSaiw4Noz4J4lCmbt/jk/yPMyk8u+dRbtDq1n4TlqJT7XJxDuCEtwcGwxZKUwACqR8ZG
 HYe23NaS1i0sCb1vDLyqcyfsomphKaQ8jJEDbPiZK9f4e1NqwdqTUi5WwoR2RYZ6aPuk0t
 cLx61XKGnRYk88DgGsVfL0aeusG246k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-WZ_aHjKtMe2xrqGSP5_FCw-1; Thu, 06 Jul 2023 11:08:37 -0400
X-MC-Unique: WZ_aHjKtMe2xrqGSP5_FCw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4B7A1C06ED0;
 Thu,  6 Jul 2023 15:08:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C332B492B01;
 Thu,  6 Jul 2023 15:08:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AAE5421E6A1F; Thu,  6 Jul 2023 17:08:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel <qemu-devel@nongnu.org>,  ~hyman <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Juan
 Quintela <quintela@redhat.com>,  "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH QEMU v7 8/9] migration: Extend query-migrate to provide
 dirty page limit info
References: <168853615963.17240.15832775267134683267-8@git.sr.ht>
Date: Thu, 06 Jul 2023 17:08:34 +0200
In-Reply-To: <168853615963.17240.15832775267134683267-8@git.sr.ht>
 (hyman@git.sr.ht's message of "Thu, 08 Jun 2023 00:21:58 +0800")
Message-ID: <87ttuhnklp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

~hyman <hyman@git.sr.ht> writes:

> From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>
> Extend query-migrate to provide throttle time and estimated
> ring full time with dirty-limit capability enabled, through which
> we can observe if dirty limit take effect during live migration.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index cc51835cdd..ebc15e2782 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -250,6 +250,18 @@
>  #     blocked.  Present and non-empty when migration is blocked.
>  #     (since 6.0)
>  #
> +# @dirty-limit-throttle-time-per-round: Maximum throttle time (in micros=
econds) of virtual
> +#                                       CPUs each dirty ring full round,=
 which shows how
> +#                                       MigrationCapability dirty-limit =
affects the guest
> +#                                       during live migration. (since 8.=
1)
> +#
> +# @dirty-limit-ring-full-time: Estimated average dirty ring full time (i=
n microseconds)
> +#                              each dirty ring full round, note that the=
 value equals

Period instead of comma, please.

> +#                              dirty ring memory size divided by average=
 dirty page rate
> +#                              of virtual CPU, which can be used to obse=
rve the average

of the virtual CPU

> +#                              memory load of virtual CPU indirectly. No=
te that zero

again

> +#                              means guest doesn't dirty memory (since 8=
.1)
> +#

Please format like

   # @dirty-limit-throttle-time-per-round: Maximum throttle time (in
   #     microseconds) of virtual CPUs each dirty ring full round, which
   #     shows how MigrationCapability dirty-limit affects the guest
   #     during live migration.  (since 8.1)
   #
   # @dirty-limit-ring-full-time: Estimated average dirty ring full time
   #     (in microseconds) each dirty ring full round.  Note that the
   #     value equals dirty ring memory size divided by average dirty
   #     page rate of the virtual CPU, which can be used to observe the
   #     average memory load of the virtual CPU indirectly.  Note that
   #     zero means guest doesn't dirty memory (since 8.1)

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

Might want to scratch "Note that" both times.

>  # Since: 0.14
>  ##
>  { 'struct': 'MigrationInfo',
> @@ -267,7 +279,9 @@
>             '*postcopy-blocktime' : 'uint32',
>             '*postcopy-vcpu-blocktime': ['uint32'],
>             '*compression': 'CompressionStats',
> -           '*socket-address': ['SocketAddress'] } }
> +           '*socket-address': ['SocketAddress'],
> +           '*dirty-limit-throttle-time-per-round': 'uint64',
> +           '*dirty-limit-ring-full-time': 'uint64'} }
>=20=20
>  ##
>  # @query-migrate:

[...]


