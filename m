Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 922477E3B72
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 13:04:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Knu-0007ji-2W; Tue, 07 Nov 2023 07:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0Knp-0007iX-ES
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:03:29 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0Knn-00089l-Ob
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:03:29 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-58706a0309dso2804933eaf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 04:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699358606; x=1699963406; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=StkbhdU3Jfc/6vDeVeHzwNljNM7UDLyvpWgqQ1F5mMg=;
 b=EHFAMhDWC+YBvpJH3bIrQixklkjZ1EtD1ipLOXgEj9PVjV3LPEta1dL+t3HpB1K9RH
 jp6ASCX3PnXcc3jqW33TZ8HLdupD0jM4G7ZVIlWHk9s1MZd/v2MrXCR/8kCqX9aCw5w1
 HpLoNCb/YVkMJ9zj70Gajxg1I+Ny0rxO6GMSQja+dpZR3KeJ3OEr51/mVIuzKhZHN/+A
 1gQojG/bkfAh8WkrgbicbSGMiLc8pFXBTOVuouGdldH180ZzvDgqYKW+e+dTtRYaxW38
 OwQw3Yd1xy52sT2gjxczIek/f3ekjHnqm7CmDABsGggb9tDvcmIPtMpOcvzJ/iyjprh+
 Z58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699358606; x=1699963406;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=StkbhdU3Jfc/6vDeVeHzwNljNM7UDLyvpWgqQ1F5mMg=;
 b=AqXhqKqGr+bvxrnbdzPgywn2CluSmDgsW09dI5PT4Zf8Enw32oHnoOYqqJ62M7XgCj
 iyU0qM7MNDVyqO3QzVYeQEBXI3ib+c2pc3LLDGsHeBuRZTRV6RA405Yn4bVaVTprYXme
 xY9OwmYx9ji1rRB/XSLKW7HbnzD3V4kN+XRbIIGnDyVs2BrZOtYWANX0lwW+N0ioS58Z
 oZtfVi7JcA14On77wsIqX1xKGUGQ/DBEHVZKwwQxKJgqw4954HaRSb+keJhvPF2yhWHX
 +1GeRvc5+4gL8CLI/hDYNFh6c0HyzzglK6E0UyUqIxoywHo44OtKca7p7vKXzve68Q59
 IlFA==
X-Gm-Message-State: AOJu0YzP0PlxLtVUD8LDv2AtcPTtIrSOcNM7NPSUp3xB1bM0lUebStX4
 QB9u5nF6XKuVcbR1eq25bX5HmVxIREToy2mPlAg=
X-Google-Smtp-Source: AGHT+IEg6UL4iLvu2RD2BXnGsB7xQrYyOnv8ZEnyE445Gc3tT/B4HGIDq3WF7G+5S536XLeVjpezh6AX8K63QtAAWh4=
X-Received: by 2002:a4a:eb92:0:b0:57b:77bb:6b19 with SMTP id
 d18-20020a4aeb92000000b0057b77bb6b19mr30515894ooj.4.1699358606261; Tue, 07
 Nov 2023 04:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20231107105603.GA993420@fedora>
 <bc415368-0e5a-5712-edb6-c0046f090a7b@eik.bme.hu>
In-Reply-To: <bc415368-0e5a-5712-edb6-c0046f090a7b@eik.bme.hu>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 7 Nov 2023 20:03:14 +0800
Message-ID: <CAJSP0QXEti8T=+LgLqSE+WJG3w0rbvr83Wto9tf9Nd_+3CxM3g@mail.gmail.com>
Subject: Re: QEMU entering soft freeze for 8.2 release cycle
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 7 Nov 2023 at 19:52, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Tue, 7 Nov 2023, Stefan Hajnoczi wrote:
> > Hi,
> > QEMU is entering soft freeze for the 8.2 release cycle. After today's
> > pull requests, only bug fixes will be merged until the 8.2 release is
> > stablized around December 12th. New features can be merged into -next
> > trees by maintainers, but will not be merged into qemu.git/master.
>
> You seem to be ahead of everyone else. It's still midday here and other
> people may just start working so maybe you should use US time zone for
> starting the freeze just to make sure people in that part of the world
> also on the same page.

This email is not an immediate cut-off. Pull requests are still being
merged for the rest of the day. I just want to give maintainers a
reminder.

Stefan

>
> Regards,
> BALATON Zoltan
>
> > The release schedule is here:
> > https://wiki.qemu.org/Planning/8.2
> >
> > Please remember to update the changelog if your work has landed in 8.2:
> > https://wiki.qemu.org/ChangeLog/8.2
> >
> > Let me know if you have any questions!
> >
> > Thanks,
> > Stefan
> >
>

