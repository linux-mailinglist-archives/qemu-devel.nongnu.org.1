Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCFE7CC5A1
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:11:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskmN-0002Ia-RX; Tue, 17 Oct 2023 10:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qskmL-0002D9-D3
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:10:38 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qskmF-0002eW-Sq
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:10:37 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53f3609550bso358862a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 07:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697551829; x=1698156629; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RfXxDinu9OQhxnaOVr87zTLSfy0yMhLOxm8G1hEtg1w=;
 b=n0zcOeeicUFwbtdadgDYHhNimV6GOn071F9VwQiNLkc/JKNAUNVIGJ14dUnPU/prvG
 in7cuDcN9d+5NnQptMVfRPR5vFpjMFszgq56LdcL6Raw9oUTkBag3MVEpTdNUJSMdxVe
 kjft41eyloN8o+am8LrXrwa/g6cdvZdYsmZZXSLstfqbz7JZRf48om1byRosw0WNRfEL
 UXDZkN86dcfeZUCslfuF8PmZ5Nw4OksZhiS5Xrw+9YogkwcxBmTl2k1kemqMuTMneyr4
 Dm1siZbCu3sEAEiZX+EhKf3a8tmEu4J/kyVe6D3N+J0uhNTttNPMm27YIcBopZdJN9rc
 CSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551829; x=1698156629;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RfXxDinu9OQhxnaOVr87zTLSfy0yMhLOxm8G1hEtg1w=;
 b=ajIC9eNAn34xXhiLBBxd33K8r3T6/WQkDEERcrEL+UWvowwpfY1VfMOuDsLqOayuF0
 3vU2XINNCMcLq0mrCiVfaJzGsQgcRnAgQ/Sv36Eempq3j9LGem2wMXmlzCff4Mw8Br2u
 XsecjPc2zFj6CLiXCD9W8kL8vRVP5TlslNfFcSViWz3ecVGiIC9iqJMBdq92gWYWsXGA
 uk9rLYifPNiPhQbkxUWciMt8X5SgXOPqk8ouuRpCyJZ2145v3Pmc5zn3zTf31ThvKQL6
 4SFDzgb8t/YCePGYNDsqwpJifr38JL4Bq274P1KGaa5a5JhzXJN3jdKk40p7aKLBUTvT
 aMeg==
X-Gm-Message-State: AOJu0YwhhxrR2MtBFwwYsALtekbHGkLJdl2FOOYlIgNYBGCc9546sBVf
 x19ZkxFuByLiaxlMzgvrz14sZfhwQ+29QaIQyugUAQ==
X-Google-Smtp-Source: AGHT+IGdEeognyk4iGhzzVFQvJKlUJkhyUw3Fb+rIUbN10BUL+ymWa+sWGMqy2WBjLC/oDfP0X66vbGinLeQh2EW+uY=
X-Received: by 2002:a05:6402:4410:b0:525:73dd:4f71 with SMTP id
 y16-20020a056402441000b0052573dd4f71mr2159824eda.14.1697551829619; Tue, 17
 Oct 2023 07:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231004142746.350225-1-tong.ho@amd.com>
 <20231004142746.350225-2-tong.ho@amd.com>
In-Reply-To: <20231004142746.350225-2-tong.ho@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2023 15:10:18 +0100
Message-ID: <CAFEAcA8OgCNT7E4KyXv6XuY2bZ4T2F=2oyL-9cuHJsUHXcjC3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/misc: Introduce AMD/Xilix Versal TRNG device
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, frasse.iglesias@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 4 Oct 2023 at 15:27, Tong Ho <tong.ho@amd.com> wrote:
>
> This adds a non-cryptographic grade implementation of the
> model for the True Random Number Generator (TRNG) component
> in AMD/Xilinx Versal device family.
>
> This implements all 3 modes defined by the actual hardware
> specs, all of which selectable by guest software at will
> at anytime:
> 1) PRNG mode, in which the generated sequence is required to
>    be reproducible after reseeded by the same 384-bit value
>    as supplied by guest software.
> 2) Test mode, in which the generated sequence is required to
>    be reproducible ater reseeded by the same 128-bit test
>    seed supplied by guest software.
> 3) TRNG mode, in which non-reproducible sequence is generated
>    based on periodic reseed by a suitable entropy source.
>
> This model is only intended for non-real world testing of
> guest software, where cryptographically strong PRNG and TRNG
> is not needed.
>
> This model supports versions 1 & 2 of the device, with
> default to be version 2; the 'hw-version' uint32 property
> can be set to 0x0100 to override the default.
>
> Other implemented properties:
> - 'forced-prng', uint64
>   When set to non-zero, mode 3's entropy source is implemented
>   as a deterministic sequence based on the given value and other
>   deterministic parameters.
>   This option allows the emulation to test guest software using
>   mode 3 and to reproduce data-dependent defects.
>
> - 'fips-fault-events', uint32, bit-mask
>   bit 3: Triggers the SP800-90B entropy health test fault irq
>   bit 1: Triggers the FIPS 140-2 continuous test fault irq
>
> Signed-off-by: Tong Ho <tong.ho@amd.com>
> ---

