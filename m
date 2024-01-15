Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F4F82DC00
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 16:02:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPOSw-0005DD-Kz; Mon, 15 Jan 2024 10:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPOSu-0005Cm-Nc
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 10:01:28 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPOSs-0008MR-Kp
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 10:01:28 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5596d187f0bso649199a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 07:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705330885; x=1705935685; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=28PujvG2/160s21ZgmyeJp2+D3ouujgYXI6YDN4sHA8=;
 b=Hi0nSjKQXSJzHr7/HFhCyEwi39UUsDYoqYE2v7pLBT5l55nAVAvrVOdgQ+QQeien5p
 1oae7fSyawoPO9RS5B9eAG3VtnfcH9DsmyZo7JaRO5byVDmbDb9xl/e8IecyrlVuDv4I
 Ep4Jvh3tmIoGN34YCsVnZOPaqectFHvwOHzTXKGrnb/YVQ8zmMUzCmd3ylN7XcUduwyJ
 d8Z41SRKUNHSI5pJ9PixPMsInXsF0cSO1M/eoAVbtUxAnd+6NQmDs14J8ogiYsGeuE/E
 +VoVchOO0GH7yYoSE+CotYgA4Tn8vGNjFW2cksAJgaMblfswHZ2WsLbaRpvcbL52QKAx
 37Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705330885; x=1705935685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=28PujvG2/160s21ZgmyeJp2+D3ouujgYXI6YDN4sHA8=;
 b=Mn214JOTGgaDgcUUODPjOnCTnzzTmwWpgB1r3v9bd6OcccxOUp87u4RkScqtYuj2RF
 ejY8t6Pg1VO40vRnK8W6DeM7r6r8+MNppPNrZ9l7JwXwzZmGq5DXR4IvTpEf1lKiaLnb
 o2GBbk5euzaP5mbIayAkIUlQS5y08oN736ylXDCtL55p/JBBInwypovNAiQ92wiiO3vK
 dtcrJV08VxaHUnCq5mbXmSbQC4BOtkUDX6/4crrzzMJlByJxv9CWqRAptMFNhHDN3Jws
 ZQkQEIrN4F1Pm7sv+tjwY2an4vFEXHZp65dyDeS2U4vrL1LkelHqYnbFC3k3mEA1VBlN
 Rn9g==
X-Gm-Message-State: AOJu0YygWIvk+ny35igIS9sRlgjoUwQ40QQNPUdwjJiG4LBahJog2Hr8
 XQDMYje+mXoGBhUlODHbAAbknPfQD31MPUH4CvC93czjIzABSw==
X-Google-Smtp-Source: AGHT+IECtI5OCsyzkyNe20qQmwtsW4N/9ND4VA29xdWHZy3IZLvLPPGU8e5YvHjNM9YOGI+U7JsvJZhzfeX+CDEvasM=
X-Received: by 2002:aa7:d483:0:b0:558:57f5:6474 with SMTP id
 b3-20020aa7d483000000b0055857f56474mr2092091edr.23.1705330884970; Mon, 15 Jan
 2024 07:01:24 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-41-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-41-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 15:01:13 +0000
