Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA077D0A9A
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 10:35:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtkxX-0000IK-6Q; Fri, 20 Oct 2023 04:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtkxI-00008Z-Oj
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:34:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtkxH-0002oZ-8Z
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697790842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ExjKUgn7axteSCEOabWgquodqKYCjk/OCBBPC9x63g4=;
 b=JWPKZBw80TXiLeS2g4vPUQL8/4tcTUryceENRk5cZfNwuKxmfBTatpaENeHH1UyhBYxuUt
 1tiH5KDVlDI1S3ZGKOEroOgUnnMbD2B2WrjM8Oci5lm4/G/xT/mBAWfOxOH9Z2pHW1EwSt
 sCOCr4j1/BKw4bmtld7T4k4R2dYLswI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-Esz6OVCDNQuLDrNUykpu6Q-1; Fri, 20 Oct 2023 04:33:51 -0400
X-MC-Unique: Esz6OVCDNQuLDrNUykpu6Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE61088D023;
 Fri, 20 Oct 2023 08:33:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C3568CEF;
 Fri, 20 Oct 2023 08:33:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9433A21E6A1F; Fri, 20 Oct 2023 10:33:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,  qemu-s390x@nongnu.org,  Juan Quintela
 <quintela@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH v2 10/22] qapi: Correct error message for
 'vcpu_dirty_limit' parameter
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-11-philmd@linaro.org>
Date: Fri, 20 Oct 2023 10:33:49 +0200
In-Reply-To: <20231005045041.52649-11-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Oct 2023 06:50:27
 +0200")
Message-ID: <875y318zgy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> QERR_INVALID_PARAMETER_VALUE is defined as:
>
>   #define QERR_INVALID_PARAMETER_VALUE \
>       "Parameter '%s' expects %s"
>
> The current error is formatted as:
>
>   "Parameter 'vcpu_dirty_limit' expects is invalid, it must greater then =
1 MB/s"
>
> Replace by:
>
>   "Parameter 'vcpu_dirty_limit' is invalid, it must greater then 1 MB/s"
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  migration/options.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/migration/options.c b/migration/options.c
> index 1d1e1321b0..79fce0c3a9 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1163,9 +1163,8 @@ bool migrate_params_check(MigrationParameters *para=
ms, Error **errp)
>=20=20
>      if (params->has_vcpu_dirty_limit &&
>          (params->vcpu_dirty_limit < 1)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "vcpu_dirty_limit",
> -                   "is invalid, it must greater then 1 MB/s");
> +        error_setg(errp, "Parameter 'vcpu_dirty_limit' is invalid,"
> +                         " it must greater then 1 MB/s");
>          return false;
>      }

Make that "greater than", please.

Arrgh, the unit is MB/s even in QMP:

    # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
    #     Defaults to 1.  (Since 8.1)

Should be Bytes.  Escaped review, and now it's too late to fix.


