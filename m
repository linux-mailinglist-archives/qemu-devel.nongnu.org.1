Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 996B4ABD0AF
	for <lists+qemu-devel@lfdr.de>; Tue, 20 May 2025 09:43:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHHbz-0006TN-Df; Tue, 20 May 2025 03:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHHbx-0006T4-FU
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHHbw-0004av-18
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747726921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wGZ3oSp2yk5EwWntgFA6An2Do40x8SJztBd3l1opZpg=;
 b=VxiL9gNjJclyivfM2IUsKqPs0Hna8mW4h0EvXJNfhRcl1LecbuHln3R+/V+f4mfCXcdJn7
 Ltk2kTyMKSAaD/pIro1o4JVmLeKBdJFr+4r7BBfEDPUSei+sdrQEbbOkpFGlwGu/0j2B4r
 7oOkLrbHoq9RQ/KJRiokkXTORKdlABg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-fIurx1_zNuiz0Q1KltGFIQ-1; Tue,
 20 May 2025 03:42:00 -0400
X-MC-Unique: fIurx1_zNuiz0Q1KltGFIQ-1
X-Mimecast-MFC-AGG-ID: fIurx1_zNuiz0Q1KltGFIQ_1747726919
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68F81195608C; Tue, 20 May 2025 07:41:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6718219560A3; Tue, 20 May 2025 07:41:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CC32821E6768; Tue, 20 May 2025 09:41:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,  Hanna Reitz
 <hreitz@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  qemu-rust@nongnu.org,
 Maksim Davydov <davydov-max@yandex-team.ru>,  Cleber Rosa
 <crosa@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 2/8] python: update pylint ignores
In-Reply-To: <20250519182153.3835722-3-jsnow@redhat.com> (John Snow's message
 of "Mon, 19 May 2025 14:21:46 -0400")
References: <20250519182153.3835722-1-jsnow@redhat.com>
 <20250519182153.3835722-3-jsnow@redhat.com>
Date: Tue, 20 May 2025 09:41:54 +0200
Message-ID: <875xhvd8zh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

John Snow <jsnow@redhat.com> writes:

> The next patch will synchronize the qemu.qmp library with the external,
> standalone version. That synchronization will require a few extra
> ignores for pylint, so do that now.

Just one, unless I'm cross-eyed again.

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/setup.cfg | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/python/setup.cfg b/python/setup.cfg
> index d7f5dc7bafe..02cc076eaea 100644
> --- a/python/setup.cfg
> +++ b/python/setup.cfg
> @@ -140,11 +140,12 @@ ignore_missing_imports = True
>  # --disable=W".
>  disable=consider-using-f-string,
>          consider-using-with,
> +        no-member,  # mypy also handles this better.
>          too-many-arguments,
> -        too-many-positional-arguments,
>          too-many-function-args,  # mypy handles this with less false positives.
>          too-many-instance-attributes,
> -        no-member,  # mypy also handles this better.
> +        too-many-positional-arguments,

Up to here, just a reorder, which I appreciate.

> +        unknown-option-value,

This is the new one.

>  
>  [pylint.basic]
>  # Good variable names which should always be accepted, separated by a comma.


