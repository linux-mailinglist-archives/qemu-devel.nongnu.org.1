Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B315772935
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:29:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT29J-0003QS-Nq; Mon, 07 Aug 2023 11:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT29G-0003PS-SB
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:27:58 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT29D-0004YQ-SR
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:27:58 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fe0fe622c3so7320605e87.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 08:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691422073; x=1692026873;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QoOuEPwXAoB1CcjOzijYnAuXvV/Nt/hIFSXgej+7r2U=;
 b=WnujQTuJX9CTtEQZgkoDjS7in/bKcKItleRv5OMk+2I1R2NZsJ217ZnDtiKz0B0tEQ
 b2NxTNA6XTlkTdmTKy7qbTX4ZyOCfnpUcCHxcpnNspb/UscDGFhoS2vv4+SklzfRIDkb
 SMTZuqNAYxIEtQ4IPXJN961rQXHQe5UU9V6pH7oZ65RWqXG65iv73BaXEhDnA+lcMrmt
 imMK5iq9IO+hGkH1FIfKHsrBmhVKKFKowStzsaTB/W1CFndfgZkv2yAb1Gw3PUSUtGJ6
 JTEa1i5Yv0X75Cdqoq+i//njLbeWQJvBWRnxPstoNugOuhnsuNTpdTHDlEiwCxjbjZZA
 xomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691422073; x=1692026873;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QoOuEPwXAoB1CcjOzijYnAuXvV/Nt/hIFSXgej+7r2U=;
 b=B2iCt3JusGWkX68q0Twd/IDE9I2ISPjOyPEgfTc+xtfa2wtZK1nrymQWxGhiThvDrB
 3TQod2yDfe7CKAceH74wtsCWdpvvLjrpGSrEJYvGTYqZNX71L8W4su8rYHvJGtHHD8XQ
 dhz/ptRfJGcaXSzpI36S73Yj/h+4jTmZbYbiZ0YSUuGelL709OQ6XFwILXQpbZD/RQqX
 rb6dNndmBpuovXrvgByoZtbkBq4ycv4swOTo+K6+AiCl7+rDi1PnEOVp2BUhJW0ZNHj5
 tNK8s73toQN7rqL6sHzjqcN6lUsjG5yi5zJpUn1EFQavDuCL0s+pd1V+XJQgBbMEVylh
 G8aQ==
X-Gm-Message-State: AOJu0YyWhUrjBpNCpz4pqS21RlEWM4tyC9W4HTIp/5ljcZimzlbJKhf6
 5HUECJbCjF5K+WJ9cYgg/BIdaPBqjhEJzw/XcQeA/A==
X-Google-Smtp-Source: AGHT+IGBANRbPwCTQseSaIfmRqk0Uk8t9EGhTT4K7ebfXgm82Uqvo+wFcHhcw3lSVwBBpEFZCQDHH0BGZhTSHgs23Cg=
X-Received: by 2002:a19:5f19:0:b0:4f8:5b23:5287 with SMTP id
 t25-20020a195f19000000b004f85b235287mr6052226lfb.62.1691422073568; Mon, 07
 Aug 2023 08:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
 <CAFEAcA9zGqkWL2zf_z-CuWEnrGxCHmO_i=_9CY347b8zCC2AuA@mail.gmail.com>
In-Reply-To: <CAFEAcA9zGqkWL2zf_z-CuWEnrGxCHmO_i=_9CY347b8zCC2AuA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Aug 2023 16:27:42 +0100
Message-ID: <CAFEAcA9A9ZG8q6cYYbtUNgAe5JQZKVKKXWWzipzDDqcjLr39sQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] accel/kvm: Specify default IPA size for arm64
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 4 Aug 2023 at 18:41, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Thu, 27 Jul 2023 at 08:31, Akihiko Odaki <akihiko.odaki@daynix.com> wr=
ote:
> >
> > Some Arm systems such as Apple Silicon Macs have IPA size smaller than =
the
> > default used by KVM. Introduce our own default IPA size that fits on su=
ch a
> > system.
> >
> > When reviewing this series, Philippe Mathieu-Daud=C3=A9 found the error=
 handling
> > around KVM type decision logic is flawed so I added a few patches for f=
ixing
> > the error handling path.
> >
> > V4 -> V5: Fixed KVM type error handling
> > V3 -> V4: Removed an inclusion of kvm_mips.h that is no longer needed.
> > V2 -> V3: Changed to use the maximum IPA size as the default.
> > V1 -> V2: Introduced an arch hook
>
> Applied to target-arm-for-8.2 with an extra doc comment in patch 1;
> thanks.

I also figured it would be good to tag the first 2 patches
for qemu-stable, so I'll do that as well.

thanks
-- PMM

