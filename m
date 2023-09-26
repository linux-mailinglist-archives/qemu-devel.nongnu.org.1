Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3C37AEB0A
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:06:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5tE-0001jt-8L; Tue, 26 Sep 2023 07:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5t9-0001j7-HC
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:05:59 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5t7-0007mh-Nw
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:05:59 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-533c8f8f91dso6767829a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 04:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695726356; x=1696331156; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+IqYctc6vXyAnk7lJI6tiNVIFCNG6WNOLwv/uH2q+Q=;
 b=yQ8fySAwXVeNrPOqADwrMQrRkiNknAiOtP+lPQK3JpPOKZJ82yrBTtTLwh7aljQaMS
 E5YmhZEsZ6M9GeBwaybdM756Nc1N8pndfNPPeNxXaFMHYaBkt9mL4V8DPmTNxMYKTAuo
 c8RXQGBQtB6aNLJBmu0Eis4Cw93GtnEZQm/3WNH77K59qqwj35uPqbqQy9tVq9wQ4GJT
 qH0grHL+/Dq4lIxmjOl0mDH3nOMeLjfr+vM0CHYRkvGZeOQcWsEEtIrJtW8EAgGL6EUw
 /9Wq1QdPgDYSQ6mkzVTckwMEgov182k5Q46IFJ4YxTISc3Gk1L6DbhGnZ8cAvYQmcVrp
 tF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695726356; x=1696331156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q+IqYctc6vXyAnk7lJI6tiNVIFCNG6WNOLwv/uH2q+Q=;
 b=dWH0cPX3yMspkx6vRm1imsgUTJpl/m4Zx1Zlm4SfayI4d2OIw9vhKCRRYTwfQza+Cw
 ABup3b2l3vtxxVmcOy02j3fTTFC/+HPa4dSIrX6ftxaqR34slDgLDAfFyRleQv2pT2EZ
 SOLIqPTjdfRSBZ656RfvEVJtarwUHQMInNMRTy0COCjoKg3nqo1fxWrSzl0FG5mheH2m
 uy5RM7L3p8Ac9viC3P/1FQaSa+M8o1BrVCQhFU8NIxiwMhhtEJPznCvdMPNtD3EUshJ/
 eKJ4oP1ROXb2H1mvog4D1GoQuV7sKonwEUQFt3wo0zcVJgXw/S+D6IKgwv21Egl5kNtY
 /XGw==
X-Gm-Message-State: AOJu0Yy969nKbhviNwe9AMD1l1g3sFIb65iJyzKYbQCYNc2we+adM1sD
 14ziDlbVGMCFC+eb7cd6HDrnmIYFKTLze9y57wavoA==
X-Google-Smtp-Source: AGHT+IFrcUGzXoEW7lAWqLF3YlU1u850HoxQCg1+KuWwTybo8rnfEk+TUuRgFiCKeROTpLuc4V4LmKqdEbZsb83dZkY=
X-Received: by 2002:aa7:c30e:0:b0:530:d53c:b4d with SMTP id
 l14-20020aa7c30e000000b00530d53c0b4dmr7915849edq.35.1695726355741; Tue, 26
 Sep 2023 04:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-10-vsementsov@yandex-team.ru>
In-Reply-To: <20230925194040.68592-10-vsementsov@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 12:05:37 +0100
Message-ID: <CAFEAcA8CXa1fyyGtZRwbyPch9wwmgMrg8wbWEPZ3pL3GW6n1dg@mail.gmail.com>
Subject: Re: [PATCH 09/12] kvm-all: introduce limits for name_size and num_desc
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 "open list:Overall KVM CPUs" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 25 Sept 2023 at 20:43, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Coverity doesn't like when the value with unchecked bounds that comes
> from fd is used as length for IO or allocation. And really, that's not
> a good practice. Let's introduce at least an empirical limits for these
> values.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  accel/kvm/kvm-all.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index ff1578bb32..6d0ba7d900 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3988,6 +3988,9 @@ typedef struct StatsDescriptors {
>  static QTAILQ_HEAD(, StatsDescriptors) stats_descriptors =
>      QTAILQ_HEAD_INITIALIZER(stats_descriptors);
>
> +
> +#define KVM_STATS_QEMU_MAX_NAME_SIZE (1024 * 1024)
> +#define KVM_STATS_QEMU_MAX_NUM_DESC (1024)

These seem arbitrary. Why these values in particular?
Does the kernel have any limitation on the values it passes us?
Do we have any particular limit on what we can handle?

thanks
-- PMM