> +    enum {
> +        U384_U32 = 384 / 32,
> +    };
> +
> +    /*
> +     * Maximum seed length is len(personalized string) + len(ext seed).
> +     *
> +     * Use little-endian to ensure guest sequence being indepedent of
> +     * host endian.
> +     */
> +    struct {
> +        guint32 ps[U384_U32];
> +        union {
> +            uint64_t int_seed[2];
> +            guint32 ext_seed[U384_U32];
> +        };
> +    } gs;

This struct-and-union seems unnecessarily complicated.
It also means you will be seeding the RNG with different
values on little and big endian, because the two halves
of the uint64_t values will be the opposite way around
when g_rand_set_seed_array() views them as a set of guint32s.
Probably better to use a simple array of guint32.

> +    /*
> +     * A disabled personalized string is the same as
> +     * a string with all zeros.
> +     *
> +     * The device's hardware spec defines 3 modes (all selectable
> +     * by guest at will and at anytime):
> +     * 1) External seeding
> +     *    This is a PRNG mode, in which the produced sequence shall
> +     *    be reproducible if reseeded by the same 384-bit seed, as
> +     *    supplied by guest software.
> +     * 2) Test seeding
> +     *    This is a PRNG mode, in which the produced sequence shall
> +     *    be reproducible if reseeded by a 128-bit test seed, as
> +     *    supplied by guest software.
> +     * 3) Truly-random seeding
> +     *    This is the TRNG mode, in which the produced sequence is
> +     *    periodically reseeded by a crypto-strength entropy source.
> +     *
> +     * To assist debugging of certain classes of software defects,
> +     * this QEMU model implements a 4th mode,
> +     * 4) Forced PRNG
> +     *    When in this mode, a reproducible sequence is generated
> +     *    if software has selected the TRNG mode (mode 2).
> +     *
> +     *    This emulation-only mode can only be selected by setting
> +     *    the uint64 property 'forced-prng' to a non-zero value.
> +     *    Guest software cannot select this mode.
> +     */
> +    memset(&gs, 0, sizeof(gs));
> +    gs.ext_seed[ARRAY_SIZE(gs.ext_seed) - 1] = cpu_to_be32(1);
> +
> +    if (!pers_disabled) {
> +        trng_le384(gs.ps, &s->regs[R_PER_STRNG_0]);
> +    }
> +
> +    if (ext_seed) {
> +        trng_le384(gs.ext_seed, &s->regs[R_EXT_SEED_0]);
> +    } else if (trng_test_enabled(s)) {
> +        gs.int_seed[0] = cpu_to_le64(s->tst_seed[0]);
> +        gs.int_seed[1] = cpu_to_le64(s->tst_seed[1]);
> +    } else if (s->forced_prng_seed) {
> +        s->forced_prng_count++;
> +        gs.int_seed[0] = cpu_to_le64(s->forced_prng_count);
> +        gs.int_seed[1] = cpu_to_le64(s->forced_prng_seed);
> +    } else {
> +        gs.int_seed[0] = cpu_to_le64(qemu_clock_get_ns(QEMU_CLOCK_HOST));
> +        gs.int_seed[1] = cpu_to_le64(getpid());

This is not "a crypto strength entropy source". It's also going
to cause problems for record-and-replay, because the value will
not be the same on replay as it was on record.

If you want 128 (or 384) bits of random data, call
qemu_guest_getrandom_nofail().

> +    }
> +
> +    g_rand_set_seed_array(s->prng, gs.ps,
> +                          sizeof(gs) / sizeof(guint32));

> +
> +    s->rand_count = 0;
> +    s->rand_reseed = 1ULL << 48;
> +}
> +
> +static void trng_regen(XlnxVersalTRng *s)
> +{
> +    if (s->rand_reseed == 0) {
> +        TRNG_GUEST_ERROR(s, "Too many generations without a reseed");
> +        trng_reseed(s);
> +    }
> +    s->rand_reseed--;
> +
> +    /*
> +     * In real hardware, each regen creates 256 bits, but QCNT
> +     * reports a max of 4.
> +     */
> +    ARRAY_FIELD_DP32(s->regs, STATUS, QCNT, 4);
> +    s->rand_count = 256 / 32;
> +}
> +
> +static uint32_t trng_rdout(XlnxVersalTRng *s)
> +{
> +    assert(s->rand_count);
> +
> +    s->rand_count--;
> +    if (s->rand_count < 4) {
> +        ARRAY_FIELD_DP32(s->regs, STATUS, QCNT, s->rand_count);
> +    }
> +
> +    /* Reject all 0's and all 1's */

This is weird. Why do we need to do this ?

> +    while (true) {
> +        /* g_rand_int_range() returns gint32, not guint32 */
> +        guint32 nr = g_rand_int(s->prng);
> +
> +        if (nr && (nr != ~0)) {
> +            return nr;
> +        }
> +    }
> +}
> +

thanks
-- PMM

