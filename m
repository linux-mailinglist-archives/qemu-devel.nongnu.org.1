Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AAF7DDAF0
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 03:26:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy0uH-0006OS-03; Tue, 31 Oct 2023 22:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1qy0uF-0006O5-03
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 22:24:31 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1qy0uC-0007De-F4
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 22:24:30 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so89442566b.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 19:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698805465; x=1699410265; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JykctbLIqjznSk9poO/FFYEuTHHswdbcfuut5yZUzbQ=;
 b=MHimCqY1rc7Zt82Fu+UhbN3l6eZoRl0Oy8OgPQDUPLt0vpK/WSomHe9lunMJoUt5zT
 oRLmjGSHsem21NyAhNHcV/M39O93pmvkQ0rdWUPLLrpEve8WnuK/CxfIGonoRrGUAec7
 VU7Z2eD3zonML8J8aPfqsJCMVjppOvWexKWuNJl/xd4sGi0FxziT8WLFqWcVY4kKrQKx
 bA2Q8FazTGlfijryOYuTWmKWnv6goTjLhMPNeBiC+zXbWW2ZjuaC6BDhR5krtDiLX29x
 6f5uv/njnvJyaSbFWpfgt8lmeqAYk8ekrDazPCQLpj6VBRkG67SmeOLVnLdXG9fE8PJZ
 /nFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698805465; x=1699410265;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JykctbLIqjznSk9poO/FFYEuTHHswdbcfuut5yZUzbQ=;
 b=PZKz5XGJDBzT0AAhj8D3VncLjC9AVscxArvjLhOIvMMFdzHEKUrpM/GuqkuLa2BFh5
 43MGrAfcIDl1eFD13HFehOVfsWodx19PZnFi21YSL+qPKlJ7DdUX31jcDPM72u268BZd
 EvVpwPtb+5nxAnn+Uo1aW4o7jSIrydtYA5ZCo+HtLLsCmhvjFW3UbP5ZjvtVc0Yu4Jfr
 wFfIgTY2e+2u7jcXu1OCNDCMSAmbJ5qA1w5+CoodJJL/y1HZzOurq30LngDPvmJzz1P/
 gkBvpw1wah+FrlFGc1Lu0hMwobkoS3YGUaTvv9+GjINKO0lfKRENLUTcPVUELVd+9rw8
 +A3w==
X-Gm-Message-State: AOJu0YwRfiZTaI9jwyRWcKSTPOfAYcV78TkAJ9Rl9JK9/L1dwPkapnFL
 UygBS0r2a78q+M0LksbvIrFihTwIAE2IZ2EG4ko=
X-Google-Smtp-Source: AGHT+IHZKugDXiFGDLW0HewjhnWu2NdA937CCGBsgEjjusZbRUuqDzJ/W/EqO5BOgsK76AR+ztQZrqkoWRhY6MYu9Gw=
X-Received: by 2002:a17:906:ef09:b0:9bd:a5a9:34de with SMTP id
 f9-20020a170906ef0900b009bda5a934demr936603ejs.23.1698805465066; Tue, 31 Oct
 2023 19:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230730064057.357598-1-dinahbaum123@gmail.com>
 <20230730064057.357598-2-dinahbaum123@gmail.com> <87r0omzz78.fsf@pond.sub.org>
In-Reply-To: <87r0omzz78.fsf@pond.sub.org>
From: Dinah B <dinahbaum123@gmail.com>
Date: Tue, 31 Oct 2023 22:24:13 -0400
Message-ID: <CAH50XRd_7w1OzLpyBZt-MRL4HMA6_MoKg28qO3h65UU2Dt2uFw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] qapi: Moved architecture agnostic data types to
 `machine`
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>
Content-Type: multipart/alternative; boundary="00000000000049b27106090df8df"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=dinahbaum123@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--00000000000049b27106090df8df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed that qapi now has a machine-common category - do you think these
changes would be more appropriate in that file
rather than "machine" for the revision?

Thanks and sorry for the delay,
-Dinah

