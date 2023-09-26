Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C827AF5C1
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 23:38:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlFjd-0000zE-4d; Tue, 26 Sep 2023 17:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qlFjb-0000ya-1a; Tue, 26 Sep 2023 17:36:47 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qlFjY-0006wx-2F; Tue, 26 Sep 2023 17:36:46 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50307759b65so15996033e87.0; 
 Tue, 26 Sep 2023 14:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695764201; x=1696369001; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P/QDVxkJNFHghmO/7aEieq4XkYfmDgnkVv/IcyPfTzM=;
 b=aez1yyoWcoFT4VA3iHo8OrLfbDCsPzFdqa9FMJ55f67kyOj7wtPETv3KlTTzLMZBOP
 dPE0WWqchDvNAhlJJ7agZIs311zfC84ZvGqznvHZQIoYlTa2R3SCO4MnpLIk90YJ4cHt
 7MwpFrxGB0bGdzAaIuD9fbVyJRACv3UBu57Vj1kB6BVTMdYR/4MH+djBvp0APA92KROU
 nW1RohX8FPi19BZIjY4HxWKKjMIMtIipeVm/j3axj3en2OSWxwnsf7oSbv3BcnUGIQ0X
 kfNCQ/vSzyo/clRJE2OC63oB/+QIbzp5Q6dVU+Tcw8Xyk+dPvEPo1Fo4YkzLcWG+u9OM
 k5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695764201; x=1696369001;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P/QDVxkJNFHghmO/7aEieq4XkYfmDgnkVv/IcyPfTzM=;
 b=bgq0woneTpyOX9fauwBkX8AoPV7ZM57ZhPfqiwCc4h9JmaF82n4LLRhntRBKZMGIkH
 iK0GpbNyhU7AZU8cII68f6+fhFfdFFq90qwlmHFYBofa4xSX0gzH4f+ycVhEuQX2XBa1
 Y8jyizm8X/3pQsLHdM678EPMBZVI/qnJDHx9X9ZMz/TZr6B+VGjDREvUx2tMyzXUu9zB
 kuFf/lyfo/IFpnkMH+/Y+Q1g+0BJXbyna6X/ISsQaM8JUJMVchWJFLoF+pOTAD3HTUK7
 IUXkZYB68sqSyoBXXspMUdn6XN3lMmtWW6l0AmlSLuqrZZRMPf1k+GFA8cNrEJRzWZy5
 uofw==
X-Gm-Message-State: AOJu0YyCxLvvB3Nq+CY8yiqWQ8dNsv+aOhm2zzX/bNnLBiR8t82g9CE9
 p1SRnaEAWnckPe2MEXdRyJA=
X-Google-Smtp-Source: AGHT+IFv44V/Bm8GN4xDfg/zqPrDWvhLqxDZQ187bjBqKzYv+viDuHaisFObB4OzewwNDdIeu4CNEA==
X-Received: by 2002:a05:6512:3b1e:b0:503:3421:4ebd with SMTP id
 f30-20020a0565123b1e00b0050334214ebdmr5996lfv.63.1695764200965; 
 Tue, 26 Sep 2023 14:36:40 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 c19-20020a197613000000b005033948f108sm2277623lff.272.2023.09.26.14.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 14:36:40 -0700 (PDT)
Date: Tue, 26 Sep 2023 23:36:39 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, alistair@alistair23.me,
 edgar.iglesias@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH v2 3/3] tests/qtest: Introduce tests for AMD/Xilinx
 Versal TRNG device
Message-ID: <20230926213638.GB18959@fralle-msi>
References: <20230922065010.4071693-1-tong.ho@amd.com>
 <20230922065010.4071693-4-tong.ho@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922065010.4071693-4-tong.ho@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_WELCOMELIST=-0.01,
 USER_IN_WHITELIST=-100 autolearn=ham autolearn_force=no
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

Hi Tong,

