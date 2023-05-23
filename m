Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D83A70DF6C
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:36:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1T7Y-0007Q1-53; Tue, 23 May 2023 10:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q1T7V-0007PW-DY
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q1T7T-0006HY-TP
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684852570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w7vU7mDKi8jfo4a2JcT7cBkT7na3/1PWsgYYvBA0muM=;
 b=KkuFLkmHJ5NMGleR0eCzZUDeYm7USXVve4yuAzRdFbdSwVFZfzmsoXnzArmLB+3ZCOEPeW
 QflHdYw+WZobX6Bqb4BaqePSbSfjEP6weXCTtgadt0pzHqA+H4uWM+bHbwEgqqK89CEcmK
 HYq6WF2bb326K5RbP9WCe/gkpYD7KEc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-mWxvp_YkOGq8VFZ45RwGtA-1; Tue, 23 May 2023 10:36:08 -0400
X-MC-Unique: mWxvp_YkOGq8VFZ45RwGtA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2555076ea4dso2660483a91.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 07:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684852568; x=1687444568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w7vU7mDKi8jfo4a2JcT7cBkT7na3/1PWsgYYvBA0muM=;
 b=CNifUQGdIXYmRJz5gzgE254AOURm3w9kqpW+BnXX+eXC6CMkgek2XkkSBUzl5W0m93
 IluHZE+ivJJRn/ogkQg4KPXSM99uLm5XIMN+IOBF8cLjMc1Y7J47Xrycu2baVQcUVHGs
 Din7DN7IEKOUT69aIxTEMlkLRs18XRmyybXx3hhhPbP6SRjTOHIDr8spVelwiTKCoc2U
 A8EBRdUmA3B+SSYaaoyKXjDm4vgbLmbjDCx6yp4MbPs/v5zADKIxSsHXl9FUVA185hjB
 fnTUWep3Fxw05x0lFWqv/Fi8h1028Mdb4kZL89xLJzbsjvesN4OTO9sKNRQbW8KJ6ve5
 MLzQ==
X-Gm-Message-State: AC+VfDwR7Avgl/PlFcI0daLsjlye4imYBrCs5m5HO2C5C6LHDka3VnQ0
 EbktTHf6T1uZ3g2X94zK9JzjP92DyERuvD1EMWMnqmzp2sb0z+q26aA6g6M+LtR/MiPlINbQsal
 L8Khey6ILJFRONdOUgVXIBoZJgb/+18c=
X-Received: by 2002:a17:90b:3587:b0:24d:ebfe:be93 with SMTP id
 mm7-20020a17090b358700b0024debfebe93mr13185181pjb.37.1684852567919; 
 Tue, 23 May 2023 07:36:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5IgVrS8y1zJELoENjwm7tbwIxLOt9lBUuH5Ieq44Y8fCGbZNkRCvEXsr3CmO4nvc1GCMqvBIz7fcpM2f+TpX0=
X-Received: by 2002:a17:90b:3587:b0:24d:ebfe:be93 with SMTP id
 mm7-20020a17090b358700b0024debfebe93mr13185159pjb.37.1684852567465; Tue, 23
 May 2023 07:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230416222838.36642-1-mateusz.p.albecki@gmail.com>
 <20230416222838.36642-2-mateusz.p.albecki@gmail.com>
 <CAFn=p-bcAW9aMymmWeVSMeyuT88YDZ2iYVh-t1GoogbBBPFjSw@mail.gmail.com>
 <CAGe=PKEvnnjBQVx-rNDXjmwvQ272S2DLw-xEDjp1vVuU30i4Hw@mail.gmail.com>
In-Reply-To: <CAGe=PKEvnnjBQVx-rNDXjmwvQ272S2DLw-xEDjp1vVuU30i4Hw@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 23 May 2023 10:35:56 -0400
Message-ID: <CAFn=p-bVdQ6E10F9FmapMcBvEUMX7hOjr-kz7FgfQL+cdJHV+A@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/ide/core.c: fix handling of unsupported commands
To: Mateusz Albecki <mateusz.p.albecki@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Mateusz Albecki <mateusz.albecki@outlook.com>, 
 Niklas Cassel <niklas.cassel@wdc.com>, Niklas Cassel <nks@flawful.org>
Content-Type: multipart/alternative; boundary="000000000000c8764b05fc5d4e0d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000c8764b05fc5d4e0d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 5:16=E2=80=AFPM Mateusz Albecki <mateusz.p.albecki@=
gmail.com>
wrote:
>
> Certainly seems like my patch is wrong as it will make the abort path
execute ide_cmd_done twice. During debug I came to the conclusion that
ide_cmd_done is not called at all as I was getting timeouts on the driver
side while waiting for D2H FIS. I am still not sure how I was getting this
behavior if the problem was actually with setting correct error bits. Even
so I think it can be safely assumed that Niklas' change will solve the
issue, I will try to verify it in a couple of days and if I see any problem
I will come back to you.
>
> Mateusz

Great, thanks :)

I'm waiting to hear back from Niklas, but I'm hoping to take their patches
this cycle as I think they look quite good.

Thank you for submitting bug reports and patches :~)

--js

--000000000000c8764b05fc5d4e0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br>
<br>
On Mon, May 22, 2023 at 5:16=E2=80=AFPM Mateusz Albecki &lt;<a href=3D"mail=
to:mateusz.p.albecki@gmail.com" target=3D"_blank" rel=3D"noreferrer">mateus=
z.p.albecki@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Certainly seems like my patch is wrong as it will make the abort path =
execute ide_cmd_done twice. During debug I came to the conclusion that ide_=
cmd_done is not called at all as I was getting timeouts on the driver side =
while waiting for D2H FIS. I am still not sure how I was getting this behav=
ior if the problem was actually with setting correct error bits. Even so I =
think it can be safely assumed that Niklas&#39; change will solve the issue=
, I will try to verify it in a couple of days and if I see any problem I wi=
ll come back to you.<br>
&gt;<br>
&gt; Mateusz<br><br><div dir=3D"auto">Great, thanks :)</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">I&#39;m waiting to hear back from Niklas, bu=
t I&#39;m hoping to take their patches this cycle as I think they look quit=
e good.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thank you for su=
bmitting bug reports and patches :~)</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">--js</div></div>

--000000000000c8764b05fc5d4e0d--


