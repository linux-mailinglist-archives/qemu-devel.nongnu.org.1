Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D87710B2F
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:37:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q29Gs-00017z-VA; Thu, 25 May 2023 07:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q29Gr-00017M-J8
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q29Gp-0002x9-MD
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685014599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=95CI5G91yHzJVFT+7YAll4Uf7RyybhS1rDwxrhQ8Vl8=;
 b=WXzm5Ci0WD2DK88ba3okoKx4YCtOezXfNKT3f/ijpYp81JxeSMwkilhQjFIUZ5ialncv5o
 1SPHRAsM5y+/Ht0irubTMOQTh6K7mEt1CbxE7KNDjhQW298fRov76YBDPI/cZcE8xfVLVD
 kUdlG7U9Gj/TRAH+d081tizKZp6N+VQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-3dWmyY02N92C_7spj71npQ-1; Thu, 25 May 2023 07:36:34 -0400
X-MC-Unique: 3dWmyY02N92C_7spj71npQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E30A1C07850;
 Thu, 25 May 2023 11:36:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 386A0492B0C;
 Thu, 25 May 2023 11:36:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 452C521E692E; Thu, 25 May 2023 13:36:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,  qemu-devel@nongnu.org,  Kyle
 Evans <kevans@freebsd.org>,  libvir-list@redhat.com,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Greg Kurz
 <groug@kaod.org>,  Eric
 Blake <eblake@redhat.com>,  Warner Losh <imp@bsdimp.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Michael Roth <michael.roth@amd.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Christian Schoenebeck
 <qemu_oss@crudebyte.com>,  Riku Voipio <riku.voipio@iki.fi>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v5 05/10] qapi: make the vcpu parameters deprecated for 8.1
References: <20230524133952.3971948-1-alex.bennee@linaro.org>
 <20230524133952.3971948-6-alex.bennee@linaro.org>
Date: Thu, 25 May 2023 13:36:32 +0200
In-Reply-To: <20230524133952.3971948-6-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Wed, 24 May 2023 14:39:47 +0100")
Message-ID: <87353kskvz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> I don't think I can remove the parameters directly but certainly mark
> them as deprecated.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20230523125000.3674739-6-alex.bennee@linaro.org>
>
> ---
> v5
>   - reword match description
>   - fix reference to return for set operation
> ---
>  docs/about/deprecated.rst |  9 +++++++++
>  qapi/trace.json           | 40 +++++++++++++++++----------------------
>  2 files changed, 26 insertions(+), 23 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index e934e0a13a..e44cde057f 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -254,6 +254,15 @@ it. Since all recent x86 hardware from the past >10 =
years is capable of the
>  QEMU API (QAPI) events
>  ----------------------

Not this patch's fault: the headline should be "QEMU Machine Protocol
(QMP) events".  The section should directly follow section "QEMU Machine
Protocol (QMP) commands".

I'd go one step farther, and fuse the two sections under the heading
"QEMU Machine Protocol (QMP)".

>=20=20
> +``vcpu`` trace events (since 8.1)
> +'''''''''''''''''''''''''''''''''
> +
> +The ability to instrument QEMU helper functions with vcpu aware trace

Should this be "vCPU-aware"?

> +points was removed in 7.0. However the QAPI still exposed the vcpu

s/the QAPI/QMP/

> +parameter. This argument has now been deprecated and the remaining
> +used trace points converted to plain trace points selected just by

"remaining trace points that used it"?

> +name.
> +
>  ``MEM_UNPLUG_ERROR`` (since 6.2)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>=20=20
> diff --git a/qapi/trace.json b/qapi/trace.json
> index 6bf0af0946..e561f3d3da 100644
> --- a/qapi/trace.json
> +++ b/qapi/trace.json
> @@ -37,13 +37,14 @@
>  #
>  # @vcpu: Whether this is a per-vCPU event (since 2.7).
>  #
> -# An event is per-vCPU if it has the "vcpu" property in the
> -# "trace-events" files.
> +# Features:
> +# @deprecated: Member @vcpu is deprecated, and always false.
>  #
>  # Since: 2.2
>  ##
>  { 'struct': 'TraceEventInfo',
> -  'data': {'name': 'str', 'state': 'TraceEventState', 'vcpu': 'bool'} }
> +  'data': {'name': 'str', 'state': 'TraceEventState',
> +           'vcpu': { 'type': 'bool', 'features': ['deprecated'] } } }
>=20=20
>  ##
>  # @trace-event-get-state:
> @@ -52,19 +53,15 @@
>  #
>  # @name: Event name pattern (case-sensitive glob).
>  #
> -# @vcpu: The vCPU to query (any by default; since 2.7).
> +# @vcpu: The vCPU to query (since 2.7).
>  #
> -# Returns: a list of @TraceEventInfo for the matching events
> -#
> -# An event is returned if:
> +# Features:
> +# @deprecated: Member @vcpu is deprecated, and always false.

This isn't quite right: parameter @vcpu cannot be false, it's int.

I figure specifying the parameter makes no sense anymore, because if you
do, the command will return an empty list.  Correct?

>  #
> -# - its name matches the @name pattern, and
> -# - if @vcpu is given, the event has the "vcpu" property.
> +# Returns: a list of @TraceEventInfo for the matching events
>  #
> -# Therefore, if @vcpu is given, the operation will only match per-vCPU
> -# events, returning their state on the specified vCPU. Special case:
> -# if @name is an exact match, @vcpu is given and the event does not
> -# have the "vcpu" property, an error is returned.
> +# An event is returned if its name matches the @name pattern
> +# (There are no longer any per-vCPU events).
>  #
>  # Since: 2.2
>  #
> @@ -75,7 +72,8 @@
>  # <- { "return": [ { "name": "qemu_memalign", "state": "disabled", "vcpu=
": false } ] }
>  ##
>  { 'command': 'trace-event-get-state',
> -  'data': {'name': 'str', '*vcpu': 'int'},
> +  'data': {'name': 'str',
> +           '*vcpu': {'type': 'int', 'features': ['deprecated'] } },
>    'returns': ['TraceEventInfo'] }
>=20=20
>  ##
> @@ -91,15 +89,11 @@
>  #
>  # @vcpu: The vCPU to act upon (all by default; since 2.7).
>  #
> -# An event's state is modified if:
> -#
> -# - its name matches the @name pattern, and
> -# - if @vcpu is given, the event has the "vcpu" property.
> +# Features:
> +# @deprecated: Member @vcpu is deprecated, and always false.

Again, parameter @vcpu cannot be false.

What happens when you use it?

>  #
> -# Therefore, if @vcpu is given, the operation will only match per-vCPU
> -# events, setting their state on the specified vCPU. Special case: if
> -# @name is an exact match, @vcpu is given and the event does not have
> -# the "vcpu" property, an error is returned.
> +# An event is enabled if its name matches the @name pattern
> +# (There are no longer any per-vCPU events).
>  #
>  # Since: 2.2
>  #
> @@ -111,4 +105,4 @@
>  ##
>  { 'command': 'trace-event-set-state',
>    'data': {'name': 'str', 'enable': 'bool', '*ignore-unavailable': 'bool=
',
> -           '*vcpu': 'int'} }
> +           '*vcpu': {'type': 'int', 'features': ['deprecated'] } } }


