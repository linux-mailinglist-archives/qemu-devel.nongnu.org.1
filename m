Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E55182B25F
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 17:04:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxWG-0005Sa-EP; Thu, 11 Jan 2024 11:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNxWE-0005S5-7f
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:02:58 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNxW7-0008Cw-Sn
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:02:53 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55753dc5cf0so6535995a12.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 08:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704988970; x=1705593770; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8H0rx9m7YGiKumSE3asPeIo0RgyQ8ZJEpezCz81G4F0=;
 b=PuoauV4Gdor9kNYPRgOCMB8n6X32WXvt1/SK1i2PnKzGKHgdAyXXxTLIgC9iLbQ8OI
 VRwiX1FF5L95YLpiBhZb/cmN0PAEOGVxLzlsyx86XgCu5fOZcGJEuQB3nxzwus3kQPup
 A+MXbpCSAWXAdNW0+sY+ItlC2JVfidCJ6q5W8ghvPdouxiNdkrKDH4U2Ky8cVdJzUfgj
 1x23sO4xOR+GdJRO1n86wJ4yO5z8x2TPp5xozKptmauLOUoOoLUh4OLeb6q5YSi/EKX7
 q1JUDM+VpZEMtJMAA5DLIar2j9Q1/bw6uwt8DjllH7dNiXVmkEo5AQGfsw6dHwqjNqYv
 UKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704988970; x=1705593770;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8H0rx9m7YGiKumSE3asPeIo0RgyQ8ZJEpezCz81G4F0=;
 b=rg9riAOX8FKKiO6uGqNR2drxKfnpWD0RJmK7/szEFvQF1r93PQRAjp90fvqwJFG3hw
 shMa+P52zQBUrR1IdyiVmW2VeK1nDRuITfGmS4WTdDq8Yo1jW6OOTMHeqOlyg6T3drNF
 BvvAj1JLQhmPlpi9OqMvrtidn1kWvz+wH+CPSNzuKZwaL+POx2w/tOh44QUiybid1Pel
 9Mk8kZwOqc65oNSq3jr8rMVltavH4Fq1jMsI/q+04N5faYGw0BptBwvi0jqOKUhLlzCz
 q+sN0wmwAun5RuYcRkXLc0z5fMbGDZHWQI7CYqr9fUrVsNTMh+pPoTPacmHRtN57kcX3
 0zmw==
X-Gm-Message-State: AOJu0YzRBDaYjWWdd6GBmpPI9faVnJ9igEOKUbwAuf0Q++ly7USl9OOS
 mHFSfg5+15FtlrOPuI5yVRyRzgRMiySBFBeztDikGmHtIDZfCQ==
X-Google-Smtp-Source: AGHT+IEdViI3na6PjkW07BzJ1O/E09Q6mbwdTPt9h63P/5hIRyQnehqXiERaPSk9FN7dEhcBnUJcFOpYR8hRhpCRl9M=
X-Received: by 2002:a05:6402:3cd:b0:558:adf8:9168 with SMTP id
 t13-20020a05640203cd00b00558adf89168mr377243edw.69.1704988969742; Thu, 11 Jan
 2024 08:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20231213105026.1944656-1-kraxel@redhat.com>
 <y2kuootd3k2tqe2245zggbuusg2kaaqrxlvxfwy2wrcbdxg3cn@zgj6tl7gd4lp>
 <CAFEAcA8H6kVNiSk6CEVun5KWQH-sqWxBKxZ9Rf7haQhZHEKiow@mail.gmail.com>
In-Reply-To: <CAFEAcA8H6kVNiSk6CEVun5KWQH-sqWxBKxZ9Rf7haQhZHEKiow@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2024 16:02:38 +0000
Message-ID: <CAFEAcA-sw2FNgTft0PYL=GW0JQhdRX9Zn0B6muUjC68nmVXHnA@mail.gmail.com>
Subject: Re: [PULL 0/6] Firmware/edk2 20231213 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 11 Jan 2024 at 15:52, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 11 Jan 2024 at 14:01, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Wed, Dec 13, 2023 at 11:50:12AM +0100, Gerd Hoffmann wrote:
> > > The following changes since commit 9c74490bff6c8886a922008d0c9ce6cae70dd17e:
> > >
> > >   Update version for v8.2.0-rc3 release (2023-12-06 14:34:20 -0500)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://gitlab.com/kraxel/qemu.git tags/firmware/edk2-20231213-pull-request
> > >
> > > for you to fetch changes up to 704f7cad5105246822686f65765ab92045f71a3b:
> > >
> > >   tests/acpi: disallow tests/data/acpi/virt/SSDT.memhp changes (2023-12-13 11:23:11 +0100)
> > >
> > > ----------------------------------------------------------------
> > > edk2: update to git snapshot (maybe for-8.2)
> > >
> > > This updates edk2 to git master as of today.  This picks up a patch
> > > (merged only yesterday, that's why this last-minute PR) which allows to
> > > work around a bug in shim, and enables that workaround in the qemu
> > > firmware builds.
> > >
> > > This solves a real-world problem on arm hardware, walk over to
> > > https://gitlab.com/qemu-project/qemu/-/issues/1990 to see the details.
> > >
> > > Merging this firmware update that close to the 8.2 release clearly is
> > > not without risks.  If I get a 'no', I'm not going to complain.
> > >
> > > That said I'm not aware of any bugs, and landing this in 8.2.0 would
> > > make a bunch of folks hanging around in issue 1990 very happy.
> > >
> > > Alternative plan would be to merge this after the release, give it some
> > > time for testing, and assuming everything goes well schedule a backport
> > > for 8.2.1
> >
> > Ping.
> >
> > As expected this missed the 8.2 boat.  Now the devel tree is open again
> > and people are back from xmas + new year vacations, can this be picked
> > up for master and eventually 8.2-stable?
>
> I can queue it, sure. Do we need to respin it to add cc: qemu-stable
> tags, or can it be applied as-is ?

...PS did you mean to cc qemu-stable, not the nonexistent edk2-stable
on this pullreq email?

thanks
-- PMM

