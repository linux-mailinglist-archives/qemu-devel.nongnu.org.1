Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5517DA48E
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 03:14:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwXtq-0000h8-VF; Fri, 27 Oct 2023 21:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qwXto-0000gv-Vv
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 21:14:01 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qwXtk-0003rm-Br
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 21:14:00 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so4545076a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 18:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1698455633; x=1699060433; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YX4U5Lujy/hV8pr08DM6Ye8U7VjXa35QkzG+WibeFGw=;
 b=ZS/LdcXSH3GgaKTrE0R445YLmSZmG0t+ykBSpMrrVZbqX4hCFruik25I7L852EViBk
 XPbSN7nBP3Mpo7oLa/itT4CgaAmveNx39UTMHaVT2Gsg8bTWpY0AHgo01Cg/JdYtt6jK
 ajueqVbtPJ+EMqfnzvP+q3yCD+9K9GPUblh/ydwaNcx4ohZB0V+8BnTqRCmoEyqtOsbd
 hM20KkgtioyyiYEkpQcUFf+lkzP8HznQc2qVjqiLE66lYmN9fB9DJOfWY/COQ5C4vA++
 jFkL1RJh0ktIEgrLSSJCJNDCNHcyE5o4PmnyxBk1ZBeDpptRJeaaoaOJLVQgJ3lUYGMU
 NzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698455633; x=1699060433;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YX4U5Lujy/hV8pr08DM6Ye8U7VjXa35QkzG+WibeFGw=;
 b=whuaQuh2v3AEZbjF1S+HyBHYTR2P8KtiC5DAeN3XIqafbNkNc3v5h/xysRjrtVXn5x
 pUOThci+RfZgl5tYIOpS1oV83BTEJyqycx833E2MqqeU4yjp2Sv/RqnH36cvgeBUHlhM
 JSAy5IcUUXkev6WeFoqFFqlrjaRbtOC76SSbfuJc+5oY8i3UPmPiWBEZOVUJPhplAOlI
 1XDedI36P3uaQKSMihzXUikXFevOH0hGxZ6gDWUH1QQX6nWBwE0CnnlR4BtborpV5LVj
 lmVT5Plr2oCpQ+/MOVIR5tQqVRbHaWg7BXSnrjniMzf8AH18hvdDlDyCzQ+5n6MYJ3mb
 Dxwg==
X-Gm-Message-State: AOJu0Yz5ofnKf5dVgjczHW/PpPY8CHavQKChcjqDIuyaKQCU3Hf2on44
 VY7Gxttbnzb+ZuiGpgasfgthX4l95+4aCcsr7hni/g==
X-Google-Smtp-Source: AGHT+IHsXSZWijuZGeMf6ok7Y3pNmBSVlBAcUiuQBGeWDaL4kAOmdNAmW7wc5KXW407OnGyP+JaxyexaxC1+DYepEzU=
X-Received: by 2002:a17:906:490c:b0:9d0:4b8f:3d65 with SMTP id
 b12-20020a170906490c00b009d04b8f3d65mr2287807ejq.23.1698455632932; Fri, 27
 Oct 2023 18:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
 <20231025193822.2813204-2-hao.xiang@bytedance.com> <87zg041c42.fsf@suse.de>
 <CAFEAcA_2PP1AqqOWz8phfJ7e4s5_fMqCyCdhd0m9OvJHwjVeug@mail.gmail.com>
In-Reply-To: <CAFEAcA_2PP1AqqOWz8phfJ7e4s5_fMqCyCdhd0m9OvJHwjVeug@mail.gmail.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Fri, 27 Oct 2023 18:13:40 -0700
Message-ID: <CAAYibXg98Y1+EWdjA5Ldqk6npg50LJuj91U4aULscj=Yy1AOjw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 01/16] Cherry pick a set of patches that
 enables multifd zero page feature.
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, quintela@redhat.com, peterx@redhat.com, 
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Oct 27, 2023 at 6:22=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 27 Oct 2023 at 13:32, Fabiano Rosas <farosas@suse.de> wrote:
> >
> > Hao Xiang <hao.xiang@bytedance.com> writes:
> >
> > > Juan Quintela had a patchset enabling zero page checking in multifd
> > > threads.
> > >
> > > https://lore.kernel.org/all/20220802063907.18882-13-quintela@redhat.c=
om/
> >
> > Hmm, risky to base your series on code more than an year old. We should
> > bother Juan so he sends an updated version for review.
>
> Also, if we do need to base another series on some older
> patches, the usual way to do this is to include those
> patches in the series in a suitably split-up manner, not
> to squash them all together into a single patch (with no
> signed-off-by tag).

Thanks for the suggestion. I didn't think that through earlier but I
will make sure I
send the next patchset version with Juan's changes in its original
commits format.

>
> For "assume this as a baseline, please review the other
> patches but this patch is not fit to go in", that should make
> the whole patchset into an RFC patch so wo don't accidentally
> apply this patch.
>

Doing zero page checking in the sender threads improves performance. I
would like to see that change getting in sooner. But if that is not
likely the case, I can either make this an RFC or just rebase the
changes to the current implementation (zero page checking in the main
loop).

> thanks
> -- PMM

