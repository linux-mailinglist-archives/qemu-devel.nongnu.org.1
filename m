Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0751882725C
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:12:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrHN-000193-Ay; Mon, 08 Jan 2024 10:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMrHG-00016y-W1
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:11:01 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMrHE-0007pg-7L
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:10:58 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-553ba2f0c8fso2194370a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704726654; x=1705331454; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zQ6DmBBGatx0tuuWQvekhU2tB298rQTKIGfmq3QuzW0=;
 b=MWXygUOfTduQVMuPwZUooliypGA7dQ19xwOFnuc+SsZLlnJ3ZMxwkCYmnH0sgg5P6g
 qMQ3IFh0vzT4DYaEL4iMNwkJ7BPwy2NMMpcsMNA82lbncgq3QEs6cAPK+vVXk1uotbYJ
 vo5LqgwtwF9dAAd1Clz2oWCwGK6CeF/NZfHPtgLFteVCJ+55i3+fy22my1/U1Nk81IjF
 cyoJOOihxbt2e6GCO7ZvFofxqPJf0JGDEVVbdFA08+H2QejgEWgu4cjAWWH1dqGg0fl2
 v7pdhTAt0h92/IM+McYpRI6e2vbxeEkWPBr8w4o6qKoETD0ZhcoB/KM9hM/Y4IFzjimF
 lFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704726654; x=1705331454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zQ6DmBBGatx0tuuWQvekhU2tB298rQTKIGfmq3QuzW0=;
 b=fnapONZwpNzh1IkHekiUxBwl8UxwrLCshm9k6fzLqV+WsXhfxQEW6pA9jxND3iJNvl
 bfL2cMn3iSueK6GKruHPnJit7e5f52X8yV1bdDTwsmrehxQOtXZEuI7WZRplJ7loQrBm
 zzVFj2pzIjWWdRMEZi+rflWFhPtSHDdfU3R9X4Xwh1D4c3lcp9f6VBkOcuYOQsLQhcKk
 eS09Z0xv7iP6RNdPY2baO4AXd+NeruUeJkGMDERp2DCAsaE1pdhEfWFxVoEW0k5LtuMO
 7ecD+T0CdJDsqFDzv3mHtdYsl9lRZw4sLqxGkUjHRh1WFKJ2ORY7JLZ+gKUDYyysxWNU
 unbg==
X-Gm-Message-State: AOJu0YwsekMcw3IrBslsHjl3V2JWDuX8PCbciUj01crPpXXz381UtV+T
 4tbMu4jo9E1u0dJuQ+k2Ho9A8ru7drGEedUN4o0x8wJCSlacWQ==
X-Google-Smtp-Source: AGHT+IHZtxuZojHlQtCeE6YuX/bidM40uPr/G28jBQi11DAiuW1mmfgPN94fKnU/Q6AHYvWUZ+Gkzi6C5VAcNZUENLo=
X-Received: by 2002:aa7:cd13:0:b0:554:dda2:dd63 with SMTP id
 b19-20020aa7cd13000000b00554dda2dd63mr1310190edw.157.1704726654599; Mon, 08
 Jan 2024 07:10:54 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA93kpreNOOKz6-qbVE_9Kg6tgZNaMowNLwc+G_47MXLHg@mail.gmail.com>
 <9f0615dc-c162-4ac6-9ead-7f9d28e5d318@redhat.com>
 <0fecbb98-9019-4a3a-a764-38e848b5b238@gmail.com>
In-Reply-To: <0fecbb98-9019-4a3a-a764-38e848b5b238@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2024 15:10:43 +0000
Message-ID: <CAFEAcA9OSCVmUW=Zw8EEkU-57QPKOdLcBn2nx5YbRY9K3XNtEw@mail.gmail.com>
Subject: Re: CI "pages" job failing with incomprehensible error message from
 htags
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 8 Jan 2024 at 14:41, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>
> On 1/8/24 18:03, Thomas Huth wrote:
> > On 05/01/2024 20.11, Peter Maydell wrote:
> >> https://gitlab.com/qemu-project/qemu/-/jobs/5871592479
> >>
> >> failed with
> >>
> >> $ htags -anT --tree-view=filetree -m qemu_init -t "Welcome to the QEMU
> >> sourcecode"
> >> htags: Negative exec line limit = -371
> >>
> >> Does anybody have any idea what this is about ?
> >
> > In case you haven't spotted it yet:
> >
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg1014394.html
> >
> > Is anybody already already creating a patch to clear CI_COMMIT_MESSAGE
> > when invoking htags ?
>
> That solution works fine on my CI, however, it is stated in Gitlab
> documentation that overriding predefined variables is not recommended.
>
>         https://docs.gitlab.com/ee/ci/variables/predefined_variables.html
>         Avoid overriding predefined variables, as it can cause the pipeline to
> behave unexpectedly.

https://docs.gitlab.com/ee/ci/variables/index.html#override-a-defined-cicd-variable
says that what it means by "overriding" a pipeline variable is
setting it *before* the pipeline is run, so that it changes
the behaviour of the pipeline.

What we're proposing to do here is instead that within the
pipeline we just effectively hide the environment variable
from the htags process (which will not do anything complex
like invoke other parts of the gitlab pipelin machinery).
So it isn't what they mean by overriding things and should
be fine.

thanks
-- PMM

