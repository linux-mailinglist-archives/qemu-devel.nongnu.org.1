Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA49740ABD
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 10:11:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEQFt-00080P-OA; Wed, 28 Jun 2023 04:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qEQFp-0007yT-Go
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:10:21 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qEQFl-0001XS-EG
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:10:20 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-51d89664272so5159459a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 01:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687939815; x=1690531815;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bdUKDs3NrDlvDu85I0ujJlz1kTwuhWYb6Cmaa8BIkaY=;
 b=CjGjXq6Jc93wTIICQIcCm9NBlfzGGwhCRz0R5XExWN+XWCNblPHozfFhVClsitXdtv
 1LcJN3mYWd56elr/7oacwGr1xNxYu/EImhaiX0y/H/4btkFjo6VYxyAZStl6tVehXAfj
 WstZDS7KdzkW9ZmU/vPG3piwmTLJY4+kJyWJyEkcD14336UB53EnOaPHx6yUwKco7hFm
 vAwxdN8sOPr/ONZvkb/6Qsa90wf5hZ0H3t/QXw1Y4/9bdTkww6NkYxQt434uwziavM84
 wSSVAi8gg637xbXih9d/PW4hvVjSw1GK/m2Mmr0n1u7UC7QdEE2+APhM1fZsZ05ZbH3Q
 /chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687939815; x=1690531815;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bdUKDs3NrDlvDu85I0ujJlz1kTwuhWYb6Cmaa8BIkaY=;
 b=K16r387kCsfWSZU8DPdSp/gFlSRJlGOnOqXb1TEGqMTke20Cd03JWfnLsBk1gXrbpn
 kuhbeZhl8BV5g1Wo0qtF9nkDbIpyDaqITdgovY4jOnIrj46XTFtxVf6zK59cAwqrXjqT
 seXY+77NFigSO6Lv8g+ckbVIvovc1bW7kqv3lgHjTzqtFkGtuTCB720jO/SfX+/H2dx+
 SjLKToVUh+C/AWSHwMVbv91qToUdsjO6kYnBgb+0FDeXvIV6p1gLhOh8FUOYl/zNg2Yh
 qgrL6rI5SZKVRzhxN3ikJxFCmvZ+th8AUp2EbL03fNEH11KfVdKT83Yk0262/OalfOqB
 cdlQ==
X-Gm-Message-State: AC+VfDwfuw2K2wRKGcvypYRrExIKgeAXsxSvI+KhdZK2/b4RQwiHXELw
 +rmTq/7ZK9bM0SdqWTVnwkqn4A==
X-Google-Smtp-Source: ACHHUZ48EmF53XhzkT83Ed7iyWW7n0y6bUnJj67KxpK36YZSgwuoWqvvTe1bQxFjQbRvQ27whf8A9Q==
X-Received: by 2002:aa7:d782:0:b0:51d:b963:4bd3 with SMTP id
 s2-20020aa7d782000000b0051db9634bd3mr911059edq.31.1687939814723; 
 Wed, 28 Jun 2023 01:10:14 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 w25-20020aa7cb59000000b0051bc7483bc7sm4574816edt.78.2023.06.28.01.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 01:10:13 -0700 (PDT)
Date: Wed, 28 Jun 2023 10:10:12 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v5 11/19] target/riscv/cpu: add misa_ext_info_arr[]
Message-ID: <20230628-d58458b465a317028b742501@orel>
References: <20230627163203.49422-1-dbarboza@ventanamicro.com>
 <20230627163203.49422-12-dbarboza@ventanamicro.com>
 <e217dfb9-a4c2-12e3-6053-ef2167f30a05@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e217dfb9-a4c2-12e3-6053-ef2167f30a05@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 27, 2023 at 11:29:54PM +0200, Philippe Mathieu-Daudé wrote:
> On 27/6/23 18:31, Daniel Henrique Barboza wrote:
> > Next patch will add KVM specific user properties for both MISA and
> > multi-letter extensions. For MISA extensions we want to make use of what
> > is already available in misa_ext_cfgs[] to avoid code repetition.
> > 
> > misa_ext_info_arr[] array will hold name and description for each MISA
> > extension that misa_ext_cfgs[] is declaring. We'll then use this new
> > array in KVM code to avoid duplicating strings.
> > 
> > There's nothing holding us back from doing the same with multi-letter
> > extensions. For now doing just with MISA extensions is enough.
> > 
> > Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >   target/riscv/cpu.c | 60 ++++++++++++++++++++++++++--------------------
> >   target/riscv/cpu.h | 11 ++++++++-
> >   2 files changed, 44 insertions(+), 27 deletions(-)
> 
> 
> > +const MISAExtInfo misa_ext_info_arr[] = {
> > +    [RVA] = {"a", "Atomic instructions"},
> > +    [RVC] = {"c", "Compressed instructions"},
> > +    [RVD] = {"d", "Double-precision float point"},
> > +    [RVF] = {"f", "Single-precision float point"},
> > +    [RVI] = {"i", "Base integer instruction set"},
> > +    [RVE] = {"e", "Base integer instruction set (embedded)"},
> > +    [RVM] = {"m", "Integer multiplication and division"},
> > +    [RVS] = {"s", "Supervisor-level instructions"},
> > +    [RVU] = {"u", "User-level instructions"},
> > +    [RVH] = {"h", "Hypervisor"},
> > +    [RVJ] = {"x-j", "Dynamic translated languages"},
> > +    [RVV] = {"v", "Vector operations"},
> > +    [RVG] = {"g", "General purpose (IMAFD_Zicsr_Zifencei)"},
> > +};
> 
> Personally I prefer using a getter() helper because we can check in
> a single place for empty entries in the array.
> 
> IIUC this 13-entries array takes 4MiB (RVV is '1<<21' = 2MiB).

Oh, ouch. I never looked close enough to see that these indices
where the _shifted_ bitnums. I assumed they were _the_ bitnums,
i.e. RVV == 21, not RVV == 2097152!

Thanks,
drew

