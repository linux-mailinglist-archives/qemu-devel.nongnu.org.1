Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FA976B586
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 15:10:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQp8F-0004qF-K5; Tue, 01 Aug 2023 09:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qQp88-0004o2-Ki
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:09:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qQp86-0001Zx-E8
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690895376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E9hojDlcuOG0yxGnmcei6lekUN8Vo3o8JSLdfI32ORI=;
 b=V+j7PQYflrNl5jH00tg5Bgpljgj9pjLt/l+cJeVaWs0hCRsjDj7RgaiCuRt1pLGAJkpN3B
 0TIT+Upy8Y/2hCVUeGidyHrevLH/x/UjWGlK7vVyCdTMlTjMzoQpKzIMHz8YCAZOuEZn2F
 ZUnzyJ8PfigO9/tU1hsIIGjjk5mh61M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-pKBJM39_P2y9rQujRZI-yw-1; Tue, 01 Aug 2023 09:09:33 -0400
X-MC-Unique: pKBJM39_P2y9rQujRZI-yw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87B77857FF8;
 Tue,  1 Aug 2023 13:09:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 472B7F7855;
 Tue,  1 Aug 2023 13:09:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2CCB821E692A; Tue,  1 Aug 2023 15:09:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Dinah Baum <dinahbaum123@gmail.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>
Subject: Re: [PATCH v3 1/3] qapi: Moved architecture agnostic data types to
 `machine`
References: <20230730064057.357598-1-dinahbaum123@gmail.com>
 <20230730064057.357598-2-dinahbaum123@gmail.com>
Date: Tue, 01 Aug 2023 15:09:31 +0200
In-Reply-To: <20230730064057.357598-2-dinahbaum123@gmail.com> (Dinah Baum's
 message of "Sun, 30 Jul 2023 02:40:55 -0400")
Message-ID: <87r0omzz78.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
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

Dinah Baum <dinahbaum123@gmail.com> writes:

