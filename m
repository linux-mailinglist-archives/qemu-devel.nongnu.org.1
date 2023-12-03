Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E48880253A
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 16:44:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9obv-0004yJ-H8; Sun, 03 Dec 2023 10:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1r9obs-0004xW-ND
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 10:42:20 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1r9obr-0006gy-3U
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 10:42:20 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40b422a274dso52765e9.0
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 07:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701618137; x=1702222937; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KQVZLnYJxTvpClCwQ9PSw3B++ib0BCgP/XV4g3SRaNY=;
 b=FqKm59PNkmR/QJdrQPqCoYn3Vc3H1AXq4o0p771ee8owhoOzg4jPgfHHeHIUuKsZXU
 MvOtveqS3t4hgV4dGYQoVhjiF3OV3k0p6AYJ9CPoiwcBudRWEWL1ONN/dfjTKlTuBOLY
 GRm8X2KmZSfh9t1Fxa8BmgVfCfkav4Kg0Y+LintIRwbjpm1Zd7Bu2gkfh9HDPa+e8uU9
 rWd9sc3RM/NhkZT3DZ4M+AR/5EhHJGHJ89vkXQQSOWqLu8BzbGrPvbG8LWA/ROCQ7Pwl
 L+ztYNZVFlqIyP4m/n7uAX2d61djkgiamRFlobRls61erjMU86vCWeFO0JyKJPIZUqYt
 idcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701618137; x=1702222937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KQVZLnYJxTvpClCwQ9PSw3B++ib0BCgP/XV4g3SRaNY=;
 b=GFRVPm+SuCYFwPVcrn5OZamF8bzR1MOrlibA02AaquC3A3lwBnu8x7hAui6EM9BnCy
 MJzHpQ/AzwHZM7rUb7jJr+SLKCuPn2ztTWt6gLoiB1OrrcVgCVmcJlAtp1feP8NRDpPv
 HgZon+/eA+bkruNVyxl0mHbUpWUtsQ3miInwhiKr8vzAqSN87YMqI0vmd6EV12/MHBZg
 D8SdJEfh7xW9YTci+hmWYXxIs2C5utNyvqJ8tY9mKXqOBNs8Onm0KJgZhYAZ9ebMGcAJ
 FmSr8bfWkOOXJ5Jon+L0BGPsniwV8MPtBP+ZYMm1H62iK/5UEhC0Hh6Wz+ETUZZQ8ihs
 Ncww==
X-Gm-Message-State: AOJu0YyWv3+glCZ1Y+CYugq8pz8fWBII1M6K/tdkkD0jDkQ0sxOC+rzi
 Lt7pg8929iYAGQt8dOWzu3Bk4gAq2GZkw4YjykFCxQ==
X-Google-Smtp-Source: AGHT+IEeeZE/OxL60MlvjpX5+jCmo4ccDDLIw3l9WqHNc1cH7/m/NFzBFFjhwjGd+X0zAfM8BUeFA7ojJDaKdCCHnFI=
X-Received: by 2002:a05:600c:3ca3:b0:40b:5972:f56b with SMTP id
 bg35-20020a05600c3ca300b0040b5972f56bmr318127wmb.3.1701618136674; Sun, 03 Dec
 2023 07:42:16 -0800 (PST)
MIME-Version: 1.0
References: <20231116163633.276671-1-venture@google.com>
 <40d8f91c-e951-413f-8f15-446f0f1b4938@redhat.com>
In-Reply-To: <40d8f91c-e951-413f-8f15-446f0f1b4938@redhat.com>
From: Patrick Venture <venture@google.com>
Date: Sun, 3 Dec 2023 07:42:03 -0800
Message-ID: <CAO=notyr9V2Z3Ad=rm6qinVmfobB4ESn70Bn5rA-3gGm3Siv-w@mail.gmail.com>
Subject: Re: [PATCH v2] system/memory: use ldn_he_p/stn_he_p
To: David Hildenbrand <david@redhat.com>
Cc: pbonzini@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 peter.maydell@linaro.org, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, Chris Rauer <crauer@google.com>, 
 Peter Foley <pefoley@google.com>
Content-Type: multipart/alternative; boundary="000000000000950380060b9cd85e"
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=venture@google.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000950380060b9cd85e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 12:43=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:

> On 16.11.23 17:36, Patrick Venture wrote:
> > Using direct pointer dereferencing can allow for unaligned accesses,
> > which was seen during execution with sanitizers enabled.
> >
> > Reviewed-by: Chris Rauer <crauer@google.com>
> > Reviewed-by: Peter Foley <pefoley@google.com>
> > Signed-off-by: Patrick Venture <venture@google.com>
> > Cc: qemu-stable@nongnu.org
>
>
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
>
> --
> Cheers,
>
> David / dhildenb
>

Friendly ping? Is this going to be applied or do I need to add another CC
or?  I do think it should go into stable.

--000000000000950380060b9cd85e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 17, 2023 at 12:43=E2=80=
=AFAM David Hildenbrand &lt;<a href=3D"mailto:david@redhat.com">david@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On 16.11.23 17:36, Patrick Venture wrote:<br>
&gt; Using direct pointer dereferencing can allow for unaligned accesses,<b=
r>
&gt; which was seen during execution with sanitizers enabled.<br>
&gt; <br>
&gt; Reviewed-by: Chris Rauer &lt;<a href=3D"mailto:crauer@google.com" targ=
et=3D"_blank">crauer@google.com</a>&gt;<br>
&gt; Reviewed-by: Peter Foley &lt;<a href=3D"mailto:pefoley@google.com" tar=
get=3D"_blank">pefoley@google.com</a>&gt;<br>
&gt; Signed-off-by: Patrick Venture &lt;<a href=3D"mailto:venture@google.co=
m" target=3D"_blank">venture@google.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-s=
table@nongnu.org</a><br>
<br>
<br>
<br>
Reviewed-by: David Hildenbrand &lt;<a href=3D"mailto:david@redhat.com" targ=
et=3D"_blank">david@redhat.com</a>&gt;<br>
<br>
-- <br>
Cheers,<br>
<br>
David / dhildenb<br></blockquote><div><br></div><div>Friendly=C2=A0ping? Is=
 this going to be applied or do I need to add another CC or?=C2=A0 I do thi=
nk it should go into stable.</div><div>=C2=A0</div></div></div>

--000000000000950380060b9cd85e--