On [2023 Sep 21] Thu 23:50:10, Tong Ho wrote:
> Signed-off-by: Tong Ho <tong.ho@amd.com>
> ---
>  tests/qtest/meson.build             |   2 +-
>  tests/qtest/xlnx-versal-trng-test.c | 490 ++++++++++++++++++++++++++++
>  2 files changed, 491 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/xlnx-versal-trng-test.c
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 1fba07f4ed..215d20e8cf 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -216,7 +216,7 @@ qtests_aarch64 = \
>    (config_all.has_key('CONFIG_TCG') and config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ?            \
>      ['tpm-tis-device-test', 'tpm-tis-device-swtpm-test'] : []) +                                         \
>    (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test', 'xlnx-versal-trng-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
>    (config_all.has_key('CONFIG_TCG') and                                            \
>     config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
.
.
.
> +
> +static const char *trng_info(void)
> +{
> +    uint32_t sta = trng_status();
> +    uint32_t ctl = trng_read(R_TRNG_CTRL);
> +
> +    static char info[64];
> +
> +    snprintf(info, sizeof(info), "; status=0x%x, ctrl=0x%x", sta, ctl);
> +    return info;
> +}
> +
> +static void trng_wait(uint32_t wait_mask, bool on, const char *act)

A suggestion is to remove the 'bool on' arg (it is only called with 'true'
below).

> +{
> +    time_t tmo = time(NULL) + 2; /* at most 2 seconds */
> +    uint32_t event_mask = 0;
> +    uint32_t clear_mask = 0;
> +
> +    /*
> +     * Only selected bits are events in R_TRNG_STATUS, and
> +     * clear them needs to go through R_INT_CTRL.
> +     */
> +    if (wait_mask & TRNG_STATUS_CERTF_MASK) {
> +        event_mask |= TRNG_STATUS_CERTF_MASK;
> +        clear_mask |= TRNG_INT_CTRL_CERTF_RST_MASK;
> +    }
> +    if (wait_mask & TRNG_STATUS_DTF_MASK) {
> +        event_mask |= TRNG_STATUS_DTF_MASK;
> +        clear_mask |= TRNG_INT_CTRL_DTF_RST_MASK;
> +    }
> +    if (wait_mask & TRNG_STATUS_DONE_MASK) {
> +        event_mask |= TRNG_STATUS_DONE_MASK;
> +        clear_mask |= TRNG_INT_CTRL_DONE_RST_MASK;
> +    }
> +
> +    for (;;) {
> +        bool sta = !!(trng_status() & event_mask);
> +
> +        if ((on ^ sta) == 0) {
> +            break;
> +        }
> +
> +        if (time(NULL) >= tmo) {
> +            FAILED("%s: Timed out waiting for event 0x%x to be %d%s",
> +                   act, event_mask, (int)on, trng_info());
> +        }
> +
> +        g_usleep(10000);
> +    }
> +
> +    /* Remove event */
> +    trng_bit_set(R_TRNG_INT_CTRL, clear_mask);
> +
> +    if (!!(trng_read(R_TRNG_STATUS) & event_mask)) {
> +        FAILED("%s: Event 0x%0x stuck at 1 after clear: %s",
> +               act, event_mask, trng_info());
> +    }
> +}
> +
> +static void trng_wait_done(const char *act)
> +{
> +    trng_wait(TRNG_STATUS_DONE_MASK, true, act);
> +}
> +
> +static void trng_wait_dtf(void)
> +{
> +    trng_wait(TRNG_STATUS_DTF_MASK, true, "DTF injection");
> +}
> +
> +static void trng_wait_certf(void)
> +{
> +    trng_wait(TRNG_STATUS_CERTF_MASK, true, "CERTF injection");
> +}
> +
> +static void trng_reset(void)
> +{
> +    trng_write(R_TRNG_RESET, TRNG_RESET_VAL_MASK);
> +    trng_write(R_TRNG_RESET, 0);
> +}
> +
> +static void trng_load(unsigned r0, const uint32_t *b384)
> +{
> +    static const uint32_t zero[12] = { 0 };
> +    unsigned k;
> +
> +    if (!b384) {
> +        b384 = zero;
> +    }
> +
> +    for (k = 0; k < 12; k++) {
> +        trng_write(r0 + 4 * k, b384[k]);
> +    }
> +}
> +
> +static void trng_reseed(const uint32_t *seed)
> +{
> +    const char *act;
> +    uint32_t ctl;
> +
> +    ctl = TRNG_CTRL_PRNGSTART_MASK |
> +          TRNG_CTRL_PRNGXS_MASK |
> +          TRNG_CTRL_TRSSEN_MASK;
> +
> +    trng_ctrl_clr(ctl | TRNG_CTRL_PRNGMODE_MASK);
> +
> +    if (seed) {
> +        trng_load(R_TRNG_EXT_SEED_0, seed);
> +        act = "Reseed PRNG";
> +        ctl &= ~TRNG_CTRL_TRSSEN_MASK;
> +    } else {
> +        trng_write(R_TRNG_OSC_EN, TRNG_OSC_EN_VAL_MASK);
> +        act = "Reseed TRNG";
> +        ctl &= ~TRNG_CTRL_PRNGXS_MASK;
> +    }
> +
> +    trng_ctrl_set(ctl);
> +    trng_wait_done(act);
> +    trng_ctrl_clr(TRNG_CTRL_PRNGSTART_MASK);
> +}
> +
> +static void trng_generate(bool auto_enb)
> +{
> +    uint32_t ctl;
> +
> +    ctl = TRNG_CTRL_PRNGSTART_MASK | TRNG_CTRL_SINGLEGENMODE_MASK;
> +    trng_ctrl_clr(ctl);
> +
> +    if (auto_enb) {
> +        ctl &= ~TRNG_CTRL_SINGLEGENMODE_MASK;
> +    }
> +
> +    trng_ctrl_set(ctl | TRNG_CTRL_PRNGMODE_MASK);
> +
> +    trng_wait_done("Generate");
> +    g_assert(trng_qcnt() != 7);
> +}
> +
> +static size_t trng_collect(uint32_t *rnd, size_t cnt)
> +{
> +    size_t i;
> +
> +    for (i = 0; i < cnt; i++) {
> +        if (trng_qcnt() == 0) {
> +            return i;
> +        }
> +
> +        rnd[i] = trng_read(R_TRNG_CORE_OUTPUT);
> +    }
> +
> +    return i;
> +}
> +
> +static void trng_test_autogen(void)
> +{
> +    const size_t cnt = 512 / 32;
> +    uint32_t rng[cnt], prng[cnt];
> +    size_t n;
> +
> +    trng_reset();
> +
> +    /* PRNG run #1 */
> +    trng_reseed(prng_seed);
> +    trng_generate(true);
> +
> +    n = trng_collect(prng, cnt);
> +    if (n != cnt) {
> +        FAILED("PRNG_1 Auto-gen test failed: expected = %u, got = %u",
> +               (unsigned)cnt, (unsigned)n);
> +    }
> +
> +    /* TRNG, should not match PRNG */
> +    trng_reseed(NULL);
> +    trng_generate(true);
> +
> +    n = trng_collect(rng, cnt);
> +    if (n != cnt) {
> +        FAILED("TRNG Auto-gen test failed: expected = %u, got = %u",
> +               (unsigned)cnt, (unsigned)n);
> +    }
> +
> +    if (!memcmp(rng, prng, sizeof(rng))) {
> +        FAILED("TRNG test failed: matching PRNG");
> +    }
> +
> +    /* PRNG #2: should matches run #1 */
> +    trng_reseed(prng_seed);
> +    trng_generate(true);
> +
> +    n = trng_collect(rng, cnt);
> +    if (n != cnt) {
> +        FAILED("PRNG_2 Auto-gen test failed: expected = %u, got = %u",
> +               (unsigned)cnt, (unsigned)n);
> +    }
> +
> +    if (memcmp(rng, prng, sizeof(rng))) {
> +        FAILED("PRNG_2 Auto-gen test failed: does not match PRNG_1");
> +    }
> +}
> +
> +static void trng_test_oneshot(void)
> +{
> +    const size_t cnt = 512 / 32;
> +    uint32_t rng[cnt];
> +    size_t n;
> +
> +    trng_reset();
> +
> +    /* PRNG run #1 */
> +    trng_reseed(prng_seed);
> +    trng_generate(false);
> +
> +    n = trng_collect(rng, cnt);
> +    if (n == cnt) {
> +        FAILED("PRNG_1 One-shot gen test failed");
> +    }
> +
> +    /* TRNG, should not match PRNG */
> +    trng_reseed(NULL);
> +    trng_generate(false);
> +
> +    n = trng_collect(rng, cnt);
> +    if (n == cnt) {
> +        FAILED("TRNG One-shot test failed");
> +    }
> +}
> +
> +static void trng_test_per_str(void)
> +{
> +    const size_t cnt = 512 / 32;
> +    uint32_t rng[cnt], prng[cnt];
> +    size_t n;
> +
> +    trng_reset();
> +
> +    /* #1: disabled */
> +    trng_ctrl_set(TRNG_CTRL_PERSODISABLE_MASK);
> +    trng_reseed(prng_seed);
> +    trng_ctrl_clr(TRNG_CTRL_PERSODISABLE_MASK);
> +
> +    trng_generate(true);
> +    n = trng_collect(prng, cnt);
> +    g_assert_cmpuint(n, ==, cnt);
> +
> +    /* #2: zero string should match personalization disabled */
> +    trng_load(R_TRNG_PER_STRNG_0, NULL);
> +    trng_reseed(prng_seed);
> +
> +    trng_generate(true);
> +    n = trng_collect(rng, cnt);
> +    g_assert_cmpuint(n, ==, cnt);
> +
> +    if (memcmp(rng, prng, sizeof(rng))) {
> +        FAILED("Failed: PER_DISABLE != PER_STRNG_ALL_ZERO");
> +    }
> +
> +    /* #3: non-zero string should not match personalization disabled */
> +    trng_load(R_TRNG_PER_STRNG_0, pers_str);
> +    trng_reseed(prng_seed);
> +
> +    trng_generate(true);
> +    n = trng_collect(rng, cnt);
> +    g_assert_cmpuint(n, ==, cnt);
> +
> +    if (!memcmp(rng, prng, sizeof(rng))) {
> +        FAILED("Failed: PER_DISABLE == PER_STRNG_NON_ZERO");
> +    }
> +}
> +
> +static void trng_test_forced_prng(void)
> +{
> +    const char *prop = "forced-prng";
> +    const uint64_t seed = 0xdeadbeefbad1bad0ULL;
> +
> +    trng_reset();

We need to move above line below the variable initialization below.

> +    const size_t cnt = 512 / 32;
> +    uint32_t rng[cnt], prng[cnt];
> +    size_t n;

Looks good to me otherwise!

Best regards,
Francisco Iglesias

> +
> +    trng_test_set_uint_prop(prop, seed);
> +
> +    /* TRNG run #1 */
> +    trng_reset();
> +    trng_reseed(NULL);
> +    trng_generate(true);
> +
> +    n = trng_collect(prng, cnt);
> +    g_assert_cmpuint(n, ==, cnt);
> +
> +    /* TRNG run #2 should match run #1 */
> +    trng_reset();
> +    trng_reseed(NULL);
> +    trng_generate(true);
> +
> +    n = trng_collect(rng, cnt);
> +    g_assert_cmpuint(n, ==, cnt);
> +
> +    if (memcmp(rng, prng, sizeof(rng))) {
> +        FAILED("Forced-prng test failed: results do not match");
> +    }
> +}
> +
> +static void trng_test_fault_events(void)
> +{
> +    const char *prop = "fips-fault-events";
> +
> +    trng_reset();
> +
> +    /* Fault events only when TRSS is enabled */
> +    trng_write(R_TRNG_OSC_EN, TRNG_OSC_EN_VAL_MASK);
> +    trng_ctrl_set(TRNG_CTRL_TRSSEN_MASK);
> +
> +    trng_test_set_uint_prop(prop, TRNG_STATUS_CERTF_MASK);
> +    trng_wait_certf();
> +
> +    trng_test_set_uint_prop(prop, TRNG_STATUS_DTF_MASK);
> +    trng_wait_dtf();
> +
> +    trng_reset();
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    int rc;
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    #define TRNG_TEST_ADD(n) \
> +            qtest_add_func("/hw/misc/xlnx-versal-trng/" #n, trng_test_ ## n);
> +    TRNG_TEST_ADD(autogen);
> +    TRNG_TEST_ADD(oneshot);
> +    TRNG_TEST_ADD(per_str);
> +    TRNG_TEST_ADD(forced_prng);
> +    TRNG_TEST_ADD(fault_events);
> +    #undef TRNG_TEST_ADD
> +
> +    trng_test_start();
> +    rc = g_test_run();
> +    trng_test_stop();
> +
> +    return rc;
> +}
> -- 
> 2.25.1
> 
> 

