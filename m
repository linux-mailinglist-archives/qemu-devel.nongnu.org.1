Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1C673D5B9
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 04:12:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDbgw-0006dQ-2n; Sun, 25 Jun 2023 22:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDbgu-0006dA-4H; Sun, 25 Jun 2023 22:10:56 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDbgs-00023S-GO; Sun, 25 Jun 2023 22:10:55 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-676f16e0bc4so248689b3a.0; 
 Sun, 25 Jun 2023 19:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687745451; x=1690337451;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gd5MDO6ifwaoxXFSPhFpUj/lSpyTFz4OUhRkMmOl/4=;
 b=hme6Hq71wtM0Rv6HuEkT/YfesvQWBNvtxwCdEx9pNFxLKiLNlr6aO4M+/6aZnA0MP+
 5/KeSUfVTwQd7z45N/rtjwH7oaptP2EdIzQB9zuwfRw/JA9HOsxSf5INriVCJ+Ekp+qA
 CIZ/857f97bxWwSTfL0BUR8uPU0nSRbhEQsu1C7CxEJlVU/AoGd41wfksdAlsZE/Ewlt
 lv15RUqdBa+nnV4+NONPXyiVV1lUkesLzbFqL4sLmgSUphcMlnGP72Y6v0vhc30HrPMP
 8OPcApYqv8RuDRGIDD8uzO6kKPKyG66rCFsMMsqyCGDY8AHU7kQ1wR50vgql99vYb1f1
 RkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687745451; x=1690337451;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/gd5MDO6ifwaoxXFSPhFpUj/lSpyTFz4OUhRkMmOl/4=;
 b=I4/79KSx5Q14kBF4Ef/s+khZz6autWhXQe36ZurIN2vaFaR1BBwMDs6sFRM+MySblw
 kb5JZPXBzMzhI3iyLrBfhhCdcctNHxJZSWq7UJDyqBkmT/KQ/ahWR+gQKZnVtK35VMOY
 ecc7aa3STXVSPZ4cnUgIP/mvxoMgjm+0YqUhJZGtwxG23LDTDmF7qJwrgbCxOCA5Fvpq
 0Xjzsbg4W0+WMXyYXsFQhEuXSs9iXkb8LENI5kNtuYpDzRXVlvfmntV0MIQFt8XwgtHZ
 PY/rLk3dRTpijVcqTkF7QdlijvTNOAC5tZnL/MRVfCaTRfoQ6ICyQFNHSpoM5TfpGN9p
 LMwQ==
X-Gm-Message-State: AC+VfDwQiOwO5bVmvqtaNXsV/dQ4sVMI9egWFxsq3kaxOjcNBUkg4rPu
 2PhliJKE1vL5bZVB9vd6VL4=
X-Google-Smtp-Source: ACHHUZ5tEVCf019+5On9wPUz2FXb2q/Bep1mdDZfsPYdrS/J5zzYEr0OhEjlcHzJpDf+JrwnXR7gKQ==
X-Received: by 2002:a05:6a20:a10b:b0:10a:ef63:4c33 with SMTP id
 q11-20020a056a20a10b00b0010aef634c33mr17213838pzk.47.1687745451043; 
 Sun, 25 Jun 2023 19:10:51 -0700 (PDT)
Received: from localhost (193-116-198-102.tpgi.com.au. [193.116.198.102])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a170902849600b001b53029fef1sm2983823plo.172.2023.06.25.19.10.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jun 2023 19:10:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jun 2023 12:10:45 +1000
Message-Id: <CTM7TTT7BGJJ.1KOH1FK5Z9FYJ@wheely>
Subject: Re: [PATCH v2] target/ppc: Restrict KVM-specific fields from ArchCPU
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Cc: "Greg Kurz" <groug@kaod.org>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, <qemu-ppc@nongnu.org>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
X-Mailer: aerc 0.15.2
References: <20230624192645.13680-1-philmd@linaro.org>
In-Reply-To: <20230624192645.13680-1-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun Jun 25, 2023 at 5:26 AM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> The 'kvm_sw_tlb' and 'tlb_dirty' fields introduced in commit
> 93dd5e852c ("kvm: ppc: booke206: use MMU API") are specific
> to KVM and shouldn't be accessed when it is not available.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Since v1 https://lore.kernel.org/qemu-devel/20230405160454.97436-9-philmd=
@linaro.org/:
> - Restrict tlb_dirty field (C=C3=A9dric, thus drop Daniel's R-b).
> ---
>  target/ppc/cpu.h        | 2 ++
>  hw/ppc/e500.c           | 2 ++
>  hw/ppc/ppce500_spin.c   | 2 ++
>  target/ppc/mmu_common.c | 4 ++++
>  4 files changed, 10 insertions(+)

