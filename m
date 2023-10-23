Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 603467D2C70
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 10:15:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quq55-0007w4-6g; Mon, 23 Oct 2023 04:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1quq4v-0007sI-5w
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 04:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1quq4t-0007s9-8J
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 04:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698048861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uoARVbaVzE8Klcf/2UJiBvPdsoBHjWiewZkEcG70H2w=;
 b=YK5IRHWahWIg/Ea+VTUTKAGs++1hjJpOl/vll8l5cx23JZTjmLMI9W7x7wxf6C7vIv0SL9
 /FKiPE9BkLDqOA7yCdr1Y38X9adyyq3bo5AmyIqKZmUoRr6mAoCbMqt9o//LX02ZYwPtBl
 6uiFvKozJNDNyjfH5qEOZ5BpiOLiiCA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-iEjYIriUNLey7iyWyMeFFQ-1; Mon, 23 Oct 2023 04:14:19 -0400
X-MC-Unique: iEjYIriUNLey7iyWyMeFFQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5b2c12c8248so1654304a12.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 01:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698048858; x=1698653658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uoARVbaVzE8Klcf/2UJiBvPdsoBHjWiewZkEcG70H2w=;
 b=ftkpnZmZ2vlH3iEGg9104fZgsLcJ2+02ZSV1qOn27sA+lEbMtemeZehBik6ZHxKrB0
 jjPwwV2z4HXiCmtsKfIgwvXc1mxc2qQuV+fHpEJzP4lsN9GkDzkDQq5IEeMdwx101JpA
 WQyS/aIMG+Nk4G70O8jWrrhbf/soBUkQJsvhvl+MLdK1/89901H4A8LZFPm0zN9AZmnD
 JzdHob7xPV4nIUUL87KoS/paRaL8NmF2T+ZrAUoR3sn9VEUu+Uhu5w2hd3QoHnZaaaUU
 pboctQpzkZiNBhtPBTw+L1e7heypfu8GS8IQ3RkREeXRi0OVSZ/X8LhpP5TRkuoJCZLb
 PiWg==
X-Gm-Message-State: AOJu0Yy32NpLPAucvGc00563TTkB1i4URuTuNJj/zcKzMlVGaKP3QjOh
 Ae4r4yDYXOSEX8xo1Q2AWGeBivBFYyBAXBDjCWx/uar5qm37TdpZRN1fy111anvmg8NEBFnTn8w
 2V2eTQ1LyhigMlUBqrw65BZNJ8ltcrOs=
X-Received: by 2002:a05:6a20:54a0:b0:13d:17cc:5bca with SMTP id
 i32-20020a056a2054a000b0013d17cc5bcamr7164688pzk.18.1698048857505; 
 Mon, 23 Oct 2023 01:14:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzq70ts5bDupwKjfq3lxncqOWwvXbGNczquvLBuYAQ7b8ip74Jouf9GwofikaNrblGdeCbW4K+TH/mBEYJsmM=
X-Received: by 2002:a05:6a20:54a0:b0:13d:17cc:5bca with SMTP id
 i32-20020a056a2054a000b0013d17cc5bcamr7164645pzk.18.1698048856339; Mon, 23
 Oct 2023 01:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231023074613.41327-1-aesteve@redhat.com>
 <-ngmaSLF2S5emYjTBWcLRNzvJRoe_eZ-Nv9HQhE6ZLuK8nIE2ZbfVh2G2O2Z41GoIFIRpts0ukEtFXUx8pNAptmrZBhlXxaQGykx_qCZ_9k=@emersion.fr>
