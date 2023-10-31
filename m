Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3497DD09C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:34:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqlF-0007QM-CZ; Tue, 31 Oct 2023 11:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxqlB-0007LL-8b
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:34:29 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxql9-0002h1-It
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:34:29 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-542d654d03cso5324794a12.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698766466; x=1699371266; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Goj02DNrzENFL0v686l2fh2JrTgLtudAvkEQEA3uq0=;
 b=XbunQKm2uxRNqE1mdZ1NTYtvfWvUeySsRP/mrbj/G0yT8BLxqJ7HRyOLJ5RpCYXPjW
 bmcEOSymDis6B5CkY9m8pp9/8gzL/ws55m8w8nRJWl9161XCOqBF+a3Lr8OKMi/SDJqv
 KB6jOfDs3MLggTZF6XsnorLf7ztUxJEBT+U2cI+A9kmCNsCogiOgTUIOYLQ1OUh3UuO0
 Wrn1KXUfOpszkGH1e5PMRdWEkwROGF67DfDAcYv4APdlf/EoKlRINKje5KgVGERBWZce
 PmTr8EkLkNoN00LEw5DxpbKiLrAiQEWIpXl9nMk+0nsT5PapifCyg9/Ued2vyuTEHv6g
 TZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698766466; x=1699371266;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Goj02DNrzENFL0v686l2fh2JrTgLtudAvkEQEA3uq0=;
 b=ppkvdzAIyOdaTan0RAvC3kslxyV6GkGa0DiC5X19piJ+OA+Bb+oU3kwZtEtxtS3iGm
 sw07bhFkNtncB5hEs3GLLV/0nC8yrX0fq51MsPHAx8BHPlQMuwQESK3lS1Xf6q5W7bwk
 /a0yYFddirv3TT1o00nVJbj7LLYOSfaLcv6I9/8tT7GTzdfptjlCS9rfmtu6/9SRehYK
 cbC6H6sQnlcWxbCdv6z9xPF7PC4aJmh2ZBM6UKGG4RUT5dJZ8dgAQoovtXUWqUJMT/bf
 dwvhoM3OfT88928W74HynBomTl/BgxS5E5H9Ou0DAJU9lQTmYWxZQ/CHhKXCe66HOc9/
 og2A==
X-Gm-Message-State: AOJu0YwhAbYZbNPe+yFRDC6KOhF+E2fSRlcEH+Go7jNCIdT1wnGim2AJ
 SvpmwX4DFbK1fGpjQvD66k5zjC7gbyVzDKcONT2tNw==
X-Google-Smtp-Source: AGHT+IFUeGOl2l28Wbdt3iCEw3K4Aj2abb0BVxLhpAN2XhAqHAxoM6/VdkeLGe0lJNE9aCb9YQjD2+arZMQ+agNqagM=
X-Received: by 2002:a50:9f21:0:b0:543:5b61:6908 with SMTP id
 b30-20020a509f21000000b005435b616908mr2950323edf.18.1698766466088; Tue, 31
 Oct 2023 08:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231027100441.375223-1-thuth@redhat.com>
 <20231027100441.375223-2-thuth@redhat.com>
