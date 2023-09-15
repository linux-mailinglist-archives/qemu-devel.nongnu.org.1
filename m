Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 074317A14C1
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 06:21:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh0JK-0006Pb-FR; Fri, 15 Sep 2023 00:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qh0JI-0006P3-03; Fri, 15 Sep 2023 00:20:04 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qh0JG-0003x1-5z; Fri, 15 Sep 2023 00:20:03 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-273527a8fdeso1391382a91.2; 
 Thu, 14 Sep 2023 21:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694751600; x=1695356400; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/vF/auRmwtqaYptNIKpo6xzEVDQm+M6qdjqAb3x/GE=;
 b=FdZLsRaQtj0hbU43ySjNQp5klqK3VCkNfXd+QuiLNI2mxpiEI6+ZXCjG2plpfjN+Ar
 zUXGxIlWAA4VW/Cc4utwG67XGdIX/kkHIy5lHsmfzqYJPMqaguZCyLj0yjRjfiWrpZc3
 t8JttkjVrnIUJPyWbQRFbCBOROyX5AWaacBdIczJj7L3y4NzgJZI0qoDGMGnf6zFHB78
 fanwqzIuaYnN4fkXmJ2wORWDbxhMHolbcYj+RS+blopKQai8cPhR4OnhcZUHaBg8yGHR
 sZHgwbrfngixF2dmCiWzMlQOS7LlUnY8S7VTAO75WiAtFcA39ybgcbU0At0cH70m0qcV
 lOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694751600; x=1695356400;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/vF/auRmwtqaYptNIKpo6xzEVDQm+M6qdjqAb3x/GE=;
 b=t+aHPX5Uk6p7Z6nSdn/xe5EFGh3Gi1kswrq1b9xU5Y2Z0oZgDTQiFlJsABEnON0xd8
 CZ4AyDhISh42cmnaFEXtTxoWEJakXkE1qShj7jXa+fRpXo8IJuqv1dvgqTaOhJdQOPKp
 yiGYKrvYVxqQIDOZGMOiUuO3NC3W1lFWJgw0a73VFZPGBR7N+GWp5/6RNtlNUIT2rBQz
 Xn6ou+T56931IbdCa3fcUvWpPBwWifY9lh0/ojhWuLQMpif5yB4I9WVkO6MKJsSs/rk0
 keu80wz+71L5mhOHRTawAe5RR6rAFHa3vGarQn0rGNknPr5gjOor6e3FpQbpCmRNKgvS
 GXBw==
X-Gm-Message-State: AOJu0Yz2Z1NgCrAMk018F+S9LXrmPcKl0Soj9AH/8lLYRNfvUGAiF6ZB
 39LEdh++6KQQ3mArTQDbLgpdjLovBauDLk0Ngfw=
X-Google-Smtp-Source: AGHT+IEN8HVTtGUJsK1x91PrGrAa1ICPxxlW//3henrKhGL9/++hb5NCFegiNjHcbfJ6OdP41utWw23WLiFEJY1V9U4=
X-Received: by 2002:a17:90a:cb0e:b0:274:748c:9c55 with SMTP id
 z14-20020a17090acb0e00b00274748c9c55mr416669pjt.20.1694751599632; Thu, 14 Sep
 2023 21:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230815195741.8325-1-richard.henderson@linaro.org>
 <20230815195741.8325-15-richard.henderson@linaro.org>
In-Reply-To: <20230815195741.8325-15-richard.henderson@linaro.org>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Fri, 15 Sep 2023 14:19:48 +1000
Message-ID: <CACzsE9qPn5gMNLmRhYb_OhvOw7-bFOkQyD+08VzFogsVJKSNkg@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] RFC tcg/ppc: Disable TCG_REG_TB for
 Power9/Power10
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=jniethe5@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Aug 16, 2023 at 5:57=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This may or may not improve performance.
> It appears to result in slightly larger code,
> but perhaps not enough to matter.

I have collected some power9 macro performance data for an smp compile work=
load:

Setup
-----

- Power9 powernv host
- mttcg smp 8 guest

Method
------

- Warm up compile skiboot (https://github.com/open-power/skiboot)
- Average time taken for 5 trials compiling skiboot with -j `nproc`

Results
-------


|                Patch                | Mean time (s) | stdev | Decrease (%=
) |
|-------------------------------------|---------------|-------|------------=
--|
| tcg: Add tcg_out_tb_start...        |        161.77 |  2.39 |            =
- |
| tcg/ppc: Enable direct branching... |        145.81 |  1.71 |          9.=
9 |
| tcg/ppc: Use ADDPCIS...             |        146.44 |  1.28 |          9.=
5 |
| RFC tcg/ppc: Disable TCG_REG_TB...  |        145.95 |  1.07 |          9.=
7 |


- Enabling direct branching is a performance gain, beyond that less conclus=
ive.
- Using pcaddis for direct branching seems slightly better than bl +4
sequence for ISA v3.0.
- PC relative addressing seems slightly better than TOC relative addressing=
.

Any other suggestions for performance comparison?
I still have to try on a Power10.

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/ppc/tcg-target.c.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 20aaa90af2..c1e0efb498 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -83,7 +83,7 @@
>  #define TCG_VEC_TMP2    TCG_REG_V1
>
>  #define TCG_REG_TB     TCG_REG_R31
> -#define USE_REG_TB     (TCG_TARGET_REG_BITS =3D=3D 64)
> +#define USE_REG_TB     (TCG_TARGET_REG_BITS =3D=3D 64 && !have_isa_3_00)
>
>  /* Shorthand for size of a pointer.  Avoid promotion to unsigned.  */
>  #define SZP  ((int)sizeof(void *))
> --
> 2.34.1
>

