Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9658382C4B7
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 18:29:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOLKP-0000So-2R; Fri, 12 Jan 2024 12:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOLKG-0000Pz-1B
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 12:28:12 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOLKC-0001ic-E6
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 12:28:11 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2cd0f4f306fso79841601fa.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 09:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705080480; x=1705685280; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z2o2nEwN2RdA6W0Lq9pAN+W3yOAdWWMaeeMlvZgKwyY=;
 b=V06fZ91jyBu8fCBQo1JssPU6u+1Jp8Tm/b0zK19JDblrVlEVeU6M7NU/61a/2zqeDJ
 WTVdoO5hDhEwzu4qzJY4IU7IHHbWrBmiFL8qYOQCix0p/qv6K92yqUu4SSuJ0V1DZPFb
 38WFWRTKgasemtpUqxX+ZGIelCVxO8HNJgSjOBgIT/53N1YOjcUNKzsCXCYDtu72S4cM
 WUavgFwg+vDM9kLmkonbrkEyTQxznRQpdmcWo1AgTSfJxfvVN+ZvKFzhYkw7Ji0SVnp8
 04zviJIDCDY+hwB4oVucW+PxIzURxzPkC2CGcLuDhCqkqrGZGmyv+Yqcpm9fIlG3gxio
 yf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705080480; x=1705685280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z2o2nEwN2RdA6W0Lq9pAN+W3yOAdWWMaeeMlvZgKwyY=;
 b=amO+eg6DA84RH3rw3GzeUiNtFkKLoHKRQe+9DrLp6Cj/odx+26kaCTgirE7nULpB4K
 C0YP3oXcs5LfrIRQppH4otEb8Hfx70WnXw5RUkAt+oDSCML+T4m7gXoagWUS01kL6w/U
 KErDoXCGUiFakyWhDSxMfgTrwikOoV1AaLxvGPNkLCu+Yq2YSroAPHVmx9i6oosa8F8y
 14QyWaDPschjshm9223dmnJfmSNHK7BqCTugcu2SMvZ66EgVOKw7s/ygHCZDEzY2xsXf
 RcPi/av/yhu1+WCtWPovXvRlyAj2nrLPyueVTKCOkty/rxQ5CUkx6GCbp4kJqiduxWmX
 ZNqg==
X-Gm-Message-State: AOJu0Yw2reYGyAFunw3jHm8KmDSyLvTZBbkcZ7zsTCkepcXQwfVjbTZz
 uGkgjAkmYBoW9TMXwT7iFqXGMQZ9GPftfja6W91GoSPx7JYkRw==
X-Google-Smtp-Source: AGHT+IF6ZGVtvotph3Nd2UiHGVzMDAfDmnPmZiF7AUUcafArtD4Iv52R/D61EwAQ4TeQyUEauV+H0m2oitc8vfwj4ZY=
X-Received: by 2002:a2e:7819:0:b0:2cc:e379:88bb with SMTP id
 t25-20020a2e7819000000b002cce37988bbmr909280ljc.19.1705080480479; Fri, 12 Jan
 2024 09:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20240111170047.909117-1-thuth@redhat.com>
In-Reply-To: <20240111170047.909117-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 17:27:49 +0000
Message-ID: <CAFEAcA--QXyv4SfNYnVFn-_NmHY+wXCYnsTN5T9_WLQF63o32Q@mail.gmail.com>
Subject: Re: [PULL 00/17] Misc patches (qtests, s390x, m68k, gitlab-ci)
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

On Thu, 11 Jan 2024 at 17:00, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> The following changes since commit 34eac35f893664eb8545b98142e23d9954722766:
>
>   Merge tag 'pull-riscv-to-apply-20240110' of https://github.com/alistair23/qemu into staging (2024-01-10 11:41:56 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-01-11
>
> for you to fetch changes up to 52a21689cd829c1cc931b59b5ee5bdb10dd578c1:
>
>   .gitlab-ci.d/buildtest.yml: Work around htags bug when environment is large (2024-01-11 17:49:21 +0100)
>
> ----------------------------------------------------------------
> * Fix non-deterministic failures of the 'netdev-socket' qtest
> * Fix device presence checking in the virtio-ccw qtest
> * Support codespell checking in checkpatch.pl
> * Fix emulation of LAE s390x instruction
> * Work around htags bug when environment is large
> * Some other small clean-ups here and there
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