On Tue, Aug 1, 2023 at 9:09=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> Dinah Baum <dinahbaum123@gmail.com> writes:
>
> > Signed-off-by: Dinah Baum <dinahbaum123@gmail.com>
> > ---
> >  qapi/machine-target.json | 78 +---------------------------------------
> >  qapi/machine.json        | 77 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 78 insertions(+), 77 deletions(-)
> >
> > diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> > index f0a6b72414..3ee2f7ca6b 100644
> > --- a/qapi/machine-target.json
> > +++ b/qapi/machine-target.json
> > @@ -4,83 +4,7 @@
> >  # This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> >  # See the COPYING file in the top-level directory.
> >
> > -##
> > -# @CpuModelInfo:
> > -#
> > -# Virtual CPU model.
> > -#
> > -# A CPU model consists of the name of a CPU definition, to which delta
> > -# changes are applied (e.g. features added/removed). Most magic values
> > -# that an architecture might require should be hidden behind the name.
> > -# However, if required, architectures can expose relevant properties.
> > -#
> > -# @name: the name of the CPU definition the model is based on
> > -#
> > -# @props: a dictionary of QOM properties to be applied
> > -#
> > -# Since: 2.8
> > -##
> > -{ 'struct': 'CpuModelInfo',
> > -  'data': { 'name': 'str',
> > -            '*props': 'any' } }
> > -
> > -##
> > -# @CpuModelExpansionType:
> > -#
> > -# An enumeration of CPU model expansion types.
> > -#
> > -# @static: Expand to a static CPU model, a combination of a static
> > -#     base model name and property delta changes.  As the static base
> > -#     model will never change, the expanded CPU model will be the
> > -#     same, independent of QEMU version, machine type, machine
> > -#     options, and accelerator options.  Therefore, the resulting
> > -#     model can be used by tooling without having to specify a
> > -#     compatibility machine - e.g. when displaying the "host" model.
> > -#     The @static CPU models are migration-safe.
> > -#
> > -# @full: Expand all properties.  The produced model is not guaranteed
> > -#     to be migration-safe, but allows tooling to get an insight and
> > -#     work with model details.
> > -#
> > -# Note: When a non-migration-safe CPU model is expanded in static
> > -#     mode, some features enabled by the CPU model may be omitted,
> > -#     because they can't be implemented by a static CPU model
> > -#     definition (e.g. cache info passthrough and PMU passthrough in
> > -#     x86). If you need an accurate representation of the features
> > -#     enabled by a non-migration-safe CPU model, use @full.  If you
> > -#     need a static representation that will keep ABI compatibility
> > -#     even when changing QEMU version or machine-type, use @static
> > -#     (but keep in mind that some features may be omitted).
> > -#
> > -# Since: 2.8
> > -##
> > -{ 'enum': 'CpuModelExpansionType',
> > -  'data': [ 'static', 'full' ] }
> > -
> > -##
> > -# @CpuModelCompareResult:
> > -#
> > -# An enumeration of CPU model comparison results.  The result is
> > -# usually calculated using e.g. CPU features or CPU generations.
> > -#
> > -# @incompatible: If model A is incompatible to model B, model A is not
> > -#     guaranteed to run where model B runs and the other way around.
> > -#
> > -# @identical: If model A is identical to model B, model A is
> > -#     guaranteed to run where model B runs and the other way around.
> > -#
> > -# @superset: If model A is a superset of model B, model B is
> > -#     guaranteed to run where model A runs.  There are no guarantees
> > -#     about the other way.
> > -#
> > -# @subset: If model A is a subset of model B, model A is guaranteed to
> > -#     run where model B runs.  There are no guarantees about the other
> > -#     way.
> > -#
> > -# Since: 2.8
> > -##
> > -{ 'enum': 'CpuModelCompareResult',
> > -  'data': [ 'incompatible', 'identical', 'superset', 'subset' ] }
> > +{ 'include': 'machine.json' }
> >
> >  ##
> >  # @CpuModelBaselineInfo:
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index a08b6576ca..192c781310 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -1691,3 +1691,80 @@
> >  { 'command': 'dumpdtb',
> >    'data': { 'filename': 'str' },
> >    'if': 'CONFIG_FDT' }
> > +
> > +##
> > +# @CpuModelInfo:
> > +#
> > +# Virtual CPU model.
> > +#
> > +# A CPU model consists of the name of a CPU definition, to which delta
> > +# changes are applied (e.g. features added/removed). Most magic values
> > +# that an architecture might require should be hidden behind the name.
> > +# However, if required, architectures can expose relevant properties.
> > +#
> > +# @name: the name of the CPU definition the model is based on
> > +#
> > +# @props: a dictionary of QOM properties to be applied
> > +#
> > +# Since: 2.8
> > +##
> > +{ 'struct': 'CpuModelInfo',
> > +  'data': { 'name': 'str', '*props': 'any' } }
> > +
> > +##
> > +# @CpuModelExpansionType:
> > +#
> > +# An enumeration of CPU model expansion types.
> > +#
> > +# @static: Expand to a static CPU model, a combination of a static
> > +#     base model name and property delta changes.  As the static base
> > +#     model will never change, the expanded CPU model will be the
> > +#     same, independent of QEMU version, machine type, machine
> > +#     options, and accelerator options.  Therefore, the resulting
> > +#     model can be used by tooling without having to specify a
> > +#     compatibility machine - e.g. when displaying the "host" model.
> > +#     The @static CPU models are migration-safe.
> > +#
> > +# @full: Expand all properties.  The produced model is not guaranteed
> > +#     to be migration-safe, but allows tooling to get an insight and
> > +#     work with model details.
> > +#
> > +# Note: When a non-migration-safe CPU model is expanded in static
> > +#     mode, some features enabled by the CPU model may be omitted,
> > +#     because they can't be implemented by a static CPU model
> > +#     definition (e.g. cache info passthrough and PMU passthrough in
> > +#     x86). If you need an accurate representation of the features
> > +#     enabled by a non-migration-safe CPU model, use @full.  If you
> > +#     need a static representation that will keep ABI compatibility
> > +#     even when changing QEMU version or machine-type, use @static
> > +#     (but keep in mind that some features may be omitted).
> > +#
> > +# Since: 2.8
> > +##
> > +{ 'enum': 'CpuModelExpansionType',
> > +  'data': [ 'static', 'full' ] }
> > +
> > +##
> > +# @CpuModelCompareResult:
> > +#
> > +# An enumeration of CPU model comparison results.  The result is
> > +# usually calculated using e.g.  CPU features or CPU generations.
>
> Single space after e.g., please.
>
> > +#
> > +# @incompatible: If model A is incompatible to model B, model A is not
> > +#     guaranteed to run where model B runs and the other way around.
> > +#
> > +# @identical: If model A is identical to model B, model A is
> > +#     guaranteed to run where model B runs and the other way around.
> > +#
> > +# @superset: If model A is a superset of model B, model B is
> > +#     guaranteed to run where model A runs.  There are no guarantees
> > +#     about the other way.
> > +#
> > +# @subset: If model A is a subset of model B, model A is guaranteed to
> > +#     run where model B runs.  There are no guarantees about the other
> > +#     way.
> > +#
> > +# Since: 2.8
> > +##
> > +{ 'enum': 'CpuModelCompareResult',
> > +  'data': [ 'incompatible', 'identical', 'superset', 'subset' ] }
>
> With that
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
>

