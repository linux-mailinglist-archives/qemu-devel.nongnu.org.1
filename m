Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3337438CA
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 11:58:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFAt5-000219-Do; Fri, 30 Jun 2023 05:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1qFAt3-0001z3-5F
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:57:57 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1qFAt1-0005Ld-Ih
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:57:56 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-313f1085ac2so1834972f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 02:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1688119073; x=1690711073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L4uwiSUewUua+vEPVN9aG5KA5Tln3IEYv5TjqCBdMZM=;
 b=dMCMzqpB1XfZy2/d8huk8ww+9bNliro+5ZvvZ0CX4GGpmEpeJO2qta7lnlq1y7FwJD
 +wHnptCmd/O0B3r3UY+kpJBuDGDjCzMFPceaAPQRRXKnJR13F9j1ZWcspTuwWb7kkEqB
 aBK7Vj/tRTBP4eg5a9m9B2UkfUAWx1/CyG6HiEGEXSpiGKvQNG0djDRGU/EeSZwyFASK
 TJjpnsjfEu1CwObaZGOBNYBjzDEey4iZ1lcr4tBA37/qZ0Q4xYP9q6W4kKZta5f4az9L
 QRSnuaWW92h1V+YG+VcbvEfdMUZimWVMs0gR8rnPOXZsStUKbFU52j5XwG1ucpMO+U+j
 0GIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688119073; x=1690711073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L4uwiSUewUua+vEPVN9aG5KA5Tln3IEYv5TjqCBdMZM=;
 b=hs0o6Uu+E8aNytGHDh7RWSvuWcgGACn9lSZ6rEiGTM/gWzPU2xiRujmOnNddDDAjri
 D96up2R+tBy8z1vELZ6R5rQ4k1eXlJzFW/EwFANTAhLnPBkQnkrBj10n9Uxfw/l7osKD
 n/50z1m3d8OTvey/5ANgjTLQLVzweixFuwkzhMbynVMpn+CTN8ZkRR56AbVxE9jCFi6x
 R+aXDEIO8412xfqSM2oIMO2Bvq2tPoSRUjfbYOJo6HrMHfC9HW5OoH7QG4/YkMYcuH8Z
 DKuZSdYyKY+FTdkHpuloAPUyMwEftXqWyrXaNqI28OmhBpXqhUVZGN98Ea/3MTruuK1j
 Vffg==
X-Gm-Message-State: ABy/qLazG9Ezq5P/nvTM0ahErX/l4D6BteXKmUVbscaAEpTWALiA6LeG
 zWf/GeGhc2nvPONntyn0MuzNUgxcC8i42AaGDonc0Q==
X-Google-Smtp-Source: APBJJlHjCteSUtm3jnDfnmT5ydtjY7ors6AHwN3sXFZ/18urhUDNTRlVV+aUjTap2e2b6Y7oOF8O+WnbZzBNKEulDtw=
X-Received: by 2002:adf:f786:0:b0:311:180d:cf38 with SMTP id
 q6-20020adff786000000b00311180dcf38mr1810959wrp.24.1688119073536; Fri, 30 Jun
 2023 02:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230630091303.1676486-1-christoph.muellner@vrull.eu>
 <20230630091303.1676486-2-christoph.muellner@vrull.eu>
 <1c8f3c84-60ba-abd8-f1c0-2bb85ed47399@linaro.org>
In-Reply-To: <1c8f3c84-60ba-abd8-f1c0-2bb85ed47399@linaro.org>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Fri, 30 Jun 2023 11:57:40 +0200
Message-ID: <CAEg0e7gfPNGL9YCf5hEY=4+8bhW1P841mn-RGarffbQGUbS34g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] riscv: Add support for the Zfa extension
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Jeff Law <jeffreyalaw@gmail.com>, Tsukasa OI <research_trasio@irq.a4lg.com>, 
 liweiwei@iscas.ac.cn, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Rob Bradford <rbradford@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-wr1-x42a.google.com
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

On Fri, Jun 30, 2023 at 11:53=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/30/23 11:13, Christoph Muellner wrote:
> > +static bool trans_fli_h(DisasContext *ctx, arg_fli_h *a)
> > +{
> > +    REQUIRE_FPU;
> > +    REQUIRE_ZFA(ctx);
> > +    REQUIRE_ZFH(ctx);
> > +
> > +    /* Values below are NaN-boxed to avoid a gen_nanbox_h(). */
> > +    const uint64_t fli_h_table[] =3D {
>
> static const.

Sorry for missing that.

Thanks,
Christoph

>
>
> r~

