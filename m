Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DE479D363
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:16:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg4BN-0000iA-Ja; Tue, 12 Sep 2023 10:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg4BH-0000gJ-OS
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:15:55 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg4B7-0000zk-2b
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:15:55 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-52e64bc7c10so7417998a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694528143; x=1695132943; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8g3cktqW9q2V/g6QTpPuDP5+W/gEdBoajslMdf72mLk=;
 b=QnlcK9XZnlDWatG/RLlxS7WXcX9ApxHfaK/MYKjWOqE141SB42MY0b4gX21I+AYpD1
 +X7TgXCSirOEYVRjNja4hlP5w4HoL2Zdm+rJ8V2cmx2ATqrys4vmm7fc3HDmVdmjT8MD
 Gbol4x3zbYCSO4r46bATe0oU2X5GDdHf+MXVNAg4ez/Gilw/Xt9Jy7dcAOQ40OUWgGQs
 RkrwSR0xFdB5FXViBtm3IJ0G1IgGf4/pND41LKriM7WJCUgjxSWvzBGseYXc6DeCWuwA
 48a0gall+Gh1UBFPxtdUAaUrkgCe/NfuLm77iwFD0Gbvbn5jxeEzRM5mHnItDqvlG8eA
 KLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694528143; x=1695132943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8g3cktqW9q2V/g6QTpPuDP5+W/gEdBoajslMdf72mLk=;
 b=NJWNsl5f+GTpQHAEdFR5NXicU4/YY5r88a/4fFVuJ8R6l5uCQ07M0SQtFpR0jtGY6B
 f8/rtbKzwssskKXGxkUQ0kTVg+XoNiyvnTuW6N1kgozOdWWOUyw9jNUBw0OLlJu5ezRK
 hnGTXSysN9WvSj8ReenQS+FbeSVDf6tCQv51GjBOxigH+tosw/yESqV1JgtfjifKEfXj
 V8eB6s4OxyAZHKQgnXOdQ6oBhzEA3hup+0kRhI8tjWORKkERPYFC4vRepUPDql4nv41u
 kyD0HQuGdpWy7lJNiMbnH45m/swxewr71xfK+DvflDMqZX91QHGV88r5HhSByIaumjBs
 DD6A==
X-Gm-Message-State: AOJu0Yz7QPSnrZGTbca/2qmjlgFYVc8p+Uag4tPrABWzl+pyuIuOSc4G
 OxaYXjja806UxL9DGQ2Tezci9m+P6lk7bUGKevflSQ==
X-Google-Smtp-Source: AGHT+IFgYm5vqC3uH5wPTiiRka8pGD2nuQOTucFmxwNIeQgavLe1XtUKaZIMKix7vJjPOevwFWCDdu0oFWgcHpMHdVw=
X-Received: by 2002:a05:6402:2023:b0:523:aef9:3b7b with SMTP id
 ay3-20020a056402202300b00523aef93b7bmr10030389edb.4.1694528143280; Tue, 12
 Sep 2023 07:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230811174751.784620-1-peter.maydell@linaro.org>
 <ZNnTO1qnA308CUtb@cormorant.local>
In-Reply-To: <ZNnTO1qnA308CUtb@cormorant.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2023 15:15:32 +0100
Message-ID: <CAFEAcA9LZvwceR7973Vz=p78S8CMUja-zhEdjB9MfKeCs8qvWA@mail.gmail.com>
Subject: Re: [PATCH 0/2] nvme: avoid dynamic stack allocations
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 14 Aug 2023 at 08:09, Klaus Jensen <its@irrelevant.dk> wrote:
>
> On Aug 11 18:47, Peter Maydell wrote:
> > The QEMU codebase has very few C variable length arrays, and if we can
> > get rid of them all we can make the compiler error on new additions.
> > This is a defensive measure against security bugs where an on-stack
> > dynamic allocation isn't correctly size-checked (e.g.  CVE-2021-3527).
> >
> > We last had a go at this a few years ago, when Philippe wrote
> > patches for this:
> > https://patchew.org/QEMU/20210505211047.1496765-1-philmd@redhat.com/
> > Some of the fixes made it into the tree, but some didn't (either
> > because of lack of review or because review found some changes
> > that needed to be made). I'm going through the remainder as a
> > non-urgent Friday afternoon task...
> >
> > This patchset deals with two VLAs in the NVME code.
> >
> > thanks
> > -- PMM
> >
> > Peter Maydell (1):
> >   hw/nvme: Avoid dynamic stack allocation
> >
> > Philippe Mathieu-Daud=C3=A9 (1):
> >   hw/nvme: Use #define to avoid variable length array
> >
> >  hw/nvme/ctrl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > --
> > 2.34.1
> >
>
> Thanks Peter,
>
> Applied to nvme-next!


Hi Klaus -- did these patches get lost? They don't seem to
have appeared in master yet.

thanks
-- PMM

