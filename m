Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9C580EC46
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:42:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD24Z-0007ph-Pn; Tue, 12 Dec 2023 07:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD23e-0007da-B6
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:40:25 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD23X-0002Y8-0r
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:40:13 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c9f572c4c5so84345281fa.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702384803; x=1702989603; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ds2y+bjFnmF3EXS0GyYyPLpE4Iv3Ytyv+qXrpUPiEN8=;
 b=NgAK3lPWXYnhttw038HJUbyKbndSstd3tphKYnQfksFfzKstLk35QLcfOTLJ7fce8u
 HV6JZ//JtyB+6bohnkNDE/dFqrd/DDwfXC+INPZS8ca7sYNvxfNtOT1lFlkVACuTf8wx
 ABL+yMpUIvLMjZuh1T6OiVGW4aP1Ju4DTRYn29FXHhmQOdNgckiuQ5t9vUYhGdnGwMHf
 Mrth3sUfg1azVjqPH1rqdbyShsXILiyF1Blo3iVr4OzZ6XPirYGo5j68oNFIKsx/4HGX
 9+m6uz4sBrTu78FcmAQaxXLXE6gZ9s4Ralz0C7mntTpMN+mutZ5NJWX49w+P2feT2s4L
 rJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384803; x=1702989603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ds2y+bjFnmF3EXS0GyYyPLpE4Iv3Ytyv+qXrpUPiEN8=;
 b=Q9WJ9L8DFDX0X+Jb5uoz3ZnjWgXkOZVrDPN8Sl7I/pvUBW4WfTcJk01pakujJg0djd
 CGijmJybMZ1/B0qCbuJxu/0+JqoWiE+AUNqWOV605pDgQD7TaGecDdU/RYynXanzvLM4
 VOIqaq9GUi3zmffqh6u5WVNyhgLPaPRCJAwegZtyyhb7/5zWNdQ8FTuKFctGPaBo4B1x
 0Dmzh6MEfyeW17fU8izJhFiarWsYdEYMcp5RVFa8szPdlBXIiBRyk++AzryttpxBKNxz
 KV5Y7q77/W9xRbSEAtdDwl4mW+LT2Mzt96hno+2BLJX+0n0eA7OqOPmWvfX05a0JTQB7
 N5vQ==
X-Gm-Message-State: AOJu0YyEsasqsFn+efdSu5f66GqL0mNHtO8ysxrax+9+PVMi1DZgMDV4
 eMQi3HrZFq6eNc7zoLgCQEmr0jGisnmL5ffkD5J+eg==
X-Google-Smtp-Source: AGHT+IF1XT0atvdFVTYUX5lVRMmzV9R2NJThKyEGxX1bHQ8HJhg1408V/25QYGwQs4In3PTZsKC1aGDdX/vDJZ6cukc=
X-Received: by 2002:a05:651c:88b:b0:2cc:1c86:542b with SMTP id
 d11-20020a05651c088b00b002cc1c86542bmr3511282ljq.38.1702384803525; Tue, 12
 Dec 2023 04:40:03 -0800 (PST)
MIME-Version: 1.0
References: <20231025092915.902814-1-gaosong@loongson.cn>
 <20231025092915.902814-6-gaosong@loongson.cn>
In-Reply-To: <20231025092915.902814-6-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2023 12:39:51 +0000
Message-ID: <CAFEAcA8c27SyPOt80zakmAX9tXnyQoxGaA+VDm5j56Z3uOimKA@mail.gmail.com>
Subject: Re: [risu PATCH 5/5] loongarch: Add block 'clean' and
 clean_lsx_result()
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org, 
 alex.bennee@linaro.org, maobibo@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

On Wed, 25 Oct 2023 at 10:29, Song Gao <gaosong@loongson.cn> wrote:
>
> The result of the LSX instruction is in the low 128 bits
> of the vreg register. We use clean_lsx_result() to clean up
> the high 128 bits of the vreg register.
>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>  loongarch64.risu       | 2121 ++++++++++++++++++++++++++--------------
>  risugen                |    2 +-
>  risugen_loongarch64.pm |   20 +
>  3 files changed, 1405 insertions(+), 738 deletions(-)
>
> diff --git a/loongarch64.risu b/loongarch64.risu
> index 596de90..531470d 100644
> --- a/loongarch64.risu
> +++ b/loongarch64.risu
> @@ -64,26 +64,26 @@ mulw_d_wu LA64 0000 00000001 11111 rk:5 rj:5 rd:5 \
>  #div.{w[u]/d[u]} rd,rj,rk
>  # div.w{u}, mod.w[u]  rk, rj, need in [0x0 ~0x7FFFFFFF]
>  # use function set_reg_w($reg)
> -div_w LA64 0000 00000010 00000 rk:5 rj:5 rd:5 \
> -    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
> -    !memory { set_reg_w($rj); set_reg_w($rk); }
> -div_wu LA64 0000 00000010 00010 rk:5 rj:5 rd:5 \
> -    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
> -    !memory { set_reg_w($rj); set_reg_w($rk); }
> -div_d LA64 0000 00000010 00100 rk:5 rj:5 rd:5 \
> -    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
> -div_du LA64 0000 00000010 00110 rk:5 rj:5 rd:5 \
> -    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
> -mod_w LA64 0000 00000010 00001 rk:5 rj:5 rd:5 \
> -    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
> -    !memory { set_reg_w($rj); set_reg_w($rk); }
> -mod_wu LA64 0000 00000010 00011 rk:5 rj:5 rd:5 \
> -    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
> -    !memory { set_reg_w($rj); set_reg_w($rk); }
> -mod_d LA64 0000 00000010 00101 rk:5 rj:5 rd:5 \
> -    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
> -mod_du LA64 0000 00000010 00111 rk:5 rj:5 rd:5 \
> -    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
> +#div_w LA64 0000 00000010 00000 rk:5 rj:5 rd:5 \
> +#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
> +#    !memory { set_reg_w($rj); set_reg_w($rk); }
> +#div_wu LA64 0000 00000010 00010 rk:5 rj:5 rd:5 \
> +#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
> +#    !memory { set_reg_w($rj); set_reg_w($rk); }
> +#div_d LA64 0000 00000010 00100 rk:5 rj:5 rd:5 \
> +#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
> +#div_du LA64 0000 00000010 00110 rk:5 rj:5 rd:5 \
> +#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
> +#mod_w LA64 0000 00000010 00001 rk:5 rj:5 rd:5 \
> +#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
> +#    !memory { set_reg_w($rj); set_reg_w($rk); }
> +#mod_wu LA64 0000 00000010 00011 rk:5 rj:5 rd:5 \
> +#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; } \
> +#    !memory { set_reg_w($rj); set_reg_w($rk); }
> +#mod_d LA64 0000 00000010 00101 rk:5 rj:5 rd:5 \
> +#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
> +#mod_du LA64 0000 00000010 00111 rk:5 rj:5 rd:5 \
> +#    !constraints { $rk != 2 && $rj != 2 && $rd != 2; }

