Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA317EC8FE
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 17:59:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3JE2-0006im-Ll; Wed, 15 Nov 2023 11:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1r3JDw-0006i9-7r
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:58:45 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1r3JDu-0000jJ-ND
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:58:43 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-545557de8e6so18834a12.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 08:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1700067521; x=1700672321; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oYBIIENIjXruZBqOiGfUysD4sF8Ds8/rSHAguxZgy/Q=;
 b=1ZG5xW47NGC0DLDbmVanb0C/ctLDofXrpGd3ybavnHzR8oyyB6X6Gfa/KnVhCSKrVT
 y0sPpHKIF1lFxsb/X/3CylBGiW44B/LxRT61KiQgOX+TijGeaTWUqY8kpxifErvZgJgl
 Y7EJMRBc33JkC2m9tpbBoxZFIrngn6+a6zTrq6r2ZPYBiIrC2mlyn0c6lLFUUITZIw1A
 5sAr0pqCzjqvO7QHCWXGqM9OAQgbn/5T7Uua2I5Fowi/akqY2fFJqjGgFsQYr5HON5da
 qFthQDpsPXYlbBi8PYvkMwKWWKGMLjKrbx8VIo0Zbq3VAN5VxShHYVs3xDYZIC1jZo7a
 l+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700067521; x=1700672321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oYBIIENIjXruZBqOiGfUysD4sF8Ds8/rSHAguxZgy/Q=;
 b=a7DEbuFbAiLl4E8jWMlQ165TT4+96zca+gd2bhCgETu+pp4B/1v7Bb1+gToCHfIk44
 Jd+likCwhKBGWs6TeBERsrL7kjs5Bu6nAb7Xb9ueydYsbbPYLkwlOFUsf2/QHGx9n9x7
 oTu6p2tZDjP8lu59BLbHSRAYl23WpvCaqyOZAbHbpXHlk570nEp3BYaMpZi0VY3rIFH+
 SXz2ij9Ilp0B+QV/ck7YXYGojOH5o6JUEyRiOj8on4zumZjuD5vaVyXVmjK7ilLKjHSr
 U7MQlLIicYBPL34Ct3UjwGLIqFNDLUEKMvqdwP7M2HxV/5KSKj986ma3oypvwgI5bGI4
 S1Ag==
X-Gm-Message-State: AOJu0Yyg/AWijKcGWf+ej6roRSRUtoGpfHh16hJGSFDRlp8mPg6i+fxk
 Y2+U4BLFRAy7JP9G+7OHFF//pR0OHXkQLOvO7pmwYw==
X-Google-Smtp-Source: AGHT+IG/3hbJgqf6E8siaEx1mfYIdw1DBWuuGNhVu+jsLTaCjxyfAeOq0BWdQKYKWT/MEfBflfOSEP6u/Lyl+vXcRro=
X-Received: by 2002:aa7:c05a:0:b0:545:94d:7b with SMTP id
 k26-20020aa7c05a000000b00545094d007bmr158094edo.4.1700067520897; 
 Wed, 15 Nov 2023 08:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20231114205507.3792947-1-venture@google.com>
 <CAFEAcA_cKSM-N0nkjtg4UYKwQwBRxffifteU3P=BBxxhEyePsw@mail.gmail.com>
In-Reply-To: <CAFEAcA_cKSM-N0nkjtg4UYKwQwBRxffifteU3P=BBxxhEyePsw@mail.gmail.com>
From: Patrick Venture <venture@google.com>
Date: Wed, 15 Nov 2023 08:58:29 -0800
Message-ID: <CAO=notzk2Dv3LOh+w1XZ1H6vTdq4sp_KvOat4Dj1vbDBhJKzvA@mail.gmail.com>
Subject: Re: [PATCH] softmmu/memory: use memcpy for multi-byte accesses
To: Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, 
 philmd@linaro.org, qemu-devel@nongnu.org, Chris Rauer <crauer@google.com>, 
 Peter Foley <pefoley@google.com>
Content-Type: multipart/alternative; boundary="000000000000adfd59060a33d008"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=venture@google.com; helo=mail-ed1-x52d.google.com
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

--000000000000adfd59060a33d008
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 2:35=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Tue, 14 Nov 2023 at 20:55, Patrick Venture <venture@google.com> wrote:
> > Avoids unaligned pointer issues.
> >
>
> It would be nice to be more specific in the commit message here, by
> describing what kind of guest behaviour or machine config runs into this
> problem, and whether this happens in a situation users are likely to
> run into. If the latter, we should consider tagging the commit
> with "Cc: qemu-stable@nongnu.org" to have it backported to the
> stable release branches.
>

Thanks! I'll update the commit message with v2.  We were seeing this in our
infrastructure with unaligned accesses using the pointer dereference as
there are no guarantees on alignment of the incoming values.


>
> thanks
> -- PMM
>

--000000000000adfd59060a33d008
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 15, 2023 at 2:35=E2=80=AF=
AM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayd=
ell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Tue, 14 Nov 2023 at 20:55, Patrick Venture &lt;<a href=3D"=
mailto:venture@google.com" target=3D"_blank">venture@google.com</a>&gt; wro=
te:<br>
&gt; Avoids unaligned pointer issues.<br>
&gt;<br>
<br>
It would be nice to be more specific in the commit message here, by<br>
describing what kind of guest behaviour or machine config runs into this<br=
>
problem, and whether this happens in a situation users are likely to<br>
run into. If the latter, we should consider tagging the commit<br>
with &quot;Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">=
qemu-stable@nongnu.org</a>&quot; to have it backported to the<br>
stable release branches.<br></blockquote><div><br></div><div>Thanks! I&#39;=
ll update the commit message with v2.=C2=A0 We were seeing this in our infr=
astructure=C2=A0with unaligned accesses using the pointer dereference as th=
ere are no guarantees on alignment of the incoming values.</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--000000000000adfd59060a33d008--

