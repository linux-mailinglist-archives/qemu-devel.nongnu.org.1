Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA86E784252
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:46:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYRhW-0007JS-Gi; Tue, 22 Aug 2023 09:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qYRhP-0007JE-Ac
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:45:35 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qYRhM-0007de-Ck
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:45:35 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fed6c2a5cfso38776745e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692711930; x=1693316730;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+N1nXMaIo5F7wsU3B643xl+n6GZpjgq1xyeQA0JZac=;
 b=tnzx8x70uAfHAnDFMY/KlpJabMSut5MgQAmeRlpHAztnnjM6bDrHnisv9Xu20Utt5N
 9CrgSY06CJQL/iF66sVVCp+gI8k0yoB+FbP6iuJ1ZI7zI6He44hdwUQnL4zvo5uiSizG
 GJFlQTps3A4EZi5auNbDs69LReQGSkD6unXOD5Q7cQ2+++0AXOQQqsz9qWiThYM6ChcL
 R+SvedHQDXMhWPXvEnmYlTH7xmpy2A+ENKqA+QO9Fj4vJZ+usqbkC6TZkZZhWem0Gfwj
 6qUCaY0s2J6FUe6U17GdItfUPlqOHXEZoS9W1Auo6fjDXUmZDSTgktz7YXe0EZ2rDVC8
 MMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692711930; x=1693316730;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y+N1nXMaIo5F7wsU3B643xl+n6GZpjgq1xyeQA0JZac=;
 b=eQGcGpWzivL9QJ5po7WcpMMB/o/2anAcXK3qEHQNqCzAYSY9EYrHVlGuAFIpa6foMs
 FGu5g8en7J0mlnLhuTMbndWMXmkKNZ0WdPAbIARPUjcdI9/giYoh1mfvqp1MiVM6cVcJ
 jZVct2VKtDOIkR+gzCwo7Cu47+OZ+78z6H6xYUYtjRvEkrBvBjef1zq3Hd3AA8u4okyf
 MuJhiaAZWfpH1ErvlBlhMnKxWzSj+2LAsbaZe+KR60R2rSx6oPI07Odgw/M36rZaCQRT
 wAhozuQZ0HxuKCn/cMZK76tyUOc7ZuR9/HEVPYWv4irEoxC3eYmPOtsZBL2VaSDA2Sb7
 R45Q==
X-Gm-Message-State: AOJu0Yzlkbbwu7L3dV7vj5jpSK/O7//MdH/zS6F5oWmowtyoNZrGR88H
 lsbjIZHk63WW6eFwuB/H0auii+5oKPlYhOf6S2k=
X-Google-Smtp-Source: AGHT+IHkgEkJEUgu6NX54kInFw3lz8MwQvk4Zf91xUgrRkMpgnvL37TnhDPmwglvI7KVL4oU7iwpvw==
X-Received: by 2002:a5d:4246:0:b0:31a:b3aa:d19b with SMTP id
 s6-20020a5d4246000000b0031ab3aad19bmr7001967wrr.23.1692711930451; 
 Tue, 22 Aug 2023 06:45:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j6-20020adfea46000000b003197a4b0f68sm16083252wrn.7.2023.08.22.06.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 06:45:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 439331FFBB;
 Tue, 22 Aug 2023 14:45:29 +0100 (BST)
References: <20230822093712.38922-1-philmd@linaro.org>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/7] tcg: Document *swap/deposit helpers
Date: Tue, 22 Aug 2023 14:42:04 +0100
In-reply-to: <20230822093712.38922-1-philmd@linaro.org>
Message-ID: <87zg2jgphi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> While reviewing a recent patch from Richard optimizing
> deposit() [*] I ended looking at the *swap friends, taking
> some notes, which then evolved to proper documentation.
>
> [*]
> https://lore.kernel.org/qemu-devel/20230816145547.477974-3-richard.hender=
son@linaro.org/

We already have some documentation in tcg.rst:

   * - bswap16_i32/i64 *t0*, *t1*, *flags*

     - | 16 bit byte swap on the low bits of a 32/64 bit input.
       |
       | If *flags* & ``TCG_BSWAP_IZ``, then *t1* is known to be zero-exten=
ded from bit 15.
       | If *flags* & ``TCG_BSWAP_OZ``, then *t0* will be zero-extended fro=
m bit 15.
       | If *flags* & ``TCG_BSWAP_OS``, then *t0* will be sign-extended fro=
m bit 15.
       |
       | If neither ``TCG_BSWAP_OZ`` nor ``TCG_BSWAP_OS`` are set, then the=
 bits of *t0* above bit 15 may contain any value.

   * - bswap32_i64 *t0*, *t1*, *flags*

     - | 32 bit byte swap on a 64-bit value.  The flags are the same as for=
 bswap16,
         except they apply from bit 31 instead of bit 15.

   * - bswap32_i32 *t0*, *t1*, *flags*

       bswap64_i64 *t0*, *t1*, *flags*

     - | 32/64 bit byte swap. The flags are ignored, but still present
         for consistency with the other bswap opcodes.

In an ideal world we could generate kdoc from the source file and
include it in the rest of the tcg docs. I'm not sure if it worth the
churn though? Richard?

https://qemu.readthedocs.io/en/master/devel/tcg-ops.html

>
> Philippe Mathieu-Daud=C3=A9 (7):
>   tcg/tcg-op: Document bswap16() byte pattern
>   tcg/tcg-op: Document bswap32() byte pattern
>   tcg/tcg-op: Document bswap64() byte pattern
>   tcg/tcg-op: Document hswap() byte pattern
>   tcg/tcg-op: Document wswap() byte pattern
>   tcg/tcg-op: Document deposit_z()
>   target/cris: Fix a typo in gen_swapr()
>
>  docs/devel/tcg-ops.rst  | 12 ++++++
>  target/cris/translate.c | 20 +++++----
>  tcg/tcg-op.c            | 96 +++++++++++++++++++++++++++++++----------
>  3 files changed, 96 insertions(+), 32 deletions(-)


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

