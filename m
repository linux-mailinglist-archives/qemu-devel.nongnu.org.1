Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EC57CD69A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1um-0001PC-Oc; Wed, 18 Oct 2023 04:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qt1uj-0001JX-Jv
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:25 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qt1uf-0003T0-KB
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:25 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso41274325ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1697617576; x=1698222376;
 darn=nongnu.org; 
 h=message-id:in-reply-to:to:references:date:subject:mime-version:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cKXetYOn3HgpUnuFeZIaD5GaOkqW5KOe6VfcdmueEKw=;
 b=KoWvOHB6iYZgDuAuG+CdFxXtSn8VhcEKuvqzBTmhzy9gZdlCc3VKZMXyXuCzGqQy8h
 1xtquI6Q7Xb7RU2ocYRbKfRvvZmdZYTNbV0yW/fJ975hYaW208o2vvTiS2885gIoZ6rv
 3nrMVDL+lU6+iEszm4Q5nygiCW8bqZGFvJP+yxwZtpeasXAG5u0iu7CENPZqXUWQFpSZ
 UeJl0HdBn58d2PpGtgWshSi/Xmlf8N5Q3x4hi+6kCqmSlvWogMAwIPKozfmvQUDebQ3c
 eBQKtnuhN3BKve4vr87sf/yUDX3FQCT0HnsPZorgw5EJc3JQOmRnA3dcbwRN7v3nNDRS
 6hXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617576; x=1698222376;
 h=message-id:in-reply-to:to:references:date:subject:mime-version:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cKXetYOn3HgpUnuFeZIaD5GaOkqW5KOe6VfcdmueEKw=;
 b=bbHrLMi4CF05ws2uSdXlGLR4dMU+Nz01FMuW2K5Or8nD/FSFGJN3O3aI8/iUhL1WR6
 EltjbL0RUjvLsgrRwpQWVtL0EPgaSvaxcOTCafF8fSyWuHrtLJN+UwRvKDWy0CmgiIqc
 WzqI8f5hO0i7WDC8mGlN0uEboeDNhhEu0+4LS53JFRve4IElQgLNDbJ5t9qs2Fjf7/9t
 DlQZpQDP+WP0AZ99M6lh8WgX+I4k2MMTI3Y9cathMLj7AlVQ/cwW9Tem+t/PN1f3Ezkb
 BqwrZB+ON4TZ/ZuK5sgW9e4lHrNsalC2cmFDkTUYRx83MsdOOPPJ6nvegm9AjYF080e3
 evxg==
X-Gm-Message-State: AOJu0Yyct0S+QRc1QtVTioCLE0MI359f9G6hCJAvXkOQUCU0CpJhH5rv
 RpUyr9tBbQAwkXRpq8cU87OSOg==
X-Google-Smtp-Source: AGHT+IERJS8XD7WJ5e4DjO41iK67SH8rHpYhAxb7KRd8lFOucvVB7bV2yI/J7gBcyVMFRioVYttJ3g==
X-Received: by 2002:a17:902:d2cb:b0:1b8:94e9:e7cb with SMTP id
 n11-20020a170902d2cb00b001b894e9e7cbmr4748845plc.21.1697617575782; 
 Wed, 18 Oct 2023 01:26:15 -0700 (PDT)
Received: from smtpclient.apple ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a170902b7c700b001b896686c78sm2917598plz.66.2023.10.18.01.26.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Oct 2023 01:26:15 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_87F406BE-6FBD-4784-8963-F5A5390EBDFB"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH v8 0/5] Implement reconnect for vhost-user-scsi
Date: Wed, 18 Oct 2023 16:26:10 +0800
References: <20231009044735.941655-1-fengli@smartx.com>
To: Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
In-Reply-To: <20231009044735.941655-1-fengli@smartx.com>
Message-Id: <9D9DFA75-541B-4EE9-831F-B2FF941B3E41@smartx.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)
Received-SPF: none client-ip=2607:f8b0:4864:20::643;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x643.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail=_87F406BE-6FBD-4784-8963-F5A5390EBDFB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello Guys,
Ping=E2=80=A6=20
These patches have been waiting for a long time. Can they be merged?

Best Regards,=20
li

