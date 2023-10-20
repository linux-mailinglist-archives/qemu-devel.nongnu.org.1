Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C61B57D094A
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 09:19:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtjmE-0002fl-7R; Fri, 20 Oct 2023 03:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtjly-0002aW-NN
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtjlw-0002cM-So
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697786296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BHNx2oGqo2h+C7htmK4wjJWDS9SWxiXaCc5HOS5trw=;
 b=K4240XmJeDr3Kuu7UPqEIUzEcyFTCThOginpGGe2PjXN2aXposZgXsdY19FvCgb7rbxFsS
 /X8Q1W1eEQeHR/RCemxIdm4LVBAAlUdqFKWecEcpoKPnq6oJrZRPnAYysen0NnjTds8rbL
 FQxtOKXzqwrSLz0evCp11GCfVKVJw9I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-GENI1ZWbNtSEPUb0aXpq6w-1; Fri, 20 Oct 2023 03:18:12 -0400
X-MC-Unique: GENI1ZWbNtSEPUb0aXpq6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 279343806655;
 Fri, 20 Oct 2023 07:18:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 037FC10828;
 Fri, 20 Oct 2023 07:18:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C8B9821E6A1F; Fri, 20 Oct 2023 09:18:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,  qemu-s390x@nongnu.org,  Thomas Huth
 <thuth@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Richard
 Henderson <richard.henderson@linaro.org>,  David Hildenbrand
 <david@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v2 07/22] qapi: Inline QERR_INVALID_PARAMETER_TYPE
 definition (constant param)
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-8-philmd@linaro.org>
Date: Fri, 20 Oct 2023 09:18:09 +0200
In-Reply-To: <20231005045041.52649-8-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Oct 2023 06:50:24
 +0200")
Message-ID: <87mswd92z2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Address the comment added in commit 4629ed1e98
> ("qerror: Finally unused, clean up"), from 2015:
>
>   /*
>    * These macros will go away, please don't use
>    * in new code, and do not add new ones!
>    */
>
> Mechanical transformation using the following
> coccinelle semantic patch:
>
>     @match@
>     expression errp;
>     constant param;
>     constant value;
>     @@
>          error_setg(errp, QERR_INVALID_PARAMETER_TYPE, param, value);
>
>     @script:python strformat depends on match@
>     param << match.param;
>     value << match.value;
>     fixedfmt; // new var
>     @@
>     fixedfmt =3D f'"Invalid parameter type for \'{param[1:-1]}\', expecte=
d: {value[1:-1]}"'
>     coccinelle.fixedfmt =3D cocci.make_ident(fixedfmt)
>
>     @replace@
>     expression match.errp;
>     constant match.param;
>     constant match.value;
>     identifier strformat.fixedfmt;
>     @@
>     -    error_setg(errp, QERR_INVALID_PARAMETER_TYPE, param, value);
>     +    error_setg(errp, fixedfmt);
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Acked-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/arm/arm-qmp-cmds.c        | 3 ++-
>  target/s390x/cpu_models_sysemu.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> index b53d5efe13..3c99fd8222 100644
> --- a/target/arm/arm-qmp-cmds.c
> +++ b/target/arm/arm-qmp-cmds.c
> @@ -154,7 +154,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(=
CpuModelExpansionType type,
>      if (model->props) {
>          qdict_in =3D qobject_to(QDict, model->props);
>          if (!qdict_in) {
> -            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict=
");
> +            error_setg(errp,
> +                       "Invalid parameter type for 'props', expected: di=
ct");
>              return NULL;
>          }
>      }
> diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_s=
ysemu.c
> index 63981bf36b..4507714493 100644
> --- a/target/s390x/cpu_models_sysemu.c
> +++ b/target/s390x/cpu_models_sysemu.c
> @@ -111,7 +111,8 @@ static void cpu_model_from_info(S390CPUModel *model, =
const CpuModelInfo *info,
>      if (info->props) {
>          qdict =3D qobject_to(QDict, info->props);
>          if (!qdict) {
> -            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict=
");
> +            error_setg(errp,
> +                       "Invalid parameter type for 'props', expected: di=
ct");
>              return;
>          }
>      }

The error messages are awful.  Your patch makes their awfulness more
visible.  Improvement of sorts ;)