In-Reply-To: <-ngmaSLF2S5emYjTBWcLRNzvJRoe_eZ-Nv9HQhE6ZLuK8nIE2ZbfVh2G2O2Z41GoIFIRpts0ukEtFXUx8pNAptmrZBhlXxaQGykx_qCZ_9k=@emersion.fr>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 23 Oct 2023 10:14:05 +0200
Message-ID: <CADSE00KW4+hpbAbZAusBngq5FYSa067wYJCGeetqngWRJaD9Kg@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Fix cursor planes with virtualized drivers
To: Simon Ser <contact@emersion.fr>
Cc: qemu-devel@nongnu.org, zackr@vmware.com, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 iforbes@vmware.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Chia-I Wu <olvaffe@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Hans de Goede <hdegoede@redhat.com>, 
 Matt Roper <matthew.d.roper@intel.com>, David Airlie <airlied@gmail.com>,
 banackm@vmware.com, 
 Rob Clark <robdclark@gmail.com>, javierm@redhat.com, krastevm@vmware.com, 
 spice-devel@lists.freedesktop.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
 David Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org, 
 linux-kernel@vger.kernel.org, mombasawalam@vmware.com, 
 Daniel Vetter <daniel@ffwll.ch>, ppaalanen@gmail.com, 
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e4cdbd06085dce80"
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

--000000000000e4cdbd06085dce80
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 9:55=E2=80=AFAM Simon Ser <contact@emersion.fr> wro=
te:

> On Monday, October 23rd, 2023 at 09:46, Albert Esteve <aesteve@redhat.com=
>
> wrote:
>
> > Link to the IGT test covering this patch (already merged):
> > https://lists.freedesktop.org/archives/igt-dev/2023-July/058427.html
>
> Hmm. IGT should not be merged before the kernel, because as long as the
> kernel is not merged there might be some uAPI changes.
>

Right, but uAPI header was not updated on the IGT side. As per suggestion
of the
maintainers, I added a static variable that matches the definition on this
patch:
https://lists.freedesktop.org/archives/igt-dev/2023-August/058803.html

+/**
+ * Clients which do set cursor hotspot and treat the cursor plane
+ * like a mouse cursor should set this property.
+ */
+#define LOCAL_DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT	6


Once this patch gets upstreamed, the localized definition will be removed,
replaced by the real one.


> > Mutter patch:
> > https://lists.freedesktop.org/archives/igt-dev/2023-July/058427.html
>
> Seems like this link is same as IGT? Copy-pasta fail maybe?
>
>
Ah yes, my bad, this is the correct link:
https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/3337

--000000000000e4cdbd06085dce80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 23, 2023 at 9:55=E2=80=AF=
AM Simon Ser &lt;<a href=3D"mailto:contact@emersion.fr">contact@emersion.fr=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
On Monday, October 23rd, 2023 at 09:46, Albert Esteve &lt;<a href=3D"mailto=
:aesteve@redhat.com" target=3D"_blank">aesteve@redhat.com</a>&gt; wrote:<br=
>
<br>
&gt; Link to the IGT test covering this patch (already merged):<br>
&gt; <a href=3D"https://lists.freedesktop.org/archives/igt-dev/2023-July/05=
8427.html" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.o=
rg/archives/igt-dev/2023-July/058427.html</a><br>
<br>
Hmm. IGT should not be merged before the kernel, because as long as the<br>
kernel is not merged there might be some uAPI changes.<br></blockquote><div=
><br></div><div>Right, but uAPI header was not updated on the IGT side. As =
per suggestion of the</div><div>maintainers, I added a static variable that=
 matches the definition=C2=A0on this patch:</div><div><a href=3D"https://li=
sts.freedesktop.org/archives/igt-dev/2023-August/058803.html">https://lists=
.freedesktop.org/archives/igt-dev/2023-August/058803.html</a></div><div><pr=
e style=3D"color:rgb(0,0,0)">+/**
+ * Clients which do set cursor hotspot and treat the cursor plane
+ * like a mouse cursor should set this property.
+ */
+#define LOCAL_DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT	6</pre></div><div>=C2=A0=
</div><div>Once this patch gets upstreamed, the localized definition will b=
e removed,</div><div>replaced by the real one.</div><div><br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Mutter patch:<br>
&gt; <a href=3D"https://lists.freedesktop.org/archives/igt-dev/2023-July/05=
8427.html" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.o=
rg/archives/igt-dev/2023-July/058427.html</a><br>
<br>
Seems like this link is same as IGT? Copy-pasta fail maybe?<br>
<br></blockquote><div><br></div><div>Ah yes, my bad, this is the correct li=
nk:</div><div><a href=3D"https://gitlab.gnome.org/GNOME/mutter/-/merge_requ=
ests/3337">https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/3337</a>=
=C2=A0</div></div></div>

--000000000000e4cdbd06085dce80--


