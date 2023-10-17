Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE567CBD5A
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:27:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfP5-0002jT-Rx; Tue, 17 Oct 2023 04:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qsfOy-0002id-Mm
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qsfOt-0004Ro-A2
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mSdEEDdyKQgZUAT/SSkOH7G+1xle4J8Edztx006dJyg=;
 b=Sef9w2qL5SYySKKC8ByyvTyVQiHXjOmKeon+0uXVTmdSwsyG0diAxb79Xvg+1XSk9c6O2O
 AyKFJhyKzeRj1/ymHEhRtCrJdD4QQZGGT7eHwNIzMJc7IxX59GN+7EgZqlZOM8Z/nIxaAS
 5saP7CXh3PlwDtr4Xno/3dZ7e1D5rYQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-ofD-yUsCNCmzmi2LzFmh2Q-1; Tue, 17 Oct 2023 04:25:59 -0400
X-MC-Unique: ofD-yUsCNCmzmi2LzFmh2Q-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5b7e91d53e5so782580a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 01:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697531158; x=1698135958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mSdEEDdyKQgZUAT/SSkOH7G+1xle4J8Edztx006dJyg=;
 b=PrS7ytqxRO4cERq2AS0VDIZ6ktwYk77XpQe2AWC4ryORaxFr50/LuO8CG4alXgBGYU
 eJRnnVviH3jvlZS9kD09tuYDdSV5UTJSAnWGLaL1Z77poZhoykaT70W7V19Rd2nfatlx
 xCzWfkhLs0A3pljScfh1LS0sUsRjlv3DBjubMK3+AmwO1H8NHq25o8mEp+UrnHYVtbzb
 L1/kvMhFS9aJ4H5SXkKQuKqhk12BZq7gmuQfbxzNxNmm2Ho8NQI+MEgl2brHvkBy3uu+
 r3JqL10Op9wSQqleOOxeRsPOG8L6nMNP4jJV3YkCiymGH5KZBq8b3EkpN4kDzGbYl3JR
 Tdeg==
X-Gm-Message-State: AOJu0YzfFimt8vNMPV6I1eT5jSafUozfMatn39c8M+4E6eTnmKmI5mhl
 HUTry9SNoLyqF8ieMaG4lrqu2lfUTduOqMoCsccqLsh0t0XptQYasBGXDx2kK0eaDB3uahE+NAe
 ZtqgV9xHqgsfz2EycDgGblO6ReMsVwzU=
X-Received: by 2002:a05:6a21:7185:b0:174:63a9:293 with SMTP id
 wq5-20020a056a21718500b0017463a90293mr1539499pzb.48.1697531158514; 
 Tue, 17 Oct 2023 01:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpL8aWm2Y4dYsrCjKaPrXzLhtYhLkL6FTd4pvLWpSh6+AHRpM0eAC6fd4go25EY8vZJF+O6MA6sNlfBkWRpDc=
X-Received: by 2002:a05:6a21:7185:b0:174:63a9:293 with SMTP id
 wq5-20020a056a21718500b0017463a90293mr1539481pzb.48.1697531158189; Tue, 17
 Oct 2023 01:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231016083201.23736-1-hreitz@redhat.com>
 <2m60m.9e9wlnnm01vd@linaro.org>
 <20231016103254.7xrnptmwrjnsr3uc@vireshk-i7> <87lec2dc7r.fsf@linaro.org>
 <20231017053638.hhs57axmwqtzbpp6@vireshk-i7>
 <ceeaa1f3-c0ad-65c1-80d1-ec869f976146@redhat.com>
 <20231017075352.2l3htkj46gunyjrm@vireshk-i7>
In-Reply-To: <20231017075352.2l3htkj46gunyjrm@vireshk-i7>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 17 Oct 2023 10:25:46 +0200
Message-ID: <CADSE00JkwkyruO-rhiN7p_T_2efAed8B2Uzp01jVj=YH7Wixmw@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: Fix protocol feature bit conflict
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Hanna Czenczek <hreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Garhwal, Vikram" <vikram.garhwal@amd.com>
Content-Type: multipart/alternative; boundary="000000000000adf0f00607e5456c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
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

--000000000000adf0f00607e5456c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

Thanks for the patch, and sorry for not noticing the flag had already been
assigned. The patch looks good to me!

BR,
Albert

On Tue, Oct 17, 2023 at 9:54=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg>
wrote:

> On 17-10-23, 09:51, Hanna Czenczek wrote:
> > Not that I=E2=80=99m really opposed to that, but I don=E2=80=99t see th=
e problem with
> just
> > doing that in the same work that makes qemu actually use this flag,
> exactly
> > because it=E2=80=99s just a -1/+1 change.
> >
> > I can send a v2, but should I do the same for libvhost-user and define
> the
> > flag there?  Do I have to add a patch to do the same for F_STATUS, whic=
h
> so
> > far only got a placeholder comment?
>
> Sure, that's fine too.
>
> --
> viresh
>
>

--000000000000adf0f00607e5456c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi!<div><br></div><div>Thanks for the patch, and sorry for=
 not noticing the flag had already been assigned. The patch looks good to m=
e!</div><div><br></div><div>BR,</div><div>Albert<br></div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 17, 2=
023 at 9:54=E2=80=AFAM Viresh Kumar &lt;<a href=3D"mailto:viresh.kumar@lina=
ro.org">viresh.kumar@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On 17-10-23, 09:51, Hanna Czenczek wrote:<=
br>
&gt; Not that I=E2=80=99m really opposed to that, but I don=E2=80=99t see t=
he problem with just<br>
&gt; doing that in the same work that makes qemu actually use this flag, ex=
actly<br>
&gt; because it=E2=80=99s just a -1/+1 change.<br>
&gt; <br>
&gt; I can send a v2, but should I do the same for libvhost-user and define=
 the<br>
&gt; flag there?=C2=A0 Do I have to add a patch to do the same for F_STATUS=
, which so<br>
&gt; far only got a placeholder comment?<br>
<br>
Sure, that&#39;s fine too.<br>
<br>
-- <br>
viresh<br>
<br>
</blockquote></div>

--000000000000adf0f00607e5456c--


