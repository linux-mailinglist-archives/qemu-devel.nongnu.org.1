Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 383CB752171
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 14:45:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJvgU-000608-Qd; Thu, 13 Jul 2023 08:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qJvgQ-0005zw-4l
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qJvgO-00005J-Jo
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689252272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z/+UnFbHqHWy1L8krN9R4YnEwm/b6aq2oDnvee89AU4=;
 b=fVOBW83NnfpzogHVeO4AZ5l12UbCxe6SUcyhBR3fhtAQPuZkCFcErU3UI62JnWXTa9O3TJ
 Snjd479VhI5zzIwVqeoQFWAImjZzd9nFDP8chmFhN+JQK5NqE/LMGoFCUHJ2DiuAvtXrOI
 /yHKdUiY4MTfftAG+/f5EB6yNi2AsWU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-JXtJcl44MtaBhYWWLGAhxQ-1; Thu, 13 Jul 2023 08:44:30 -0400
X-MC-Unique: JXtJcl44MtaBhYWWLGAhxQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50654858290;
 Thu, 13 Jul 2023 12:44:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D00B492C13;
 Thu, 13 Jul 2023 12:44:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1FDEB21E6A1F; Thu, 13 Jul 2023 14:44:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel <qemu-devel@nongnu.org>,  ~hyman <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Juan
 Quintela <quintela@redhat.com>,  "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH QEMU v8 4/9] migration: Introduce dirty-limit capability
References: <168870305868.29142.5121604177475325995-4@git.sr.ht>
Date: Thu, 13 Jul 2023 14:44:29 +0200
In-Reply-To: <168870305868.29142.5121604177475325995-4@git.sr.ht>
 (hyman@git.sr.ht's message of "Wed, 07 Jun 2023 23:30:50 +0800")
Message-ID: <875y6oj80i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
> Introduce migration dirty-limit capability, which can
> be turned on before live migration and limit dirty
> page rate durty live migration.
>
> Introduce migrate_dirty_limit function to help check
> if dirty-limit capability enabled during live migration.
>
> Meanwhile, refactor vcpu_dirty_rate_stat_collect
> so that period can be configured instead of hardcoded.
>
> dirty-limit capability is kind of like auto-converge
> but using dirty limit instead of traditional cpu-throttle
> to throttle guest down. To enable this feature, turn on
> the dirty-limit capability before live migration using
> migrate-set-capabilities, and set the parameters
> "x-vcpu-dirty-limit-period", "vcpu-dirty-limit" suitably
> to speed up convergence.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index e43371955a..031832cde5 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -497,6 +497,15 @@
>  #     are present.  'return-path' capability must be enabled to use
>  #     it.  (since 8.1)
>  #
> +# @dirty-limit: If enabled, migration will use the dirty-limit
> +#     algorithm to throttle down guest instead of auto-converge
> +#     algorithm. This algorithm only works when vCPU's dirtyrate

Two spaces after sentence-ending punctuation, please.

"dirty rate" with a space, because that's how we spell it elsewhere.

> +#     greater than 'vcpu-dirty-limit', read processes in guest os
> +#     aren't penalized any more, so the algorithm can improve
> +#     performance of vCPU during live migration. This is an optional
> +#     performance feature and should not affect the correctness of the
> +#     existing auto-converge algorithm. (since 8.1)
> +#

I'm still confused.

The text suggests there are two separate algorithms "to throttle down
guest": "auto converge" and "dirty limit", and we get to pick one.
Correct?

If it is correct, then the last sentence feels redundant: picking
another algorithm can't affect the algorithm we're *not* using.  What
are you trying to express here?

When do we use "auto converge", and when do we use "dirty limit"?

What does the user really need to know about these algorithms?  Enough
to pick one, I guess.  That means advantages and disadvantages of the
two algorithms.  Which are?

>  # Features:
>  #
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> @@ -512,7 +521,8 @@
>             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
> -           'zero-copy-send', 'postcopy-preempt', 'switchover-ack'] }
> +           'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> +           'dirty-limit'] }
>=20=20
>  ##
>  # @MigrationCapabilityStatus:

[...]