> On 9 Oct 2023, at 12:46=E2=80=AFPM, Li Feng <fengli@smartx.com> wrote:
>=20
> Changes for v8:
> - [PATCH 3/5] vhost-user-scsi: support reconnect to backend
>  - Fix code style suggested by Manos Pitsidianakis
> - [PATCH 4/5] vhost-user-scsi: start vhost when guest kicks
>  - Use 'DEVICE()' macro in vhost_user_scsi_handle_output to replace =
the
>    'parent_obj.parent_obj.parent_obj.parent_obj'.
>=20
> Changes for v7:
> - [PATCH 3/5] vhost-user-scsi: support reconnect to backend
>  - Add reporting the error in vhost-scsi;
>  - Rebase to master and fix the conflict.
> - Add "Reviewed-by" tags.
>=20
> Changes for v6:
> - [PATCH] vhost-user: fix lost reconnect
>  - Fix missing assign event_cb.
>=20
> Changes for v5:
> - No logic has been changed, just move part of the code from patch 4 =
to patch 5.
>=20
> Changes for v4:
> - Merge
>  =
https://lore.kernel.org/all/20230830045722.611224-1-fengli@smartx.com/ =
to
>  this series.
> - Add ERRP_GUARD in vhost_user_scsi_realize;
> - Reword the commit messages.
>=20
> Changes for v3:
> - Split the vhost_user_scsi_handle_output to a separate patch;
> - Move the started_vu from vhost scsi common header to vhost-user-scsi =
header;
> - Fix a log print error;
>=20
> Changes for v2:
> - Split the v1 patch to small separate patchset;
> - New patch for fixing fd leak, which has sent to reviewers in another
>  mail;
> - Implement the `vhost_user_scsi_handle_output`;
> - Add the started_vu safe check;
> - Fix error handler;
> - Check the inflight before set/get inflight fd.
>=20
> Li Feng (5):
>  vhost-user-common: send get_inflight_fd once
>  vhost: move and rename the conn retry times
>  vhost-user-scsi: support reconnect to backend
>  vhost-user-scsi: start vhost when guest kicks
>  vhost-user: fix lost reconnect
>=20
> hw/block/vhost-user-blk.c             |   6 +-
> hw/scsi/vhost-scsi-common.c           |  47 ++---
> hw/scsi/vhost-scsi.c                  |   6 +-
> hw/scsi/vhost-user-scsi.c             | 250 +++++++++++++++++++++++---
> hw/virtio/vhost-user-gpio.c           |   5 +-
> hw/virtio/vhost-user.c                |  10 +-
> include/hw/virtio/vhost-scsi-common.h |   2 +-
> include/hw/virtio/vhost-user-scsi.h   |   6 +
> include/hw/virtio/vhost-user.h        |   3 +-
> include/hw/virtio/vhost.h             |   2 +
> 10 files changed, 277 insertions(+), 60 deletions(-)
>=20
> --=20
> 2.41.0
>=20


