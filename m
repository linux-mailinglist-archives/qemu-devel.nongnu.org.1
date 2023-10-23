Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E81D7D371A
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:46:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quuJM-0006fu-NM; Mon, 23 Oct 2023 08:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@emersion.fr>)
 id 1quq9i-0002Os-IR
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 04:19:22 -0400
Received: from mail-4323.proton.ch ([185.70.43.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@emersion.fr>)
 id 1quq9f-0000Bk-VL
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 04:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1698049156; x=1698308356;
 bh=WxADqybr844I3oyxhgF11CfEL7UzS7ZR4cFdELQGNvc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=U2RcwxLU7ur57UbIqCUc41rPeN8/K52RWTLgORhgJU5QCGJ7yuP/p1Xi0EqVjMKAW
 htgDguF11LRmmTvNhgmHoWbDlWHHq+nQnEHLaJAHT4svQzQszctKAuxU9jcXg88xeW
 /r2ObbAxjn+pX9LpZfk8L9RoxG1aw0Sj7i6a3cEfZXXbMmPTGUNkHqYZbxBv0yVjvM
 gbTu505EB44iV5R0BwC6vJmBbDIR8ChlOn9NLzI1ZWR4hajxOIzWT2zrQkcSw4/Usw
 EsgsAcaN63gmyTSJc7XKGcWmJi9D+KDCEIwpQtvoHTOf0n7dSJHFC02fFuln/MkBmO
 eYnQkIKLYP0Ig==
Date: Mon, 23 Oct 2023 08:19:05 +0000
To: Albert Esteve <aesteve@redhat.com>
From: Simon Ser <contact@emersion.fr>
Cc: qemu-devel@nongnu.org, zackr@vmware.com, linux-doc@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 iforbes@vmware.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Chia-I Wu <olvaffe@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Hans de Goede <hdegoede@redhat.com>, Matt Roper <matthew.d.roper@intel.com>,
 David Airlie <airlied@gmail.com>, banackm@vmware.com,
 Rob Clark <robdclark@gmail.com>, javierm@redhat.com, krastevm@vmware.com,
 spice-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mombasawalam@vmware.com, Daniel Vetter <daniel@ffwll.ch>, ppaalanen@gmail.com,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 0/9] Fix cursor planes with virtualized drivers
Message-ID: <219B7sJmmuzo8lj-2i5F6y0pc8XM03X6NdxHUq_R76N71AcTptEPcpjKLO9Rutriw88YtJDRNqibuR-YICIkhPnrBnQSM-Uu9YCc2uZoOiM=@emersion.fr>
In-Reply-To: <CADSE00KW4+hpbAbZAusBngq5FYSa067wYJCGeetqngWRJaD9Kg@mail.gmail.com>
References: <20231023074613.41327-1-aesteve@redhat.com>
 <-ngmaSLF2S5emYjTBWcLRNzvJRoe_eZ-Nv9HQhE6ZLuK8nIE2ZbfVh2G2O2Z41GoIFIRpts0ukEtFXUx8pNAptmrZBhlXxaQGykx_qCZ_9k=@emersion.fr>
 <CADSE00KW4+hpbAbZAusBngq5FYSa067wYJCGeetqngWRJaD9Kg@mail.gmail.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.23; envelope-from=contact@emersion.fr;
 helo=mail-4323.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 23 Oct 2023 08:45:09 -0400
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

On Monday, October 23rd, 2023 at 10:14, Albert Esteve <aesteve@redhat.com> =
wrote:

> On Mon, Oct 23, 2023 at 9:55=E2=80=AFAM Simon Ser <contact@emersion.fr> w=
rote:
>=20
> > On Monday, October 23rd, 2023 at 09:46, Albert Esteve <aesteve@redhat.c=
om> wrote:
> >=20
> > > Link to the IGT test covering this patch (already merged):
> > > https://lists.freedesktop.org/archives/igt-dev/2023-July/058427.html
> >=20
> > Hmm. IGT should not be merged before the kernel, because as long as the
> > kernel is not merged there might be some uAPI changes.
>=20
> Right, but uAPI header was not updated on the IGT side. As per suggestion=
 of the
> maintainers, I added a static variable that matches the definition on thi=
s patch:
> https://lists.freedesktop.org/archives/igt-dev/2023-August/058803.html
>=20
> +/**
> + * Clients which do set cursor hotspot and treat the cursor plane
> + * like a mouse cursor should set this property.
> + */
> +#define LOCAL_DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT=096
>=20
> Once this patch gets upstreamed, the localized definition will be removed=
,
> replaced by the real one.

What if this patch gets delayed and another patch using the same number
is merged into the kernel first? What if someone finds a design flaw in
the uAPI and it needs to be completely changed? The IGT test would then
be completely broken.

As a rule of thumb: never merge user-space patches before kernel. As
soon as the kernel part is merged, it's fine to locally copy definitions
if desirable.

> > > Mutter patch:
> > > https://lists.freedesktop.org/archives/igt-dev/2023-July/058427.html
> >=20
> > Seems like this link is same as IGT? Copy-pasta fail maybe?
>=20
> Ah yes, my bad, this is the correct link:
> https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/3337

Thanks!

