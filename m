Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2417AF034
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:04:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAV2-0001xq-Ta; Tue, 26 Sep 2023 12:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlAUH-0001mX-9g
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:00:37 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlAUF-0008Pf-Io
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:00:37 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2bff776fe0bso152351951fa.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695744033; x=1696348833; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dIb+tmvX7M8F3OahZjzcL5PmF/cYEe83ShjE17qyD8M=;
 b=cBAfWf/Pq8B6PwXyjCginy+2+9tTDES367sNJd+YPoE/OnkVRiBWBHjVyKMvcR6o0P
 oKGj83edf/Va9fc6EBTNIbPf7jjILZaaOlQd1WSW1C65F3jfffP3NgSQ3gMdLYswv8ET
 iY6OP6rVM150qVERw7oAIn9hGhqdXf8DE+m6c40jXqNqHUydfxEfnjXfdmeLa0owVTX2
 LqFLlOdgAqiTRbHZPmfqePjOMLocBdejvt1RsXenRwmA7XhVNWzDcAAczXEDbCntly2d
 vQG8FTMuZ3HlmrzuqnLHmpvJb9pIdrr+8Q3uJk9oY2bQsVtwt87ISIUcZiREvnH+nk/c
 U3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695744033; x=1696348833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dIb+tmvX7M8F3OahZjzcL5PmF/cYEe83ShjE17qyD8M=;
 b=CTWSFTRoapAWNO/7EOdVwNXyRpo8aWaK2JwiO3QPfG9j7aZnpoblDbcOpF3bxGfa8N
 n/RWUYhdFgcaxOUuEj+SmBizs2MsfPQWajxaRLOaXa8PY9VrUVRgrHR3ZRgv6AtUk2yP
 K0jOmxKJcW9nbpOYhgZk484sHRpZfAKfsU/hUwqs8qUtS3I2pQ582UYdvVgDKetp+khv
 WMvlHeHTUUzI0bIGrckIA/xVM6tNkD0CS/QZwd3vKkYKbfWolBrfpbGmiZN3cNCQFMFK
 a8nZaLQNACgJ8wl6xP3LN46EFmVMGgSLItyYIS5BkYrYhGzmTw9RRk9PyKOR2oYMkPJP
 FvPQ==
X-Gm-Message-State: AOJu0YzWGZaW4RiRawKFYJEjBThQV6BrjFZIMokus1B6wUQzuShu3fmS
 /USeqc0GPuUli/aoKp77MJ8vsBhz4n4c6+mC6VA/hiKdcGeqdV1q
X-Google-Smtp-Source: AGHT+IHJtk9ZJIctL1yahSsL6Ga8Hwff4vOr0K+HRzjnq13kYam0dtgWHvNiiFekrZZRnUrRi0V3WNagjZe37FiW75Q=
X-Received: by 2002:a05:6512:110b:b0:502:fdca:2eaa with SMTP id
 l11-20020a056512110b00b00502fdca2eaamr10212134lfg.52.1695744033032; Tue, 26
 Sep 2023 09:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230926144149.715750-1-pbonzini@redhat.com>
In-Reply-To: <20230926144149.715750-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 17:00:14 +0100
Message-ID: <CAFEAcA_8EfEnh+-7JnN88KUWWxu1eQzJTH4Q7f-Tdf3dzDMwxw@mail.gmail.com>
Subject: Re: [PATCH] make-release: do not ship dtc sources
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Tue, 26 Sept 2023 at 15:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> A new enough libfdt is included in all of Debian 11, Ubuntu 20.04
> and MSYS2.  It has also been included for several minor releases
> in Fedora and openSUSE Leap, as well as in CentOS.  Therefore
> there is no need anymore to ship the sources together with the QEMU
> tarballs.
>
> Keep the wrap file so that it can be used with --enable-download,
> but do not ship the sources anymore with either archive-source.sh
> or make-release.

Can you explain this use case in a little more detail? I'm
clear on the two poles of:
 (1) dependency isn't in all our supported distros, so we need
     to provide sources and handle building it ourselves
 (2) dependency is in all our supported distros, so we don't
     need any special support because meson will find the
     system library and headers

but I'm not sure when we'd want something in the middle, which
is what this sounds like?

thanks
-- PMM

