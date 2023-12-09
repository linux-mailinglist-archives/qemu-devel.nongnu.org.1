Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0576F80B21C
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Dec 2023 06:07:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBpWw-00066G-9v; Sat, 09 Dec 2023 00:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rBpWt-000664-9m
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 00:05:31 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rBpWp-0002ZE-8S
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 00:05:30 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6d9d59d6676so1885222a34.1
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 21:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1702098203; x=1702703003;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vvxclCes1CjnCDGCH8p7DoxHYVOzpzEtq0LaxsKcQJg=;
 b=uImEM2djBJP8sqA8aGHYBtSTQlexqhbX1HNw8PAiQDJsnsJ3MogZWDtfr77PMoqDFV
 kiceJsETqlrpU5h6Lm/pxhG4ocex3HSRm7b2aI3rewp1h3hfVJtqYcYfi1AvGMcHtxUy
 G2U6FQhraH1hfzJeJs8xDl8mOPa4bYcqdmsdCbd28oj2BL9nV1yyZ9RbrvYe44WwB8ss
 aYushCRJJEcEJbP0phK42IeSaGaY+19sk1JejZ4ecX860+o7O3OgvPkMWFg44//wZF84
 2sotf9bIXQMHV0lmVOf+8TzehFe/8dKxLU+G2hLY0GjB3jNr07jIe+Kl9jr0PX9wEXjt
 hMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702098203; x=1702703003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vvxclCes1CjnCDGCH8p7DoxHYVOzpzEtq0LaxsKcQJg=;
 b=Bi9URAelK6jStSmcyylMnlxYDXbigH6lfd6XAGA05iQ7RbTBwryifebI3g2lH/JRh2
 gY1hRJi67Ep95ZmXmlIC8F1Wpw65beKh02z2FdRd3dkkz6MQaVhcPGs5PIhJkdtVR/yz
 ss7FeN4ORTSRrusOXPf7dH3sT6zm1jRF9A1dOQg3Bg5upORzrTiqgyVb9Py7QKQDoCw0
 8yoHVYlvgE7rIp/Q+U0lbJ/3pSE/sR5Wvp/vf7o5aw2V1ggOpPa0glkSvGq5L3YxyUvS
 wGqo5O4LTZKe8kJXPCin/hOukXtFgoggTyJgNYo79a5RagoV2S52jg1nxeHvgfj5ekgF
 p0rA==
X-Gm-Message-State: AOJu0YxrH/FmS/U/63Ks1ZF5dQ899gakthZawC2H0sJMIExCBnrwLcaC
 H6zvcsyOfI3tc4FHSU3mb1Re/GLD/OTW/kBgOBVL5A==
X-Google-Smtp-Source: AGHT+IE7RqCAd6gSgD4kgnOGEAwbAumSsNXkBjNg6YLyMJbD8XAJC0+4aylaNqyKtmPmN3vZvy6SOyZZ1eqpy0VJzM0=
X-Received: by 2002:a05:6358:7e8d:b0:170:6d55:e82e with SMTP id
 o13-20020a0563587e8d00b001706d55e82emr1409962rwn.2.1702098202367; Fri, 08 Dec
 2023 21:03:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699793550.git.yong.huang@smartx.com>
 <2f146005c8573814528f4ffb5a0393eb73b154e3.1699793550.git.yong.huang@smartx.com>
 <87h6llep0o.fsf@pond.sub.org>
 <CAK9dgmYTjQRregoseU7S+8WvJsY4R10KP5hVkcEBKBFtHNv0=A@mail.gmail.com>
 <87v89vleqp.fsf@pond.sub.org>
 <3d4add1a-2dcf-4a35-a3f6-c7eca0275a35@redhat.com>
 <87jzpyuewq.fsf@pond.sub.org>
 <e4f0491e-c915-4d9b-80a5-953e0ad27528@redhat.com>
In-Reply-To: <e4f0491e-c915-4d9b-80a5-953e0ad27528@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Sat, 9 Dec 2023 13:03:06 +0800
Message-ID: <CAK9dgmZ2WL6PfiirNhapddQmvJtYdBYeWWjC76zF3s6a803_Xw@mail.gmail.com>
Subject: Re: [RFC 1/2] qapi/virtio: introduce the "show-bits" argument for
 x-query-virtio-status
To: Laurent Vivier <lvivier@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b9a943060c0c9e4b"
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x32f.google.com
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

