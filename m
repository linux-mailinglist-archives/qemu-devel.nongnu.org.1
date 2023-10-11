Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 099847C47C1
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 04:25:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqOt4-0004Cd-31; Tue, 10 Oct 2023 22:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qqOsz-0004BQ-JR; Tue, 10 Oct 2023 22:23:45 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qqOsx-0000Yn-UF; Tue, 10 Oct 2023 22:23:45 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-694ed847889so4832657b3a.2; 
 Tue, 10 Oct 2023 19:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696991022; x=1697595822; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=smAf/KNHdb90Zg1Id/tQSkW36V02FG0YK1OibE3CaqU=;
 b=AhoPQw4+61kzOzQTAUth3A88kHyf02ZQuu3nx+LR29FY23ZWMOetrzFDj6alA2z8OA
 PmaJu/pA5FxjLtDUpWo+yALRY0wUGMob48GKXOoXKbvKYBkPtNxWrprNlxhmapJRsDfy
 Pu6Wn0tov38bwCipiAkD5BCVe9o6cQFjzGir62lK/HVA6DSBuLrSn/w3PG+H40g5H84D
 o/qvd3x5XysNSDHAWV3I4dX8XxHU7UnxWAlxSESlgJDaeXU+qyuoUQX9+yYRV03Mz56d
 cLvupShefkhFs3YzyuG1FI2IdbRSaJbNIhOfsz08NDGFQUiDwqBcj1Ta7HWq6cgTM76w
 Xa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696991022; x=1697595822;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=smAf/KNHdb90Zg1Id/tQSkW36V02FG0YK1OibE3CaqU=;
 b=HZG0PgEHhCI8XZb5zCgJSXIvHOpbumG3O1xRZFs/t+pCJov/jst0zkza72o2Jn21es
 OZMX59E/MiBLoPCCSNgEhwXan+ZEeh95f4InVqTS7V3xmAlHAhU4TRWBNyXSZpQ+EXg0
 I9IMV0WpdyT0+pqq3vF+WHxxT3rYSzy7ibOOeffjIQ4o1wW3a9ErOlBarANXNkNOTYzR
 Rf/JLkw5pyvcoWO7oEVkGm4OS6CjJvB06i+WcOgRRy8mON3EfsyIDVHULHLNY2+4w+4D
 wOfOAYmKoxSjcBw9xOTXAx9a5JKcMyJWrK40F4MabhTNj2h9QghCJvC+PxJVT+QQ/uMI
 FXbg==
X-Gm-Message-State: AOJu0Yxkjn7pUrQygg+ZwZMknjPs67bQyw2iR81uigCRFZMO0zGU4+Sv
 HCVAp/W3fyrM97AB8WS7zyc=
X-Google-Smtp-Source: AGHT+IHE4+B6Lxv45lQYhdEEjLJ2jqX2qKtkX5qiB8fLNy2DM4F0wKy1OqZPjtAGOgiVlwhGtJO53w==
X-Received: by 2002:a05:6a20:430e:b0:121:ca90:df01 with SMTP id
 h14-20020a056a20430e00b00121ca90df01mr19675097pzk.40.1696991021969; 
 Tue, 10 Oct 2023 19:23:41 -0700 (PDT)
Received: from localhost ([1.128.222.4]) by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001b895336435sm12533158plg.21.2023.10.10.19.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 19:23:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Oct 2023 12:23:35 +1000
Message-Id: <CW593XZPASQW.3OODX8I6KCO2L@wheely>
Cc: <qemu-ppc@nongnu.org>, "Cleber Rosa" <crosa@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 06/11] tests/avocado: Add FreeBSD distro boot tests
 for ppc
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Warner Losh" <imp@bsdimp.com>
X-Mailer: aerc 0.15.2
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-7-npiggin@gmail.com>
 <CANCZdfqNJ97EgAax=P7pzny8zcULfiLEVJighecm5=DgLtRv8g@mail.gmail.com>
In-Reply-To: <CANCZdfqNJ97EgAax=P7pzny8zcULfiLEVJighecm5=DgLtRv8g@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed Oct 11, 2023 at 7:55 AM AEST, Warner Losh wrote:
> On Tue, Oct 10, 2023 at 1:53=E2=80=AFAM Nicholas Piggin <npiggin@gmail.co=
m> wrote:
>
> > FreeBSD project provides qcow2 images that work well for testing QEMU.
> > Add pseries tests for HPT and Radix, KVM and TCG.
> >
> > Other architectures could be added so this does not get a ppc_ prefix
> > but is instead named similarly to boot_linux.
> >
> > Cc: Warner Losh <imp@bsdimp.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >
> > CC'ing Warner to check if it's okay for us to use these images and
> > any comments or suggestions. avocado tests have many Linux boots so we'=
d
> > do much better to expand test coverage by adding some other systems.
> >
>
> I like this.... I'm a little worried at the exact hash encoded in it, but
> since there's a checksum
> to match, it's OK I guess. It will give this code a shelf-life of months,
> IIRC our retention policy.

The oldest 15.0 CURRENT image on there is May 1st, so ~6 months? That's
not too bad. There are some release qcow2 images as well which sound
like they're maintained longer-term:

https://download.freebsd.org/releases/VM-IMAGES/

No builds for powerpc, but those might be preferable for other targets.

Another option for powerpc might be to use a release .iso. It's much
nicer to have a qcow image already installed though. I'll tinker with
it a bit more, but may stick with the snapshot for now.

Thanks,
Nick