--Apple-Mail=_87F406BE-6FBD-4784-8963-F5A5390EBDFB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><pre id=3D"b" =
style=3D"font-size: 13px; background: rgb(255, 255, 255); color: rgb(0, =
0, 51); text-wrap: wrap; font-variant-ligatures: normal; orphans: 2; =
widows: 2; text-decoration-thickness: initial; text-decoration-style: =
initial; text-decoration-color: initial;">Hello Guys,</pre><pre id=3D"b" =
style=3D"font-size: 13px; background: rgb(255, 255, 255); color: rgb(0, =
0, 51); text-wrap: wrap; font-variant-ligatures: normal; orphans: 2; =
widows: 2; text-decoration-thickness: initial; text-decoration-style: =
initial; text-decoration-color: initial;">Ping=E2=80=A6&nbsp;</pre><pre =
id=3D"b" style=3D"font-size: 13px; background: rgb(255, 255, 255); =
color: rgb(0, 0, 51); text-wrap: wrap; font-variant-ligatures: normal; =
orphans: 2; widows: 2; text-decoration-thickness: initial; =
text-decoration-style: initial; text-decoration-color: initial;">These =
patches have been waiting for a long time. Can they be merged?</pre><pre =
id=3D"b" style=3D"font-size: 13px; background: rgb(255, 255, 255); =
color: rgb(0, 0, 51); text-wrap: wrap; font-variant-ligatures: normal; =
orphans: 2; widows: 2; text-decoration-thickness: initial; =
text-decoration-style: initial; text-decoration-color: =
initial;"><br></pre><pre id=3D"b" style=3D"font-size: 13px; background: =
rgb(255, 255, 255); color: rgb(0, 0, 51); text-wrap: wrap; =
font-variant-ligatures: normal; orphans: 2; widows: 2; =
text-decoration-thickness: initial; text-decoration-style: initial; =
text-decoration-color: initial;">Best Regards,&nbsp;</pre><pre id=3D"b" =
style=3D"font-size: 13px; background: rgb(255, 255, 255); color: rgb(0, =
0, 51); text-wrap: wrap; font-variant-ligatures: normal; orphans: 2; =
widows: 2; text-decoration-thickness: initial; text-decoration-style: =
initial; text-decoration-color: initial;">li</pre><pre id=3D"b" =
style=3D"font-size: 13px; background: rgb(255, 255, 255); color: rgb(0, =
0, 51); text-wrap: wrap; font-variant-ligatures: normal; orphans: 2; =
widows: 2; text-decoration-thickness: initial; text-decoration-style: =
initial; text-decoration-color: =
initial;"><br></pre><div><div><blockquote type=3D"cite"><div>On 9 Oct =
2023, at 12:46=E2=80=AFPM, Li Feng &lt;fengli@smartx.com&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div><div>Changes =
for v8:<br>- [PATCH 3/5] vhost-user-scsi: support reconnect to =
backend<br> &nbsp;- Fix code style suggested by Manos Pitsidianakis<br>- =
[PATCH 4/5] vhost-user-scsi: start vhost when guest kicks<br> &nbsp;- =
Use 'DEVICE()' macro in vhost_user_scsi_handle_output to replace the<br> =
&nbsp;&nbsp;&nbsp;'parent_obj.parent_obj.parent_obj.parent_obj'.<br><br>Ch=
anges for v7:<br>- [PATCH 3/5] vhost-user-scsi: support reconnect to =
backend<br> &nbsp;- Add reporting the error in vhost-scsi;<br> &nbsp;- =
Rebase to master and fix the conflict.<br>- Add "Reviewed-by" =
tags.<br><br>Changes for v6:<br>- [PATCH] vhost-user: fix lost =
reconnect<br> &nbsp;- Fix missing assign event_cb.<br><br>Changes for =
v5:<br>- No logic has been changed, just move part of the code from =
patch 4 to patch 5.<br><br>Changes for v4:<br>- Merge<br> =
&nbsp;https://lore.kernel.org/all/20230830045722.611224-1-fengli@smartx.co=
m/ to<br> &nbsp;this series.<br>- Add ERRP_GUARD in =
vhost_user_scsi_realize;<br>- Reword the commit messages.<br><br>Changes =
for v3:<br>- Split the vhost_user_scsi_handle_output to a separate =
patch;<br>- Move the started_vu from vhost scsi common header to =
vhost-user-scsi header;<br>- Fix a log print error;<br><br>Changes for =
v2:<br>- Split the v1 patch to small separate patchset;<br>- New patch =
for fixing fd leak, which has sent to reviewers in another<br> =
&nbsp;mail;<br>- Implement the `vhost_user_scsi_handle_output`;<br>- Add =
the started_vu safe check;<br>- Fix error handler;<br>- Check the =
inflight before set/get inflight fd.<br><br>Li Feng (5):<br> =
&nbsp;vhost-user-common: send get_inflight_fd once<br> &nbsp;vhost: move =
and rename the conn retry times<br> &nbsp;vhost-user-scsi: support =
reconnect to backend<br> &nbsp;vhost-user-scsi: start vhost when guest =
kicks<br> &nbsp;vhost-user: fix lost reconnect<br><br> =
hw/block/vhost-user-blk.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;6 +-<br> hw/scsi/vhost-scsi-common.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;47 =
++---<br> hw/scsi/vhost-scsi.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;6 +-<br> =
hw/scsi/vhost-user-scsi.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
250 +++++++++++++++++++++++---<br> hw/virtio/vhost-user-gpio.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;5 +-<br> hw/virtio/vhost-user.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;| &nbsp;10 +-<br> include/hw/virtio/vhost-scsi-common.h =
| &nbsp;&nbsp;2 +-<br> include/hw/virtio/vhost-user-scsi.h &nbsp;&nbsp;| =
&nbsp;&nbsp;6 +<br> include/hw/virtio/vhost-user.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;3 +-<br> =
include/hw/virtio/vhost.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;2 +<br> 10 files changed, 277 insertions(+), 60 =
deletions(-)<br><br>-- =
<br>2.41.0<br><br></div></div></blockquote></div><br></div></body></html>=

--Apple-Mail=_87F406BE-6FBD-4784-8963-F5A5390EBDFB--

