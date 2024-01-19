Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D86E3832D04
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:19:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQrZS-0003pS-Uo; Fri, 19 Jan 2024 11:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrZQ-0003l0-OR
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:18:16 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrZO-0005Yt-PD
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:18:16 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55a45a453eeso1155655a12.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 08:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705681093; x=1706285893; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x1i0j3gxZF6H+vFapCDBKtOnqYLkTVaTO13055cI39w=;
 b=Adwz1dAYi03KjCu0cppvFZ6V/jN8tNzgWa/NcZU7sZiSN6nSKe5YT79QULeqT+CdBC
 RoXuf9SLh6DR9QOzG3b7gjgvQ8VCSkcQtjDU7ogBLB7a/RSMMJ7EZ/6dtdW6saWmXW1Z
 LjVK2IFOoYQqxG1ba91jKOhoQ6+YAViao7gKEXE3yOFDd2npEsn6ntII69gqqKA0gQ4v
 xfUkFJg1gJBc8mI7ZabaJ3L2FdzYnXWcE0Xocjf5CSQZ02AffzohEHJCpjtmUfvLHvWP
 WyhG440OA3H91rMdc2SQVCqZDgZwgcHGdWk90bHJd+jFyDq1HLaUvRLl3MfHcZAc1wX8
 EXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705681093; x=1706285893;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x1i0j3gxZF6H+vFapCDBKtOnqYLkTVaTO13055cI39w=;
 b=v8BX6WJ0hYW/cfRq3/RUhCSkbROHhhhPIvsglCWq3wZlQSj0ZOX7/KU6PPeYD7vjFe
 fS3uw6LSagSq+cF5fptjRPYS3Jmqxtv57g9NYx54nqilZFhKpkTjRCtKUxH2n7d5KnP0
 Pqkff/EijlEqW8XoKajIhQcAHWaBcBm1vZKGCDSj7YIvGajtEfT3vIMifQfpAQhRZOXy
 YioMcRxdDotrVk0mb30pmVRmJvKDIzBFuA12nI6tRN2XebYVDA1Uk0x+NqHnXBkRFAUX
 a4IKJs7kBxCNXcj4058kjSOWN/9VuEQBrisGpTvPl8IXybur3LvwhoF0b/e/TAiv+Ola
 yUbw==
X-Gm-Message-State: AOJu0Yx6Fw+PD2f4jxesiMp47NLNNXioXn9B8a/61eLbQ2GWpXquT/F6
 WaNNtZxHcPRFB0J8dPCt0rz5SPTb72PLI75n/BjxuBXxuVDynHJvlg9JRI+WSka9klAiMlmMo7P
 jNgn2VC1GiDZ68utsrs8AMEvavBearVNE/lVC6A==
X-Google-Smtp-Source: AGHT+IGhmvf04M8VZS7HAei4Ib7xKy66YF/sOY9m/Gp2xg8xDIotxn8op5m4+LllpxS+WNAWBomJ7lf5S0TCru6gn4U=
X-Received: by 2002:a05:6402:3c2:b0:55a:26a9:6e93 with SMTP id
 t2-20020a05640203c200b0055a26a96e93mr1401423edw.52.1705681093005; Fri, 19 Jan
 2024 08:18:13 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_7s=scvgYfG8kGmJ==5cKmvvA-ZqVkpt4M9jV6eS1Zow@mail.gmail.com>
 <ZaqCA5uYWFSgK6F-@redhat.com>
 <CAFEAcA_n-pgzd-bne7VvHk5a3Q9ofpxWsmWTshtV=nKfZd9ESA@mail.gmail.com>
In-Reply-To: <CAFEAcA_n-pgzd-bne7VvHk5a3Q9ofpxWsmWTshtV=nKfZd9ESA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2024 16:18:01 +0000
Message-ID: <CAFEAcA-PKwFOj6=H+v=8B-xMg0=vUPf0gE8-=3N2N1XY1TLDog@mail.gmail.com>
Subject: Re: how do the iotests pick a machine model to run on ?
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Hanna Reitz <hreitz@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, 19 Jan 2024 at 15:26, Peter Maydell <peter.maydell@linaro.org> wrote:
> (Also, we should probably put an entry for sh4 in machine_map,
> because the default board type (shix) is about to be deprecated,
> and the r2d board type is thus a better choice.)

The good news is if we add r2d to the machine_map, then
only 3 iotests fail:

 191 -- not sure exactly what's going on. QEMU complains
        "machine type does not support if=ide,bus=0,unit=1".
        Side note: the test harness seems to throw away the
        stderr from QEMU with this error message, leaving the
        test failure log rather uninformative. I had to
        run everything under strace to get hold of it.
 203 -- this wants a machine type that can be migrated;
        sh4 CPUs don't support migration, so the test
        fails because the 'migrate' command returns the error
        {"error": {"class": "GenericError", "desc": "State blocked by
non-migratable device 'cpu'"}}
 267 -- similarly, wants a machine that supports snapshots,
        so fails when the loadvm/savevm get the error
        Error: State blocked by non-migratable device 'cpu'

How should a test indicate "I need a machine type that
supports migration" ?

thanks
-- PMM

