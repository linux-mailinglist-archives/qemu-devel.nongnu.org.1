Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F727AEE79
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 16:35:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql98q-0005pD-74; Tue, 26 Sep 2023 10:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql98p-0005p5-2f
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:34:23 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql98k-00044L-AF
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:34:22 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-534659061afso1565704a12.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 07:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695738857; x=1696343657; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gTIpHzZB0qoGJbisp9W4jhOfqGHDthqYzFmGN75Gff0=;
 b=v++88OGa4vVCmZDocGxBo8c1DhtjxhSkomY4ZkaCUmJiFBxBXkdkaUbWEqoQN1tw8J
 5IaP9yYD6AEEB4lSH7FIrsUYnZyVTnSt5pBDAGyFq3IBCKE31qjUVOKz2MMvaNdAVZZK
 7GgVVdJn8Ly6sEzQccSd4/KEcYPoWrItQ8pSMdkQi61VYkyKi9dGoWkud47EFk7r3UDB
 mH3DR2SsxeQWEE4wkpeArJkNdkSWYP/ShOrkY65A/xUrZq56slvyRWyccQH7zgNG2f/b
 WzU2YDUbvSE2+VZe3hMNTKnuFAYCiP5L7ZArvszqpusGTaezLeaiq71V9XsA3LyWJSbc
 p3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695738857; x=1696343657;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gTIpHzZB0qoGJbisp9W4jhOfqGHDthqYzFmGN75Gff0=;
 b=SPkJ0hku7/lpXgzQLGRzgVWW09kRTnMZVzJBMhn73lNHDaqSEv+lG8nAhkZF6FKzBZ
 rLo4vZpBGmoc62xgfro5qW6mjk/dbQgs9WkyhMC7y8EWk5EjO/HhtzZnxY7y7NqnzEZO
 JqUkEPDQ1rdrpKwuE1DJ9uBFiA+0HHH5BSPWW/LFIcROYsMbIOCTXcw38dIxfhUrqk2e
 c72/Qxy2IhNa1MdGnQQZtaf5cb2GZc6E7XXtkkM7TISyzC7SMVhs+KvQC1bc8lCXH6Ys
 YF/+qe3jjK34WGUeqM99itVCYXm93IQBo8Zxa6PnbXjOFnKeQSU/Jt73vdAieuCHPpZg
 FasA==
X-Gm-Message-State: AOJu0Yw8gO7eybnY7fIlFQjJQyxpf3FC7tgBjZLJATKYYg83vDReu5JO
 UsCr+g8WQXpe59yYxgFrmGVToKZIjk19GPsRgxfb2A==
X-Google-Smtp-Source: AGHT+IE8MpOLnZUhh4JTrnO+ZrIaV7wiRxeYwqa47y9tVvL0atKe7pv9oBXKCd6MDW/MAKJdtvMDa52twDPz1mzGuyM=
X-Received: by 2002:aa7:c98b:0:b0:533:9df5:ede with SMTP id
 c11-20020aa7c98b000000b005339df50edemr9185689edt.14.1695738856715; Tue, 26
 Sep 2023 07:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-6-vsementsov@yandex-team.ru>
 <CAFEAcA9TjB7OJ-j+Cnst8pt3CjVADvyvG07ZvykQKRoowgMe3g@mail.gmail.com>
 <887188ac-4887-4491-f889-fe1f62a461e8@yandex-team.ru>
In-Reply-To: <887188ac-4887-4491-f889-fe1f62a461e8@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 15:33:58 +0100
Message-ID: <CAFEAcA-A5s_SzjFuWY_7EynmgDNKvz=ryr0LNtAJky=qU6ioYg@mail.gmail.com>
Subject: Re: [PATCH 05/12] device_tree: qmp_dumpdtb(): stronger assertion
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 Alistair Francis <alistair.francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 26 Sept 2023 at 15:20, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 26.09.23 13:51, Peter Maydell wrote:
> > On Mon, 25 Sept 2023 at 20:42, Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru> wrote:
> >>
> >> Coverity mark this size, got from the buffer as untrasted value, it's
> >> not good to use it as length when writing to file. Make the assertion
> >> more strict to also check upper bound.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> >> ---
> >>   softmmu/device_tree.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/softmmu/device_tree.c b/softmmu/device_tree.c
> >> index 30aa3aea9f..adc4236e21 100644
> >> --- a/softmmu/device_tree.c
> >> +++ b/softmmu/device_tree.c
> >> @@ -660,7 +660,7 @@ void qmp_dumpdtb(const char *filename, Error **errp)
> >>
> >>       size = fdt_totalsize(current_machine->fdt);
> >>
> >> -    g_assert(size > 0);
> >> +    g_assert(size > 0 && size <= FDT_MAX_SIZE);
> >
> > FDT_MAX_SIZE is not "this is as big as an FDT can ever be". It's
> > only the internal sizing of device trees that we create ourselves
> > in the machine models (and which we will bump up if for some
> > reason we ever find ourselves needing to create bigger device
> > trees). So it's not really a suitable upper bound.
> >
> >>       if (!g_file_set_contents(filename, current_machine->fdt, size, &err)) {
> >>           error_setg(errp, "Error saving FDT to file %s: %s",
> >
> > Nothing bad happens if we pass g_file_set_contents() a very
>
> but it will also try to read beyond the allocated fdt.

No, it won't, because we can assume that current_machine->fdt points
to a valid device tree blob, and so size is by definition correct.

The libfdt code keeps track of the size of the memory we allocated
for it to use -- when we call fdt_open_into() we pass that size.
fdt_totalsize() simply returns that passed in size value. So
the amount of memory we can access is exactly "size".

(The fdt may not have come from create_device_tree(), so
it's possible both that the size as returned by fdt_totalsize()
can validly be larger than FDT_MAX_SIZE, and also that the fdt
blob can be smaller than FDT_MAX_SIZE. So that's the wrong thing
to try to check against either way.)

thanks
-- PMM

