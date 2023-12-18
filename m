Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF67817065
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 14:26:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFDcX-0005F3-Pb; Mon, 18 Dec 2023 08:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rFDcS-0005B0-1O
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 08:25:16 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rFDcP-0004QW-7o
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 08:25:15 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c9f099cf3aso40681431fa.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 05:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702905909; x=1703510709;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OABC8VWh8fzgJWe/K/eAN3t3SjyvwYVdVOOuFMTacGs=;
 b=kWDZZqSpODRavn3yf3SIpOj9hNmI/puFFYW3SWQST+vFaquwkLSgniGUXEgJ1/uENc
 ugpOvgfR1PaFT0LYosG0eNANfZvCB9zdXl7pk82sVIewtJMIyRtfAr7g3dLsfghHZ2WT
 WoLIq8V56toLbeSCoHx2eDB6UAczwnDt2bXmlUcjGfN90/QEFtVWafWXDfB9JYHule4n
 tdgSozfpTXxI3bLGDo/W1EVBvRCtqvgbXLSjOF/S3JpGEzT3HtJqlkNdw8+9VIftNa/g
 e4H338ciUsyIVqJqylFDZvHY1Qklh6px3RWKYWm9ChKIotpuK8dgx9IYX0E7+Mr4DGV5
 hGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702905909; x=1703510709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OABC8VWh8fzgJWe/K/eAN3t3SjyvwYVdVOOuFMTacGs=;
 b=NLIxl9m8WI83DtA09ukj86aKNztBS2gRjUxDsaxC15tDtTLAhNzTzOgcYRdWt6O9id
 D8XRlefFtE8K5WD/8gvq3yVseim+QtO+Or2HV+ih44NbGZSApKB37bsU8Bm1yZDw+AaC
 jZ5gNAzmnesDXRBVxkTofn3X0Te/5g5JXIWyRiOyywfgAJldSKBsi+md4f8738nSEVPV
 5f0BQ58Izz4+Wh3d8+oQbb+so0PajvfqCv0V1bhAeiNLg7z0QuUxgUFcpQxMvK4RsNoH
 T0qKFHVN8sSBBRCfgjmLD6Gr5yx26vJW2YKaJjgbQcJyvUnKocfnJ7zv7aLJ3aNQaFfl
 IdmQ==
X-Gm-Message-State: AOJu0YzXG9G78dT2pYCA+bF67mWbJuAUpisQFU5x4nxQMIMiA30SZdyd
 9AxP1t6wQWJLySX2Uog8sxQoQK0i/OmMm/Wjd6HoTA==
X-Google-Smtp-Source: AGHT+IHvrEHBR62GuRxM+hfr6+oxCnVtj0lsSvfiuHjgjj9GopUXCrylCVFuc8tlW84RPfgPO8iLlsX8oWt3T/zppPc=
X-Received: by 2002:a2e:808d:0:b0:2cc:575b:db55 with SMTP id
 i13-20020a2e808d000000b002cc575bdb55mr1974549ljg.65.1702905909488; Mon, 18
 Dec 2023 05:25:09 -0800 (PST)
MIME-Version: 1.0
References: <20230831065140.496485-1-andrew@daynix.com>
 <20230831065140.496485-5-andrew@daynix.com>
 <874jgfu0wj.fsf@pond.sub.org>
