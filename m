Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB097B85A9
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:47:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo50z-0004h9-4f; Wed, 04 Oct 2023 12:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qo50u-0004gW-U1
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:46:22 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qo50s-000714-Ph
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:46:20 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3af5b26d599so17527b6e.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696437977; x=1697042777; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qhvTO0KoFFH6QTE+DjRTtVPEsG+0RYnDwyOMo8NgFtM=;
 b=MfAHmbT66EyM8Evhn9CJ8ATp57xYul/uUdFSODiKBmg7v15wwztRwG7z2B3uceH8WU
 cfu27oKetUAAKvugNB94kjV4C7w0vanMDMKhlQBKNFkyJEv+vEKDu6NPToEx5NIclgyE
 VZbxJCvkOzKuQrYBzDFxf+t1UroCUDtiGLjnmitGhYPP2qz87VSmIfGGUI4J1oyKF6jB
 1AamYMjQhQXpbHvHUCiffgi3BC0UR1/YThwJO8YHWEMizWtfF1HqC5UOYH7Qpfvt2Zch
 c//cnkc2xlbSmMoJf7SLbH8iY4CjoPpzxqsseZi8PoCHW/4YWBJ6kFoxT+pa2jgIvmwb
 oZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437977; x=1697042777;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qhvTO0KoFFH6QTE+DjRTtVPEsG+0RYnDwyOMo8NgFtM=;
 b=B/VrndR/sBWUZmUFyy0cNx/RepZ9qxppweBFjLB2vqCq3rrRMnT3311VstGSjr92no
 4OzRQPPJ+V7d658j+TKBUbSfqNqwGdNga+tlX9xQR6rSOCrmmyhNhLyAPZljN0cuMJ8o
 1PFHYmtBwwC8LIFk6K52aUgXZXdwLQDtWT+6y1a9VobxFxYjcG2g73nq7RFH2C/pjgVH
 ByWWSyxcdoc1mm95coDpramIq/11mER01P5XEICJb7y1RMyF1kkjOg+3OJfyz/QyoAhd
 2mWemV+h8FXzfBgE69FtBfEVvIyhMtfexOfhyhM3begCbbNznNZ3z+El2OiRX/h5dKWR
 OOlA==
X-Gm-Message-State: AOJu0YxAuRUJnvmVTO0dYXpytmb0q8YlhreG9089RZ1o6EgvsIS9r2V/
 cb/n3HSmsRatVSZFis+tqaZXNZOUJoZ2Zr4SRds=
X-Google-Smtp-Source: AGHT+IHLjZJADVvHS2oC392uIPzEXHhWtMTzh607Y4NGcZxSGTipVQkodaTxhF3WaxMSdQGMGI+FV/TMCt4DTrU4Omo=
X-Received: by 2002:a05:6808:19a9:b0:3a7:37ae:4a47 with SMTP id
 bj41-20020a05680819a900b003a737ae4a47mr3643489oib.12.1696437977331; Wed, 04
 Oct 2023 09:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
 <CAJSP0QXw80o=S-f3ey1ujF7nY0JwYQ-BPrmxm6nRJPt2wrjxOg@mail.gmail.com>
 <72fabe24-0b50-92d1-6269-7722d6708ebb@linaro.org>
In-Reply-To: <72fabe24-0b50-92d1-6269-7722d6708ebb@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 4 Oct 2023 12:46:05 -0400
Message-ID: <CAJSP0QWAa5UjPD_cQogCOZdnxyokvJ6gc7UsLytF1YgxG-5rYA@mail.gmail.com>
Subject: Re: [PULL 00/47] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x236.google.com
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

On Wed, 4 Oct 2023 at 12:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/4/23 07:57, Stefan Hajnoczi wrote:
> > This commit breaks the build:
> >
> > ../bsd-user/signal.c:479:19: error: unused variable 'env'
> > [-Werror,-Wunused-variable]
> > CPUArchState *env = cpu_env(cpu);
> > ^
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/5222693462
> >
> > Please resend the pull request with a fix.
>
> The line number quoted above does not correspond to my source.
> Did you attempt to merge multiple pulls simultaneously?
> There must be a conflict between them.
>
> My guess is Warner's bsd-user PR.
> Please just apply that first and I'll re-roll mine afterward.

Okay. Note that host_signal_handler()'s env local variable looks
unused in your tag:
https://gitlab.com/rth7680/qemu/-/blob/pull-tcg-20231003/bsd-user/signal.c?ref_type=tags#L473

