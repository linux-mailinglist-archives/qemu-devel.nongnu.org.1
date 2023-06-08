Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 676FB727BAE
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 11:43:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7C9z-0001ta-8s; Thu, 08 Jun 2023 05:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7C9x-0001tQ-H8
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 05:42:25 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7C9v-0003JH-Rw
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 05:42:25 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5149e65c218so680298a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 02:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686217342; x=1688809342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4z91XAPrs91Rq0RO5FmKkOCbRCXzmsSEfDlfnwhGS3I=;
 b=orHyxY5sW+7bMHtEswKdcL/fCfKgVUX6dFy/3pgnN1MsLdtr0EZBtAYFS6MPF5BfPZ
 k4zsYzWsWcUOyYNGuJChdV0f/VH5r8/PTdM6akASfODDKjuoZK/XWXowuz5+zZzfK0Q5
 5mUHn0Oml0fXiBz7yGy8Y9csF13bp8ohSPA151fAQ2fQFs6R1taKcrgQPfOMg5A0TLoA
 ksjHMXgCfDBiC2qtEnvmiJLHOjJJEL5Pl4+YKcrl9BskrAa3vPuJOZWkaCQlf6wU/1uw
 HeIYFkqEZvBsdpGDhUrXrC9tzCcFYJsVnz/f8pUuhX8KdfjVfSVMOdRN0WeXFVd5F2+z
 Tkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686217342; x=1688809342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4z91XAPrs91Rq0RO5FmKkOCbRCXzmsSEfDlfnwhGS3I=;
 b=lD0O2C1SAa1TP4L0bxooP0zsUsPEozFESSSPAzNLC6cmFXv/rKLhzEzRS1WU9W1CJp
 3vS9njQJIBO5XyjiKlwdeCWwQ2KSI4F9ytd//U8QaK0Z7iCFf+I3JOWvxB/pg0EbK9oc
 rkojNviBrKTqEOlOmA7pEi7t7pEm1fh7d2jYGBDM8LEfqS8fV9usPYq3sJgCdWmicOfz
 OJnOzzqn5zRHGafbtXiQ68wQggJ2IUaL7kzezWVk4/M4kcIjSmmpjkWyIMmsTSH+f6r3
 kAwg3eVCEzOrIKgIHKKo+AVbBZBXEZcJyCId6AvuL3qKyQ0n/t829RahraSq2r753zyG
 aSjw==
X-Gm-Message-State: AC+VfDwBJuYXn6VNDZ2BzkG7/V8opU6C9PtinBm0MoNU2qdp8Ch8MJUg
 HH5WUKO2Ij5zauzu2X1yEAGYhKc5YQvIT6JDkUzt7w==
X-Google-Smtp-Source: ACHHUZ5IdBr1a/lBkLgNgufQPT6wG41WUCIhFmKKhYcqP/ZXZAu4U/LK7c2Mg2XulV0yr74z38idgS4tvk+8N5IVuAY=
X-Received: by 2002:aa7:d697:0:b0:510:8ee2:2b05 with SMTP id
 d23-20020aa7d697000000b005108ee22b05mr6129039edr.38.1686217342003; Thu, 08
 Jun 2023 02:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230530212259.7111-1-vikram.garhwal@amd.com>
In-Reply-To: <20230530212259.7111-1-vikram.garhwal@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 10:42:11 +0100
Message-ID: <CAFEAcA9nPRghOXb6vc6eQ_4iGFW3J8z2XyZzgv8BNb1RpBO+wg@mail.gmail.com>
Subject: Re: [QEMU][PATCH v6 4/4] tests/qtest: Introduce tests for Xilinx
 VERSAL CANFD controller
To: Vikram Garhwal <vikram.garhwal@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 30 May 2023 at 22:23, Vikram Garhwal <vikram.garhwal@amd.com> wrote:
>
> The QTests perform three tests on the Xilinx VERSAL CANFD controller:
>     Tests the CANFD controllers in loopback.
>     Tests the CANFD controllers in normal mode with CAN frame.
>     Tests the CANFD controllers in normal mode with CANFD frame.
>
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Hi; Coverity has spotted some issues with this test code; could
you investigate and send followup patches, please ?


> +static void match_rx_tx_data(const uint32_t *buf_tx, const uint32_t *buf_rx,
> +                             bool is_canfd_frame)
> +{
> +    uint16_t size = 0;
> +    uint8_t len = CAN_FRAME_SIZE;
> +
> +    if (is_canfd_frame) {
> +        len = CANFD_FRAME_SIZE;
> +    }

Here len is either 4 (if !is_canfd_frame) or 18 (if is_canfd_frame)...

> +
> +    while (size < len) {

...and we loop with size always less than len...

> +        if (R_RX0_ID_OFFSET + 4 * size == R_RX0_DLC_OFFSET)  {
> +            g_assert_cmpint((buf_rx[size] & DLC_FD_BIT_MASK), ==,
> +                            (buf_tx[size] & DLC_FD_BIT_MASK));
> +        } else {
> +            if (!is_canfd_frame && size == 4) {

...so here this condition can never be true: if !is_canfd_frame
then we know size is less than 4.

What was the intention here ?

(CID 1512900)

> +                break;
> +            }
> +
> +            g_assert_cmpint(buf_rx[size], ==, buf_tx[size]);
> +        }
> +
> +        size++;
> +    }
> +}
> +/*
> + * Xilinx CANFD supports both CAN and CANFD frames. This test will be
> + * transferring CAN frame i.e. 8 bytes of data from CANFD0 and CANFD1 through
> + * canbus. CANFD0 initiate the data transfer to can-bus, CANFD1 receives the
> + * data. Test compares the can frame data sent from CANFD0 and received on
> + * CANFD1.
> + */
> +static void test_can_data_transfer(void)
> +{
> +    uint32_t buf_tx[CAN_FRAME_SIZE] = { 0x5a5bb9a4, 0x80000000,
> +                                        0x12345678, 0x87654321 };
> +    uint32_t buf_rx[CAN_FRAME_SIZE] = { 0x00, 0x00, 0x00, 0x00 };

The buf_rx[] array here is only 4 bytes long...

> +    uint32_t status = 0;
> +
> +    generate_random_data(buf_tx, false);
> +
> +    QTestState *qts = qtest_init("-machine xlnx-versal-virt"
> +                " -object can-bus,id=canbus"
> +                " -machine canbus0=canbus"
> +                " -machine canbus1=canbus"
> +                );
> +
> +    configure_canfd(qts, MSR_NORMAL_MODE);
> +
> +    /* Check if CANFD0 and CANFD1 are in Normal mode. */
> +    status = qtest_readl(qts, CANFD0_BASE_ADDR + R_SR_OFFSET);
> +    status = status & STATUS_REG_MASK;
> +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
> +
> +    status = qtest_readl(qts, CANFD1_BASE_ADDR + R_SR_OFFSET);
> +    status = status & STATUS_REG_MASK;
> +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
> +
> +    write_data(qts, CANFD0_BASE_ADDR, buf_tx, false);
> +
> +    send_data(qts, CANFD0_BASE_ADDR);
> +    read_data(qts, CANFD1_BASE_ADDR, buf_rx);

...but read_data() will write up to 17 bytes of data to the buffer,
if the incoming data from the device claims it to be a canfd frame.
The device shouldn't really do that, but the point of a test is
that the device might not be functioning correctly, so we should
size buf_rx[] large enough to fit whatever read_data() writes to it.

(CID 1512899)

> +    match_rx_tx_data(buf_tx, buf_rx, false);
> +
> +    qtest_quit(qts);
> +}

thanks
-- PMM

