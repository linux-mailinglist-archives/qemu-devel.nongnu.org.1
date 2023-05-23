Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E37D70DF5F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:35:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1T6I-0006X6-Hp; Tue, 23 May 2023 10:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1T6A-0006Wi-Fb
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:34:50 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1T68-0005gi-Ta
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:34:50 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-510db954476so1536148a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 07:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684852487; x=1687444487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j7s2C9SI6XB8wAsyLEfISzV45J7HRyP9cRK/x0Uw9Po=;
 b=cZvUg5WuhQoe2e+PVHIDjt3MPuG3HUqSpQZqKAhHe6fvLk7eHDL5iQs5L5r3UhneeV
 qoLCUzCeyA0AQLUg8Ym4LQrrswQHOkDhwRPXIj9aTEQsubAe5qjxmvVFrsCKGgtZZwA3
 9Wo4TRufNmltet+VQ1JG2FS4n5HRJtgta09Yqr/2AT34N1Ay4DSMgPOcfqSbjAfWbAWq
 zMxLttix/s15d+nCgyrPdstf6EpFPB2R2KXoK7hLokS3E5y1dPUyERduH7KBL8P9tJ/B
 +t8Dki4M8ZIXifPecFObLPwHHCmRsOuEzlJaihRSFB5V/5xoiG01/+dd9MIVx1YE4Tma
 e8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684852487; x=1687444487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j7s2C9SI6XB8wAsyLEfISzV45J7HRyP9cRK/x0Uw9Po=;
 b=dsouApIGw2S0LBqoaQ1yxG8uufbkA4sJNRYS+kkxHgI+M6r/Gtb7Ui5nPq58WHOLuN
 nAY6L2d2tX+pFHblHZ9uOwYsX3qx/EiDWwxSQNOhjjErl+Ifjaw6VVUvrtLIWlbVZDpW
 qBBH/Sl8LixB16UX1iRvQt9GVX3b93KVWMdW8LZlG8feXx8YtFiixHDq3Wp2wo+fGMts
 hAQKGlI0LLJZFEk6BBIGBdobCdgFRcXwlu9bhlipIS8oFBhwkS7MMAKGkzAOnwUT1xH5
 nZV/b3sNvFM0xCwoGhw4EZ2g2vFGg9NpXVwyuBTdTzGS4McGGsNfDHwz6rv1J5t/ryQN
 77QA==
X-Gm-Message-State: AC+VfDz9+6OS6Wru1b3+ECL5be1MoQewQs5EdNxtwxX/EqFzPE+VkU74
 dfJYHQRTISKpJnzjUZa7HMxhRFwWIyotyW/4HYOjnVn0W6rcwL/M
X-Google-Smtp-Source: ACHHUZ7Hg2BGlDuddJjwQ7Wb+PxVd/C/0J8EsRFx6GFZGvdXSzzJmNrtu1ypGEtOkKljXHdTmTA0/5adKUI1MhXGHx0=
X-Received: by 2002:aa7:d916:0:b0:50b:d57c:2a7c with SMTP id
 a22-20020aa7d916000000b0050bd57c2a7cmr11676626edr.18.1684852487434; Tue, 23
 May 2023 07:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_=Zp9YBcJDsCZ-UoMUyjBoG8XMkgfjS3_iGX9hWzM0=Q@mail.gmail.com>
 <4141b7a3-b288-7431-918f-959a3d97f526@linaro.org>
In-Reply-To: <4141b7a3-b288-7431-918f-959a3d97f526@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 May 2023 15:34:36 +0100
Message-ID: <CAFEAcA9RpqQ1m5jhQGz-YgBEtqNV+GpXV1FZQEVAhTsZ83WO=A@mail.gmail.com>
Subject: Re: proposed schedule for 8.1 release
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 2 May 2023 at 16:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/2/23 15:44, Peter Maydell wrote:
> > Hi; I figured we could put some dates into the proposed 8.1
> > schedule. Here's a starter:
> >
> > 2023-07-11 Soft feature freeze
> > 2023-07-18 Hard feature freeze. Tag rc0
> > 2023-07-25 Tag rc1
> > 2023-08-01 Tag rc2
> > 2023-08-08 Tag rc3
> > 2023-08-15 Release; or tag rc4 if needed
> > 2023-08-22 Release if we needed an rc4
> >
> > (dates picked largely to ensure that we don't slip into
> > September)
> >
> > Richard, you're doing merges, so the most important
> > question is whether this works for you :-)
>
> Looks reasonable.  I have some holiday scheduled between rc0 and rc1, but I'm sure we can
> work that out.

In the absence of any other comments I've marked this as
the actual schedule on the wiki.

-- PMM

