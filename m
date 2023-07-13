Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAE6752185
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 14:46:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJvi6-0007Dz-II; Thu, 13 Jul 2023 08:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qJvhw-00074j-LS
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qJvht-0000z0-VM
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689252362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlf060W5OAnfa/XWQM6OsGgAFLf6E87wbFISv5JCuAY=;
 b=ADcyN2jKZMeMCslJqU68nnfPj0j9w5Bh+Q/LAudBO8lI83gvdUerpjTg4LKIrLzen6VWSI
 ON8BIXV1oKrtL+oR7VL/cPKPqwf7sw9+D3xjBYo9CE+tCHZ/YgUXmuonhC0z1wv/Xb7g8d
 Wjmmkm0ft8XNAZxdVtfA0pgpcbl7qsU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-YwYkco43MhWK7c7kSoAFUw-1; Thu, 13 Jul 2023 08:45:57 -0400
X-MC-Unique: YwYkco43MhWK7c7kSoAFUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F2BC805C10;
 Thu, 13 Jul 2023 12:45:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C4B1F66D1;
 Thu, 13 Jul 2023 12:45:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3D8DB21E6A1F; Thu, 13 Jul 2023 14:45:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel <qemu-devel@nongnu.org>,  ~hyman <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Juan
 Quintela <quintela@redhat.com>,  "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH QEMU v8 8/9] migration: Extend query-migrate to provide
 dirty page limit info
References: <168870305868.29142.5121604177475325995-8@git.sr.ht>
Date: Thu, 13 Jul 2023 14:45:56 +0200
In-Reply-To: <168870305868.29142.5121604177475325995-8@git.sr.ht>
 (hyman@git.sr.ht's message of "Thu, 08 Jun 2023 00:21:58 +0800")
Message-ID: <874jm8j7y3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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
> Extend query-migrate to provide throttle time and estimated
> ring full time with dirty-limit capability enabled, through which
> we can observe if dirty limit take effect during live migration.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 031832cde5..97f7d0fd3c 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -250,6 +250,18 @@
>  #     blocked.  Present and non-empty when migration is blocked.
>  #     (since 6.0)
>  #
> +# @dirty-limit-throttle-time-per-round: Maximum throttle time
> +#     (in microseconds) of virtual CPUs each dirty ring full round,
> +#     which shows how MigrationCapability dirty-limit affects the
> +#     guest during live migration. (since 8.1)

Two spaces after sentence-ending punctuation, please:

   #     guest during live migration.  (since 8.1)

Same below.

> +#
> +# @dirty-limit-ring-full-time: Estimated average dirty ring full
> +#     time (in microseconds) each dirty ring full round. The value
> +#     equals dirty ring memory size divided by average dirty page
> +#     rate of the virtual CPU, which can be used to observe the
> +#     average memory load of the virtual CPU indirectly. Note that
> +#     zero means guest doesn't dirty memory (since 8.1)

Last sentence should end with with a period.

Together:

   # @dirty-limit-throttle-time-per-round: Maximum throttle time (in
   #     microseconds) of virtual CPUs each dirty ring full round, which
   #     shows how MigrationCapability dirty-limit affects the guest
   #     during live migration.  (Since 8.1)
   #
   # @dirty-limit-ring-full-time: Estimated average dirty ring full time
   #     (in microseconds) each dirty ring full round.  The value equals
   #     dirty ring memory size divided by average dirty page rate of the
   #     virtual CPU, which can be used to observe the average memory
   #     load of the virtual CPU indirectly.  Note that zero means guest
   #     doesn't dirty memory.  (Since 8.1)

> +#
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

The issues I'm pointing out don't justfy yet another respin.  But if you
need to respin the series for some other reason, plase take care of them.


