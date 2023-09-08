Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DF8799252
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 00:33:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qek2Q-00029L-Eg; Fri, 08 Sep 2023 18:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1qek2E-00027p-5Z
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 18:33:06 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1qek2B-0004IN-Ky
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 18:33:05 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-501bef6e0d3so4212814e87.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 15:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atishpatra.org; s=google; t=1694212381; x=1694817181; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yqXm+za/42HYAElCu96LeV1rf/seSOt91QYGkjq4wA=;
 b=CjP+QcB66PrZBW4As9lrTFnfmMt+JpcyDQqyhlzPvj+fZsO/4MKRWDHXvzJCvGPev6
 2KdilqlW0dpfpfi1HsJX3DluXIePXGO1tz4fFU6RlRudNSNs4yc1gOT0Ik66QoiiJ6Nx
 SL1PkgjOCGg1Vj3ymBgZoIdoEngGcw075e6zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694212381; x=1694817181;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yqXm+za/42HYAElCu96LeV1rf/seSOt91QYGkjq4wA=;
 b=g7/2+2nS4pHqcmz9GyUKAIzY21OWwi0/DoMs8SkYQ3AIEgBHveeXRp3duBjgLFDG0D
 TqTbQPSlY8vyU7IiORYjsn9Eda1QWXP6x9nIgXZhdLy15aHqCzsd9nnR63mXdYfqxHer
 O7mnCedgj589H/c+ufokBET/b51GCPmplW4r6SJMcb2X5WctPw17I0A9k8owOuWLc6PI
 Zar4V3S+DD9ApcuMafoLvoGIQBPnEfLbWPsy4ZybXAz0IPRDu7B6kS8h4evPB5zoqhjc
 ZK7pnLSRWWJL5LCTzYg9V560kO89l1a6qIyjM7nBEnWaEEHZItMsZtUHyez2DSZXhLJ8
 FwqQ==
X-Gm-Message-State: AOJu0Yy7Ye5Z9Q700wr8z9n0UaE45cTYnvGW1CDwayE6V4rk92tv+zC/
 dH0PtPmGKiAczSNvqJK9KadmPODdhr+vFrC4FkqO
X-Google-Smtp-Source: AGHT+IEoFG2B9Bx/oDzmu1l/+2nOO5YCAEAb012JoIKAVgJuMrmdWM0B+OITE8jdBWdMECYxDWlCKYOipVVdF7PADhU=
X-Received: by 2002:ac2:58e1:0:b0:4ff:7004:545e with SMTP id
 v1-20020ac258e1000000b004ff7004545emr2601982lfo.4.1694212381116; Fri, 08 Sep
 2023 15:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230908033129.694-1-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20230908033129.694-1-zhiwei_liu@linux.alibaba.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Fri, 8 Sep 2023 15:32:50 -0700
Message-ID: <CAOnJCUJPA9nzJRUuxd13WJzhGjWPBbmnNFn4Fcw4Wcf7WOO2fw@mail.gmail.com>
Subject: Re: [RESEND] qemu/timer: Add host ticks function for RISC-V
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 LIU Zhiwei <lzw194868@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=atishp@atishpatra.org; helo=mail-lf1-x12c.google.com
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

On Thu, Sep 7, 2023 at 8:33=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> From: LIU Zhiwei <lzw194868@alibaba-inc.com>
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>  include/qemu/timer.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index 9a91cb1248..105767c195 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -979,6 +979,25 @@ static inline int64_t cpu_get_host_ticks(void)
>      return cur - ofs;
>  }
>
> +#elif defined(__riscv) && defined(__riscv_xlen) && __riscv_xlen =3D=3D 3=
2
> +static inline int64_t cpu_get_host_ticks(void)
> +{
> +    uint32_t lo, hi;
> +    asm volatile("RDCYCLE %0\n\t"
> +                 "RDCYCLEH %1"
> +                 : "=3Dr"(lo), "=3Dr"(hi));
> +    return lo | (uint64_t)hi << 32;
> +}
> +
> +#elif defined(__riscv) && defined(__riscv_xlen) && __riscv_xlen > 32
> +static inline int64_t cpu_get_host_ticks(void)
> +{
> +    int64_t val;
> +
> +    asm volatile("RDCYCLE %0" : "=3Dr"(val));
> +    return val;
> +}
> +

rdcycle won't be accessible from the user space directly in the
future. rdcycle will be accessible via perf similar to other
architectures from the next kernel release [1].

rdtime must be used to compute the host ticks if the host is a riscv.
This is the equivalent of rdtsc in x86.

[1] https://lore.kernel.org/lkml/CAP-5=3DfVcMg7TL6W_jH61PW6dYMobuTs13d4JDuT=
Ax=3DmxJ+PNtQ@mail.gmail.com/T/#md852c28f4070212973b796c232ecd37dc1c6cb2b

>  #else
>  /* The host CPU doesn't have an easily accessible cycle counter.
>     Just return a monotonically increasing value.  This will be
> --
> 2.17.1
>
>


--=20
Regards,
Atish