Why do we comment out all these patterns ? The commit
message doesn't say anything about this.

>
>  alsl_w LA64 0000 00000000 010 sa2:2 rk:5 rj:5 rd:5 \
>      !constraints { $rk != 2 && $rj != 2 && $rd != 2; }
> @@ -615,665 +615,1248 @@ fstx_d LA64 0011 10000011 11000 rk:5 rj:5 fd:5 \
>  # LSX instructions
>  #
>
> -vadd_b LSX 0111 00000000 10100 vk:5 vj:5 vd:5
> -vadd_h LSX 0111 00000000 10101 vk:5 vj:5 vd:5

> +vadd_b LSX 0111 00000000 10100 vk:5 vj:5 vd:5 \
> +    !clean { clean_lsx_result($vd); }
> +vadd_h LSX 0111 00000000 10101 vk:5 vj:5 vd:5 \
> +    !clean { clean_lsx_result($vd); }

If there are patterns that need the clean_lsx_result
handling, then add the support for that first, rather
than adding a broken pattern and then editing it to
add the extra block to every pattern, please.

> diff --git a/risugen b/risugen
> index fa94a39..8a67fdf 100755
> --- a/risugen
> +++ b/risugen
> @@ -43,7 +43,7 @@ my @pattern_re = ();            # include pattern
>  my @not_pattern_re = ();        # exclude pattern
>
>  # Valid block names (keys in blocks hash)
> -my %valid_blockname = ( constraints => 1, memory => 1, safefloat =>1 );
> +my %valid_blockname = ( constraints => 1, memory => 1, safefloat =>1, clean => 1 );
>
>  sub parse_risu_directive($$@)
>  {
> diff --git a/risugen_loongarch64.pm b/risugen_loongarch64.pm
> index b3f901d..97f00f3 100644
> --- a/risugen_loongarch64.pm
> +++ b/risugen_loongarch64.pm
> @@ -81,6 +81,18 @@ sub nanbox_s($)
>      return $fpreg;
>  }
>
> +sub clean_lsx_result($)
> +{
> +    my ($vreg) = @_;
> +
> +    # xvinsgr2vr.d vd, r0, 2;
> +    insn32(0x76ebe000 | 2 << 10 | $vreg);
> +    # xvinsgr2vr.d vd, r0, 3;
> +    insn32(0x76ebe000 | 3 << 10 | $vreg);
> +
> +    return $vreg;
> +}
> +
>  sub align($)
>  {
>      my ($a) = @_;
> @@ -405,6 +417,7 @@ sub gen_one_insn($$)
>          my $constraint = $rec->{blocks}{"constraints"};
>          my $memblock = $rec->{blocks}{"memory"};
>          my $safefloat = $rec->{blocks}{"safefloat"};
> +        my $clean = $rec->{blocks}{"clean"};
>
>          $insn &= ~$fixedbitmask;
>          $insn |= $fixedbits;
> @@ -448,6 +461,13 @@ sub gen_one_insn($$)
>              $resultreg = eval_with_fields($insnname, $insn, $rec, "safefloat", $safefloat);
>          }
>
> +        if (defined $clean) {
> +            # LSX insns only care about low 128 bit,
> +            # so we use clean_lsx_result() make sure that high 128bit is 0x0;
> +            my $cleanreg;
> +            $cleanreg = eval_with_fields($insnname, $insn, $rec, "clean", $clean);
> +        }
> +
>          if (defined $memblock) {
>              # Clean up following a memory access instruction:
>              # we need to turn the (possibly written-back) basereg
> --

The handling here is exactly identical to the existing "safefloat"
block, and 'safefloat' does nothing floating point specific and
the new 'clean' block does nothing LSX specific. I think we would
do better to have a single block type for "do anything you need to
do to clean up after the insn", and use it for both the patterns
that need to tidy up a float register and those that need to do
this new LSX related tidying.

Open to suggestions for better naming, but my suggestion is that
we call this block type "!post" (because it is the hook for
doing things after emitting the instruction). In future if
we ever needed it we could add a "!pre".

That is:
 * rename "!safefloat" to "!post"
 * add the clean_lsx_result() function before adding the LSX
   etc patterns, so we don't need to add the patterns and then
   change them later to add a "!post" block

thanks
-- PMM

