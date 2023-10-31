Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6157DD65D
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 19:57:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtuV-0001rd-ES; Tue, 31 Oct 2023 14:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxtuT-0001r4-1b
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxtuN-0005p1-1G
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=canlju2lPuNeWZqq91Bz3pAPQWVl+V3H/ZWTI9aRFpw=;
 b=jHb5runTHibjPoJdHuX/O8klG45zBK4XIbdblNIYC+Q+D8RgELW1jCeH6ukCtA/QE8+bYx
 NaOGeuucY8/FcfA5m51SyGSkoYHoFyn+73HHu2phKKYLPIAgcimn8nWq2X4v8/XuXpJMoR
 5O9euVbNDqsIWAqOQOsj6fPF2K/CN0s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-pEsKDVihOICJ1UYPqjbZFw-1; Tue, 31 Oct 2023 14:56:07 -0400
X-MC-Unique: pEsKDVihOICJ1UYPqjbZFw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso2923007f8f.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 11:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698778565; x=1699383365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=canlju2lPuNeWZqq91Bz3pAPQWVl+V3H/ZWTI9aRFpw=;
 b=MQJpn5JndqVT+fGthgJZUVnVZy+vVfFVU3rBu6APdx5gBBP9EFhWeTJdVI3Ht5sUNU
 8e0YpG+2hrVpvBv1wUH31OSCH3iOR1Sp6SeQlFiXdwjOk6TelKV4pCBEexll6OLu1MIv
 bUitvDQqUOvF7mez9BESpOp8zpl2RTeU1FrlBA8Ff+v9kvlmIiRmDgDo5RUtSwsVurhI
 4ZVUoFrSpWLBYh5kNC4dM4nGPcwC/6YbLVM85gmf8ROds8QM4pnlHuFuojJK139JrSgk
 BiDWQKA3O2h6cFZI/XyTGK9SQehfaCkWHSmLL+m6yTn0aMIaAwEsxGHoZwbGiWQNOlxH
 QApA==
X-Gm-Message-State: AOJu0YzLBA48As8RKjdyDf6X1GISiqa0ys6yybFy5Zd7cfcioble6Pxr
 ghzR4u+kstkBUWtTLMZT0qWCiWTrkrHnB4FWUhc7OKwfRcnyQqdZPs0Zb5FsTtHaM2re5pN6/0v
 qnlsEdRPx6PWMRUQ6x2xpNMY4zv/dAVw=
X-Received: by 2002:a5d:51c4:0:b0:32d:83b7:bdb4 with SMTP id
 n4-20020a5d51c4000000b0032d83b7bdb4mr9864250wrv.9.1698778565745; 
 Tue, 31 Oct 2023 11:56:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpd4prJMHGy3iURiAeBvTKi4tbtjEgGWlQjS+O3aCFGYr3Rw8WS1fPoKB1Q/VO0/aDnD1QPKiGlMzEmIkpEoM=
X-Received: by 2002:a5d:51c4:0:b0:32d:83b7:bdb4 with SMTP id
 n4-20020a5d51c4000000b0032d83b7bdb4mr9864233wrv.9.1698778565416; Tue, 31 Oct
 2023 11:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-14-farosas@suse.de>
 <87msvy4rjg.fsf@secure.mitica>
 <d746e4d6-1572-2360-3780-7be4ae63ac29@nutanix.com>
In-Reply-To: <d746e4d6-1572-2360-3780-7be4ae63ac29@nutanix.com>
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 31 Oct 2023 19:55:53 +0100
Message-ID: <CAGiv1-VF9mCq7B-6RCHPONT43Zd8YTH87xJXFbdf5GLcY_dbcQ@mail.gmail.com>
Subject: Re: [PATCH v15 13/14] migration: Implement MigrateChannelList to hmp
 migration flow.
To: Het Gala <het.gala@nutanix.com>
Cc: Fabiano Rosas <farosas@suse.de>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Prerna Saxena <prerna.saxena@nutanix.com>, dgilbert@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Manish Mishra <manish.mishra@nutanix.com>, 
 Aravind Retnakaran <aravind.retnakaran@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f1ab3b060907b4a6"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000f1ab3b060907b4a6
Content-Type: text/plain; charset="UTF-8"

I intrehated al parches until this forma next pull.

On Tue, Oct 31, 2023, 19:51 Het Gala <het.gala@nutanix.com> wrote:

