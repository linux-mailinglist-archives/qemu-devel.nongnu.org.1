Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DC390EA93
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jun 2024 14:12:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJu9V-0001cb-FV; Wed, 19 Jun 2024 08:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJu9S-0001bO-UP
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 08:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJu9R-0001PJ-DX
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 08:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718799056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xzEHy9Lx0QkN79C+YBJdnpUx4fo3H3zijh18WueHhuQ=;
 b=NoAdZxZyeqIxm7B33r97LWP8y1ynE0rrLOVwYy8A2bHu9xCdUWulp+nqyG44DeD1V5TbSr
 CYZkm7272b9GbMUIwO2Dqw0Aoa6ckmJm8gMj25YFzO4hwX/wIaf5XTe1DbbMVVS/Fg+xVs
 dIrMvos8UKoaud7occFnMF2GMkJfLoo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-_4MxRVBCPpKX1hfMzEQZWA-1; Wed,
 19 Jun 2024 08:10:54 -0400
X-MC-Unique: _4MxRVBCPpKX1hfMzEQZWA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3666195609D; Wed, 19 Jun 2024 12:10:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 404C13000218; Wed, 19 Jun 2024 12:10:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1B21B21E6687; Wed, 19 Jun 2024 14:10:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Victor Toso de
 Carvalho <victortoso@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Marcel
 Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Fabiano Rosas <farosas@suse.de>,  Lukas
 Straub <lukasstraub2@web.de>,  Eduardo Habkost <eduardo@habkost.net>,
 Mads Ynddal <mads@ynddal.dk>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Peter Xu <peterx@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Jason
 Wang <jasowang@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,  Jiri Pirko <jiri@resnulli.us>,  Alex Williamson
 <alex.williamson@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH 08/13] qapi: ensure all errors sections are uniformly
 typset
In-Reply-To: <20240619003012.1753577-9-jsnow@redhat.com> (John Snow's message
 of "Tue, 18 Jun 2024 20:30:07 -0400")
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-9-jsnow@redhat.com>
Date: Wed, 19 Jun 2024 14:10:47 +0200
Message-ID: <87plsd16bc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> Transactions have the only instance of an Errors section that isn't a
> rST list; turn it into one.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Let;s explain the "why" a bit more clearly.  Maybe

    qapi: Nail down convention that Errors sections are lists

    By unstated convention, Errors sections are rST lists.  Document the
    convention, and make the one exception conform.

> ---
>  docs/devel/qapi-code-gen.rst | 7 +++++++
>  qapi/transaction.json        | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index f453bd35465..cee43222f19 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -1011,6 +1011,13 @@ like this::
>  "Returns" and "Errors" sections are only valid for commands.  They
>  document the success and the error response, respectively.
>  
> +"Errors" sections should be formatted as an rST list, each entry
> +detailing a relevant error condition. For example::
> +
> + # Errors:
> + #     - If @device does not exist, DeviceNotFound
> + #     - Any other error returns a GenericError.
> +
>  A "Since: x.y.z" tagged section lists the release that introduced the
>  definition.
>  
> diff --git a/qapi/transaction.json b/qapi/transaction.json
> index 5749c133d4a..07afc269d54 100644
> --- a/qapi/transaction.json
> +++ b/qapi/transaction.json
> @@ -235,7 +235,7 @@
>  #     additional detail.
>  #
>  # Errors:
> -#     Any errors from commands in the transaction
> +#     - Any errors from commands in the transaction
>  #
>  # Note: The transaction aborts on the first failure.  Therefore, there
>  #     will be information on only one failed operation returned in an

Preferably with an improved commit message
Reviewed-by: Markus Armbruster <armbru@redhat.com>