--00000000000049b27106090df8df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I noticed that qapi now =
has a machine-common category - do you think these changes would be more ap=
propriate in that file</div><div>rather than &quot;machine&quot; for the re=
vision?<br></div><div><br></div><div>Thanks and sorry for the delay,<br></d=
iv><div>-Dinah<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Aug 1, 2023 at 9:09=E2=80=AFAM Markus Armbr=
uster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Dinah Baum =
&lt;<a href=3D"mailto:dinahbaum123@gmail.com" target=3D"_blank">dinahbaum12=
3@gmail.com</a>&gt; writes:<br>
<br>
&gt; Signed-off-by: Dinah Baum &lt;<a href=3D"mailto:dinahbaum123@gmail.com=
" target=3D"_blank">dinahbaum123@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/machine-target.json | 78 +---------------------------------=
------<br>
&gt;=C2=A0 qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 77 ++++++++++++++=
+++++++++++++++++++++++++<br>
&gt;=C2=A0 2 files changed, 78 insertions(+), 77 deletions(-)<br>
&gt;<br>
&gt; diff --git a/qapi/machine-target.json b/qapi/machine-target.json<br>
&gt; index f0a6b72414..3ee2f7ca6b 100644<br>
&gt; --- a/qapi/machine-target.json<br>
&gt; +++ b/qapi/machine-target.json<br>
&gt; @@ -4,83 +4,7 @@<br>
&gt;=C2=A0 # This work is licensed under the terms of the GNU GPL, version =
2 or later.<br>
&gt;=C2=A0 # See the COPYING file in the top-level directory.<br>
&gt;=C2=A0 <br>
&gt; -##<br>
&gt; -# @CpuModelInfo:<br>
&gt; -#<br>
&gt; -# Virtual CPU model.<br>
&gt; -#<br>
&gt; -# A CPU model consists of the name of a CPU definition, to which delt=
a<br>
&gt; -# changes are applied (e.g. features added/removed). Most magic value=
s<br>
&gt; -# that an architecture might require should be hidden behind the name=
.<br>
&gt; -# However, if required, architectures can expose relevant properties.=
<br>
&gt; -#<br>
&gt; -# @name: the name of the CPU definition the model is based on<br>
&gt; -#<br>
&gt; -# @props: a dictionary of QOM properties to be applied<br>
&gt; -#<br>
&gt; -# Since: 2.8<br>
&gt; -##<br>
&gt; -{ &#39;struct&#39;: &#39;CpuModelInfo&#39;,<br>
&gt; -=C2=A0 &#39;data&#39;: { &#39;name&#39;: &#39;str&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*props&#39;: &#39;any&=
#39; } }<br>
&gt; -<br>
&gt; -##<br>
&gt; -# @CpuModelExpansionType:<br>
&gt; -#<br>
&gt; -# An enumeration of CPU model expansion types.<br>
&gt; -#<br>
&gt; -# @static: Expand to a static CPU model, a combination of a static<br=
>
&gt; -#=C2=A0 =C2=A0 =C2=A0base model name and property delta changes.=C2=
=A0 As the static base<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0model will never change, the expanded CPU model =
will be the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0same, independent of QEMU version, machine type,=
 machine<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0options, and accelerator options.=C2=A0 Therefor=
e, the resulting<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0model can be used by tooling without having to s=
pecify a<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0compatibility machine - e.g. when displaying the=
 &quot;host&quot; model.<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0The @static CPU models are migration-safe.<br>
&gt; -#<br>
&gt; -# @full: Expand all properties.=C2=A0 The produced model is not guara=
nteed<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0to be migration-safe, but allows tooling to get =
an insight and<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0work with model details.<br>
&gt; -#<br>
&gt; -# Note: When a non-migration-safe CPU model is expanded in static<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0mode, some features enabled by the CPU model may=
 be omitted,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0because they can&#39;t be implemented by a stati=
c CPU model<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0definition (e.g. cache info passthrough and PMU =
passthrough in<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0x86). If you need an accurate representation of =
the features<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0enabled by a non-migration-safe CPU model, use @=
full.=C2=A0 If you<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0need a static representation that will keep ABI =
compatibility<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0even when changing QEMU version or machine-type,=
 use @static<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0(but keep in mind that some features may be omit=
ted).<br>
&gt; -#<br>
&gt; -# Since: 2.8<br>
&gt; -##<br>
&gt; -{ &#39;enum&#39;: &#39;CpuModelExpansionType&#39;,<br>
&gt; -=C2=A0 &#39;data&#39;: [ &#39;static&#39;, &#39;full&#39; ] }<br>
&gt; -<br>
&gt; -##<br>
&gt; -# @CpuModelCompareResult:<br>
&gt; -#<br>
&gt; -# An enumeration of CPU model comparison results.=C2=A0 The result is=
<br>
&gt; -# usually calculated using e.g. CPU features or CPU generations.<br>
&gt; -#<br>
&gt; -# @incompatible: If model A is incompatible to model B, model A is no=
t<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0guaranteed to run where model B runs and the oth=
er way around.<br>
&gt; -#<br>
&gt; -# @identical: If model A is identical to model B, model A is<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0guaranteed to run where model B runs and the oth=
er way around.<br>
&gt; -#<br>
&gt; -# @superset: If model A is a superset of model B, model B is<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0guaranteed to run where model A runs.=C2=A0 Ther=
e are no guarantees<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0about the other way.<br>
&gt; -#<br>
&gt; -# @subset: If model A is a subset of model B, model A is guaranteed t=
o<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0run where model B runs.=C2=A0 There are no guara=
ntees about the other<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0way.<br>
&gt; -#<br>
&gt; -# Since: 2.8<br>
&gt; -##<br>
&gt; -{ &#39;enum&#39;: &#39;CpuModelCompareResult&#39;,<br>
&gt; -=C2=A0 &#39;data&#39;: [ &#39;incompatible&#39;, &#39;identical&#39;,=
 &#39;superset&#39;, &#39;subset&#39; ] }<br>
&gt; +{ &#39;include&#39;: &#39;machine.json&#39; }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @CpuModelBaselineInfo:<br>
&gt; diff --git a/qapi/machine.json b/qapi/machine.json<br>
&gt; index a08b6576ca..192c781310 100644<br>
&gt; --- a/qapi/machine.json<br>
&gt; +++ b/qapi/machine.json<br>
&gt; @@ -1691,3 +1691,80 @@<br>
&gt;=C2=A0 { &#39;command&#39;: &#39;dumpdtb&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;data&#39;: { &#39;filename&#39;: &#39;str&#39; },<br=
>
&gt;=C2=A0 =C2=A0 &#39;if&#39;: &#39;CONFIG_FDT&#39; }<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @CpuModelInfo:<br>
&gt; +#<br>
&gt; +# Virtual CPU model.<br>
&gt; +#<br>
&gt; +# A CPU model consists of the name of a CPU definition, to which delt=
a<br>
&gt; +# changes are applied (e.g. features added/removed). Most magic value=
s<br>
&gt; +# that an architecture might require should be hidden behind the name=
.<br>
&gt; +# However, if required, architectures can expose relevant properties.=
<br>
&gt; +#<br>
&gt; +# @name: the name of the CPU definition the model is based on<br>
&gt; +#<br>
&gt; +# @props: a dictionary of QOM properties to be applied<br>
&gt; +#<br>
&gt; +# Since: 2.8<br>
&gt; +##<br>
&gt; +{ &#39;struct&#39;: &#39;CpuModelInfo&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: { &#39;name&#39;: &#39;str&#39;, &#39;*props&#=
39;: &#39;any&#39; } }<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @CpuModelExpansionType:<br>
&gt; +#<br>
&gt; +# An enumeration of CPU model expansion types.<br>
&gt; +#<br>
&gt; +# @static: Expand to a static CPU model, a combination of a static<br=
>
&gt; +#=C2=A0 =C2=A0 =C2=A0base model name and property delta changes.=C2=
=A0 As the static base<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0model will never change, the expanded CPU model =
will be the<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0same, independent of QEMU version, machine type,=
 machine<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0options, and accelerator options.=C2=A0 Therefor=
e, the resulting<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0model can be used by tooling without having to s=
pecify a<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0compatibility machine - e.g. when displaying the=
 &quot;host&quot; model.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0The @static CPU models are migration-safe.<br>
&gt; +#<br>
&gt; +# @full: Expand all properties.=C2=A0 The produced model is not guara=
nteed<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0to be migration-safe, but allows tooling to get =
an insight and<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0work with model details.<br>
&gt; +#<br>
&gt; +# Note: When a non-migration-safe CPU model is expanded in static<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0mode, some features enabled by the CPU model may=
 be omitted,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0because they can&#39;t be implemented by a stati=
c CPU model<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0definition (e.g. cache info passthrough and PMU =
passthrough in<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0x86). If you need an accurate representation of =
the features<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0enabled by a non-migration-safe CPU model, use @=
full.=C2=A0 If you<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0need a static representation that will keep ABI =
compatibility<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0even when changing QEMU version or machine-type,=
 use @static<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0(but keep in mind that some features may be omit=
ted).<br>
&gt; +#<br>
&gt; +# Since: 2.8<br>
&gt; +##<br>
&gt; +{ &#39;enum&#39;: &#39;CpuModelExpansionType&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: [ &#39;static&#39;, &#39;full&#39; ] }<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @CpuModelCompareResult:<br>
&gt; +#<br>
&gt; +# An enumeration of CPU model comparison results.=C2=A0 The result is=
<br>
&gt; +# usually calculated using e.g.=C2=A0 CPU features or CPU generations=
.<br>
<br>
Single space after e.g., please.<br>
<br>
&gt; +#<br>
&gt; +# @incompatible: If model A is incompatible to model B, model A is no=
t<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0guaranteed to run where model B runs and the oth=
er way around.<br>
&gt; +#<br>
&gt; +# @identical: If model A is identical to model B, model A is<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0guaranteed to run where model B runs and the oth=
er way around.<br>
&gt; +#<br>
&gt; +# @superset: If model A is a superset of model B, model B is<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0guaranteed to run where model A runs.=C2=A0 Ther=
e are no guarantees<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0about the other way.<br>
&gt; +#<br>
&gt; +# @subset: If model A is a subset of model B, model A is guaranteed t=
o<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0run where model B runs.=C2=A0 There are no guara=
ntees about the other<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0way.<br>
&gt; +#<br>
&gt; +# Since: 2.8<br>
&gt; +##<br>
&gt; +{ &#39;enum&#39;: &#39;CpuModelCompareResult&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: [ &#39;incompatible&#39;, &#39;identical&#39;,=
 &#39;superset&#39;, &#39;subset&#39; ] }<br>
<br>
With that<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank">armbru@redhat.com</a>&gt;<br>
<br>
</blockquote></div>

--00000000000049b27106090df8df--

