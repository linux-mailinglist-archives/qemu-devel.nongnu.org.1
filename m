Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C009824C4F
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 02:04:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLYbs-0005bF-6F; Thu, 04 Jan 2024 20:02:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1rLYbo-0005az-IR
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 20:02:48 -0500
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1rLYbm-0006o4-Pz
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 20:02:48 -0500
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7bbf9437261so38322839f.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 17:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704416564; x=1705021364;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rrSjvBY4BTiZpSmOgXlqhETXs16bn4oQNqSgm8JL0+w=;
 b=cHLFdTyXtpdjsdbpkgJRIihGddZXmgH0QxuIzjeMZLKq3LzmLp8pZ341htzcbwQaTm
 5znuKUq7ErGYKmlRdZ3sULJrWUIlQDzaJHelfryWX3I0XORWbrYhBi9MRQ7gnvN3ymSR
 pwn1NB8oSJVrCFz3+ETwlEXu5ArbbnIB9sYNOmkVNgF9lhJ3j/7RJMexGZZXmyncZbPI
 XCUWG5kk4lkldaHr6Jvo2aKOGDHobVkLAJH/vz/Ai+u05tRTKTMCBog3k5If5Gv6UnH1
 YAqnp+8vlp4tHuh624g10eCQvxFq4Xc+oCBmEkpe6IKVrVFumytspJYSFcrUCzYA/DlR
 TbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704416564; x=1705021364;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rrSjvBY4BTiZpSmOgXlqhETXs16bn4oQNqSgm8JL0+w=;
 b=KXgd8BYDf8Ouijvs0D+Lp0zfuQHV9QUehn9gt6d/VFbgPHW/cLi68sfXaoXe4EkoEB
 Px21sNbx1dsNOL+mzVZEl/x9BOjiV7fqQeL7l5RT8+OGNbAgVH+f49qdyMcHlb/geou9
 sd9ua0REapJD7kO2j1Z4pmWRvtHx7VY5HuSf9Y+wLEE777C5lgxwtpoDGmMLyw5mgqN/
 v2bNdx6rGowsnGcsEAwzBBosDsjv4uaMBeBjRTz/hjv8bdhCgdkNMi4uU2+h1s+Lr7xg
 ksuUshZGBh1KoQ4uI+HOvINjmQh0v98oVIqqhJ+1Iq5wOmdfRE0hCqvi05IzMxet+Fr1
 UHmw==
X-Gm-Message-State: AOJu0Yz+RWImZpriU41uxkCYS9GDh7GN/Ns6ZT4Vhm2KtB+HwJqTsg6n
 I5gYCrPS94pXDToXAgC6c98TT7rRJ+IZ0sUnF7q378FVN7N8cA==
X-Google-Smtp-Source: AGHT+IGOcLgchRIm9nRG6vbO/NBaVpJvcdc3/O5fV8zlTKsmtpHSy4X7hxGJeEP4ExI7THKANHPaGh6BlViuc6Wynpo=
X-Received: by 2002:a6b:f111:0:b0:7b7:5eeb:615e with SMTP id
 e17-20020a6bf111000000b007b75eeb615emr1651884iog.6.1704416564587; Thu, 04 Jan
 2024 17:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20240103185716.1790546-1-me@deliversmonkey.space>
 <20240103185716.1790546-6-me@deliversmonkey.space>
In-Reply-To: <20240103185716.1790546-6-me@deliversmonkey.space>
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 4 Jan 2024 17:02:33 -0800
Message-ID: <CAKC1njSMAWV_tPru_E04GfhstfPK3gjeF1PuBtx+VaQqws6uVA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] target/riscv: Update address modify functions to
 take into account pointer masking
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=debug@rivosinc.com; helo=mail-io1-xd2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -94,6 +94,18 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
>
>  static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
>  {
> +    RISCVPmPmm pmm = riscv_pm_get_pmm(env);
> +    if (pmm == PMM_FIELD_DISABLED)
> +        return addr;
> +    int pmlen = riscv_pm_get_pmlen(pmm);
> +    bool signext = !riscv_cpu_bare_mode(env);
> +    addr = addr << pmlen;
> +    /* sign/zero extend masked address by N-1 bit */
> +    if (signext) {
> +        addr = (target_long)addr >> pmlen;

These look like right shift operations and not sign extensions of N-1 bit

> +    } else {
> +        addr = addr >> pmlen;

Same here.

> +    }
>      return addr;
>  }
>
> --
> 2.34.1
>
>