In-Reply-To: <874jgfu0wj.fsf@pond.sub.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 18 Dec 2023 15:24:57 +0200
Message-ID: <CAOEp5Oc+6T7yiH2qdO=ZPyDn+d4gO+4KZXmxcRU7DoO3BabPPA@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] qmp: Added new command to retrieve eBPF blob.
To: Markus Armbruster <armbru@redhat.com>
Cc: Andrew Melnychenko <andrew@daynix.com>, jasowang@redhat.com, mst@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org, berrange@redhat.com, yan@daynix.com
Content-Type: multipart/alternative; boundary="000000000000d24006060cc8ad05"
Received-SPF: none client-ip=2a00:1450:4864:20::22f;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--000000000000d24006060cc8ad05
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 2:54=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Uh, I missed this one, my apologies!  Let me have a quick look...
>
> Commit message style nitpick:
>
>     qmp: Add command to retrieve eBPF blob
>
> or
>
>     qmp: New command to retrieve eBPF blob
>
> It's a title, not a sentence.
>
> Andrew Melnychenko <andrew@daynix.com> writes:
>
> > Now, the binary objects may be retrieved by id.
> > It would require for future qmp commands that may require specific
> > eBPF blob.
> >
> > Added command "request-ebpf". This command returns
> > eBPF program encoded base64. The program taken from the
> > skeleton and essentially is an ELF object that can be
> > loaded in the future with libbpf.
> >
> > The reason to use the command to provide the eBPF object
> > instead of a separate artifact was to avoid issues related
> > to finding the eBPF itself. eBPF object is an ELF binary
> > that contains the eBPF program and eBPF map description(BTF).
> > Overall, eBPF object should contain the program and enough
> > metadata to create/load eBPF with libbpf. As the eBPF
> > maps/program should correspond to QEMU, the eBPF can't
> > be used from different QEMU build.
> >
> > The first solution was a helper that comes with QEMU
> > and loads appropriate eBPF objects. And the issue is
> > to find a proper helper if the system has several
> > different QEMUs installed and/or built from the source,
> > which helpers may not be compatible.
> >
> > Another issue is QEMU updating while there is a running
> > QEMU instance. With an updated helper, it may not be
> > possible to hotplug virtio-net device to the already
> > running QEMU. Overall, requesting the eBPF object from
> > QEMU itself solves possible failures with acceptable effort.
> >
> > Links:
> > [PATCH 3/5] qmp: Added the helper stamp check.
> > https://lore.kernel.org/all/20230219162100.174318-4-andrew@daynix.com/
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
>
> [...]
>
> > diff --git a/qapi/ebpf.json b/qapi/ebpf.json
> > new file mode 100644
> > index 0000000000..ba78407148
> > --- /dev/null
> > +++ b/qapi/ebpf.json
> > @@ -0,0 +1,66 @@
> > +# -*- Mode: Python -*-
> > +# vim: filetype=3Dpython
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > +# See the COPYING file in the top-level directory.
> > +
> > +##
> > +# =3D eBPF Objects
> > +#
> > +# eBPF object is an ELF binary that contains the eBPF
> > +# program and eBPF map description(BTF). Overall, eBPF
> > +# object should contain the program and enough metadata
> > +# to create/load eBPF with libbpf. As the eBPF maps/program
> > +# should correspond to QEMU, the eBPF can't be used from
> > +# different QEMU build.
>
> An introduction, nice!
>
> Two spaces between sentences for consistency, please.
>
> Wrap comment lines at column 70, like this:
>
>    # eBPF object is an ELF binary that contains the eBPF program and eBPF
>    # map description(BTF).  Overall, eBPF object should contain the
>    # program and enough metadata to create/load eBPF with libbpf.  As the
>    # eBPF maps/program should correspond to QEMU, the eBPF can't be used
>    # from different QEMU build.
>
> > +#
> > +# Currently, there is a possible eBPF for receive-side scaling (RSS).
> > +#
> > +##
> > +
> > +##
> > +# @EbpfObject:
> > +#
> > +# An eBPF ELF object.
> > +#
> > +# @object: the eBPF object encoded in base64
> > +#
> > +# Since: 8.2
>
> Won't make 8.2, so bump to 9.0.  More of the same below, not noting it
> again.
>

Will there be 8.3?


