Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FF571A14F
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:59:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4jla-0003Mi-Ji; Thu, 01 Jun 2023 10:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4jlY-0003MQ-Uc
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:59:04 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4jlX-0006KL-9R
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:59:04 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f6067a9029so1001988e87.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685631541; x=1688223541;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sfa12e3H+IEjydh/tx3CUa2C4TV2nFRduS1SiyBzebI=;
 b=QFEb+A4mQDynJ3MsFAZ8Lbf3+7cNkJeBwL7Bul5BQNr6LUkYnadoPUbv00f7sWfp36
 wV7vBtFOOHsKzQVTtefGKTSyVap6El1X50tUgdUyK6gLIjW0Px0Sp2GkIbkyAsDSQRVf
 fEHqfTjfXJKIbgAKoM350vgJJ5ncLkX/Uko2z2NpXvzwpo+aufIvTFXEzBIgK0J0gmjZ
 7db7/75HCDUJBr8hbZWC4RJcsiTHLa6jUB0fBY1vQfANtmv1jlIWy4N6IAACmyyF9C00
 Au2jt49A4uoiqUr7mHvQVDGJrnGQVuDokZPkEl27sZgpRuSuM8xHSg/+6pyc5rlB5F5a
 BoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685631541; x=1688223541;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sfa12e3H+IEjydh/tx3CUa2C4TV2nFRduS1SiyBzebI=;
 b=kW43+QrcOPV226ih8wEvtSt61sf/WkafhEiM6cwLzarrG2SiwsdBKqpiIbICPqI4vK
 uWNzZ03gjPWe5Wa49Orf8XN5cKhqVxC4xLG6TPjR0V5J9d7uKFK35H70WszZKHyrHDXI
 mQfA1BHnWXCYAv1Ld0dTRODVNVBRZI31viGbgLV3K8mdBKPUPTQdn6zKnOalr0fe6YXp
 8gLin5kS/tbHr7JKL4TIk+4eAFnnu8DPzmHlqYcB8tzUHQJO+pEeMLinf2XKLl513Ymf
 BER+4PNQZLjBLts5HfDdlXvmkCUmJ2zwBsvfIn0vxkgThnDf8TnAUmYE1ORfSM7Vp66/
 rfxA==
X-Gm-Message-State: AC+VfDzLwfMjMPyf/mt1LF3trtckrosncGxtVLHTeHKYv8BQvzCoTMfw
 ktxadzvMDmuabDWv78xzBYrk9XD8napQStdQ/tc2jQ==
X-Google-Smtp-Source: ACHHUZ7hDqPizqNIhiY1bwHHvMEK+qQxGn7QBlz9Id5ucnzrhJTeY2ShZ57m5a7FsH7LTXvpng1MZ3mn9N9Q93D4bYQ=
X-Received: by 2002:ac2:5984:0:b0:4f3:baf9:8f8e with SMTP id
 w4-20020ac25984000000b004f3baf98f8emr141947lfn.4.1685631541520; Thu, 01 Jun
 2023 07:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230601143312.69691-1-quic_acaggian@quicinc.com>
In-Reply-To: <20230601143312.69691-1-quic_acaggian@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2023 15:58:50 +0100
Message-ID: <CAFEAcA-92-zExcOFMwaNYvP5pXLTUETsYi3mpuvTp2txfVEp9Q@mail.gmail.com>
Subject: Re: [PATCH] hvf: Handle EC_INSNABORT
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mark Burton <quic_mburton@quicinc.com>, Alexander Graf <agraf@csgraf.de>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Thu, 1 Jun 2023 at 15:33, Antonio Caggiano <quic_acaggian@quicinc.com> wrote:
>
> Instead of aborting immediately, try reading the physical address where
> the instruction should be fetched by calling address_space_read. This
> would give any memory regions ops callback a chance to allocate and/or
> register an RAM/Alias memory region needed for resolving that physical
> address. Then, if the memory transaction is OK, retry HVF execution at
> the same PC.

What are the circumstances where this happens?
Do we try to support this on KVM ?


> Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> Co-authored-by: Mark Burton <quic_mburton@quicinc.com>
> ---
>  target/arm/hvf/hvf.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index ad65603445..6e527254b1 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1446,6 +1446,18 @@ int hvf_vcpu_exec(CPUState *cpu)
>              hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
>          }
>          break;
> +    case EC_INSNABORT: {
> +        uint32_t sas = (syndrome >> 22) & 3;
> +        uint32_t len = 1 << sas;
> +        uint64_t val = 0;
> +
> +        MemTxResult res = address_space_read(
> +            &address_space_memory, hvf_exit->exception.physical_address,
> +            MEMTXATTRS_UNSPECIFIED, &val, len);
> +        assert(res == MEMTX_OK);

You can't assert() this, it might not be true, especially if
we're here because hvf couldn't read from this address.

> +        flush_cpu_state(cpu);
> +        break;
> +    }
>      default:
>          cpu_synchronize_state(cpu);
>          trace_hvf_exit(syndrome, ec, env->pc);

thanks
-- PMM

