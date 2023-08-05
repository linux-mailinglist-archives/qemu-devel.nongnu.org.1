Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04639770CF9
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 03:21:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS5xP-0002n7-Gy; Fri, 04 Aug 2023 21:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qS5xJ-0002mg-Gz
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 21:19:46 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qS5xH-0007id-5p
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 21:19:45 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fe27849e6aso4562881e87.1
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 18:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1691198380; x=1691803180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tfWzbM/S4PqzSik2O63Ovi6KjFI8sGxfctCJDbRLdkA=;
 b=dcz87h/l0TJD7l1CaULZ9AX7OyZQD8BwiG7YMGfjkf5baUPp6TFW0lsrGU57FUYnr2
 7C9hslhmSG6uen6iwC65dBdJvuaHyEICLqMADmqQcjhhjo5h1+FnrQjuIdLPO+QZ4/MV
 23o6wG/F9jDYL4wCAVxJl0rcc05Ga5Ha9ET2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691198380; x=1691803180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tfWzbM/S4PqzSik2O63Ovi6KjFI8sGxfctCJDbRLdkA=;
 b=e/zuam6DddkNOA5EQqwF9+TuMvoBEew8LNF7kBOoqyIeM65xKnoGmjFr9N97nBtjxF
 E7Px3v0wr7EDDBxPucJ3uNiBe56croOVLNJ+pJUSedoPSuNpPmd5rECfvOorXLWvbR9Y
 3xgtsENO0LmUl8v+vhUcpAQZhal3eUrY2FD6uomHH2+Rb6SR91d41H9kDmUrrQjVKvlS
 H05hVz5SROKwzW5e4MuQhGtBzcT3HnCeGDOHAR9YW1nVSrVEl/VnobkhT3SFbpc0xOk8
 mBWHvTszSyAZb7PbkjoOBy9cfuAhBVVmPKLlBskaJsUCN3I1Q4n21+j/CZro+IhYF7Pp
 G0bQ==
X-Gm-Message-State: AOJu0Yy3qYxxQ1OfSl2oGr/PPemBDOP3HgU4aNYn+ITz4fO0IxsB5QnS
 lxXu+xSvF8pTsz0RSa0yt70ogfW7HaDxPYiR5wShqg==
X-Google-Smtp-Source: AGHT+IH73bSXEzDgPVbWhDVszrx3mOtPrhOTkHdQP6IxoRVfTTvwvR+xm/nkaQGVBJblC9X54WHw5A==
X-Received: by 2002:a05:6512:2097:b0:4f8:5ede:d447 with SMTP id
 t23-20020a056512209700b004f85eded447mr2181638lfr.28.1691198379822; 
 Fri, 04 Aug 2023 18:19:39 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com.
 [209.85.128.44]) by smtp.gmail.com with ESMTPSA id
 n18-20020aa7c692000000b005224d15d3dfsm1953654edq.87.2023.08.04.18.19.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Aug 2023 18:19:39 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-3fe1e44fd2bso20025e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 18:19:39 -0700 (PDT)
X-Received: by 2002:a05:600c:6023:b0:3f1:6fe9:4a95 with SMTP id
 az35-20020a05600c602300b003f16fe94a95mr64588wmb.4.1691198378914; Fri, 04 Aug
 2023 18:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230711025649.708-1-gurchetansingh@chromium.org>
 <87351diqf9.fsf@alyssa.is>
 <CAAfnVBkm6yjR8HVWgpCCQkzpQ53unBCTP4Ngk=Z8QeEZ-7MbMw@mail.gmail.com>
 <87zg3aaj04.fsf@alyssa.is>
In-Reply-To: <87zg3aaj04.fsf@alyssa.is>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Fri, 4 Aug 2023 18:19:25 -0700
X-Gmail-Original-Message-ID: <CAAfnVBkLuNeDkgGz2DNvv4iG5oKn6DxP=3s07pVz=9gR+ZK+ug@mail.gmail.com>
Message-ID: <CAAfnVBkLuNeDkgGz2DNvv4iG5oKn6DxP=3s07pVz=9gR+ZK+ug@mail.gmail.com>
Subject: Re: Rutabaga backwards compatibility
To: Alyssa Ross <hi@alyssa.is>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com, 
 akihiko.odaki@gmail.com, dmitry.osipenko@collabora.com, ray.huang@amd.com, 
 alex.bennee@linaro.org, shentey@gmail.com, crosvm-dev@chromium.org
