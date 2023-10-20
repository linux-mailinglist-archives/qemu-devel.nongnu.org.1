Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 542FF7D104B
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:09:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtpFa-0001kC-PL; Fri, 20 Oct 2023 09:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtpFW-0001jE-Ev
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:09:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtpFU-0006Qw-Pe
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697807348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pmm/qcdzPjzGFWUI595QLQHPribdZbfyTCDh4Sg46gI=;
 b=adFBf1JsU3tzyLEC/F84gAXDJiC0S0iMEoeDySt5uiNP2STBHY+tj2KmbTDiv0WUMUFR6z
 CtWEwd1xPnKkGuNhmg3PSS9F64jUDk5fVUssDGCGmikG9RRhDEYWRT1XGUhuxjnQk+cd+e
 fc0q5bLTMhr7/bzSJg2hbpDsdAZSVsY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-sWUXBc-_Mx-Mrc9BdmPafQ-1; Fri, 20 Oct 2023 09:08:55 -0400
X-MC-Unique: sWUXBc-_Mx-Mrc9BdmPafQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D64588B76F;
 Fri, 20 Oct 2023 13:08:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BEEE492BFB;
 Fri, 20 Oct 2023 13:08:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 175A521E6A1F; Fri, 20 Oct 2023 15:08:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,  qemu-s390x@nongnu.org,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 19/22] qapi: Inline and remove
 QERR_PROPERTY_VALUE_OUT_OF_RANGE definition
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-20-philmd@linaro.org>
Date: Fri, 20 Oct 2023 15:08:53 +0200
In-Reply-To: <20231005045041.52649-20-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Oct 2023 06:50:36
 +0200")
Message-ID: <8734y51lwa.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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
> Mechanical transformation using sed, manually
> removing the definition in include/qapi/qmp/qerror.h.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/qapi/qmp/qerror.h |  3 ---
>  hw/intc/openpic.c         |  3 ++-
>  target/i386/cpu.c         | 12 ++++++++----
>  util/block-helpers.c      |  3 ++-
>  4 files changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
> index 7862ac55a1..e094f13114 100644
> --- a/include/qapi/qmp/qerror.h
> +++ b/include/qapi/qmp/qerror.h
> @@ -17,9 +17,6 @@
>   * add new ones!
>   */
>=20=20
> -#define QERR_PROPERTY_VALUE_OUT_OF_RANGE \
> -    "Property %s.%s doesn't take value %" PRId64 " (minimum: %" PRId64 "=
, maximum: %" PRId64 ")"
> -
>  #define QERR_QGA_COMMAND_FAILED \
>      "Guest agent command failed, error was '%s'"
>=20=20
> diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
> index a6f91d4bcd..4f6ee930e2 100644
> --- a/hw/intc/openpic.c
> +++ b/hw/intc/openpic.c
> @@ -1535,7 +1535,8 @@ static void openpic_realize(DeviceState *dev, Error=
 **errp)
>      };
>=20=20
>      if (opp->nb_cpus > MAX_CPU) {
> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
> +        error_setg(errp, "Property %s.%s doesn't take value %" PRId64
> +                         " (minimum: %" PRId64 ", maximum: %" PRId64 ")",
>                     TYPE_OPENPIC, "nb_cpus", (uint64_t)opp->nb_cpus,
>                     (uint64_t)0, (uint64_t)MAX_CPU);
>          return;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index e5a14885ed..273f865228 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5086,7 +5086,8 @@ static void x86_cpuid_version_set_family(Object *ob=
j, Visitor *v,
>          return;
>      }
>      if (value < min || value > max) {
> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
> +        error_setg(errp, "Property %s doesn't take value %" PRId64
> +                         " (minimum: %" PRId64 ", maximum: %" PRId64 ")",
>                     name ? name : "null", value, min, max);
>          return;
>      }
> @@ -5126,7 +5127,8 @@ static void x86_cpuid_version_set_model(Object *obj=
, Visitor *v,
>          return;
>      }
>      if (value < min || value > max) {
> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
> +        error_setg(errp, "Property %s doesn't take value %" PRId64
> +                         " (minimum: %" PRId64 ", maximum: %" PRId64 ")",
>                     name ? name : "null", value, min, max);
>          return;
>      }
> @@ -5161,7 +5163,8 @@ static void x86_cpuid_version_set_stepping(Object *=
obj, Visitor *v,
>          return;
>      }
>      if (value < min || value > max) {
> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
> +        error_setg(errp, "Property %s doesn't take value %" PRId64
> +                         " (minimum: %" PRId64 ", maximum: %" PRId64 ")",
>                     name ? name : "null", value, min, max);
>          return;
>      }
> @@ -5263,7 +5266,8 @@ static void x86_cpuid_set_tsc_freq(Object *obj, Vis=
itor *v, const char *name,
>          return;
>      }
>      if (value < min || value > max) {
> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
> +        error_setg(errp, "Property %s doesn't take value %" PRId64
> +                         " (minimum: %" PRId64 ", maximum: %" PRId64 ")",
>                     name ? name : "null", value, min, max);
>          return;
>      }
> diff --git a/util/block-helpers.c b/util/block-helpers.c
> index c4851432f5..de94909bc4 100644
> --- a/util/block-helpers.c
> +++ b/util/block-helpers.c
> @@ -30,7 +30,8 @@ void check_block_size(const char *id, const char *name,=
 int64_t value,
>  {
>      /* value of 0 means "unset" */
>      if (value && (value < MIN_BLOCK_SIZE || value > MAX_BLOCK_SIZE)) {
> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,

Three callers:

* set_blocksize()

  Property setter.  Good.

* vu_blk_exp_create() and vduse_blk_exp_create()

  These check QMP arguments, i.e. *not* porperties.  Misuse of
  QERR_PROPERTY_VALUE_OUT_OF_RANGE.

> +        error_setg(errp, "Property %s.%s doesn't take value %" PRId64
> +                         " (minimum: %" PRId64 ", maximum: %" PRId64 ")",
>                     id, name, value, MIN_BLOCK_SIZE, MAX_BLOCK_SIZE);
>          return;
>      }


