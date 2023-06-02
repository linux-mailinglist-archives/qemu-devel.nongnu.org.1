Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D399720803
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 18:59:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5871-0004mf-GS; Fri, 02 Jun 2023 12:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q586x-0004m8-L2
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 12:58:47 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q586v-000477-Sd
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 12:58:47 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-514924b4f8cso3318560a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 09:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685725124; x=1688317124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9MJ/q4b2JQ5MmeMtLqiu76U2JvAHvFLoGFE6utYs/OE=;
 b=NbhJM1sFoRv1mVKD9w7SvgxWi19soyjDTvTHvGa1V+wtoRezaMeDjzemv9D0duVmEQ
 TqLQ8j+nqN0dLDIYSnFgZ5A+gEK3QIgrk6jdXRADN0d5Ny3Jrj+hfO1OyOh9jBPG5RlZ
 VfbMh0QKmXBDYtOkXPWpqUjfDayY++NlReJpl/qm2iiAt+dLpA+sWSSIr7oFfHVLrJVj
 gmsR6O+HB2ThoHUBqEdv3jyBZ4fkzC6wYCi+e3trHXNfg1260mQ3iLvkT91dT/GT5XuE
 y6K8U7AQA55BlgTf92we5bJmN5DnaFGGnIDA3QuOLQIEiFN064opcVwGMqse/GH47K2i
 wMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685725124; x=1688317124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9MJ/q4b2JQ5MmeMtLqiu76U2JvAHvFLoGFE6utYs/OE=;
 b=IDBVaEOAaYQEgQAK8Dy7tfD6dsNDq/SKtg6YdMvgl6e9a0+E/mPcvBLBtX3ltSNXXh
 84ODirHHQhz2YJLz/hWNFKJK77fmdhITVlA781sUUAmgLO5a2MV+3lHxPEZ0HDdtNdZH
 Oly+VoE0cJSWcwBou71tRREraT2/rOsv/HEYXuNwRKlzSxB5R/YxgJLZSiUysgPgEwDz
 T7JU23V110/JkZHd8Tbl99fgs4RH8qeQAqZRsEE37dW5vwSirIMF75uACoFxLZ4LYNFL
 WSq2DffSm0TGLTwczT+aO195mKRmavnwjalbk6PtfyU3g+W/t2lIdFSI1XLDgWQ/SXPu
 85Hg==
X-Gm-Message-State: AC+VfDzr3oYa5gYyAmfrBZJMew8F7EC4bu2AtyLswcTtcxL6qqkCNGIh
 tH8uBBxj0Sdc8qIuPgd7eqHHT2aNtXTI9YCaZ0xwjg==
X-Google-Smtp-Source: ACHHUZ5lQGHWjNNVfJqvxS/YY7WTq1wBJAG6Zykv//p08eAhBXGyqAczmPRjZw5ozB7nToWUY75JB82kVGqjQfZ50cs=
X-Received: by 2002:a05:6402:1846:b0:514:8e56:4cae with SMTP id
 v6-20020a056402184600b005148e564caemr2272299edy.8.1685725124013; Fri, 02 Jun
 2023 09:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230302123029.153265-1-pbonzini@redhat.com>
 <20230302123029.153265-33-pbonzini@redhat.com>
 <CAFEAcA-s+sNDn4z_kXd70koFGSLXqjMUXB5Gn9VzTnaSbr2B_Q@mail.gmail.com>
 <d61333c6394697d88dd08d48cc7fa730ff8e1987.camel@infradead.org>
In-Reply-To: <d61333c6394697d88dd08d48cc7fa730ff8e1987.camel@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2023 17:58:33 +0100
Message-ID: <CAFEAcA_CR0PraF1DuDxw6q9U=Atut_=v0L1gHr6VfgxHCbmJXw@mail.gmail.com>
Subject: Re: [PATCH] i386/xen: consistent locking around Xen singleshot timers
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 22 May 2023 at 19:52, David Woodhouse <dwmw2@infradead.org> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Coverity points out (CID 1507534) that we sometimes access
> env->xen_singleshot_timer_ns under the protection of
> env->xen_timers_lock (eg in xen_vcpu_singleshot_timer_event()) and
> sometimes not (the specific case Coverity complains about is in
> do_vcpu_soft_reset()).
>
> This isn't strictly an issue. There are two modes for the timers; if
> the kernel supports the EVTCHN_SEND capability then it handles all the
> timer hypercalls and delivery internally, and all we need to do is an
> ioctl to get/set the next timer as part of the vCPU state. If the
> kernel doesn't have that support, then we do all the emulation within
> qemu, and *those* are the code paths where we actually care about the
> locking.
>
> But it doesn't hurt to be a little bit more consistent and avoid having
> to explain *why* it's OK.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Looking a bit more closely at the Coverity lists, there's also
CID 1507968 which is for the access to env->xen_singleshot_timer_ns
in kvm_get_xen_state(), which this patch doesn't touch, I think ?

thanks
-- PMM