>
> On 31/10/23 11:12 pm, Juan Quintela wrote:
> > Fabiano Rosas <farosas@suse.de> wrote:
> >> From: Het Gala <het.gala@nutanix.com>
> >>
> >> Integrate MigrateChannelList with all transport backends
> >> (socket, exec and rdma) for both src and dest migration
> >> endpoints for hmp migration.
> >>
> >> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> >> Signed-off-by: Het Gala <het.gala@nutanix.com>
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> >>       bool resume = qdict_get_try_bool(qdict, "resume", false);
> >>       const char *uri = qdict_get_str(qdict, "uri");
> >>       Error *err = NULL;
> >> +    MigrationChannelList *caps = NULL;
> >> +    g_autoptr(MigrationChannel) channel = NULL;
> >>
> >> -    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
> >> +    if (!migrate_uri_parse(uri, &channel, &err)) {
> >> +        goto end;
> >> +    }
> >> +    QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
> >> +
> >> +    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
> >>                    false, false, true, resume, &err);
> >
> >> -    if (hmp_handle_error(mon, err)) {
> >> -        return;
> >> -    }
> > I think that dropping this chunk is wrong.  What assures that
> > qmp_migrate will not give an error?
> >
> >> +    qapi_free_MigrationChannelList(caps);
> >
> >
> >
> >
> >>
> >>       if (!detach) {
> >>           HMPMigrationStatus *status;
> >> @@ -766,6 +780,9 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
> >>                                             status);
> >>           timer_mod(status->timer,
> qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
> >>       }
> >> +
> >> +end:
> >> +    hmp_handle_error(mon, err);
> >
> > Oh, you put it here, but you enter in the detach case even if there is
> > one error.
> >
> > I think it is easier to just repeat the hmp_mhandle_error() inplace of
> > the goto.
>
> Okay Juan, will add hmp_handle_error() instead of goto statement
>
> if (!migrate_uri_parse(uri, &channel, &err)) {
>      hmp_handle_error(mon, err);
>      return;
> }
>
> I will send new patchset, squash previous commits and add the tags
> wherever required.
>
> > Later, Juan.
> Regards,
> Het Gala
>
>

--000000000000f1ab3b060907b4a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I intrehated al parches until this forma next pull.</div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue=
, Oct 31, 2023, 19:51 Het Gala &lt;<a href=3D"mailto:het.gala@nutanix.com">=
het.gala@nutanix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
><br>
On 31/10/23 11:12 pm, Juan Quintela wrote:<br>
&gt; Fabiano Rosas &lt;<a href=3D"mailto:farosas@suse.de" target=3D"_blank"=
 rel=3D"noreferrer">farosas@suse.de</a>&gt; wrote:<br>
&gt;&gt; From: Het Gala &lt;<a href=3D"mailto:het.gala@nutanix.com" target=
=3D"_blank" rel=3D"noreferrer">het.gala@nutanix.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Integrate MigrateChannelList with all transport backends<br>
&gt;&gt; (socket, exec and rdma) for both src and dest migration<br>
&gt;&gt; endpoints for hmp migration.<br>
&gt;&gt;<br>
&gt;&gt; Suggested-by: Aravind Retnakaran &lt;<a href=3D"mailto:aravind.ret=
nakaran@nutanix.com" target=3D"_blank" rel=3D"noreferrer">aravind.retnakara=
n@nutanix.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Het Gala &lt;<a href=3D"mailto:het.gala@nutanix.com=
" target=3D"_blank" rel=3D"noreferrer">het.gala@nutanix.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Fabiano Rosas &lt;<a href=3D"mailto:farosas@suse.de=
" target=3D"_blank" rel=3D"noreferrer">farosas@suse.de</a>&gt;<br>
&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool resume =3D qdict_get_try_bool(qdict=
, &quot;resume&quot;, false);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *uri =3D qdict_get_str(qdict,=
 &quot;uri&quot;);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Error *err =3D NULL;<br>
&gt;&gt; +=C2=A0 =C2=A0 MigrationChannelList *caps =3D NULL;<br>
&gt;&gt; +=C2=A0 =C2=A0 g_autoptr(MigrationChannel) channel =3D NULL;<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt; -=C2=A0 =C2=A0 qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, in=
c,<br>
&gt;&gt; +=C2=A0 =C2=A0 if (!migrate_uri_parse(uri, &amp;channel, &amp;err)=
) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 QAPI_LIST_PREPEND(caps, g_steal_pointer(&amp;channe=
l));<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, in=
c,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 false, false, true, resume, &amp;err);<br>
&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 if (hmp_handle_error(mon, err)) {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt; -=C2=A0 =C2=A0 }<br>
&gt; I think that dropping this chunk is wrong.=C2=A0 What assures that<br>
&gt; qmp_migrate will not give an error?<br>
&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 qapi_free_MigrationChannelList(caps);<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!detach) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HMPMigrationStatus *status=
;<br>
&gt;&gt; @@ -766,6 +780,9 @@ void hmp_migrate(Monitor *mon, const QDict *qd=
ict)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0status);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timer_mod(status-&gt;timer=
, qemu_clock_get_ms(QEMU_CLOCK_REALTIME));<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; +<br>
&gt;&gt; +end:<br>
&gt;&gt; +=C2=A0 =C2=A0 hmp_handle_error(mon, err);<br>
&gt;<br>
&gt; Oh, you put it here, but you enter in the detach case even if there is=
<br>
&gt; one error.<br>
&gt;<br>
&gt; I think it is easier to just repeat the hmp_mhandle_error() inplace of=
<br>
&gt; the goto.<br>
<br>
Okay Juan, will add hmp_handle_error() instead of goto statement<br>
<br>
if (!migrate_uri_parse(uri, &amp;channel, &amp;err)) {<br>
=C2=A0 =C2=A0 =C2=A0hmp_handle_error(mon, err);<br>
=C2=A0 =C2=A0 =C2=A0return;<br>
}<br>
<br>
I will send new patchset, squash previous commits and add the tags <br>
wherever required.<br>
<br>
&gt; Later, Juan.<br>
Regards,<br>
Het Gala<br>
<br>
</blockquote></div>

--000000000000f1ab3b060907b4a6--