Message-ID: <CAFEAcA-EbKFmUEmUdNsUTv-49gwTsWM50emPbhZP7Joh5-tX-g@mail.gmail.com>
Subject: Re: [PATCH v4 40/45] Add mailbox property tests. Part 1
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Fri, 8 Dec 2023 at 02:35, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  tests/qtest/bcm2838-mailbox.c            |  34 ++--
>  tests/qtest/bcm2838-mailbox.h            |  18 +-
>  tests/qtest/bcm2838-mbox-property-test.c | 206 +++++++++++++++++++++++
>  tests/qtest/meson.build                  |   2 +-
>  4 files changed, 220 insertions(+), 40 deletions(-)
>  create mode 100644 tests/qtest/bcm2838-mbox-property-test.c
>
> diff --git a/tests/qtest/bcm2838-mailbox.c b/tests/qtest/bcm2838-mailbox.c
> index 2edc24e15e..4b160cd56c 100644
> --- a/tests/qtest/bcm2838-mailbox.c
> +++ b/tests/qtest/bcm2838-mailbox.c
> @@ -12,6 +12,10 @@
>  #include "libqtest-single.h"
>  #include "bcm2838-mailbox.h"
>
> +REG32(MBOX_EXCHNG_REG,          0)
> +FIELD(MBOX_EXCHNG_REG, CHANNEL, 0, 4)
> +FIELD(MBOX_EXCHNG_REG, DATA,    4, 28)
> +
>
>  static uint32_t qtest_mbox0_read_reg32(QTestState *s, uint32_t offset)
>  {
> @@ -25,47 +29,33 @@ static void qtest_mbox1_write_reg32(QTestState *s, uint32_t offset, uint32_t val
>
>  static void qtest_mbox1_write(QTestState *s, uint8_t channel, uint32_t data)
>  {
> -    uint32_t reg;
> +    uint32_t mbox_reg = 0;
>
> -    reg = FIELD_DP32(reg, MBOX_WRITE_REG, CHANNEL, channel);
> -    reg = FIELD_DP32(reg, MBOX_WRITE_REG, DATA, data);
> -    qtest_mbox1_write_reg32(s, MBOX_REG_WRITE, reg);
> +    mbox_reg = FIELD_DP32(mbox_reg, MBOX_EXCHNG_REG, CHANNEL, channel);
> +    mbox_reg = FIELD_DP32(mbox_reg, MBOX_EXCHNG_REG, DATA, data);
> +    qtest_mbox1_write_reg32(s, MBOX_REG_WRITE, mbox_reg);

Why change the variable name? I don't mind which one you use,
but please pick something and stick to it.

>  }
>
>  int qtest_mbox0_has_data(QTestState *s) {
>      return !(qtest_mbox0_read_reg32(s, MBOX_REG_STATUS) & MBOX_READ_EMPTY);
>  }
>
> -int mbox0_has_data(void) {
> -    return qtest_mbox0_has_data(global_qtest);
> -}

Why did we add this if we're now deleting it?

> -
>  void qtest_mbox0_read_message(QTestState *s,
>                                uint8_t channel,
>                                void *msgbuf,
>                                size_t msgbuf_size)
>  {
> -    uint32_t reg;
> +    uint32_t mbox_reg;
>      uint32_t msgaddr;
>
>      g_assert(qtest_mbox0_has_data(s));
> -    reg = qtest_mbox0_read_reg32(s, MBOX_REG_READ);
> -    g_assert_cmphex(FIELD_EX32(reg, MBOX_WRITE_REG, CHANNEL), ==, channel);
> -    msgaddr = FIELD_EX32(reg, MBOX_WRITE_REG, DATA) << 4;
> +    mbox_reg = qtest_mbox0_read_reg32(s, MBOX_REG_READ);
> +    g_assert_cmphex(FIELD_EX32(mbox_reg, MBOX_EXCHNG_REG, CHANNEL), ==, channel);
> +    msgaddr = FIELD_EX32(mbox_reg, MBOX_EXCHNG_REG, DATA) << 4;
>      qtest_memread(s, msgaddr, msgbuf, msgbuf_size);
>  }
>
> -void mbox0_read_message(uint8_t channel, void *msgbuf, size_t msgbuf_size) {
> -    qtest_mbox0_read_message(global_qtest, channel, msgbuf, msgbuf_size);
> -}
> -
>  void qtest_mbox1_write_message(QTestState *s, uint8_t channel, uint32_t msg_addr)
>  {
>      qtest_mbox1_write(s, channel, msg_addr >> 4);
>  }
> -
> -
> -void mbox1_write_message(uint8_t channel, uint32_t msg_addr)
> -{
> -    qtest_mbox1_write_message(global_qtest, channel, msg_addr);
> -}
> diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
> index 2b140a5d32..7e660e65a7 100644
> --- a/tests/qtest/bcm2838-mailbox.h
> +++ b/tests/qtest/bcm2838-mailbox.h
> @@ -77,7 +77,7 @@
>  #define TAG_SET_GPIO_STATE         0x00038041
>  #define TAG_INITIALIZE_VCHIQ       0x00048010
>
> -#define BOARD_REVISION    11546898
> +#define BOARD_REVISION    0xB03115

This doesn't look like it should be here ?

>  #define FIRMWARE_REVISION 346337
>  #define FIRMWARE_VARIANT  0x77777777 /* TODO: Find the real value */
>
> @@ -147,22 +147,6 @@
>  /* Used to test stubs that don't perform actual work */
>  #define DUMMY_VALUE 0x12345678
>
> -REG32(MBOX_WRITE_REG,          0)
> -FIELD(MBOX_WRITE_REG, CHANNEL, 0, 4)
> -FIELD(MBOX_WRITE_REG, DATA,    4, 28)
> -
> -REG32(MBOX_SIZE_STAT,          0)
> -FIELD(MBOX_SIZE_STAT, SIZE,    0, 30)
> -FIELD(MBOX_SIZE_STAT, SUCCESS, 30, 1)
> -
> -REG32(SET_DEVICE_POWER_STATE_CMD,        0)
> -FIELD(SET_DEVICE_POWER_STATE_CMD, EN,    0, 1)
> -FIELD(SET_DEVICE_POWER_STATE_CMD, WAIT,  1, 1)
> -
> -REG32(GET_CLOCK_STATE_CMD,        0)
> -FIELD(GET_CLOCK_STATE_CMD, EN,    0, 1)
> -FIELD(GET_CLOCK_STATE_CMD, NPRES, 1, 1)

We only just added these in the previous patch ?

> -
>  typedef struct {
>      uint32_t size;
>      uint32_t req_resp_code;

thanks
-- PMM

