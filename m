Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5722772F9A
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 21:42:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT66s-0005f7-JQ; Mon, 07 Aug 2023 15:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qT66k-0005ei-K8
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 15:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qT66i-0004c0-T1
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 15:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691437295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T3FrIEHUYmjKjA7vmnM+MwzZcDFVQxsehRFDJMxthLk=;
 b=WKBbw4v4QwZB6LOQ/wBQjFNtTAq+wtaMTR9GhnXO22hAadPgxAUmC7nXDtWu8FCOB8F/XV
 bm/b74uCg4ViJ1qeWc1zSLyTeQ5kGQlJsSHrnpH5u8cRm/Sp/7oDStGROxgh17rYgOT8/e
 vJzVJE9RqOoZ8EX3keZZiqogbAMvDbs=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-KMCe3c4LOP2PeZNM-O9oug-1; Mon, 07 Aug 2023 15:41:33 -0400
X-MC-Unique: KMCe3c4LOP2PeZNM-O9oug-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-79aca015f70so941448241.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 12:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691437293; x=1692042093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T3FrIEHUYmjKjA7vmnM+MwzZcDFVQxsehRFDJMxthLk=;
 b=U0caF+XYNlvvT/6x16nyQ88crDwbpmgxbw8+UMB0+VdqoNFS5va6+7dE3xkbQaCuwM
 S/bnke0+OWS4Z5xzu4fZ5Ea7l/rViicT8bzNczqGPU2QgcwbrZgRErJEp2q4Ski8xIxK
 aFwYEEYCCvdCO+f1pVVYi46UKndT+S+dCOwD/KbE6TYPfRs/F4JmS7Ltz6nv2pofN2ie
 6d7HgxwUqCaEh3WQ1Zd4XBgXj/lMPNmFc4Qv5r8I1rh2/dndsnruQhw5GMXi0eTNwQ1q
 XdWH0yx4cYuOeAOD8g7AZFgeRwEvr9O8YLlC2S/7BAcT+8v55yVRGtZBsO2l6hXL/Jyb
 8XMg==
X-Gm-Message-State: AOJu0YxWLLEv/K6VCCIipQshOd11luI36Rm6o4dw9KCIKrrvLRTxDEws
 /m/qy/ku+wjbWPcHrjsfHaizx26SBrniONWoOVQ+aPc6lTe0Vnt3cs43OBTmH5OdZffiwxVC7VI
 ivypyNxgw0ZdpqJU9NzWCGLQDJCPfNuQ=
X-Received: by 2002:a05:6102:3a42:b0:445:5314:fd76 with SMTP id
 c2-20020a0561023a4200b004455314fd76mr5255064vsu.3.1691437292920; 
 Mon, 07 Aug 2023 12:41:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRTPdsJUk1SukKKvpYHrfmimUAbWrhV+lYI5g3jwI/wyyFOLHN0xMnXQoii+III0tjmdCNfCH5zBckZKNXAvI=
X-Received: by 2002:a05:6102:3a42:b0:445:5314:fd76 with SMTP id
 c2-20020a0561023a4200b004455314fd76mr5255057vsu.3.1691437292690; Mon, 07 Aug
 2023 12:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230807094807.471646-1-pbonzini@redhat.com>
 <20230807094807.471646-3-pbonzini@redhat.com>
 <6420392676438a75c2696236299d7b31abe12bd0.camel@linux.ibm.com>
In-Reply-To: <6420392676438a75c2696236299d7b31abe12bd0.camel@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 7 Aug 2023 21:41:21 +0200
Message-ID: <CABgObfbXEXQPPnoGf2rN7yiLSo_WBqARHxMnaO6t-gG7EzFuxg@mail.gmail.com>
Subject: Re: [PATCH 2/3] linux-user: cleanup unused linux-user/include/host
 directories
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000fdb85a06025a6e57"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

--000000000000fdb85a06025a6e57
Content-Type: text/plain; charset="UTF-8"

Yes, found the same in CI. I will send V2 tomorrow.

Paolo

Il lun 7 ago 2023, 19:18 Ilya Leoshkevich <iii@linux.ibm.com> ha scritto:

> On Mon, 2023-08-07 at 11:48 +0200, Paolo Bonzini wrote:
> > Alpha and 31-bit s390 lack the assembly fragment to handle signals
> > occurring at the same time as system calls, so they cannot run
> > linux-user emulation anymore.  Drop the host-signal.h files for
> > them.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  linux-user/include/host/alpha/host-signal.h |  55 --------
> >  linux-user/include/host/s390/host-signal.h  | 138 ------------------
> > --
> >  2 files changed, 193 deletions(-)
> >  delete mode 100644 linux-user/include/host/alpha/host-signal.h
> >  delete mode 100644 linux-user/include/host/s390/host-signal.h
>
> s390/host-signal.h is included by s390x/host-signal.h, so on a (64-bit)
> s390x host I get:
>
> In file included from ../linux-user/signal.c:33:
> ../linux-user/include/host/s390x/host-signal.h:1:10: fatal error:
> ../s390/host-signal.h: No such file or directory
>     1 | #include "../s390/host-signal.h"
>
>

--000000000000fdb85a06025a6e57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yes, found the same in CI. I will send V2 tomorrow.<div d=
ir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 7 ago 2023, 19:18=
 Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com">iii@linux.ibm.co=
m</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Mon, 2023-=
08-07 at 11:48 +0200, Paolo Bonzini wrote:<br>
&gt; Alpha and 31-bit s390 lack the assembly fragment to handle signals<br>
&gt; occurring at the same time as system calls, so they cannot run<br>
&gt; linux-user emulation anymore.=C2=A0 Drop the host-signal.h files for<b=
r>
&gt; them.<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson=
@linaro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.=
org</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0linux-user/include/host/alpha/host-signal.h |=C2=A0 55 --------<=
br>
&gt; =C2=A0linux-user/include/host/s390/host-signal.h=C2=A0 | 138 ---------=
---------<br>
&gt; --<br>
&gt; =C2=A02 files changed, 193 deletions(-)<br>
&gt; =C2=A0delete mode 100644 linux-user/include/host/alpha/host-signal.h<b=
r>
&gt; =C2=A0delete mode 100644 linux-user/include/host/s390/host-signal.h<br=
>
<br>
s390/host-signal.h is included by s390x/host-signal.h, so on a (64-bit)<br>
s390x host I get:<br>
<br>
In file included from ../linux-user/signal.c:33:<br>
../linux-user/include/host/s390x/host-signal.h:1:10: fatal error:<br>
../s390/host-signal.h: No such file or directory<br>
=C2=A0 =C2=A0 1 | #include &quot;../s390/host-signal.h&quot;<br>
<br>
</blockquote></div>

--000000000000fdb85a06025a6e57--


