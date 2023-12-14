Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E50FD813BA7
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 21:40:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDsUL-0002aN-BQ; Thu, 14 Dec 2023 15:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rDsUJ-0002YA-8x
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 15:39:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rDsUH-0008H4-CR
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 15:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702586356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ev346Txp+rbZ5OPumLBMG4rG9gkpqu+bGYFxDiB6H3U=;
 b=S9SOs4WYvPBtBYzyEomny4XGQLmNoRpzlVpP45gpnDko3DxTsQUK6iagMgCr62mynh1Jr+
 3woXZ8JCTRX72hU1zmqhlTgiLrGgDugLckbgrLDNypswyb5yOMJr7S74gcZg3nIh1SdwAH
 uRtTmB+NOWZTbjSWmnsZDe1OEMqz60A=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-bUJoHs2XM8uddY-h3g3GmQ-1; Thu, 14 Dec 2023 15:39:14 -0500
X-MC-Unique: bUJoHs2XM8uddY-h3g3GmQ-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-4b69322a658so206194e0c.2
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 12:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702586354; x=1703191154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ev346Txp+rbZ5OPumLBMG4rG9gkpqu+bGYFxDiB6H3U=;
 b=mTkLk+OJjKAAgtSUfKLq2fDXDtrBVnTYxDXc2290sIIkNcJ33eF6iOx1hnPmusx+94
 eouiiNW+vWrxaj/7LbOviSIqxJm26vG0EPhe2jZdnPqoD++vzHs5kZSIXSHIT8YOdkk0
 jDhihAr91IkZ5yKANB2kFEWWZXzF7f3RiSq/WpNI2YoZ6VEVTWXvK+Ge3u+NvYXJjkkd
 4cxuYgu9hJ+GzRm6KuT4Jz3lxcaLNXV5HixkPnqEqfv0BVAKPmUVDQX5GBWiPE8JYpJn
 SIoeQdceDnJl45gPxB061fPhv5nYZ61nbvQLemEKEU9Z8t8zSfGH8EaJrb6UKeWfrqOq
 jtjw==
X-Gm-Message-State: AOJu0YyTslzviLybyIUprdLeuHEox+v5hN4HPpYc/Ck518Gh0pOXuLBR
 EOCLd7r3oY8ZeXjSHOOERUhetKmBvxQglI7I1ktPKy9st5mzYTytgLjcY/RVG1sHmsjqIRO2Mv2
 xxmOH7c1pT/HU7snrj5qP92jpFbNQ/mo=
X-Received: by 2002:a05:6122:444a:b0:4b2:c554:e3f9 with SMTP id
 cy10-20020a056122444a00b004b2c554e3f9mr3820493vkb.25.1702586353790; 
 Thu, 14 Dec 2023 12:39:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF565nlju7URA4wtZMZQTxLn0iMHUTjw+swt42UhW5fb/1HqViGETWZBPNS7AKeOYoeSW/OIf7I4saG3FNm3pM=
X-Received: by 2002:a05:6122:444a:b0:4b2:c554:e3f9 with SMTP id
 cy10-20020a056122444a00b004b2c554e3f9mr3820482vkb.25.1702586353310; Thu, 14
 Dec 2023 12:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <20231213211544.1601971-4-stefanha@redhat.com>
 <CABgObfYWPVFcqa5bBhPMZuS-6hh=nAt=pHztL5YHSAQOwiarig@mail.gmail.com>
 <20231214201213.GC1645604@fedora>
In-Reply-To: <20231214201213.GC1645604@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 14 Dec 2023 21:39:02 +0100
Message-ID: <CABgObfb06Z=2q0Yqa9x0VcDJdRPV_siE2VDHnQTyaKkG1AgFug@mail.gmail.com>
Subject: Re: [RFC 3/3] aio-posix: call ->poll_end() when removing AioHandler
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Fiona Ebner <f.ebner@proxmox.com>
Content-Type: multipart/alternative; boundary="000000000000c9f78c060c7e461e"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--000000000000c9f78c060c7e461e
Content-Type: text/plain; charset="UTF-8"

Il gio 14 dic 2023, 21:12 Stefan Hajnoczi <stefanha@redhat.com> ha scritto:

> Since the fd may be bypassed until ->io_poll_end() returns, we must poll
> one last time to check if an event snuck in right at the end without
> making the fd readable. If polling detected an event, then we must do
> something. We cannot drop the event


I agree that in general we cannot. I wonder however if, in the (already
racy) case of a concurrent aio_set_fd_handler(ctx, fd, NULL, ...), you
really need to call poll_ready here.

>
> (An alternative is to poll once before monitoring the fd again. That way
> pending events are detected even if the fd wasn't readable. That is
> currently not the way aio-posix.c works though.)
>

Yes, that would be a change. If I understood correctly Hanna's suggestions
in the issue, she also mentioned doing a manual virtqueue notification
before monitoring restarts. So basically my idea boils down to implementing
that, and then cleaning up everything on top.

Paolo



> Stefan
>

--000000000000c9f78c060c7e461e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 14 dic 2023, 21:12 Stefan Hajnoczi &lt;<a href=
=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">Since the fd may be bypassed until -&g=
t;io_poll_end() returns, we must poll<br>
one last time to check if an event snuck in right at the end without<br>
making the fd readable. If polling detected an event, then we must do<br>
something. We cannot drop the event</blockquote></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">I agree that in general we cannot. I wonder =
however if, in the (already racy) case of a concurrent aio_set_fd_handler(c=
tx, fd, NULL, ...), you really need to call poll_ready here.</div><div dir=
=3D"auto"></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
<br>
(An alternative is to poll once before monitoring the fd again. That way<br=
>
pending events are detected even if the fd wasn&#39;t readable. That is<br>
currently not the way aio-posix.c works though.)<br></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, that would be a change=
. If I understood correctly Hanna&#39;s suggestions in the issue, she also =
mentioned doing a manual virtqueue notification before monitoring restarts.=
 So basically my idea boils down to implementing that, and then cleaning up=
 everything on top.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paol=
o</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Stefan<br>
</blockquote></div></div></div>

--000000000000c9f78c060c7e461e--


