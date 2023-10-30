Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3CD7DC252
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 23:11:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxaSM-0004sR-Qz; Mon, 30 Oct 2023 18:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qxaSE-0004re-V4
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 18:09:55 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qxaSC-0008L2-UZ
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 18:09:50 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6ce2fc858feso2915276a34.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698703787; x=1699308587; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BcSnbTQoO8unJtSFsVxX2n+uMY5Wz496Rurn25E5NF8=;
 b=d9nQp3yF/nmFvkhebLwLSEARkJhnmZVpYqbgtLXzcSk4YxpsEGlQPwS3hPMTDUbhbM
 wNVXiTMBOZKY5xmTKOGFc0QCzbyQcMUY1mjVXFQQVR4Jdq4GDpCgYpDWjVo+dzl6SMrQ
 xf1aN75uNxI6bSw9auE0wr590qBI0fd4KNJ2b7klvPcbVrdw7oNan4heARihag1juU2c
 +H6ypA6y+YOZyj4mJu8cyLmO7bBk0U3X4BVdRtqi28LQpPY2Ao277/u4Fi5KqQjvpSjK
 kgynhQ9JCnVAquu0g+lVbQ1sfosgHWDZglYProBX+ZTgBH3RN1SiMLf/ORvUGeKR4yKu
 kevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698703787; x=1699308587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BcSnbTQoO8unJtSFsVxX2n+uMY5Wz496Rurn25E5NF8=;
 b=PKSkge+IZUhk1TXt6uuMJeSIbGqYy+3zyrqL8mXutz7nBpSF/5S+8BHOnahk1VHL3z
 PMfA46FcJXvB0gGtYS0cyle3IJQWzmtOZm85Oz30JrwUo2XfFDtSDzJJXKN9HzViMgGP
 DxNupaMB8rs9H3qADBlKF9pZSWJkfNsQZBKbqsPotCZ/pB/XRZj1jQw7OeZ4VJ4tUWiK
 ZbPyrFqSXSxgbCCBjbbOU1IcvbRE9teF+kurAZ4QH3snNuCvBPbYYmbJv6amXErqzb3l
 ENqU2omWADN5U/a/pJhEmUykxP8gIJAMRSFmrvA8qxj0Cx11W9eEwE1RnUvk7vr4D9GQ
 PVOw==
X-Gm-Message-State: AOJu0YzeLOmc1/hHTQb2UD+N9mkmu7wNoEMsPPkdCK7qQXAs+scUC1WQ
 bPn4uHsRr5s7wWWDT4UDGExphVMD6nClJGW5Wlk=
X-Google-Smtp-Source: AGHT+IHKkOtQamXsWbtTAiTOSfCdtzfGOFyf34ZY05Q5BBnbn/fxv5xjaaGXJ44tv1zwbkRtK2Br4fUPH5MKEe3kyrg=
X-Received: by 2002:a05:6830:4d6:b0:6cd:896:e363 with SMTP id
 s22-20020a05683004d600b006cd0896e363mr8661725otd.37.1698703787113; Mon, 30
 Oct 2023 15:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
 <CAJSP0QU1SUqdTbzNT9_fgCyZ1pGDUk47_T2B-JzjnBXFicEWBA@mail.gmail.com>
 <CAFEAcA_na1NB3nFRmc9MRRr92VunxPJUG3SHmE2HkXAGx6RPUw@mail.gmail.com>
In-Reply-To: <CAFEAcA_na1NB3nFRmc9MRRr92VunxPJUG3SHmE2HkXAGx6RPUw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 31 Oct 2023 07:09:35 +0900
Message-ID: <CAJSP0QW=7f3k35DjBwsnbnj79HmqwSH3hWRE1Fur8x4pyOGs7w@mail.gmail.com>
Subject: Re: [PULL 00/41] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x334.google.com
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

On Mon, 30 Oct 2023 at 19:09, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sun, 29 Oct 2023 at 23:15, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > On Fri, 27 Oct 2023 at 23:41, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > Hi; here's the latest target-arm queue. Mostly this is refactoring
> > > and cleanup type patches.
>
> > Hi Peter,
> > I can't find this email thread on lore.kernel.org and your git repo
> > doesn't let me fetch the tag:
> >
> >   $ git fetch https://git.linaro.org/people/pmaydell/qemu-arm.git
> > tags/pull-target-arm-20231027
> >   fatal: couldn't find remote ref tags/pull-target-arm-20231027
>
> This works for me:
>
> $ git fetch https://git.linaro.org/people/pmaydell/qemu-arm.git
> tags/pull-target-arm-20231027
> remote: Enumerating objects: 16753, done.
> remote: Counting objects: 100% (16753/16753), done.
> remote: Compressing objects: 100% (3181/3181), done.
> remote: Total 17529 (delta 14031), reused 16255 (delta 13541), pack-reused 776
> Receiving objects: 100% (17529/17529), 22.87 MiB | 10.44 MiB/s, done.
> Resolving deltas: 100% (14498/14498), completed with 1672 local objects.
> From https://git.linaro.org/people/pmaydell/qemu-arm
>  * tag                       pull-target-arm-20231027 -> FETCH_HEAD
>
> > cgit shows the tag though, for some reason:
> > https://git.linaro.org/people/pmaydell/qemu-arm.git/tag/?h=pull-target-arm-20231027
> >
> > Any idea what's up with this pull request? Thanks!
>
> 'git.linaro.org' has several geolocated servers and pushes to
> it should get mirrored across to all of them. Maybe the
> syncing between them went wrong? You could try using one
> specific one:
>  https://git-us.linaro.org/people/pmaydell/qemu-arm.git
> tags/pull-target-arm-20231027
>
> git-ie.linaro.org also seems to have the tag.

Yes, that solves the problem. DNS was resolving to git-ap.linaro.org
for me and it doesn't have the tag.

Thanks,
Stefan

