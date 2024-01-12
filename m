Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDDE82C37D
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 17:20:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOKFl-0003HS-3b; Fri, 12 Jan 2024 11:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOKFi-0003FQ-6r
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 11:19:26 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOKFf-0005EL-Ok
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 11:19:25 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ccbc328744so80839511fa.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 08:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705076360; x=1705681160; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=feDeth5VKgUt0lqZbaR5fZloj9Fb4TwwskHygaq4c7Q=;
 b=fQ/tnEh+YIjEXU25RhsqczwV5H+ChXik3SxyPbokx1Iw6JywUg8/dSbd3J2VxsVm1Y
 1J3DarR8W5iFpjBszlH48YH60UaIH/NnuUI8NjN+bu+S3OGx1Na9W/lje1SU11FzZwGT
 2QlCG7lq546dJ3D7/eL8ITqgE/nAn6WjHoxR+xVq1vTroYH9rLTeSN30VSYuZ5q1IDbc
 nHmwxquOnCBWwRG2geobnAi9sKvZFzjeDMmWlQvYNjJ6bYh9Ij5FK4uD9mn9tQirtyUi
 9/ePsZAi5BVbQJRpFDzZZiaavhdONpzrYf6Tm3XMWQxI7KzrtM/ddmWepbav4wICuKt7
 22NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705076360; x=1705681160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=feDeth5VKgUt0lqZbaR5fZloj9Fb4TwwskHygaq4c7Q=;
 b=N63VwYrNWO2H48Es70u/U2ch3z5+9nO/1sL7Luf+jBcx8vamap7h/6Te2IxTR+4o4k
 7iq4DEVVIQpuXGHK626Ky3gfkm0d09i09yCJYJES1p7Na+lo9Q+MWWx3bmNA/Hoz49PL
 dycWE2o1BhCAwJ4hK5eUyvuanx4DW1dMZqGGaNOLKU5yBXD6ohbtoS8KXyQflVQfyvKC
 UtrcZxKvwURDZFmfVFbujZ3psXiu6diJMLW/K7gYBj0gpF03//xCV4ZRRDj9D2MBJTlQ
 79DYn4ikzmRJg3C/t3hKXJ7uV3/jrWhrpVymtoE/Noap5s86iYb1RDHipgYFRp3euIdy
 mw3w==
X-Gm-Message-State: AOJu0YyWuQ+8woWmLPN002iZ0SRS4niMFNxMnxm9spE13iWk7pTg8TnY
 MDVCcz+owQKhNuv8BjwH0poG2lIIBoe3gA1CaB1OuiUyBw1p+w==
X-Google-Smtp-Source: AGHT+IG5hgf7WFHqzna6VGNA7hg9Djr05bFyF/KmSXlRAu3m+amwIceIUbSVUC2imtQT0/2QgAJJi5W4Z89xUeXriTs=
X-Received: by 2002:a2e:a4a2:0:b0:2cc:d665:db21 with SMTP id
 g2-20020a2ea4a2000000b002ccd665db21mr767211ljm.66.1705076360500; Fri, 12 Jan
 2024 08:19:20 -0800 (PST)
MIME-Version: 1.0
References: <20231213105026.1944656-1-kraxel@redhat.com>
 <y2kuootd3k2tqe2245zggbuusg2kaaqrxlvxfwy2wrcbdxg3cn@zgj6tl7gd4lp>
 <CAFEAcA8H6kVNiSk6CEVun5KWQH-sqWxBKxZ9Rf7haQhZHEKiow@mail.gmail.com>
 <CAFEAcA-sw2FNgTft0PYL=GW0JQhdRX9Zn0B6muUjC68nmVXHnA@mail.gmail.com>
 <e2hpw77r6t2ge6h233cq75qdadou6koz62sfktcsrlc2gzeqnq@4ejyxysmmulo>
 <CAFEAcA_f0Q7LkSQ2+sxgBcRQNSTenykq1R28QMuGyW22PtxW2Q@mail.gmail.com>
In-Reply-To: <CAFEAcA_f0Q7LkSQ2+sxgBcRQNSTenykq1R28QMuGyW22PtxW2Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 16:19:09 +0000
Message-ID: <CAFEAcA_-fF7fWGm_QUJa86LHJvtBk4jKvTw=OvM+EOxQzuYvWA@mail.gmail.com>
Subject: Re: Re: [PULL 0/6] Firmware/edk2 20231213 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 12 Jan 2024 at 12:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 11 Jan 2024 at 16:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Thu, Jan 11, 2024 at 04:02:38PM +0000, Peter Maydell wrote:
> > > On Thu, 11 Jan 2024 at 15:52, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > >
> > > > On Thu, 11 Jan 2024 at 14:01, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > > >
> > > > > Ping.
> > > > >
> > > > > As expected this missed the 8.2 boat.  Now the devel tree is open again
> > > > > and people are back from xmas + new year vacations, can this be picked
> > > > > up for master and eventually 8.2-stable?
> > > >
> > > > I can queue it, sure. Do we need to respin it to add cc: qemu-stable
> > > > tags, or can it be applied as-is ?
> > >
> > > ...PS did you mean to cc qemu-stable, not the nonexistent edk2-stable
> > > on this pullreq email?
> >
> > Yes, Cc'ing qemu-stable was the intention, thanks for fixing it up.
> >
> > I'd leave it to the stable maintainer(s).  If they prefer a respin with
> > Cc qemu-stable added to all patches I surely can do that.  If being
> > notified with this reply is good enough I'm happy too.
>
> Well, it all made it through the CI fine, and I think MJT is
> fairly flexible about stable- notifications, so I'm going to
> push this merge to git.
>
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
> for any user-visible changes.

PS: when are we likely to be able to update to a proper released
EDK2 ? Running with a git snapshot isn't ideal, so if we can
move to an EDK2 release version within this QEMU cycle that would
be nice.

thanks
-- PMM