> Signed-off-by: Dinah Baum <dinahbaum123@gmail.com>
> ---
>  qapi/machine-target.json | 78 +---------------------------------------
>  qapi/machine.json        | 77 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+), 77 deletions(-)
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index f0a6b72414..3ee2f7ca6b 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -4,83 +4,7 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or later.
>  # See the COPYING file in the top-level directory.
>  
> -##
> -# @CpuModelInfo:
> -#
> -# Virtual CPU model.
> -#
> -# A CPU model consists of the name of a CPU definition, to which delta
> -# changes are applied (e.g. features added/removed). Most magic values
> -# that an architecture might require should be hidden behind the name.
> -# However, if required, architectures can expose relevant properties.
> -#
> -# @name: the name of the CPU definition the model is based on
> -#
> -# @props: a dictionary of QOM properties to be applied
> -#
> -# Since: 2.8
> -##
> -{ 'struct': 'CpuModelInfo',
> -  'data': { 'name': 'str',
> -            '*props': 'any' } }
> -
> -##
> -# @CpuModelExpansionType:
> -#
> -# An enumeration of CPU model expansion types.
> -#
> -# @static: Expand to a static CPU model, a combination of a static
> -#     base model name and property delta changes.  As the static base
> -#     model will never change, the expanded CPU model will be the
> -#     same, independent of QEMU version, machine type, machine
> -#     options, and accelerator options.  Therefore, the resulting
> -#     model can be used by tooling without having to specify a
> -#     compatibility machine - e.g. when displaying the "host" model.
> -#     The @static CPU models are migration-safe.
> -#
> -# @full: Expand all properties.  The produced model is not guaranteed
> -#     to be migration-safe, but allows tooling to get an insight and
> -#     work with model details.
> -#
> -# Note: When a non-migration-safe CPU model is expanded in static
> -#     mode, some features enabled by the CPU model may be omitted,
> -#     because they can't be implemented by a static CPU model
> -#     definition (e.g. cache info passthrough and PMU passthrough in
> -#     x86). If you need an accurate representation of the features
> -#     enabled by a non-migration-safe CPU model, use @full.  If you
> -#     need a static representation that will keep ABI compatibility
> -#     even when changing QEMU version or machine-type, use @static
> -#     (but keep in mind that some features may be omitted).
> -#
> -# Since: 2.8
> -##
> -{ 'enum': 'CpuModelExpansionType',
> -  'data': [ 'static', 'full' ] }
> -
> -##
> -# @CpuModelCompareResult:
> -#
> -# An enumeration of CPU model comparison results.  The result is
> -# usually calculated using e.g. CPU features or CPU generations.
> -#
> -# @incompatible: If model A is incompatible to model B, model A is not
> -#     guaranteed to run where model B runs and the other way around.
> -#
> -# @identical: If model A is identical to model B, model A is
> -#     guaranteed to run where model B runs and the other way around.
> -#
> -# @superset: If model A is a superset of model B, model B is
> -#     guaranteed to run where model A runs.  There are no guarantees
> -#     about the other way.
> -#
> -# @subset: If model A is a subset of model B, model A is guaranteed to
> -#     run where model B runs.  There are no guarantees about the other
> -#     way.
> -#
> -# Since: 2.8
> -##
> -{ 'enum': 'CpuModelCompareResult',
> -  'data': [ 'incompatible', 'identical', 'superset', 'subset' ] }
> +{ 'include': 'machine.json' }
>  
>  ##
>  # @CpuModelBaselineInfo:
> diff --git a/qapi/machine.json b/qapi/machine.json
> index a08b6576ca..192c781310 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1691,3 +1691,80 @@
>  { 'command': 'dumpdtb',
>    'data': { 'filename': 'str' },
>    'if': 'CONFIG_FDT' }
> +
> +##
> +# @CpuModelInfo:
> +#
> +# Virtual CPU model.
> +#
> +# A CPU model consists of the name of a CPU definition, to which delta
> +# changes are applied (e.g. features added/removed). Most magic values
> +# that an architecture might require should be hidden behind the name.
> +# However, if required, architectures can expose relevant properties.
> +#
> +# @name: the name of the CPU definition the model is based on
> +#
> +# @props: a dictionary of QOM properties to be applied
> +#
> +# Since: 2.8
> +##
> +{ 'struct': 'CpuModelInfo',
> +  'data': { 'name': 'str', '*props': 'any' } }
> +
> +##
> +# @CpuModelExpansionType:
> +#
> +# An enumeration of CPU model expansion types.
> +#
> +# @static: Expand to a static CPU model, a combination of a static
> +#     base model name and property delta changes.  As the static base
> +#     model will never change, the expanded CPU model will be the
> +#     same, independent of QEMU version, machine type, machine
> +#     options, and accelerator options.  Therefore, the resulting
> +#     model can be used by tooling without having to specify a
> +#     compatibility machine - e.g. when displaying the "host" model.
> +#     The @static CPU models are migration-safe.
> +#
> +# @full: Expand all properties.  The produced model is not guaranteed
> +#     to be migration-safe, but allows tooling to get an insight and
> +#     work with model details.
> +#
> +# Note: When a non-migration-safe CPU model is expanded in static
> +#     mode, some features enabled by the CPU model may be omitted,
> +#     because they can't be implemented by a static CPU model
> +#     definition (e.g. cache info passthrough and PMU passthrough in
> +#     x86). If you need an accurate representation of the features
> +#     enabled by a non-migration-safe CPU model, use @full.  If you
> +#     need a static representation that will keep ABI compatibility
> +#     even when changing QEMU version or machine-type, use @static
> +#     (but keep in mind that some features may be omitted).
> +#
> +# Since: 2.8
> +##
> +{ 'enum': 'CpuModelExpansionType',
> +  'data': [ 'static', 'full' ] }
> +
> +##
> +# @CpuModelCompareResult:
> +#
> +# An enumeration of CPU model comparison results.  The result is
> +# usually calculated using e.g.  CPU features or CPU generations.

Single space after e.g., please.

> +#
> +# @incompatible: If model A is incompatible to model B, model A is not
> +#     guaranteed to run where model B runs and the other way around.
> +#
> +# @identical: If model A is identical to model B, model A is
> +#     guaranteed to run where model B runs and the other way around.
> +#
> +# @superset: If model A is a superset of model B, model B is
> +#     guaranteed to run where model A runs.  There are no guarantees
> +#     about the other way.
> +#
> +# @subset: If model A is a subset of model B, model A is guaranteed to
> +#     run where model B runs.  There are no guarantees about the other
> +#     way.
> +#
> +# Since: 2.8
> +##
> +{ 'enum': 'CpuModelCompareResult',
> +  'data': [ 'incompatible', 'identical', 'superset', 'subset' ] }

With that
Reviewed-by: Markus Armbruster <armbru@redhat.com>