--000000000000b9a943060c0c9e4b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 11:37=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:

> On 12/1/23 16:21, Markus Armbruster wrote:
> > Laurent Vivier <lvivier@redhat.com> writes:
> >
> >> On 11/21/23 08:58, Markus Armbruster wrote:
> >>> Laurent, there's a question for you at the end.
> >>>
> >>> Yong Huang <yong.huang@smartx.com> writes:
> >>>
> >>>> On Thu, Nov 16, 2023 at 10:44=E2=80=AFPM Markus Armbruster <armbru@r=
edhat.com
> >
> >>>> wrote:
> >>>>
> >>>>> Hyman Huang <yong.huang@smartx.com> writes:
> >>>>>
> >>>>>> This patch allows to display feature and status bits in
> virtio-status.
> >>>>>>
> >>>>>> An optional argument is introduced: show-bits. For example:
> >>>>>> {"execute": "x-query-virtio-status",
> >>>>>>    "arguments": {"path":
> "/machine/peripheral-anon/device[1]/virtio-backend",
> >>>>>>                  "show-bits": true}
> >>>>>>
> >>>>>> Features and status bits could be helpful for applications to
> compare
> >>>>>> directly. For instance, when an upper application aims to ensure t=
he
> >>>>>> virtio negotiation correctness between guest, QEMU, and OVS-DPDK,
> it use
> >>>>>> the "ovs-vsctl list interface" command to retrieve interface
> features
> >>>>>> (in number format) and the QMP command x-query-virtio-status to
> retrieve
> >>>>>> vhost-user net device features. If "show-bits" is added, the
> application
> >>>>>> can compare the two features directly; No need to encoding the
> features
> >>>>>> returned by the QMP command.
> >>>>>>
> >>>>>> This patch also serves as a preparation for the next one, which
> implements
> >>>>>> a vhost-user test case about acked features of vhost-user protocol=
.
> >>>>>>
> >>>>>> Note that since the matching HMP command is typically used for
> human,
> >>>>>> leave it unchanged.
> >>>>>>
> >>>>>> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> >
> > [...]
> >
> >>>>> Double-checking...  @feature-bits provides the exact same
> information as
> >>>>> @features, only in another encoding.  Correct?
> >>>>
> >>>>
> >>>>> Same for all the other new -bits.  Correct?
> >>>>
> >>>> Yes, all the new fields are only about providing another encoding.
> >>>
> >>> Why do we want to return the same information in two different
> >>> encodings?  I figure the commit message tries to answer this question=
:
> >>>
> >>>        Features and status bits could be helpful for applications to
> compare
> >>>        directly. For instance, when an upper application aims to
> ensure the
> >>>        virtio negotiation correctness between guest, QEMU, and
> OVS-DPDK, it use
> >>>        the "ovs-vsctl list interface" command to retrieve interface
> features
> >>>        (in number format) and the QMP command x-query-virtio-status t=
o
> retrieve
> >>>        vhost-user net device features. If "show-bits" is added, the
> application
> >>>        can compare the two features directly; No need to encoding the
> features
> >>>        returned by the QMP command.
> >>>
> >>>        This patch also serves as a preparation for the next one, whic=
h
> implements
> >>>        a vhost-user test case about acked features of vhost-user
> protocol.
> >>>
> >>> I guess you're trying to simplify use cases where the QMP client want=
s
> >>> to compare entire feature sets without caring for individual features=
.
> >>>
> >>> The comparison is easy if both sets are represented the same way,
> >>> e.g. both are numbers, or both are lists of symbols.
> >>>
> >>> With different representations, we first have to map to a common
> >>> representation.  Unfortunately, the design of x-query-virtio-status
> >>> makes this harder than it should be.
> >>>
> >>> We use QAPI types VirtioDeviceStatus, VhostDeviceProtocols,
> >>> VirtioDeviceFeatures to represent feature sets.  They all work the sa=
me
> >>> way: array of strings plus a number.  For each bit QEMU knows, there'=
s
> a
> >>> string in the array.  Any remaining bits go into the number.
> >>>
> >>> The format of the string is undocumented.  They look like
> >>>
> >>>       "WELL_KNOWN_SYMBOL: human readable explanation"
> >>>
> >>> Mapping from bit to this string in a client would require duplicating
> >>> QEMU's code exactly.
> >>>
> >>> Mapping both bit and string to just "WELL_KNOWN_SYMBOL" could perhaps
> be
> >>> done.
> >>>
> >>> The mapping between symbols and bits is not visible in QMP.  Mapping
> >>> from string to bit requires exploiting the undocumented format: extra=
ct
> >>> the well-known symbol and decode it.
> >>>
> >>> This encoding of feature sets goes back to commit f3034ad71fc (qmp:
> >>> decode feature & status bits in virtio-status) v7.2.  Before that, th=
e
> >>> command returned the bits as a number.
> >>>
> >>> For example, return value "member "status":
> >>>
> >>>       Before f3034ad71fc:
> >>>
> >>>           "status": 15,
> >>>
> >>>       Since f3034ad71fc:
> >>>
> >>>           "status": {
> >>>               "statuses": [
> >>>                   "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device
> found",
> >>>                   "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with
> device",
> >>>                   "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation
> complete",
> >>>                   "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
> >>>               ]},
> >>>
> >>>       With your patch:
> >>>
> >>>           "status": {
> >>>               "statuses": [
> >>>                   "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device
> found",
> >>>                   "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with
> device",
> >>>                   "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation
> complete",
> >>>                   "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
> >>>               ]},
> >>>           "status-bits": 15,
> >>>
> >>> Looks like commit f3034ad71fc improved one use case at the expense of
> >>> another, and your patch tries to revert the damage.  Which one exactl=
y
> >>> it improved is unclear; the commit message doesn't tell.  Laurent?
> >>>
> >>> [...]
> >>>
> >>
> >> The first idea of the series "hmp,qmp: Add commands to introspect
> virtio devices"
> >> including commit f3034ad71fc was to help developer to debug virtio
> devices, so for this
> >> purpose it was interesting to display the status in a human readable
> manner.
> >>
> >> Of course, if you want to run automatic tests and be able to compare
> the result to have
> >> the status bits result seems to be better.
> >>
> >> As these are two different use cases, it's understandable to have two
> different
> >> representations of the same information.
> >
> > Thanks!
> >
> > Both use cases are valid, but I dislike both the existing and the
> > proposed interface.
> >
> > We can change it: x-query-virtio-status isn't stable (it's for debuggin=
g
> > and testing).  But even unstable interfaces should only be changed for
> > good, clear reasons.
> >
> > I feel the change from "bits encoded as a number" to "bits as list of
> > descriptive strings plus number for the unknown ones" fell short.  Let
> > me explain.
> >
> > The initial version of the command had "bits encoded as number".  Unles=
s
> > we understand why that was done, we should assume it was done for a
> > reason.  We now know it was: Hyman Huang posted a patch to get it back.
> >
> > Instead of "bits as list of descriptive strings plus number for the
> > unknown ones", we could have done "bits encoded as number, plus list of
> > descriptive strings", or plus some other human-readable encoding.
> >
> > QMP output of the form "WELL_KNOWN_SYMBOL: human readable explanation"
> > smells of encoding structured information in strings, which is a no-no.
> >
> > Perhaps we could have added human-readable output just in HMP.  That's
> > what we normally do.
> >
> > Here are a few possible alternatives to Hyman Huang's patch:
> >
> > 1. Revert commit f3034ad71fc for QMP, keep it for HMP.
> >
> > 2. Replace @unknown-FOO (just the unknown bits) by @FOO-bits (all bits)=
.
> >
> > 3. Add @FOO-bits next to @unknown-FOO, deprecate @unknown-FOO.
> >
> > 4. Create a QAPI enum for the known bits.  Clients can use introspectio=
n
> >     to learn the mapping between symbols and bits.  Requires dumbing do=
wn
> >     the descriptive strings to just the symbols.  This feels
> >     both overengineered and cumbersome to use.
> >
> > For 2 and 3, I'd prefer to also dumb down the descriptive strings to
> > just the symbols.
> >
> > Thoughts?
> >
>
> I agree with you. As x-CMD are unstable, perhaps we can go directly to 2?
> (and of course to remove the descriptive strings. Is it easily possible t=
o
> keep them for
> the HMP version?)
>
> Thanks,
> Laurent
>
>
Sorry for the late reply. :(

Let me make a conclusion about our discussion, if i misunderstand
something,
point that out please:

1. we take the policy of adding human-readable output just in HMP.

2. For the HMP output, we display the human-readable information and drop
   the unknown bits in practice.

3. For the QMP output, we remove the descriptive strings and only display
    bits encoded as numbers.

I'll do that in the next version and make the PATCH 1/2 apart from the
PATCH 2/2
since it could be handled in an independent context.


--=20
Best regards

--000000000000b9a943060c0c9e4b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 1, 202=
3 at 11:37=E2=80=AFPM Laurent Vivier &lt;<a href=3D"mailto:lvivier@redhat.c=
om">lvivier@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-s=
tyle:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On 12/1/23 =
16:21, Markus Armbruster wrote:<br>
&gt; Laurent Vivier &lt;<a href=3D"mailto:lvivier@redhat.com" target=3D"_bl=
ank">lvivier@redhat.com</a>&gt; writes:<br>
&gt; <br>
&gt;&gt; On 11/21/23 08:58, Markus Armbruster wrote:<br>
&gt;&gt;&gt; Laurent, there&#39;s a question for you at the end.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Yong Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=
=3D"_blank">yong.huang@smartx.com</a>&gt; writes:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Thu, Nov 16, 2023 at 10:44=E2=80=AFPM Markus Armbruster=
 &lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.c=
om</a>&gt;<br>
&gt;&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.co=
m" target=3D"_blank">yong.huang@smartx.com</a>&gt; writes:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; This patch allows to display feature and status bi=
ts in virtio-status.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; An optional argument is introduced: show-bits. For=
 example:<br>
&gt;&gt;&gt;&gt;&gt;&gt; {&quot;execute&quot;: &quot;x-query-virtio-status&=
quot;,<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 &quot;arguments&quot;: {&quot;path&qu=
ot;: &quot;/machine/peripheral-anon/device[1]/virtio-backend&quot;,<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &quot;show-bits&quot;: true}<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Features and status bits could be helpful for appl=
ications to compare<br>
&gt;&gt;&gt;&gt;&gt;&gt; directly. For instance, when an upper application =
aims to ensure the<br>
&gt;&gt;&gt;&gt;&gt;&gt; virtio negotiation correctness between guest, QEMU=
, and OVS-DPDK, it use<br>
&gt;&gt;&gt;&gt;&gt;&gt; the &quot;ovs-vsctl list interface&quot; command t=
o retrieve interface features<br>
&gt;&gt;&gt;&gt;&gt;&gt; (in number format) and the QMP command x-query-vir=
tio-status to retrieve<br>
&gt;&gt;&gt;&gt;&gt;&gt; vhost-user net device features. If &quot;show-bits=
&quot; is added, the application<br>
&gt;&gt;&gt;&gt;&gt;&gt; can compare the two features directly; No need to =
encoding the features<br>
&gt;&gt;&gt;&gt;&gt;&gt; returned by the QMP command.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; This patch also serves as a preparation for the ne=
xt one, which implements<br>
&gt;&gt;&gt;&gt;&gt;&gt; a vhost-user test case about acked features of vho=
st-user protocol.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Note that since the matching HMP command is typica=
lly used for human,<br>
&gt;&gt;&gt;&gt;&gt;&gt; leave it unchanged.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:y=
ong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; <br>
&gt; [...]<br>
&gt; <br>
&gt;&gt;&gt;&gt;&gt; Double-checking...=C2=A0 @feature-bits provides the ex=
act same information as<br>
&gt;&gt;&gt;&gt;&gt; @features, only in another encoding.=C2=A0 Correct?<br=
>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Same for all the other new -bits.=C2=A0 Correct?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Yes, all the new fields are only about providing another e=
ncoding.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Why do we want to return the same information in two different=
<br>
&gt;&gt;&gt; encodings?=C2=A0 I figure the commit message tries to answer t=
his question:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Features and status bits could be h=
elpful for applications to compare<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 directly. For instance, when an upp=
er application aims to ensure the<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio negotiation correctness betw=
een guest, QEMU, and OVS-DPDK, it use<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 the &quot;ovs-vsctl list interface&=
quot; command to retrieve interface features<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 (in number format) and the QMP comm=
and x-query-virtio-status to retrieve<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost-user net device features. If =
&quot;show-bits&quot; is added, the application<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 can compare the two features direct=
ly; No need to encoding the features<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 returned by the QMP command.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 This patch also serves as a prepara=
tion for the next one, which implements<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 a vhost-user test case about acked =
features of vhost-user protocol.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I guess you&#39;re trying to simplify use cases where the QMP =
client wants<br>
&gt;&gt;&gt; to compare entire feature sets without caring for individual f=
eatures.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The comparison is easy if both sets are represented the same w=
ay,<br>
&gt;&gt;&gt; e.g. both are numbers, or both are lists of symbols.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; With different representations, we first have to map to a comm=
on<br>
&gt;&gt;&gt; representation.=C2=A0 Unfortunately, the design of x-query-vir=
tio-status<br>
&gt;&gt;&gt; makes this harder than it should be.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; We use QAPI types VirtioDeviceStatus, VhostDeviceProtocols,<br=
>
&gt;&gt;&gt; VirtioDeviceFeatures to represent feature sets.=C2=A0 They all=
 work the same<br>
&gt;&gt;&gt; way: array of strings plus a number.=C2=A0 For each bit QEMU k=
nows, there&#39;s a<br>
&gt;&gt;&gt; string in the array.=C2=A0 Any remaining bits go into the numb=
er.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The format of the string is undocumented.=C2=A0 They look like=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;WELL_KNOWN_SYMBOL: human reada=
ble explanation&quot;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Mapping from bit to this string in a client would require dupl=
icating<br>
&gt;&gt;&gt; QEMU&#39;s code exactly.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Mapping both bit and string to just &quot;WELL_KNOWN_SYMBOL&qu=
ot; could perhaps be<br>
&gt;&gt;&gt; done.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The mapping between symbols and bits is not visible in QMP.=C2=
=A0 Mapping<br>
&gt;&gt;&gt; from string to bit requires exploiting the undocumented format=
: extract<br>
&gt;&gt;&gt; the well-known symbol and decode it.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This encoding of feature sets goes back to commit f3034ad71fc =
(qmp:<br>
&gt;&gt;&gt; decode feature &amp; status bits in virtio-status) v7.2.=C2=A0=
 Before that, the<br>
&gt;&gt;&gt; command returned the bits as a number.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; For example, return value &quot;member &quot;status&quot;:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Before f3034ad71fc:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;status&quot;: 15=
,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Since f3034ad71fc:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;status&quot;: {<=
br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;st=
atuses&quot;: [<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found&quot;,<b=
r>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device&quot;,<=
br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete&quot;=
,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready&quot;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]},<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0With your patch:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;status&quot;: {<=
br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;st=
atuses&quot;: [<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found&quot;,<b=
r>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device&quot;,<=
br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete&quot;=
,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready&quot;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]},<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;status-bits&quot=
;: 15,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Looks like commit f3034ad71fc improved one use case at the exp=
ense of<br>
&gt;&gt;&gt; another, and your patch tries to revert the damage.=C2=A0 Whic=
h one exactly<br>
&gt;&gt;&gt; it improved is unclear; the commit message doesn&#39;t tell.=
=C2=A0 Laurent?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; [...]<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; The first idea of the series &quot;hmp,qmp: Add commands to intros=
pect virtio devices&quot;<br>
&gt;&gt; including commit f3034ad71fc was to help developer to debug virtio=
 devices, so for this<br>
&gt;&gt; purpose it was interesting to display the status in a human readab=
le manner.<br>
&gt;&gt;<br>
&gt;&gt; Of course, if you want to run automatic tests and be able to compa=
re the result to have<br>
&gt;&gt; the status bits result seems to be better.<br>
&gt;&gt;<br>
&gt;&gt; As these are two different use cases, it&#39;s understandable to h=
ave two different<br>
&gt;&gt; representations of the same information.<br>
&gt; <br>
&gt; Thanks!<br>
&gt; <br>
&gt; Both use cases are valid, but I dislike both the existing and the<br>
&gt; proposed interface.<br>
&gt; <br>
&gt; We can change it: x-query-virtio-status isn&#39;t stable (it&#39;s for=
 debugging<br>
&gt; and testing).=C2=A0 But even unstable interfaces should only be change=
d for<br>
&gt; good, clear reasons.<br>
&gt; <br>
&gt; I feel the change from &quot;bits encoded as a number&quot; to &quot;b=
its as list of<br>
&gt; descriptive strings plus number for the unknown ones&quot; fell short.=
=C2=A0 Let<br>
&gt; me explain.<br>
&gt; <br>
&gt; The initial version of the command had &quot;bits encoded as number&qu=
ot;.=C2=A0 Unless<br>
&gt; we understand why that was done, we should assume it was done for a<br=
>
&gt; reason.=C2=A0 We now know it was: Hyman Huang posted a patch to get it=
 back.<br>
&gt; <br>
&gt; Instead of &quot;bits as list of descriptive strings plus number for t=
he<br>
&gt; unknown ones&quot;, we could have done &quot;bits encoded as number, p=
lus list of<br>
&gt; descriptive strings&quot;, or plus some other human-readable encoding.=
<br>
&gt; <br>
&gt; QMP output of the form &quot;WELL_KNOWN_SYMBOL: human readable explana=
tion&quot;<br>
&gt; smells of encoding structured information in strings, which is a no-no=
.<br>
&gt; <br>
&gt; Perhaps we could have added human-readable output just in HMP.=C2=A0 T=
hat&#39;s<br>
&gt; what we normally do.<br>
&gt; <br>
&gt; Here are a few possible alternatives to Hyman Huang&#39;s patch:<br>
&gt; <br>
&gt; 1. Revert commit f3034ad71fc for QMP, keep it for HMP.<br>
&gt; <br>
&gt; 2. Replace @unknown-FOO (just the unknown bits) by @FOO-bits (all bits=
).<br>
&gt; <br>
&gt; 3. Add @FOO-bits next to @unknown-FOO, deprecate @unknown-FOO.<br>
&gt; <br>
&gt; 4. Create a QAPI enum for the known bits.=C2=A0 Clients can use intros=
pection<br>
&gt;=C2=A0 =C2=A0 =C2=A0to learn the mapping between symbols and bits.=C2=
=A0 Requires dumbing down<br>
&gt;=C2=A0 =C2=A0 =C2=A0the descriptive strings to just the symbols.=C2=A0 =
This feels<br>
&gt;=C2=A0 =C2=A0 =C2=A0both overengineered and cumbersome to use.<br>
&gt; <br>
&gt; For 2 and 3, I&#39;d prefer to also dumb down the descriptive strings =
to<br>
&gt; just the symbols.<br>
&gt; <br>
&gt; Thoughts?<br>
&gt; <br>
<br>
I agree with you. As x-CMD are unstable, perhaps we can go directly to 2?<b=
r>
(and of course to remove the descriptive strings. Is it easily possible to =
keep them for <br>
the HMP version?)<br>
<br>
Thanks,<br>
Laurent<br>
<br>
</blockquote></div><br clear=3D"all"><div><div class=3D"gmail_default" styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Sorry for the late r=
eply. :(</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic=
 sans ms&quot;,sans-serif"><br></div><div class=3D"gmail_default" style=3D"=
font-family:&quot;comic sans ms&quot;,sans-serif">Let me make a conclusion =
about our discussion, if i misunderstand something,=C2=A0</div><div class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f">point that out please:</div><div class=3D"gmail_default" style=3D"font-f=
amily:&quot;comic sans ms&quot;,sans-serif"><br></div><div class=3D"gmail_d=
efault" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">1. we ta=
ke the policy of adding human-readable output just in HMP.</div><div class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f"><br></div><div class=3D"gmail_default" style=3D"font-family:&quot;comic =
sans ms&quot;,sans-serif">2. For the HMP output, we display the human-reada=
ble information and drop</div><div class=3D"gmail_default" style=3D"font-fa=
mily:&quot;comic sans ms&quot;,sans-serif">=C2=A0 =C2=A0the unknown bits in=
 practice.</div><div class=3D"gmail_default" style=3D"font-family:&quot;com=
ic sans ms&quot;,sans-serif"><br></div><div class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">3. For the QMP output=
, we remove the descriptive strings and only display=C2=A0</div><div class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f">=C2=A0 =C2=A0 bits encoded as numbers.</div><br></div><div><div class=3D=
"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">=
I&#39;ll do that in the next version and make the=C2=A0PATCH 1/2=C2=A0apart=
 from the PATCH 2/2</div><div class=3D"gmail_default" style=3D"font-family:=
&quot;comic sans ms&quot;,sans-serif">since it could be handled in an indep=
endent context.</div><br></div><div><br></div><span class=3D"gmail_signatur=
e_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font></div>=
</div></div>

--000000000000b9a943060c0c9e4b--

