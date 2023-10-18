Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E88937CE707
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 20:43:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtBTu-0000Ge-0d; Wed, 18 Oct 2023 14:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qtBTr-0000Eo-Sw
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qtBTq-0005gL-D7
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697654476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hVRpz4N57vf0F1Ie7+yJZsDCC62d/0IX2bN2ey/uP4o=;
 b=gwqtvJPii5e9F5BJjGdqDZ53/lofUqSwvZ6xeLNjbnSh1AFX7w9WC5BhjDi9NZzGPx2MOy
 82YeT52Y3Kp+TvsEfBCB2YTqyxJ9qpoyA5wReL3GgS1HL73tpaIR5ZDVOIgAS0rUZ/bt5U
 hky3rPtsL1zeXhbSbS95eZJtvIjMN4Y=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-8hsyvH4LMjeVGLl1Pd0fjQ-1; Wed, 18 Oct 2023 14:41:13 -0400
X-MC-Unique: 8hsyvH4LMjeVGLl1Pd0fjQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5b7bf88d712so2625538a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 11:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697654472; x=1698259272;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hVRpz4N57vf0F1Ie7+yJZsDCC62d/0IX2bN2ey/uP4o=;
 b=tPxUvHMV/VXy12N/RzB1FTb/QJDzi2o68Ie/NcET6lsOpNQFppa0Vsv009dhcy7foG
 siaUIyV1BY36dnFU0Wjtit67dQ0Y+TMtpGzDms47mlRHvjSC0MBy30UnmP2krDk7I1ZV
 A+Ym8g5mY7CA/66pjBb4uRTF94l8ElnXFSk7+tA9ZiLlnGPK+AUstAP57iuPvHiC4mIg
 P4dQm7NFG5/X0ZcSyW0wyEo3CLaqlV0Tp5f511ik2FdQw/KiM74hgu9HLelTohxwXhoP
 8ZbBENZRUPlMTd5TTKdCqcW+DeigxDvgMZ+DReA4k47P3fX1Cayw+DacZOsYUowF3Px0
 yu8Q==
X-Gm-Message-State: AOJu0YwyVfOzLQwLEDeASNMmW/FSuiPh3GI0qI1w01jKQ4YfJZfDhUmX
 eaRKkvGXQlIV4LmgrXMTdFLl+lbiUCGyp4scEusQFlylm4O1XWWBeUHY/tv/HbPyW4B6ahoKbFu
 pBxG+vsgp2yCeKgoEGhlbFavl399HKCM=
X-Received: by 2002:a05:6a20:441d:b0:13e:debc:3657 with SMTP id
 ce29-20020a056a20441d00b0013edebc3657mr249932pzb.30.1697654472331; 
 Wed, 18 Oct 2023 11:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9aR977Oq31OXsoFjmTyxyGFXSYuzTrblTPcsU2Wm2dJHNS/FIetxx07TsF0ht4BJ8qIxa8wTJ+boz0WDoAbw=
X-Received: by 2002:a05:6a20:441d:b0:13e:debc:3657 with SMTP id
 ce29-20020a056a20441d00b0013edebc3657mr249907pzb.30.1697654471970; Wed, 18
 Oct 2023 11:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231004230532.3002201-1-jsnow@redhat.com>
 <20231004230532.3002201-4-jsnow@redhat.com>
 <878r80wbu5.fsf@pond.sub.org>
In-Reply-To: <878r80wbu5.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 18 Oct 2023 14:41:00 -0400
Message-ID: <CAFn=p-aM=zG=pAb78x6VGbUsBeJnR-Di6NkJ0oY7wdihD98c4w@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] qapi: re-establish linting baseline
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Victor Toso de Carvalho <victortoso@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000c0e79b060801fbf8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000c0e79b060801fbf8
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 18, 2023, 4:53 AM Markus Armbruster <armbru@redhat.com> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Some very minor housekeeping to make the linters happy once more.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Queued.  Thanks!
>

Hehehe. Thank you O:-)

--000000000000c0e79b060801fbf8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Wed, Oct 18, 2023, 4:53 AM Markus Armbruster &lt;<a hre=
f=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; writes:<b=
r>
<br>
&gt; Some very minor housekeeping to make the linters happy once more.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
Queued.=C2=A0 Thanks!<br></blockquote></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Hehehe. Thank you O:-)</div></div>

--000000000000c0e79b060801fbf8--


