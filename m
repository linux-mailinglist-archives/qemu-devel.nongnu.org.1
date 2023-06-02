Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1D472025B
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 14:46:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q54A2-00044H-9w; Fri, 02 Jun 2023 08:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1q549z-000440-PU
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:45:39 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1q549r-0003fk-Px
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:45:38 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-974f4897d87so49788966b.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 05:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685709917; x=1688301917; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E+6nITjxiVNKLSxS9tyRtumsyHtwglAlx1FkH21FSNE=;
 b=SrJndCoCvndo1LLDWvUw4trofuI7rWxp1mUknEm/PJKj+ULP2InDogqGqs8NOwegm7
 kc1Uii1OOWijMTj8uM4ZaHX/pH8VsfTa3K7NCOA0E3tVYheor0aylUyeQhuFbpKjAzS/
 zIRSUOO76czRuQq8s6w0eEFNCVEVYA9jryBUnD21tUOjbEHY/1WBCsXNG1RuC4WSHAw+
 DQxulTXY3OJAJtJo1P6WfjBXEH9Z3r4REsEfx9SPL9LW3RPitISry5pWLfYbRobKzUFF
 DPSVWoZ4KsrwMg7RbzGyJMk6TLHfPOUo4k/81bowCSA3weDs6Lt3sJkFi0yXGogRNxU7
 6UFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685709917; x=1688301917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E+6nITjxiVNKLSxS9tyRtumsyHtwglAlx1FkH21FSNE=;
 b=Zea3KnUgXID37TCAdzyN67vTRd/VtX6vkWAGLyqeCEIRA59MO3mfBzPWgYwU0YDg1l
 L1FnVFduJ4123e6rRzpi6RNkdx2rcaC1dStAjoodrkBEgjehFv5+4AOhNJS607ftF+9A
 8YQYrHL6PUsWrOBEpUXLVV0pabXyB8grOSbm4KwTF9ZcdpVjRHde8b5NX3PELci/fCoC
 kE2Bp6T38xsnNjmRNyzIbAMqgnO+K+SmRZpRPboiiDsae7I8tE+6kGrxt2vzoxcCFTra
 HYbUQ4rbHw4jRkouWGjTklF2LPjWvvCTLnnMmZ9j7PvMktGr12x+incwH3jXNzHxz/MH
 WvNA==
X-Gm-Message-State: AC+VfDy3k92XwAaaNsMq/Hn+gK9cngdpKFnh08YmQ5QJMeS9/j2/sWiY
 MdLuWNS1ogi10N3XAdpXQqJSYtDvUBCqGR94k0rWcZ2v/afxcxOWa9s=
X-Google-Smtp-Source: ACHHUZ6DNV4/uzZushl3sxOtbz4wbg/7xUE6fVKRIqLhnkiPLm8ZXXZn5DImPK5aQJDVZMH/5cSwCu6+D5s3RMPqVEU=
X-Received: by 2002:a17:907:6e0d:b0:94e:afa6:299f with SMTP id
 sd13-20020a1709076e0d00b0094eafa6299fmr10811513ejc.22.1685709917097; Fri, 02
 Jun 2023 05:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230602121638.36342-1-rbradford@rivosinc.com>
 <20230602121638.36342-3-rbradford@rivosinc.com>
In-Reply-To: <20230602121638.36342-3-rbradford@rivosinc.com>
From: Rob Bradford <rbradford@rivosinc.com>
Date: Fri, 2 Jun 2023 13:44:41 +0100
Message-ID: <CABPZdxv+gj3MWfoaQ5Dv-7tJj66-pg3yT2bZHpwuEAaepEizig@mail.gmail.com>
Subject: Re: [PATCH 2/2] disas/riscv: Add support for amocas.{w, d,
 q} instructions
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=rbradford@rivosinc.com; helo=mail-ej1-x629.google.com
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

On Fri, 2 Jun 2023 at 13:17, Rob Bradford <rbradford@rivosinc.com> wrote:

>  /* structures */
> @@ -2123,6 +2126,9 @@ const rv_opcode_data opcode_data[] = {
>      { "cm.jalt", rv_codec_zcmt_jt, rv_fmt_zcmt_index, NULL, 0 },
>      { "czero.eqz", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
>      { "czero.nez", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
> +    { "amoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "amoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "amoswap.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
>  };

There is a copy & paste error here. s/amoswap/amocas/.

My local version is fixed already.

Cheers,

Rob

