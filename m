Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93345810ACC
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 08:02:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDJFa-0006cf-IO; Wed, 13 Dec 2023 02:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rDJFX-0006bt-J0
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 02:01:43 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rDJFV-0007pg-RU
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 02:01:43 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5c21e185df5so5571305a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 23:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1702450898; x=1703055698; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ZY+cxXOIdcMkNM2EwN8xLlAGBkPxKBX2VXeH5g07Hk=;
 b=gv87linZEt5fjZ3FLpCmU4jqXcA48nTR0P7xuU3J3iH5jmm4I0cnHzPr2L5LS8HfPt
 Bi1UaV5TnETqJtOapnl0XYqXfTDKFglnglThsjuGGSdJ8ECuTwZAHmOS9DggXKIQ7i6j
 +9wu/eAvf3itd45I67U7Xbz2zAYY8vwyUexLCoSwi8PtCEjIiBvgQESpyQ/rdoY58YUl
 esydQo73Qm3G6hSbdtQ3xoByAE/s8SnR1JQFn0Jd+wRz7ifV8FuETY/9yvSakBz4vtEK
 GXJKRjxxaidDVXQiqtB1i9hsQd/Jwdr4OnY9STVgHxUgnlbqyn2XlBxh/z5ESxId0DQ6
 osTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702450898; x=1703055698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ZY+cxXOIdcMkNM2EwN8xLlAGBkPxKBX2VXeH5g07Hk=;
 b=GAW9MiSYQUaQ2j7/mrcZh9WwiDnwAbNadUNs1kCbCDJIpvcg2731fKgPrjRVwQYI0r
 bC0TLxuVPqkrrEX/PXCVFqclxi2ctt6/HDG8ut/ooabICwCx5Lefq5B7XTb5zklnVnSw
 c12WYKRnc93NgmPhIonYeZloOgoRtE4W2i9jfxU/76KPEVH7LFXDZXGGaUyUaCYaMvcA
 U1EajNXWN3fTkpNiKXLKeGmb7G5Qpoijdk2IBjowg77O4sRWmbpKK0lYec0zDG6xh/8m
 myU4zjhiKTphi30yWwdg715cqkXdyBwR6qBO43INYSeoYizTVAdDGxjvBPJIokMoOTvW
 DEkw==
X-Gm-Message-State: AOJu0YyacedfOPoNaWfKYJlnMc96ELTTxzvtfGDb9zN/w9rVB3/udN3v
 WarTm+gk8XTjI/ddoNeNxFeBgznDjwPYVWm6fbqlwA==
X-Google-Smtp-Source: AGHT+IHG/f1Bls9uanaI+Bw79CQHLmOOSWYjuKlN7903DWvgd4DId+XpndTVB3m0XjCW5Ui0a0u2DAs9kq1Dnu1tqFA=
X-Received: by 2002:a05:6a20:8e13:b0:18f:f57a:e761 with SMTP id
 y19-20020a056a208e1300b0018ff57ae761mr10375320pzj.63.1702450898487; Tue, 12
 Dec 2023 23:01:38 -0800 (PST)
MIME-Version: 1.0
References: <20231208094315.177-1-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20231208094315.177-1-zhiwei_liu@linux.alibaba.com>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Wed, 13 Dec 2023 08:00:00 +0100
Message-ID: <CAEg0e7j-+=S__67puJh2KqTkqZeQAShSo4fZAwDN=SLNa8iSHw@mail.gmail.com>
Subject: Re: [PATCH for 8.2] target/riscv: Fix th.dcache.cval1 priviledge check
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 alistair.francis@wdc.com, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-pg1-x533.google.com
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

On Fri, Dec 8, 2023 at 10:44=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> According to the specification, the th.dcache.cvall1 can be executed
> under all priviledges.
> The specification about xtheadcmo located in,
> https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadcmo=
/dcache_cval1.adoc
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Christoph Muellner <christoph.muellner@vrull.eu>

> ---
>  target/riscv/insn_trans/trans_xthead.c.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/in=
sn_trans/trans_xthead.c.inc
> index 810d76665a..dbb6411239 100644
> --- a/target/riscv/insn_trans/trans_xthead.c.inc
> +++ b/target/riscv/insn_trans/trans_xthead.c.inc
> @@ -296,7 +296,7 @@ NOP_PRIVCHECK(th_dcache_csw, REQUIRE_XTHEADCMO, REQUI=
RE_PRIV_MS)
>  NOP_PRIVCHECK(th_dcache_cisw, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
>  NOP_PRIVCHECK(th_dcache_isw, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
>  NOP_PRIVCHECK(th_dcache_cpal1, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
> -NOP_PRIVCHECK(th_dcache_cval1, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
> +NOP_PRIVCHECK(th_dcache_cval1, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MSU)
>
>  NOP_PRIVCHECK(th_icache_iall, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
>  NOP_PRIVCHECK(th_icache_ialls, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
> --
> 2.17.1
>