Content-Type: multipart/alternative; boundary="0000000000009f3ebe060222ce6d"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=gurchetansingh@chromium.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000009f3ebe060222ce6d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 1, 2023 at 8:18=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:

> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>
> > On Mon, Jul 24, 2023 at 2:56=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrot=
e:
> >>
> >> Gurchetan Singh <gurchetansingh@chromium.org> writes:
> >>
> >> > In terms of API stability/versioning/packaging, once this series is
> >> > reviewed, the plan is to cut a "gfxstream upstream release branch".
> We
> >> > will have the same API guarantees as any other QEMU project then, i.=
e
> no
> >> > breaking API changes for 5 years.
> >>
> >> What about Rutabaga?
> >
> > Yes, rutabaga + gfxstream will both be versioned and maintain API
> > backwards compatibility in line with QEMU guidelines.
>
> In that case, I should draw your attention to
> <https://crrev.com/c/4584252>, which I've just realised while testing v2
> of your series here breaks the build of the rutabaga ffi, and which will
> require the addition of a "prot" field to struct rutabaga_handle (a
> breaking change).  I'll push a new version of that CL to fix rutabaga
> ffi in the next few days.
>

Sorry, I didn't see this until now.  At first glance, do we need to modify
the rutabaga_handle?  Can't we do fcntl(.., GET_FL) to get the access flags
when needed?

Since this is already coming up, before the release has even been made,
> is it worth exploring how to limit the rutabaga API to avoid more
> breaking changes after the release?  Could there be more use of opaque
> structs, for example?
>
> (CCing the crosvm list)
>

--0000000000009f3ebe060222ce6d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 1, 2023 at 8:18=E2=80=AFA=
M Alyssa Ross &lt;<a href=3D"mailto:hi@alyssa.is">hi@alyssa.is</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Gurchetan Sin=
gh &lt;<a href=3D"mailto:gurchetansingh@chromium.org" target=3D"_blank">gur=
chetansingh@chromium.org</a>&gt; writes:<br>
<br>
&gt; On Mon, Jul 24, 2023 at 2:56=E2=80=AFAM Alyssa Ross &lt;<a href=3D"mai=
lto:hi@alyssa.is" target=3D"_blank">hi@alyssa.is</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@chromium.org"=
 target=3D"_blank">gurchetansingh@chromium.org</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; In terms of API stability/versioning/packaging, once this ser=
ies is<br>
&gt;&gt; &gt; reviewed, the plan is to cut a &quot;gfxstream upstream relea=
se branch&quot;.=C2=A0 We<br>
&gt;&gt; &gt; will have the same API guarantees as any other QEMU project t=
hen, i.e no<br>
&gt;&gt; &gt; breaking API changes for 5 years.<br>
&gt;&gt;<br>
&gt;&gt; What about Rutabaga?<br>
&gt;<br>
&gt; Yes, rutabaga + gfxstream will both be versioned and maintain API<br>
&gt; backwards compatibility in line with QEMU guidelines.<br>
<br>
In that case, I should draw your attention to<br>
&lt;<a href=3D"https://crrev.com/c/4584252" rel=3D"noreferrer" target=3D"_b=
lank">https://crrev.com/c/4584252</a>&gt;, which I&#39;ve just realised whi=
le testing v2<br>
of your series here breaks the build of the rutabaga ffi, and which will<br=
>
require the addition of a &quot;prot&quot; field to struct rutabaga_handle =
(a<br>
breaking change).=C2=A0 I&#39;ll push a new version of that CL to fix rutab=
aga<br>
ffi in the next few days.<br></blockquote><div><br></div><div>Sorry, I didn=
&#39;t see this until now.=C2=A0 At first glance, do we need to modify the =
rutabaga_handle?=C2=A0 Can&#39;t we do=C2=A0fcntl(.., GET_FL) to get the ac=
cess flags when needed?</div><div><br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
Since this is already coming up, before the release has even been made,<br>
is it worth exploring how to limit the rutabaga API to avoid more<br>
breaking changes after the release?=C2=A0 Could there be more use of opaque=
<br>
structs, for example?<br>
<br>
(CCing the crosvm list)<br>
</blockquote></div></div>

--0000000000009f3ebe060222ce6d--

