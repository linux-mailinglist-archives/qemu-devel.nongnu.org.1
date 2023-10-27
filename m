Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C79E7D9905
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 14:55:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwMMJ-0002ES-Fp; Fri, 27 Oct 2023 08:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwMMF-0002BX-Pn
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 08:54:36 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwMMD-0002ZG-Tg
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 08:54:35 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53dd752685fso3159765a12.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 05:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698411271; x=1699016071; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Td/NqAshOfqLfxe0c3nHtrRLThvP4TOFDA4gLE6YDhY=;
 b=fJI9HgeJap3IPiBBEU/c/d+q+ydaoFzFrDJdCeHQVluA1GWOlAixzbMX5EbTTBE2NT
 XoCdO2iT+Zi2vdhVUwuRqmwtS8mDbuKpfYJ59cyCERlHyXJs8FXo5rHo5JNgsAQv8olz
 BbUrn6Az4HNRqaLDC5wawbcuZq2EgnFJrL+VeZcMl0WbdUcy6hedDUsmGAlK8lI4CkUz
 iifjJl22aLn/zbBihdML6MhIhEuszmlqrUlcaB0rnBOqdTlptr351PA6cNamb6GKNoqO
 HdKImxUOhI1UxD9aT/oozcFOVVf9GbLpCmPK6CFhAXNOhnIHltVLk2TqBgMBHDhrTH+0
 NqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698411271; x=1699016071;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Td/NqAshOfqLfxe0c3nHtrRLThvP4TOFDA4gLE6YDhY=;
 b=oDIYLtP1VjM89jZt1HTdf2oxuYrYnGf7N+JDP9H3VWf4M45Z1cIWJV6HhGChbBSk8a
 fAT56g+9laYJ1f8wp8yKEYSh3uExaiY+ETqi1QW49jMDIiQRAAP+BZw/lzgVk/uw0xzn
 v9WTDTMko997i5BFGTgSaTQYQBsIP4PJm76YNvSZM6E8ABIJ4dCqtDEb7CwwCf9NyVy4
 4Go2N2AMY0Qb3gA+UvU/5hapnP84vQMgwBkXsJLhHrnR8x+cKll67YLxJkCVEtRPHV4r
 zrSFh4893Cc8zYfvc7IJgxFse+I9LPDMzUjWnsfLE7PrcbcTpeqkBSicGD3yKpu0mFbr
 e3CA==
X-Gm-Message-State: AOJu0Yy8ZjntfoGZfT9xFXJMs8/hY3wUUfWrc3lpBOk2801C0iAFQkX9
 jlfPUYQgsw+pi8fF7DGMHKNCO9j0HLYMctVswr3j5A==
X-Google-Smtp-Source: AGHT+IE5S0sdPvyCbUICcg9Jg0QvVb9IfVpvmKrEKkxFEiNkyuyMrrkOoMIQ3cvxwooSMrYEsQnZpvw6L3vTa5Zrm4s=
X-Received: by 2002:a05:6402:1843:b0:533:c75a:6f6 with SMTP id
 v3-20020a056402184300b00533c75a06f6mr2009357edy.12.1698411271423; Fri, 27 Oct
 2023 05:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231017193217.1512868-1-tong.ho@amd.com>
 <20231017193217.1512868-2-tong.ho@amd.com>
In-Reply-To: <20231017193217.1512868-2-tong.ho@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Oct 2023 13:54:20 +0100
Message-ID: <CAFEAcA-erj5szS7Z7cw3mrQhAR9L78JTf8JsVzMTDohWojybGw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] hw/misc: Introduce AMD/Xilix Versal TRNG device
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, richard.henderson@linaro.org, 
 frasse.iglesias@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 17 Oct 2023 at 20:32, Tong Ho <tong.ho@amd.com> wrote:
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
> guest software, where cryptographically strong PRNG or TRNG
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

> +static void trng_le128(uint32_t *le128, uint64_t h00, uint64_t h64)
> +{
> +    le128[0] = cpu_to_le32(h00 & 0xffffffffU);
> +    le128[1] = cpu_to_le32(h00 >> 32);
> +    le128[2] = cpu_to_le32(h64 & 0xffffffffU);
> +    le128[3] = cpu_to_le32(h64 >> 32);

Why are we using cpu_to_le32() here ? We have a host-order
pair of uint64_t values, and we want a set of host-order
uint32_t values (because we're passing a guint32 array
to the glib g_rand_set_seed_array() function). So I
think we want

   seedarray[0] = extract64(h00, 0, 32);
   seedarray[1] = extract64(h00, 32, 32);
   seedarray[2] = extract64(h64, 0, 32);
   seedarray[3] = extract64(h64, 32, 32);

(I renamed the function argument because le128 is a
red herring, and used extract64 because I find that clearer.
The function itself could also use a different name now it
isn't doing anything little-endian related.)

> +}
> +
> +static void trng_le384(uint32_t *le384, const uint32_t *h384)
> +{
> +    size_t i;
> +
> +    for (i = 0; i < (384 / 32); i++) {
> +        le384[i] = cpu_to_le32(h384[i]);
> +    }

Similarly here we have an array of host-order 32-bit values
(from the s->regs[] array) and we want an array of host-order
32-bit values for g_rand_set_seed_array(), so the cpu_to_le32()
is unnecessary (and we're just doing a copy).

> +}
> +
> +static void trng_reseed(XlnxVersalTRng *s)
> +{
> +    bool ext_seed = ARRAY_FIELD_EX32(s->regs, CTRL, PRNGXS);
> +    bool pers_disabled = ARRAY_FIELD_EX32(s->regs, CTRL, PERSODISABLE);
> +
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
> +    guint32 gs[U384_U32 * 2], *seed = &gs[U384_U32];
> +
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
> +    memset(gs, 0, sizeof(gs));
> +    stb_p((uint8_t *)gs + sizeof(gs) - 1, 1);

This looks like it gives different results on big and little
endian. The gs[] array is an array of g_uint32, not an
array of bytes. What's the intention behind setting this
byte to 1, anyway?

> +
> +    if (!pers_disabled) {
> +        trng_le384(gs, &s->regs[R_PER_STRNG_0]);
> +    }
> +
> +    if (ext_seed) {
> +        trng_le384(seed, &s->regs[R_EXT_SEED_0]);
> +    } else if (trng_test_enabled(s)) {
> +        trng_le128(seed, s->tst_seed[0], s->tst_seed[1]);
> +    } else if (s->forced_prng_seed) {
> +        s->forced_prng_count++;
> +        trng_le128(seed, s->forced_prng_count, s->forced_prng_seed);
> +    } else {
> +        qemu_guest_getrandom_nofail(seed, U384_U32 * 4);
> +    }
> +
> +    g_rand_set_seed_array(s->prng, gs, ARRAY_SIZE(gs));
> +
> +    s->rand_count = 0;
> +    s->rand_reseed = 1ULL << 48;
> +}

thanks
-- PMM

