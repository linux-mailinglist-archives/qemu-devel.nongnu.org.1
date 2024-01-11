Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EC082B230
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:54:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxMp-0000Uk-3a; Thu, 11 Jan 2024 10:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNxMm-0000SN-Du
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:53:12 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNxMk-0002s4-3A
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:53:12 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5574feb7958so6436452a12.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 07:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704988384; x=1705593184; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BNsC1/N0bWn+KjF+LEP1psQiDdKqSRtkMpV1EMVhI6s=;
 b=LoUs6sVKmo6IOiT/A3Q3oZGO+8Ys8WhBpcTfed51JFDx5FGP7TMjiE75E1vEsdMdxl
 onoNs9Ujq6H0x2+EygZmPmaQptdH9/oxjnbd8J1gIavtv0fXGyQ+aupxEG90i7v+n/n7
 2HcfLBoUGIZZczrpeHUSkgxbwwiJoNh+P90Xwo3sT8evUzOWnxheyWZf56J+6j6iEOyz
 nbCxRq4AzL67uyRxt0Y37KKxo2D8kl/CdI3bTATkV4k2lYZ5iCkmOMFpPeQkZokTrk54
 2T8KXTHMlR+TtfQEZmjXj/80dkka1rinsQhMIpKt3ltkPKeyGw6BSAvjPBy/nN2gYmyO
 UkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704988384; x=1705593184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BNsC1/N0bWn+KjF+LEP1psQiDdKqSRtkMpV1EMVhI6s=;
 b=XBykL4FfMVWAvwBOz3aPuzWXNq1vNxIUP2v/Fy4qdtrdmwuuHS+JMtJ/VEQoNeG9GP
 WjuMz79hHbN1L504eRB+fTbj+W8lRr7+dZgZkvWp+jGhUWEOy5pmRouSkpD6g1fMsifa
 KQD5TnplCvxuefulfHp6pUns8/t/9dseJzQB7cQ9bNscLRFZE8wjB1yEVge2F5cPc2vp
 0mqUE4+TiP5PEZG54okUotr2vBunDVxKx2kMyawmjSrDrGUoW8qViCzg2I6fcX+/xhxg
 GHC0DqMwUp/y1bk3YxihfgfALmCgv6lQZGz9m9lAcGTASJqoyAgGg0eSMelR/G9SHgXg
 APKQ==
X-Gm-Message-State: AOJu0YyJE0THMWcdJLAdhLL+eNUmpfchHXF0yAIdRq1KOnPFBKciOCfm
 MVz8ijHDdiXetLTps8+BdvLHJ0EBCoI4Ulj1VW2iVTfjU7mZWA==
X-Google-Smtp-Source: AGHT+IFFDfm56+Rx9FN0qNARFJptsLqJfvrbw474JW/jmvoHrFMnOXs2ouFWX+WXen/7vA7EqPAkOtCvCATB/oyRV5Q=
X-Received: by 2002:aa7:d988:0:b0:557:6f9d:e0ce with SMTP id
 u8-20020aa7d988000000b005576f9de0cemr722426eds.69.1704988383737; Thu, 11 Jan
 2024 07:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20231213105026.1944656-1-kraxel@redhat.com>
 <y2kuootd3k2tqe2245zggbuusg2kaaqrxlvxfwy2wrcbdxg3cn@zgj6tl7gd4lp>
In-Reply-To: <y2kuootd3k2tqe2245zggbuusg2kaaqrxlvxfwy2wrcbdxg3cn@zgj6tl7gd4lp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2024 15:52:52 +0000
Message-ID: <CAFEAcA8H6kVNiSk6CEVun5KWQH-sqWxBKxZ9Rf7haQhZHEKiow@mail.gmail.com>
Subject: Re: [PULL 0/6] Firmware/edk2 20231213 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, edk2-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 11 Jan 2024 at 14:01, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Wed, Dec 13, 2023 at 11:50:12AM +0100, Gerd Hoffmann wrote:
> > The following changes since commit 9c74490bff6c8886a922008d0c9ce6cae70dd17e:
> >
> >   Update version for v8.2.0-rc3 release (2023-12-06 14:34:20 -0500)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/kraxel/qemu.git tags/firmware/edk2-20231213-pull-request
> >
> > for you to fetch changes up to 704f7cad5105246822686f65765ab92045f71a3b:
> >
> >   tests/acpi: disallow tests/data/acpi/virt/SSDT.memhp changes (2023-12-13 11:23:11 +0100)
> >
> > ----------------------------------------------------------------
> > edk2: update to git snapshot (maybe for-8.2)
> >
> > This updates edk2 to git master as of today.  This picks up a patch
> > (merged only yesterday, that's why this last-minute PR) which allows to
> > work around a bug in shim, and enables that workaround in the qemu
> > firmware builds.
> >
> > This solves a real-world problem on arm hardware, walk over to
> > https://gitlab.com/qemu-project/qemu/-/issues/1990 to see the details.
> >
> > Merging this firmware update that close to the 8.2 release clearly is
> > not without risks.  If I get a 'no', I'm not going to complain.
> >
> > That said I'm not aware of any bugs, and landing this in 8.2.0 would
> > make a bunch of folks hanging around in issue 1990 very happy.
> >
> > Alternative plan would be to merge this after the release, give it some
> > time for testing, and assuming everything goes well schedule a backport
> > for 8.2.1
>
> Ping.
>
> As expected this missed the 8.2 boat.  Now the devel tree is open again
> and people are back from xmas + new year vacations, can this be picked
> up for master and eventually 8.2-stable?

I can queue it, sure. Do we need to respin it to add cc: qemu-stable
tags, or can it be applied as-is ?

-- PMM

