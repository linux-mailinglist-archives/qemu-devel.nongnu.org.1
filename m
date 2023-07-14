Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E18BF75332E
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 09:28:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKDDz-0001bN-B6; Fri, 14 Jul 2023 03:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKDDf-0001aG-KB
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:28:04 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKDDc-0002xC-LW
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:28:03 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-666edfc50deso1006222b3a.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 00:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689319678; x=1691911678;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IRNkAyYOxaYorrSx+EWNj/GqtvsCdKRzaPD2iT5Y+fs=;
 b=k3MELwL0diu9sAkw/7ETssrEvUmofEJ3yM9GCVw+XeZy1SYc7eZR34heMQzqS7jhHF
 c8t6Q8bx5ylqdx3KBSlJRCwVZaZQiBMzXaiTt8IsXp1rGFmMSihhbeaUGGGhhBV+zmgh
 RagewraqnrTZm7DlRNsTRxIVZ+xxxsk5OmN9oAeUCdcNBSZl2fSH8hE5Kj4iVgg61z3C
 /TBPfwRClEOOFa6fxl4jJsGofNDgDxD4agaQrBkPQPFUPiUuH63YumU19oOyLyWBW+VY
 wHxZAdE/XeulYoxofOX6ATGRbxAyEfZsK2+EKqFmgyjnYBAQfWl+Ztleei10lUhlAW9H
 l7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689319678; x=1691911678;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IRNkAyYOxaYorrSx+EWNj/GqtvsCdKRzaPD2iT5Y+fs=;
 b=QoWlgK4r05cnQVSCfXws6/8NPXoJyT3BPwA/XiZewP+maneqFyz5pun/MexAgp+8G0
 Mlj6gCVcuxddX+Znc48fZkKL7RHroaZ/WFSLUK4MvJlCQOidnirnE2FkCFrPYb+g3vYk
 yyKEFjfwGH5TKxneouu0bZvpw1R+5NjKaW6Mk8hW47cEVcZEQGlFl0omUIRBfZs4400X
 fiVqp0ehc8n8kX1f50HFm27O+06FVf18MEqbtOXXHnJwX/nZgRLe9ewaFt00hD6UseGy
 pd/6A1XW2mMVviDJfj2m60f6XZjaD6smbaveWYuBAP6rrHCGx6DYfkW1Jar/jSZYDSqT
 HmHw==
X-Gm-Message-State: ABy/qLbZ+ElzNvfd8He20/rZ7JegbXjkcmAaSwkG8OKSrtkexxG44sq3
 SlfBi+2gU2UgAqZu5RliVqpaWQ==
X-Google-Smtp-Source: APBJJlFFsOnLXF1j+lTUlJBCrs88c10bHqIA2B+VU4NZ451YAayOrlynIUvPahnUMYa/B5m5NasXaA==
X-Received: by 2002:a05:6a00:2d20:b0:67a:20d0:b9bb with SMTP id
 fa32-20020a056a002d2000b0067a20d0b9bbmr3009177pfb.1.1689319677878; 
 Fri, 14 Jul 2023 00:27:57 -0700 (PDT)
Received: from [192.168.149.227] ([172.58.27.104])
 by smtp.gmail.com with ESMTPSA id
 fm12-20020a056a002f8c00b00666b6dc10desm6550256pfb.56.2023.07.14.00.27.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 00:27:57 -0700 (PDT)
Message-ID: <f9c35a6c-be32-7758-d78a-e63449f864b8@linaro.org>
Date: Fri, 14 Jul 2023 08:27:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 11/11] hw/char/pl011: Implement TX FIFO
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mikko Rapeli <mikko.rapeli@linaro.org>
References: <20230710175102.32429-1-philmd@linaro.org>
 <20230710175102.32429-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710175102.32429-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 7/10/23 18:51, Philippe Mathieu-Daudé wrote:
> +static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void *opaque)
> +{
> +    PL011State *s = opaque;
> +    int ret;
> +    const uint8_t *buf;
> +    uint32_t buflen;
> +    uint32_t count;
> +    bool tx_enabled;
> +
> +    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> +        /* Instant drain the fifo when there's no back-end */
> +        return pl011_drain_tx(s);
> +    }
> +
> +    tx_enabled = s->cr & CR_UARTEN;

What happened to "Hello, World"?  We ought to be consistent.
For actual modeling, I think you need TXE too.

Where does UARTFR get updated after successfully transmitting data?

>   static void pl011_write_txdata(PL011State *s, const uint8_t *buf, int length)
> @@ -162,12 +218,32 @@ static void pl011_write_txdata(PL011State *s, const uint8_t *buf, int length)
>       if (!(s->cr & CR_TXE)) {
>           qemu_log_mask(LOG_GUEST_ERROR, "PL011 write data but TX disabled\n");
>       }
> +    if (!fifo8_is_empty(&s->xmit_fifo)) {
> +        /*
> +         * If the UART is disabled in the middle of transmission
> +         * or reception, it completes the current character before
> +         * stopping.
> +         */
> +        pl011_xmit(NULL, G_IO_OUT, s);
> +        return;
> +    }

Why is this in write_txdata?  I would expect to find this with a write to UARTCR.
You appear to *not* be queuing data unless the fifo is empty.

> +    if (length > fifo8_num_free(&s->xmit_fifo)) {
> +        /*
> +         * The FIFO contents remain valid because no more data is
> +         * written when the FIFO is full, only the contents of the
> +         * shift register are overwritten. The CPU must now read
> +         * the data, to empty the FIFO.
> +         */
> +        trace_pl011_fifo_tx_overrun();
> +        s->rsr |= RSR_OE;
> +        return;
> +    }
> +
> +    trace_pl011_fifo_tx_put(length);
> +    fifo8_push_all(&s->xmit_fifo, buf, length);

Since length will always be 1, probably we should just remove it.

> +static bool pl011_xmit_fifo_state_needed(void *opaque, int version_id)
> +{
> +    PL011State* s = opaque;
> +
> +    return pl011_is_fifo_enabled(s) && !fifo8_is_empty(&s->xmit_fifo);
> +}

Ok.

>   static int pl011_post_load(void *opaque, int version_id)
>   {
>       PL011State* s = opaque;
> @@ -455,6 +538,11 @@ static int pl011_post_load(void *opaque, int version_id)
>           s->read_pos = 0;
>       }
>   
> +    if (pl011_xmit_fifo_state_needed(s, version_id)) {
> +        /* Reschedule another transmission */
> +        qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP, pl011_xmit, s);
> +    }

Ok.

> @@ -473,6 +561,7 @@ static const VMStateDescription vmstate_pl011 = {
>           VMSTATE_UINT32(int_enabled, PL011State),
>           VMSTATE_UINT32(int_level, PL011State),
>           VMSTATE_UINT32_ARRAY(read_fifo, PL011State, PL011_FIFO_DEPTH),
> +        VMSTATE_FIFO8_TEST(xmit_fifo, PL011State, pl011_xmit_fifo_state_needed),

Not ok.

The new data should go in its own VMStateDescription, like vmstate_pl011_clock.


r~

