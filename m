Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BEAA3BFC8
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Feb 2025 14:25:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkk4P-0000r6-Kj; Wed, 19 Feb 2025 08:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tkk4I-0000qD-Qt
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:24:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tkk4H-0000eD-4u
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739971488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OkLcJHoN+JI9oF265uxqijCqSV60CRrQH25gi1356/A=;
 b=H+RYlxMs7DfL+RTVWKwgzP4uic2CyXcbA8kUAYB6zI0wobo3zyFyOdw5z+0/AOluxSZpw6
 oitFt4Q1ShWPlJv18iNEKPJm98Nu3u89xuWMcZFlo3GuVVPggKiUSB0S7kD0eZ9oSmD4Ov
 3BQpPaZCdf8/eCOvFaxEfjdVHe+QSU4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-Xx6YDlPXPi-G3yoLx_Aizg-1; Wed,
 19 Feb 2025 08:24:45 -0500
X-MC-Unique: Xx6YDlPXPi-G3yoLx_Aizg-1
X-Mimecast-MFC-AGG-ID: Xx6YDlPXPi-G3yoLx_Aizg_1739971484
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6908218EAB3A; Wed, 19 Feb 2025 13:24:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7C751800947; Wed, 19 Feb 2025 13:24:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5720021E6A28; Wed, 19 Feb 2025 14:24:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] qapi/char.json: minor doc rewording for `hub` device
In-Reply-To: <20250219090607.559887-1-r.peniaev@gmail.com> (Roman Penyaev's
 message of "Wed, 19 Feb 2025 10:06:03 +0100")
References: <20250219090607.559887-1-r.peniaev@gmail.com>
Date: Wed, 19 Feb 2025 14:24:41 +0100
Message-ID: <87frka12zq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Roman Penyaev <r.peniaev@gmail.com> writes:

> Refine documentation for the hub device, specify the maximum.
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  qapi/char.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qapi/char.json b/qapi/char.json
> index f02b66c06b3e..dde2f9538f81 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -337,7 +337,7 @@
>  #
>  # Configuration info for hub chardevs.
>  #
> -# @chardevs: List of chardev IDs, which should be added to this hub
> +# @chardevs: IDs to be added to this hub (maximum 4 devices).
>  #
>  # Since: 10.0
>  ##

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thank you, Roman!