>
> > +##
> > +{ 'struct': 'EbpfObject',
> > +  'data': {'object': 'str'},
> > +  'if': 'CONFIG_EBPF' }
> > +
> > +##
> > +# @EbpfProgramID:
> > +#
> > +# The eBPF programs that can be gotten with request-ebpf.
> > +#
> > +# @rss: Receive side scaling, technology that allows steering traffic
> > +#     between queues by calculation hash.  Users may set up
> > +#     indirection table and hash/packet types configurations.  Used
> > +#     with virtio-net.
> > +#
> > +# Since: 8.2
> > +##
> > +{ 'enum': 'EbpfProgramID',
> > +  'if': 'CONFIG_EBPF',
> > +  'data': [ { 'name': 'rss' } ] }
> > +
> > +##
> > +# @request-ebpf:
> > +#
> > +# Retrieve an eBPF object that can be loaded with libbpf.  Management
> > +# applications (g.e. libvirt) may load it and pass file descriptors to
> > +# QEMU, so they can run running QEMU without BPF capabilities.
> > +#
> > +# @id: The ID of the program to return.
> > +#
> > +# Returns: eBPF object encoded in base64.
> > +#
> > +# Since: 8.2
> > +##
> > +{ 'command': 'request-ebpf',
> > +  'data': { 'id': 'EbpfProgramID' },
> > +  'returns': 'EbpfObject',
> > +  'if': 'CONFIG_EBPF' }
> > diff --git a/qapi/meson.build b/qapi/meson.build
> > index 60a668b343..90047dae1c 100644
> > --- a/qapi/meson.build
> > +++ b/qapi/meson.build
> > @@ -33,6 +33,7 @@ qapi_all_modules =3D [
> >    'crypto',
> >    'cxl',
> >    'dump',
> > +  'ebpf',
> >    'error',
> >    'introspect',
> >    'job',
> > diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> > index 6594afba31..2c82a49bae 100644
> > --- a/qapi/qapi-schema.json
> > +++ b/qapi/qapi-schema.json
> > @@ -53,6 +53,7 @@
> >  { 'include': 'char.json' }
> >  { 'include': 'dump.json' }
> >  { 'include': 'net.json' }
> > +{ 'include': 'ebpf.json' }
> >  { 'include': 'rdma.json' }
> >  { 'include': 'rocker.json' }
> >  { 'include': 'tpm.json' }
>
> With the (minor) doc comment fixes:
> Acked-by: Markus Armbruster <armbru@redhat.com>
>
>

--000000000000d24006060cc8ad05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 18, 2023 at 2:54=E2=80=AF=
PM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Uh, I missed this one, my apologies!=C2=A0 Let me have a quick look...<=
br>
<br>
Commit message style nitpick:<br>
<br>
=C2=A0 =C2=A0 qmp: Add command to retrieve eBPF blob<br>
<br>
or<br>
<br>
=C2=A0 =C2=A0 qmp: New command to retrieve eBPF blob<br>
<br>
It&#39;s a title, not a sentence.<br>
<br>
Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.com" target=3D"_blan=
k">andrew@daynix.com</a>&gt; writes:<br>
<br>
&gt; Now, the binary objects may be retrieved by id.<br>
&gt; It would require for future qmp commands that may require specific<br>
&gt; eBPF blob.<br>
&gt;<br>
&gt; Added command &quot;request-ebpf&quot;. This command returns<br>
&gt; eBPF program encoded base64. The program taken from the<br>
&gt; skeleton and essentially is an ELF object that can be<br>
&gt; loaded in the future with libbpf.<br>
&gt;<br>
&gt; The reason to use the command to provide the eBPF object<br>
&gt; instead of a separate artifact was to avoid issues related<br>
&gt; to finding the eBPF itself. eBPF object is an ELF binary<br>
&gt; that contains the eBPF program and eBPF map description(BTF).<br>
&gt; Overall, eBPF object should contain the program and enough<br>
&gt; metadata to create/load eBPF with libbpf. As the eBPF<br>
&gt; maps/program should correspond to QEMU, the eBPF can&#39;t<br>
&gt; be used from different QEMU build.<br>
&gt;<br>
&gt; The first solution was a helper that comes with QEMU<br>
&gt; and loads appropriate eBPF objects. And the issue is<br>
&gt; to find a proper helper if the system has several<br>
&gt; different QEMUs installed and/or built from the source,<br>
&gt; which helpers may not be compatible.<br>
&gt;<br>
&gt; Another issue is QEMU updating while there is a running<br>
&gt; QEMU instance. With an updated helper, it may not be<br>
&gt; possible to hotplug virtio-net device to the already<br>
&gt; running QEMU. Overall, requesting the eBPF object from<br>
&gt; QEMU itself solves possible failures with acceptable effort.<br>
&gt;<br>
&gt; Links:<br>
&gt; [PATCH 3/5] qmp: Added the helper stamp check.<br>
&gt; <a href=3D"https://lore.kernel.org/all/20230219162100.174318-4-andrew@=
daynix.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/a=
ll/20230219162100.174318-4-andrew@daynix.com/</a><br>
&gt;<br>
&gt; Signed-off-by: Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.=
com" target=3D"_blank">andrew@daynix.com</a>&gt;<br>
<br>
[...]<br>
<br>
&gt; diff --git a/qapi/ebpf.json b/qapi/ebpf.json<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..ba78407148<br>
&gt; --- /dev/null<br>
&gt; +++ b/qapi/ebpf.json<br>
&gt; @@ -0,0 +1,66 @@<br>
&gt; +# -*- Mode: Python -*-<br>
&gt; +# vim: filetype=3Dpython<br>
&gt; +#<br>
&gt; +# This work is licensed under the terms of the GNU GPL, version 2 or =
later.<br>
&gt; +# See the COPYING file in the top-level directory.<br>
&gt; +<br>
&gt; +##<br>
&gt; +# =3D eBPF Objects<br>
&gt; +#<br>
&gt; +# eBPF object is an ELF binary that contains the eBPF<br>
&gt; +# program and eBPF map description(BTF). Overall, eBPF<br>
&gt; +# object should contain the program and enough metadata<br>
&gt; +# to create/load eBPF with libbpf. As the eBPF maps/program<br>
&gt; +# should correspond to QEMU, the eBPF can&#39;t be used from<br>
&gt; +# different QEMU build.<br>
<br>
An introduction, nice!<br>
<br>
Two spaces between sentences for consistency, please.<br>
<br>
Wrap comment lines at column 70, like this:<br>
<br>
=C2=A0 =C2=A0# eBPF object is an ELF binary that contains the eBPF program =
and eBPF<br>
=C2=A0 =C2=A0# map description(BTF).=C2=A0 Overall, eBPF object should cont=
ain the<br>
=C2=A0 =C2=A0# program and enough metadata to create/load eBPF with libbpf.=
=C2=A0 As the<br>
=C2=A0 =C2=A0# eBPF maps/program should correspond to QEMU, the eBPF can&#3=
9;t be used<br>
=C2=A0 =C2=A0# from different QEMU build.<br>
<br>
&gt; +#<br>
&gt; +# Currently, there is a possible eBPF for receive-side scaling (RSS).=
<br>
&gt; +#<br>
&gt; +##<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @EbpfObject:<br>
&gt; +#<br>
&gt; +# An eBPF ELF object.<br>
&gt; +#<br>
&gt; +# @object: the eBPF object encoded in base64<br>
&gt; +#<br>
&gt; +# Since: 8.2<br>
<br>
Won&#39;t make 8.2, so bump to 9.0.=C2=A0 More of the same below, not notin=
g it<br>
again.<br></blockquote><div><br></div><div>Will there be 8.3?</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +##<br>
&gt; +{ &#39;struct&#39;: &#39;EbpfObject&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: {&#39;object&#39;: &#39;str&#39;},<br>
&gt; +=C2=A0 &#39;if&#39;: &#39;CONFIG_EBPF&#39; }<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @EbpfProgramID:<br>
&gt; +#<br>
&gt; +# The eBPF programs that can be gotten with request-ebpf.<br>
&gt; +#<br>
&gt; +# @rss: Receive side scaling, technology that allows steering traffic=
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0between queues by calculation hash.=C2=A0 Users =
may set up<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0indirection table and hash/packet types configur=
ations.=C2=A0 Used<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0with virtio-net.<br>
&gt; +#<br>
&gt; +# Since: 8.2<br>
&gt; +##<br>
&gt; +{ &#39;enum&#39;: &#39;EbpfProgramID&#39;,<br>
&gt; +=C2=A0 &#39;if&#39;: &#39;CONFIG_EBPF&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: [ { &#39;name&#39;: &#39;rss&#39; } ] }<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @request-ebpf:<br>
&gt; +#<br>
&gt; +# Retrieve an eBPF object that can be loaded with libbpf.=C2=A0 Manag=
ement<br>
&gt; +# applications (g.e. libvirt) may load it and pass file descriptors t=
o<br>
&gt; +# QEMU, so they can run running QEMU without BPF capabilities.<br>
&gt; +#<br>
&gt; +# @id: The ID of the program to return.<br>
&gt; +#<br>
&gt; +# Returns: eBPF object encoded in base64.<br>
&gt; +#<br>
&gt; +# Since: 8.2<br>
&gt; +##<br>
&gt; +{ &#39;command&#39;: &#39;request-ebpf&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: { &#39;id&#39;: &#39;EbpfProgramID&#39; },<br>
&gt; +=C2=A0 &#39;returns&#39;: &#39;EbpfObject&#39;,<br>
&gt; +=C2=A0 &#39;if&#39;: &#39;CONFIG_EBPF&#39; }<br>
&gt; diff --git a/qapi/meson.build b/qapi/meson.build<br>
&gt; index 60a668b343..90047dae1c 100644<br>
&gt; --- a/qapi/meson.build<br>
&gt; +++ b/qapi/meson.build<br>
&gt; @@ -33,6 +33,7 @@ qapi_all_modules =3D [<br>
&gt;=C2=A0 =C2=A0 &#39;crypto&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;cxl&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;dump&#39;,<br>
&gt; +=C2=A0 &#39;ebpf&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;error&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;introspect&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;job&#39;,<br>
&gt; diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json<br>
&gt; index 6594afba31..2c82a49bae 100644<br>
&gt; --- a/qapi/qapi-schema.json<br>
&gt; +++ b/qapi/qapi-schema.json<br>
&gt; @@ -53,6 +53,7 @@<br>
&gt;=C2=A0 { &#39;include&#39;: &#39;char.json&#39; }<br>
&gt;=C2=A0 { &#39;include&#39;: &#39;dump.json&#39; }<br>
&gt;=C2=A0 { &#39;include&#39;: &#39;net.json&#39; }<br>
&gt; +{ &#39;include&#39;: &#39;ebpf.json&#39; }<br>
&gt;=C2=A0 { &#39;include&#39;: &#39;rdma.json&#39; }<br>
&gt;=C2=A0 { &#39;include&#39;: &#39;rocker.json&#39; }<br>
&gt;=C2=A0 { &#39;include&#39;: &#39;tpm.json&#39; }<br>
<br>
With the (minor) doc comment fixes:<br>
Acked-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=
=3D"_blank">armbru@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div>

--000000000000d24006060cc8ad05--