In-Reply-To: <20231027100441.375223-2-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2023 15:34:14 +0000
Message-ID: <CAFEAcA8NjMw2qPUeEs4U5zfdxq4H=Lb8-iW6QKohO76eZDUHjA@mail.gmail.com>
Subject: Re: [risu PATCH 1/2] risugen: allow instructions with length > 32 bit
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Sebastian Mitterle <smitterl@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 27 Oct 2023 at 11:05, Thomas Huth <thuth@redhat.com> wrote:
>
> RISU currently only supports instructions with a length of
> 16 bit or 32 bit, however classical CISC systems like s390x
> also have instructions that are longer than 32 bit. Thus let's
> change the generator to support longer instructions, too.
>
> This adds support for 48-bit instructions on s390x, while
> the other architectures are just minimally changed to preserve
> the current state.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  risugen                | 48 +++++++++++++++++++++++++++++-------------
>  risugen_arm.pm         |  6 +++---
>  risugen_common.pm      |  2 +-
>  risugen_loongarch64.pm |  4 ++--
>  risugen_m68k.pm        |  6 +++---
>  risugen_ppc64.pm       |  4 ++--
>  risugen_s390x.pm       | 17 +++++++++++----
>  7 files changed, 57 insertions(+), 30 deletions(-)
>
> diff --git a/risugen b/risugen
> index fa94a39..833b459 100755
> --- a/risugen
> +++ b/risugen
> @@ -105,6 +105,16 @@ sub read_tokenised_line(*)
>      return @tokens;
>  }
>
> +sub check_bitmask($$)
> +{
> +    my ($fixedbits, $fixedbitmask) = @_;
> +
> +    if ((($fixedbits & $fixedbitmask) != $fixedbits)
> +        || (($fixedbits & ~$fixedbitmask) != 0)) {
> +        die "internal error: fixed bits not lined up with mask";
> +    }
> +}
> +
>  sub parse_config_file($)
>  {
>      # Read in the config file defining the instructions we can generate
> @@ -160,10 +170,11 @@ sub parse_config_file($)
>              exit(1);
>          }
>
> -        my $fixedbits = 0;
> -        my $fixedbitmask = 0;
> +        my @fixedbits = (0, 0, 0, 0);
> +        my @fixedbitmask = (0, 0, 0, 0);

I wonder if rather than turning these into arrays of integers, we
should use Perl bit vectors (see 'perldoc -f vec'). You can use those
to create arbitrary length bit-strings, and they directly support
the usual bitwise logical operators.

It's probably a bit of a bigger conversion job, though (and I
haven't needed to use them before, so there might be awkwardnesses
I haven't anticipated).

>          my $bitpos = 32;
> -        my $insnwidth = 32;
> +        my $wordpos = 0;
> +        my $insnwidth = 0;
>          my $seenblock = 0;
>
>          while (@bits) {
> @@ -217,36 +228,43 @@ sub parse_config_file($)
>
>              my $bitmask = oct("0b". '1' x $bitlen);
>              $bitpos -= $bitlen;
> +            $insnwidth += $bitlen;
>              if ($bitpos < 0) {
>                  print STDERR "$file:$.: ($insn $enc) too many bits specified\n";
>                  exit(1);
>              }
>
>              if (defined $bitval) {
> -                $fixedbits |= ($bitval << $bitpos);
> -                $fixedbitmask |= ($bitmask << $bitpos);
> +                $fixedbits[$wordpos] |= ($bitval << $bitpos);
> +                $fixedbitmask[$wordpos] |= ($bitmask << $bitpos);
>              } else {
> -                push @fields, [ $var, $bitpos, $bitmask ];
> +                push @fields, [ $var, $bitpos, $bitmask, $wordpos ];
> +            }
> +
> +            if ($bitpos == 0) {
> +                check_bitmask($fixedbits[$wordpos], $fixedbitmask[$wordpos]);
> +
> +                $wordpos += 1;
> +                if (@bits) {
> +                    $bitpos = 32;
> +                }
>              }
>          }
>          if ($bitpos == 16) {
>              # assume this is a half-width thumb instruction
>              # Note that we don't fiddle with the bitmasks or positions,
>              # which means the generated insn will be in the high halfword!

I suspect the process of conversion to bit-vectors will probably
imply fixing this bit of ugliness en route, incidentally.

> -            $insnwidth = 16;
> -        } elsif ($bitpos != 0) {
> -            print STDERR "$file:$.: ($insn $enc) not enough bits specified\n";
> +            check_bitmask($fixedbits[$wordpos], $fixedbitmask[$wordpos]);
> +        } elsif ($bitpos != 0 && $bitpos != 32) {
> +            print STDERR "$file:$.: ($insn $enc) not enough bits specified ($bitpos)\n";
>              exit(1);
>          }

thanks
-- PMM

