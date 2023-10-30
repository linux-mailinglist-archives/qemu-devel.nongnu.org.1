Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEA37DB77D
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 11:11:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxPDS-0005mL-RK; Mon, 30 Oct 2023 06:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxPDR-0005m9-45
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:09:49 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxPDP-0003RN-5h
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:09:48 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5401bab7525so7166156a12.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 03:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698660585; x=1699265385; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WJE0aQ2lPpQ7XLCh4XmM4xcA3ffiEXhcCLE4K6YyCP4=;
 b=uMkjIHJYGJjpp0o6F+cnAY8GeRNz9lm1sWmVMuUapYktn4e6T6+KZC8qHXHaGTAr+y
 N5gXCLBqrOatSvytWxVsda728WU/mb6Xtpk7gzljWPD729LuPzXd3yq9tOY6lhNEUaBr
 VN5K0SAEbXNcAcUwOmp5Tm6P8bMrWvtcFg7cshHb0ExTZkReaajMKTgcOGAVDMoT3RUD
 SGhHKwY/v+7xCnb2wfuMPDZoyZZEtu5QrHxTuARlBeJgMltUi2EkXKSfEmbGBxxKuKCE
 0uqQqZDQaaNg58DjCqt/s3jzwxKDThksBplRCZ2h8dSMoL2hR48K3fKI8oD6G/xwCtDZ
 u8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698660585; x=1699265385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WJE0aQ2lPpQ7XLCh4XmM4xcA3ffiEXhcCLE4K6YyCP4=;
 b=XS/wpnQg35tFQ7H93Qvi8I1SoJAErPF6/ZNW8b8pUd1csHpcNdKWrufBdEwZdafmZP
 00NZtveFps8W56kO1tmi9joKc43CYMGVjUs4TGQE82w42+f4O9iPBikfIJXuiAkfu7rP
 JZ9NEKCw7EFNR1nHmi7VXfRf3bEw7rA+1iGZT8lIr2Bf43HJUJkB3iv8MwUl/yhdmol4
 oyicTjUFxuvektP079uVYDLlBYVqTomsGLN7voD+rEkYspBs5xxwPgJJJ/sfIbed3RRJ
 m5bAs7xFTr8oACsmtiT4Iudrg1yDD0mClJ7DmnCppf2XNoUr0bNsEPgF5syuHlbm/IAk
 4Bvg==
X-Gm-Message-State: AOJu0YzrzOA1oYKtbgaLx5KRctU50bStGt+Dx3P/eA5+2vOzzh/GSWT4
 d6C3yPpguEe3/zYRhvevkUkPHx3scrbXbYU8nscxyoYAjbC85jhL
X-Google-Smtp-Source: AGHT+IFQzgnphmReJxJKMnM8D6Iftw1KMspP0a+rwnwjZxlrx8donvcjdLM3LkPE4BYBIs8Wqza2MEOauQiBY5P3Mmg=
X-Received: by 2002:a05:6402:8c1:b0:53e:afc0:ea43 with SMTP id
 d1-20020a05640208c100b0053eafc0ea43mr8058405edz.4.1698660585134; Mon, 30 Oct
 2023 03:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
 <CAJSP0QU1SUqdTbzNT9_fgCyZ1pGDUk47_T2B-JzjnBXFicEWBA@mail.gmail.com>
In-Reply-To: <CAJSP0QU1SUqdTbzNT9_fgCyZ1pGDUk47_T2B-JzjnBXFicEWBA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Oct 2023 10:09:34 +0000
Message-ID: <CAFEAcA_na1NB3nFRmc9MRRr92VunxPJUG3SHmE2HkXAGx6RPUw@mail.gmail.com>
Subject: Re: [PULL 00/41] target-arm queue
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Sun, 29 Oct 2023 at 23:15, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Fri, 27 Oct 2023 at 23:41, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > Hi; here's the latest target-arm queue. Mostly this is refactoring
> > and cleanup type patches.

> Hi Peter,
> I can't find this email thread on lore.kernel.org and your git repo
> doesn't let me fetch the tag:
>
>   $ git fetch https://git.linaro.org/people/pmaydell/qemu-arm.git
> tags/pull-target-arm-20231027
>   fatal: couldn't find remote ref tags/pull-target-arm-20231027

This works for me:

$ git fetch https://git.linaro.org/people/pmaydell/qemu-arm.git
tags/pull-target-arm-20231027
remote: Enumerating objects: 16753, done.
remote: Counting objects: 100% (16753/16753), done.
remote: Compressing objects: 100% (3181/3181), done.
remote: Total 17529 (delta 14031), reused 16255 (delta 13541), pack-reused 776
Receiving objects: 100% (17529/17529), 22.87 MiB | 10.44 MiB/s, done.
Resolving deltas: 100% (14498/14498), completed with 1672 local objects.
From https://git.linaro.org/people/pmaydell/qemu-arm
 * tag                       pull-target-arm-20231027 -> FETCH_HEAD

> cgit shows the tag though, for some reason:
> https://git.linaro.org/people/pmaydell/qemu-arm.git/tag/?h=pull-target-arm-20231027
>
> Any idea what's up with this pull request? Thanks!

'git.linaro.org' has several geolocated servers and pushes to
it should get mirrored across to all of them. Maybe the
syncing between them went wrong? You could try using one
specific one:
 https://git-us.linaro.org/people/pmaydell/qemu-arm.git
tags/pull-target-arm-20231027

git-ie.linaro.org also seems to have the tag.

If you let me know what 'git.linaro.org' resolves to for you
I can check with our IT whether the syncing has broken.

I don't know why the email hasn't hit lore.kernel.org, but
that seems likely to be a problem with lore, because the
series did reach patchew, the lists.gnu.org archive, and you:

https://patchew.org/QEMU/20231027143942.3413881-1-peter.maydell@linaro.org/
https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg09548.html

thanks
-- PMM

