Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E5778B8F6
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:02:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiQz-0002ls-9P; Mon, 28 Aug 2023 16:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qaiQo-0002lj-Mj
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:01:50 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qaiQm-0006GI-6w
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:01:50 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6bd0a96e63dso2827125a34.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693252906; x=1693857706;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ld0BdgW1Vw7lSTkNpsDU20EAEpIruQSBXinGosgUJW8=;
 b=OSveC+bGAaKL5E3Z/MkFTewkJnqmXIfyj0g+tFOIjubPtUUd47asNtjEQaaAb0g6O3
 OXCq53Qf8l0kNeWHTh9Rnbu+UbkUPTMiPL/5SHWRyqkohruKKoomSApy7SsYg+ixH0Rb
 GjSYZZK55z/llOUYZjjnY363h945XJYROsSkewUJ0z9vfDy5CbByylw66wgcH4JGfuWH
 2+/Na53ASszRxUhCig7pDBW1PRGEcC+bftU96DFS4aYvJLG7mTJJuSdqZZ8FfXBbpmZm
 Qtzm32/7qmfUVdiwqN/t6oSeXYAXXVz0QzPR5XU1rqJSOYYZ9+vKjWcPT1YDSI6rsLKV
 od6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693252906; x=1693857706;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ld0BdgW1Vw7lSTkNpsDU20EAEpIruQSBXinGosgUJW8=;
 b=XUNN8+fppc4ap1W7RB46I8NRQjZtAAYSCsfDfNhPWzw3aHHS7DG54xfeS4zwNXFsnn
 BZi1mnGCD1k3XPEUO6HJacU7zHKMIq0CGbROHvFG88cQy3PJE8Kdr4FS4eJ4hfURQRJL
 +Wwq4kWqHywPnpAYCuMThqaAMSJd+9cGqp/mT7IjOVWd4A0SWeni2LGCKwbhmHGPNvhI
 R0AQH3OZMbiEXIDAAUxaUL+ghFfnUJWkbLSoTbA5/LK2cxKrCQRazKlfStRFpw5MGflY
 exKt94Id8I02SzW6RiWf4C1kzx2qnBd9nS6istBL/MlIljQc9JtejKAms/741biZRB7b
 ENoA==
X-Gm-Message-State: AOJu0YzZv4BPSjBVJiOOcZPWZeIy4CvvvJqdSzHhCH6Dgydcc+fzWJjt
 TrEVlTok/0t4IeUWJK4RzqhDxPKFxELXW0iz9UY=
X-Google-Smtp-Source: AGHT+IGVfLw/P0wjoj2tMpgfxnW1Z7qpL9O1vH/sC4k+rX9VJpVdTXJfrvgoIiKPjI6HDvUxnD561DExOUrSAFBrmQM=
X-Received: by 2002:a4a:3014:0:b0:573:2312:b3 with SMTP id
 q20-20020a4a3014000000b00573231200b3mr10947077oof.4.1693252906425; 
 Mon, 28 Aug 2023 13:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693228686.git.yong.huang@smartx.com>
In-Reply-To: <cover.1693228686.git.yong.huang@smartx.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 28 Aug 2023 16:01:34 -0400
Message-ID: <CAJSP0QXLticPp0DOS=7bYQf0R0MiYpRXYu_dCRE9JVUbZd2nsw@mail.gmail.com>
Subject: Re: [PULL 0/3] Dirty page rate and dirty page limit 20230828 patches
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Andrei Gudkov <gudkov.andrei@huawei.com>, 
 "alloc . young" <alloc.young@outlook.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32e.google.com
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

On Mon, 28 Aug 2023 at 10:36, Hyman Huang <yong.huang@smartx.com> wrote:
>
> From: Hyman <yong.huang@smartx.com>
>
> The following changes since commit 50e7a40af372ee5931c99ef7390f5d3d6fbf6ec4:
>
>   Merge tag 'pull-target-arm-20230824' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-08-24 10:08:33 -0400)
>
> are available in the git repository at:
>
>   https://github.com/newfriday/qemu.git tags/dirtylimit-dirtyrate-fixes-pull-request

Hi,
This is not a signed tag. Please use "git tag -s" so the tag is signed
with your GPG key.

I also noticed that this pull request email thread only has a cover
letter. Please also send the individual patches along with the pull
request email. This makes it easier for people to reply if they have
comments about a patch.

After pushing a signed tag, please send the pull request again with
"PULL v2" in the subject line. Thanks!

Thanks,
Stefan

>
> for you to fetch changes up to e424d9f7e749c84de4a6ce532981271db1c14b23:
>
>   migration/dirtyrate: Fix precision losses and g_usleep overshoot (2023-08-28 21:03:58 +0800)
>
> ----------------------------------------------------------------
> Dirty page limit and dirty page rate PULL request
>
> Hi, this is the fix for dirty page limit and dirty page rate.
>
> Please apply.
>
> Thanks, Yong.
> ----------------------------------------------------------------
> Andrei Gudkov (1):
>       migration/dirtyrate: Fix precision losses and g_usleep overshoot
>
> alloc.young (2):
>       softmmu: Fix dirtylimit memory leak
>       softmmu/dirtylimit: Convert free to g_free
>
>  migration/dirtyrate.c | 10 ++++++++--
>  softmmu/dirtylimit.c  | 26 ++++++++++++--------------
>  2 files changed, 20 insertions(+), 16 deletions(-)
>
> --
> 1.8.3.1
>
>

