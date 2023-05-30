Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F78715A51
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 11:38:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3vna-00067m-I1; Tue, 30 May 2023 05:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q3vnY-00067a-AT
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:37:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q3vnW-00010M-Kf
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685439465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2rsULGqXANf3umzD0Jm6rAqiGCqTw5JI5ad14SVX/0=;
 b=fnb2vTREMptOPi0OgeuVrSL1aRdi7UJg6Mot5a4fJUNdoKfjo9HjoeDgaeia1KUJXzdQZB
 Cp1ke/FsHmACZF54J//kIeSQIp7wA3EDSfDqBk8JL5NvkqlyGO+2cEcivk3fHf/vVHg2TI
 gC5yMgKVUOPWtxN3dc0u0O27MhKjkbQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-Agvbpfh4N16nAwPTvtJoCg-1; Tue, 30 May 2023 05:37:42 -0400
X-MC-Unique: Agvbpfh4N16nAwPTvtJoCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D65D33C0F423;
 Tue, 30 May 2023 09:37:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4423112132C;
 Tue, 30 May 2023 09:37:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A548D21E692E; Tue, 30 May 2023 11:37:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fei Wu <fei2.wu@intel.com>
Cc: richard.henderson@linaro.org,  alex.bennee@linaro.org,
 qemu-devel@nongnu.org,  "Vanderson M . do Rosario"
 <vandersonmr2@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v14 04/10] accel/tcg: add jit stats and time to
 TBStatistics
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-5-fei2.wu@intel.com>
Date: Tue, 30 May 2023 11:37:40 +0200
In-Reply-To: <20230530083526.2174430-5-fei2.wu@intel.com> (Fei Wu's message of
 "Tue, 30 May 2023 16:35:20 +0800")
Message-ID: <87sfbeqhwb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Fei Wu <fei2.wu@intel.com> writes:

> This collects all the statistics for TBStatistics, not only for the
> whole emulation but for each TB.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> ---
>  accel/tcg/monitor.c           |  20 ++++-
>  accel/tcg/tb-stats.c          | 146 ++++++++++++++++++++++++++++++++++
>  accel/tcg/tcg-accel-ops.c     |   7 ++
>  accel/tcg/translate-all.c     |  70 +++++++++++++++-
>  accel/tcg/translator.c        |   7 +-
>  include/exec/tb-stats-flags.h |   2 +
>  include/exec/tb-stats.h       |  46 +++++++++++
>  include/qemu/timer.h          |   6 ++
>  include/tcg/tcg.h             |  28 ++++++-
>  softmmu/runstate.c            |   9 +++
>  tcg/tcg.c                     |  88 ++++++++++++++++++--
>  tests/qtest/qmp-cmd-test.c    |   3 +
>  12 files changed, 417 insertions(+), 15 deletions(-)
>
> diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
> index e903dd1d2e..2bc87f2642 100644
> --- a/accel/tcg/monitor.c
> +++ b/accel/tcg/monitor.c
> @@ -15,6 +15,7 @@
>  #include "sysemu/cpus.h"
>  #include "sysemu/cpu-timers.h"
>  #include "sysemu/tcg.h"
> +#include "exec/tb-stats.h"
>  #include "internal.h"
>=20=20
>=20=20
> @@ -69,6 +70,11 @@ HumanReadableText *qmp_x_query_opcount(Error **errp)
>  {
>      g_autoptr(GString) buf =3D g_string_new("");
>=20=20
> +    if (!tb_stats_collection_enabled()) {
> +        error_setg(errp, "TB information not being recorded.");

From error_setg()'s contract in include/qapi/error.h:

     * The resulting message should be a single phrase, with no newline or
     * trailing punctuation.

Please drop the period.  Same elsewhere, not flagging it again there.

> +        return NULL;
> +    }
> +
>      if (!tcg_enabled()) {
>          error_setg(errp,
>                     "Opcode count information is only available with acce=
l=3Dtcg");
> @@ -80,11 +86,23 @@ HumanReadableText *qmp_x_query_opcount(Error **errp)
>      return human_readable_text_from_str(buf);
>  }
>=20=20
> +#ifdef CONFIG_TCG
> +HumanReadableText *qmp_x_query_profile(Error **errp)
> +{
> +    g_autoptr(GString) buf =3D g_string_new("");
> +
> +    dump_jit_exec_time_info(dev_time, buf);
> +    dev_time =3D 0;
> +
> +    return human_readable_text_from_str(buf);
> +}
> +#else
>  HumanReadableText *qmp_x_query_profile(Error **errp)
>  {
> -    error_setg(errp, "Internal profiler not compiled");
> +    error_setg(errp, "TCG should be enabled!");
>      return NULL;
>  }
> +#endif

machine.json has

   ##
   # @x-query-profile:
   #
   # Query TCG profiling information
   #
   # Features:
   #
   # @unstable: This command is meant for debugging.
   #
   # Returns: profile information
   #
   # Since: 6.2
   ##
   { 'command': 'x-query-profile',
     'returns': 'HumanReadableText',
     'if': 'CONFIG_TCG',
     'features': [ 'unstable' ] }

Not changed in this series.

Note the command is conditional on CONFIG_TCG, i.e. code generated for
it is #if defined(CONFIG_TCG).

The only other use is in hmp-commands-info.hx, and it is also guarded by
CONFIG_TCG.

Therefore, your #else is unreachable.  You can delete it along with...

>=20=20
>  static void hmp_tcg_register(void)
>  {

[...]

> diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
> index 73a670e8fa..749aafe4da 100644
> --- a/tests/qtest/qmp-cmd-test.c
> +++ b/tests/qtest/qmp-cmd-test.c
> @@ -46,6 +46,9 @@ static int query_error_class(const char *cmd)
>          { "query-balloon", ERROR_CLASS_DEVICE_NOT_ACTIVE },
>          { "query-hotpluggable-cpus", ERROR_CLASS_GENERIC_ERROR },
>          { "query-vm-generation-id", ERROR_CLASS_GENERIC_ERROR },
> +#ifndef CONFIG_TCG
> +        { "x-query-profile", ERROR_CLASS_GENERIC_ERROR },
> +#endif

... this entry.

>          /* Only valid with a USB bus added */
>          { "x-query-usb", ERROR_CLASS_GENERIC_ERROR },
>          /* Only valid with accel=3Dtcg */


