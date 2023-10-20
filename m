Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8647D7D102F
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:02:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtp8J-0006BK-KI; Fri, 20 Oct 2023 09:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtp7K-00063V-8g
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:00:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtp7C-0004TI-VX
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697806832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NJIySRtNCp38Hmx09wCIFor1YWd+eY+vcX31qBpyLp0=;
 b=cvFX13Zx5bws7X7cW0VKZK3GnqCrzJwZ0NQNlmbIypvAi79hN+G90n9YubxpgJtHmBQjp9
 j5whdoIwq1nMFIHT/dM1HUunQVCyIt/uvZPNMeL4ENmCGSVRaL6GRWmJPCscrK5vwOy8jV
 LCBpV+wvZ1Pu37TRM7CN8racfeAO9jE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-D872OM3kM-2XaiD9O6Aqbg-1; Fri, 20 Oct 2023 09:00:25 -0400
X-MC-Unique: D872OM3kM-2XaiD9O6Aqbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 904BF81156E;
 Fri, 20 Oct 2023 13:00:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D1861C060B1;
 Fri, 20 Oct 2023 13:00:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 807B021E6A1F; Fri, 20 Oct 2023 15:00:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,  qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH v2 18/22] qapi: Inline and remove
 QERR_PROPERTY_VALUE_BAD definition
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-19-philmd@linaro.org>
Date: Fri, 20 Oct 2023 15:00:23 +0200
In-Reply-To: <20231005045041.52649-19-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Oct 2023 06:50:35
 +0200")
Message-ID: <87bkct1mag.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

> Address the comment added in commit 4629ed1e98
> ("qerror: Finally unused, clean up"), from 2015:
>
>   /*
>    * These macros will go away, please don't use
>    * in new code, and do not add new ones!
>    */
>
> Manual change. Remove the definition in
> include/qapi/qmp/qerror.h.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/qapi/qmp/qerror.h | 3 ---
>  hw/core/qdev-properties.c | 2 +-
>  target/i386/cpu.c         | 2 +-
>  3 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
> index b0f48f22fe..7862ac55a1 100644
> --- a/include/qapi/qmp/qerror.h
> +++ b/include/qapi/qmp/qerror.h
> @@ -17,9 +17,6 @@
>   * add new ones!
>   */
>=20=20
> -#define QERR_PROPERTY_VALUE_BAD \
> -    "Property '%s.%s' doesn't take value '%s'"
> -
>  #define QERR_PROPERTY_VALUE_OUT_OF_RANGE \
>      "Property %s.%s doesn't take value %" PRId64 " (minimum: %" PRId64 "=
, maximum: %" PRId64 ")"
>=20=20
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 357b8761b5..44fc1686e0 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -682,7 +682,7 @@ void error_set_from_qdev_prop_error(Error **errp, int=
 ret, Object *obj,
>          break;
>      default:
>      case -EINVAL:
> -        error_setg(errp, QERR_PROPERTY_VALUE_BAD,
> +        error_setg(errp, "Property '%s.%s' doesn't take value '%s'",
>                     object_get_typename(obj), name, value);
>          break;
>      case -ENOENT:
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ed72883bf3..e5a14885ed 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5190,7 +5190,7 @@ static void x86_cpuid_set_vendor(Object *obj, const=
 char *value,
>      int i;
>=20=20
>      if (strlen(value) !=3D CPUID_VENDOR_SZ) {
> -        error_setg(errp, QERR_PROPERTY_VALUE_BAD, "", "vendor", value);

Reporting the actual problem would be better: we need the value to be
exactly CPUID_VENDOR_SZ characters long.

> +        error_setg(errp, "Property 'vendor' doesn't take value '%s'", va=
lue);
>          return;
>      }


