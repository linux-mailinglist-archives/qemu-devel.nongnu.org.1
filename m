Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B0673E069
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:20:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlUL-0005xk-Tc; Mon, 26 Jun 2023 08:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qDlUG-0005rQ-1U
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:38:32 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qDlUD-0005Oh-MN
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:38:31 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51d7f4c1cfeso3281397a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687783107; x=1690375107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ni86dvHD4BwWEdLQGUae2Lgg0E4k1u8amOK/2u0rXw=;
 b=ab0G21Z+y8LiZ3ooonG6mGcOpbPrQaTAXIRQgjyN3704+Ei9FYMGPR/RlxvCoUfwrE
 jZ6E+lhhyyy1RxwjhVb5bysdGskXWgeZGKTFnqBy340loVBo2L/qvURZg970wLyRtZat
 PYNKAeDqZBBJlOawipOnKjs3zWDdFvf6waKHHLDm2sqckz1XfBJAB4VsuSo9gbXyDjcg
 zW0y5zqzORMA7aX/FskGe4XG1LwvkLDVLQDXyiDGDVdCzHv1Gb8vHe2kSvK/3+qk/vhN
 awZU5Am1SCha4aH4DCOjOX53Uoa7DrFRFf8alE8A3Ngm2zT2Fks2s9ov45RocjHmhWzT
 +noA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687783107; x=1690375107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ni86dvHD4BwWEdLQGUae2Lgg0E4k1u8amOK/2u0rXw=;
 b=bNRpB4xM9FADTbyyh8udj2nt7WUvJMwwYLjbntXliCJXcNgvCmag8tHlwJpw4ugeRm
 ZxvrqLMkpegS3C6H5G0PlREpoghnAAZ8qpGpI3sugLe5Ymygzff0lcW7Bz+CyysjeRxZ
 vfdOWs9iaokEA2U04uJiQpgU5BbUYa+/4j7UXqFhJZp15YjhSd/ugB1by1K/e7H7K7Sb
 bcF0lYiBtibXys14k/KqqJG+YMvAckOCRuMaPyeNSzq0GegIz7TSZ6ByMAnOM1varg53
 FQJe+EORGQ2w8E9aRIRBC8trAzFYHlql8dyDB0L9HhedRHuBbPowiY4tKDkgaZLt32Qj
 0qEg==
X-Gm-Message-State: AC+VfDwq0fJwuXCWKynOqFZb0/g2uwFduRB/srrWPI3XcYdLNS/izrCS
 xIr9GwczKlNEq5mtXUPxEgB0iNVy94G9AcW/yT6FuDcrQLaDk8Oo
X-Google-Smtp-Source: ACHHUZ5CKKU7In03WCL+GMC25Ca6LBYBWNkVxspfkUveEE2GpnmMIUb3icnQVBsGU7u0aGyp2NTgqORiI4o13ucNKeA=
X-Received: by 2002:a05:6402:1601:b0:51b:e89e:a846 with SMTP id
 f1-20020a056402160100b0051be89ea846mr9682073edv.19.1687783107503; Mon, 26 Jun
 2023 05:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <168722304495.6281.8113287217736957231-0@git.sr.ht>
 <168722304495.6281.8113287217736957231-1@git.sr.ht>
In-Reply-To: <168722304495.6281.8113287217736957231-1@git.sr.ht>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jun 2023 13:38:16 +0100
Message-ID: <CAFEAcA8Ttt=6mt_1X3u6F2ngFoD_9hRw72r=87ybpbeeodrBLw@mail.gmail.com>
Subject: Re: [PATCH qemu v3 1/2] target/arm: Handle IC IVAU to improve
 compatibility with JITs
To: "~jhogberg" <john.hogberg@ericsson.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, 20 Jun 2023 at 02:04, ~jhogberg <jhogberg@git.sr.ht> wrote:
>
> From: John H=C3=B6gberg <john.hogberg@ericsson.com>
>
> Unlike architectures with precise self-modifying code semantics
> (e.g. x86) ARM processors do not maintain coherency for instruction
> execution and memory, and require the explicit use of cache
> management instructions as well as an instruction barrier to make
> code updates visible (the latter on every core that is going to
> execute said code).

This is implementation-dependent : if the
implementation reports CTR_EL0.{DIC,IDC} =3D=3D {1,1} then
it doesn't need icache invalidation or data cache clean
to provide data-to-instruction or instruction-to-data
coherence. This is currently not true for any CPU QEMU
models, but the Neoverse-V1 (which I'm about to send a patch
for) can do this. (It's also tempting to make 'max' set
these bits, which would save the guest some effort in
doing cache ops which we NOP anyway.)

So maybe we should also force CTR_EL0.DIC to 0 in user-mode
so that the guest won't decide based on the value of that bit
that it doesn't need to issue the IC IVAU ?
arm_cpu_realizefn() would be the place to do this, I think.

thanks
-- PMM

