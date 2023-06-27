Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C12D73FCCF
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:25:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8gL-0002OA-Ej; Tue, 27 Jun 2023 09:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1qE8gC-0002LC-Om
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:24:26 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1qE8gA-0003id-2X
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:24:23 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-510d6b939bfso5932852a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 06:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1687872259; x=1690464259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlLHpt8mqhf5MppTqMtZyXybKQoLwbHkqPVsSZB+qso=;
 b=JQaYT36FZJ69uwYOB+2N0+KnUeJHJyl4JBv1aL9Hyb6BRkq+mR1Vi6AnTYPc627KAH
 uerFlYzZImz8xoZGgcAP7jOTsBTY/jObvUgWTL70tjlKmi327estVR2Gnji3iNDyPSJ1
 i4B6uWmp/LrZNzLDdGozYDXrSa9sSdBKKoEq/x8GrRT/iCuAgb5F6xlr29fYxTM2iU+a
 eqpeSA19hDD6x6mbp4dLymIzpOYSo1HN+/B4e1mMrIFqqHPevT4aipDoDRpn8hNVR7tu
 0SLniWTUOLMYkzHEEWMQF8exRkeLPOMujwI+4191i6c4ocrYOZK0LXp8kd9EMZGD9jbI
 yyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687872259; x=1690464259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VlLHpt8mqhf5MppTqMtZyXybKQoLwbHkqPVsSZB+qso=;
 b=UP+GTkSzqRO6YM323TOIi5qjworA7OqwNx3n2xmYHhw8czd4HCn4F3xFwh7jq+njG9
 m2ebWGv+hgm5U6hk84xF5JqnsQHBi1lBCx6gdWgTaLbNjHYu7VYXPJMz+dPq3zL//gSc
 SNp3q2S3IxXc+1/ROCUQDrR4PZ2cjsq0mdtOGt03z18kA4q7I57mbltUPWh0dp2kn182
 u12MfZ+z3eD1iy3HkbUUhTgNvPkPVT0HcS2nRfohLwEbCKLhrZZU854JgFFvLoaYc678
 tv5h6J0IwNtuTL0ShPGYGCiJYZh4rV+MwCXet0fsubHC+VotSmSek+L73Ua/4afzM3Rl
 GTqA==
X-Gm-Message-State: AC+VfDzYDYTYbJ3KKlFMrXHbSPClGn69kQNSZQTA0Wedzba1YMKSWkgJ
 sLb2swZ7dscfdTRkFt1rq7XPnvhYggGy/+AP1cmK0A==
X-Google-Smtp-Source: ACHHUZ506UFY7rmJn414b+dkZM1Qm2XfZHZHBvhz6baV3o2/bjfBIjFpFxy0O8EM/P80hqMBuT2hu/bUAmpz/8AtN4w=
X-Received: by 2002:a05:6402:1859:b0:51d:8835:90a1 with SMTP id
 v25-20020a056402185900b0051d883590a1mr7444094edy.30.1687872259390; Tue, 27
 Jun 2023 06:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <deda3e29-654a-5a60-98bf-b97b0ada570e@linaro.org>
In-Reply-To: <deda3e29-654a-5a60-98bf-b97b0ada570e@linaro.org>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 27 Jun 2023 18:54:07 +0530
Message-ID: <CAAhSdy2JeRHeeoEc1XKQhPO3aDz4YKeyQsPT4S8yKJcYTA+AiQ@mail.gmail.com>
Subject: Re: Is it possible to boot a riscv32 guest on riscv64 host using KVM?
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Yifei Jiang <jiangyifei@huawei.com>, Mingwang Li <limingwang@huawei.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 qemu-riscv <qemu-riscv@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::52f;
 envelope-from=anup@brainfault.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jun 26, 2023 at 4:57=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi,
>
> I'm working on a tree-wide accelerator refactor and want
> to run various configs to be sure I didn't broke anything.
>
> QEMU theoretically supports running a riscv32 guest using
> KVM on a riscv64 host, however the documentation I'm finding
> only refers to riscv64 guests:
> https://github.com/kvm-riscv/howto/wiki
>
> So I wonder, is this a valid / supported config? If so,
> do you mind helping me with pointing me to a guest image
> and its command line?

Currently, we only support running rv64 guest on rv64 host
and rv32 guest on rv32 host.

In the future, we might support running rv32 guest on rv64 host
but as of now we don't see a strong push for it.

Regards,
Anup

>
> Thanks,
>
> Phil.

