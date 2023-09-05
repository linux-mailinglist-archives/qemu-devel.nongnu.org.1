Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D48F179309C
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 23:06:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qddEG-0003D6-6J; Tue, 05 Sep 2023 17:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qddED-0003Co-UF
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 17:04:53 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qddEB-00058x-Jp
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 17:04:53 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5733d431209so1858474eaf.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693947890; x=1694552690; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mfUDd8ZEGAsrffpbGNCo9ME/tXdTQ9gHp5SfBaR2JFk=;
 b=K9Ne/p0c4230zWBAUWMjo3rpk08HltaPYQgAukkJpJQiSWhxcrAwEHmqu5UVPV1uoa
 /pKTL10VxqmDW62wNIBQJd6b6jgqCflS1zoZcJHFXeoCil3swQsGvHdDbJpqOHzV6MDr
 zERYo3J1ap/rUYeusrmqL5CAi/PLRghs99N16Sr6xJdkeyRqEk7haN1JsPmm2BqcvKq2
 ZVtHQ8E1iCFZ/immUY1Y81O/LzuZU6pdKltbdr8gSsl522mu3pR7fBEtG1hPf8WiMNK0
 TgyOZwD8wob077zPtTEr6nsJ1xcxjSh+CACZquJkHwOs6WV1nmGYH//84S2kP+f96OEh
 C+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693947890; x=1694552690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mfUDd8ZEGAsrffpbGNCo9ME/tXdTQ9gHp5SfBaR2JFk=;
 b=ZAwIHynSp0hTcSRwiOAESK54FIirZJh891nXiNi6LMZk7Y6kFKM8u82T1E96vDn/jw
 2v+EfGTH5IEFgcyAj4Gq0MhQf7h2TGbMOKC4AynBSjf/M3GSEXkg3punmmvscSARRB/G
 /wK9lfYl/fM+m+i9Q4bJ3kCfsJNE6Nj7N+GcsohrzxnPwTLOcKey/Bew+D0QC0JHHIdy
 VszaSxPk21UHG5tx+v4txQ2djvYOZlsB+lN+saqFqDhwxrA06C0nXBch3RbCiEpmaTIT
 +30z4Hx4H+fLSMQi/pyTf6DIQmm2Pc1a6TdDEc5+EOXvKBh0m3o2KMDEKxpAwS0gOhJe
 J/kA==
X-Gm-Message-State: AOJu0Yxc/VyiMwD5HVQ5KQ574cqt+kCmRovwfv5vzXAnEoVqeEopcwfx
 emTxdLRHLLz9AXTTYuRck6av82xRJPRwYVWMuqM=
X-Google-Smtp-Source: AGHT+IEDB5El3t1tPA55jFUyEH5UYV1jsyGuekJxqK59K6q9MSvZV9zME7FBkbQl8uJl/wBiPcQ9Y6AXpQl4j8pKtI0=
X-Received: by 2002:a4a:7559:0:b0:56e:a14a:f04e with SMTP id
 g25-20020a4a7559000000b0056ea14af04emr11287105oof.9.1693947890232; Tue, 05
 Sep 2023 14:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230905180359.14083-1-farosas@suse.de>
 <20230905205649.GA530281@fedora>
In-Reply-To: <20230905205649.GA530281@fedora>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 5 Sep 2023 17:04:38 -0400
Message-ID: <CAJSP0QX5+OepYq2usrOPfbTFYSaU5rtk0FKoumK3joyRO-eDCQ@mail.gmail.com>
Subject: Re: [PATCH v3] iothread: Set the GSource "name" field
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc35.google.com
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

On Tue, 5 Sept 2023 at 16:57, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Tue, Sep 05, 2023 at 03:03:59PM -0300, Fabiano Rosas wrote:
> > Having a name in the source helps with debugging core dumps when one
> > might not have access to TLS data to cross-reference AioContexts with
> > their addresses.
> >
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> > v3:
> > used const
> > v2:
> > used g_autofree where appropriate
> > ---
> >  iothread.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
>
> Thanks, applied to my monitor-drain_call_rcu tree:
> https://gitlab.com/stefanha/qemu/commits/monitor-drain_call_rcu

That should have been https://gitlab.com/stefanha/qemu/-/commits/block. :)

Stefan

