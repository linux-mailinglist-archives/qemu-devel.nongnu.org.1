Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09033827208
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:01:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMr80-0006CM-6H; Mon, 08 Jan 2024 10:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMr7l-0006Bp-PV
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:01:11 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMr7j-0002tE-1F
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:01:09 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-556c3f0d6c5so2207581a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704726065; x=1705330865; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xjuJ8p64YYyiyxB8HtYFESOS8y/RlKCSYwiAqrSM4ZQ=;
 b=oYPQYYDcOXsTRWn3enElgBHjISZ7allLnbHvUWgCOZN/HGISDDgyQD5vXhzQ4BCdaG
 V+a+0XE8SPBqhzfh1cI6rxp+xdgcLCsNMRm3A/17ZaBs2ZbsedPrKKIUYOdB29R36Bjy
 pGmcZRwR+TI8mdvfblJ8hm3/MSZRU+IzmDivdpfJt26PqAK9FoArD/xG5b6QW58V8m4K
 n6cCbvufzosM2nKTLEJb2AJNtzAowUYNz3e8IRbCpzKRxDQfop8Nw+HKv5YZaNew0iRU
 UR3lohyJ5B/+FsSeY1TmDlqzO1/mTEQm5FhBV/rUbZYdf3ozn//7329umtPnvayNlOnO
 JJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704726065; x=1705330865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xjuJ8p64YYyiyxB8HtYFESOS8y/RlKCSYwiAqrSM4ZQ=;
 b=wbRc5cj1chd0C7Tb4+dJKdtVp3qb5rJbQ78IZhL0ILeX4djqqByL3IAFmwhD06pV8c
 NJCQb/4NWMH7G343ZBYMZyc3p68guSEo6mM5tfBjmSD40w+fNef9lQMcLm4hiSGTAoyO
 LzF6lG8i/0e6SiwUiQOdTZG3/OQRgo3R2khQEw9Lc/XCOdX0Qmrid2DHubXZYWjTS+XD
 HoLcuvWDYebwr4Glq2PCUHSg9SHkkfojTj1Anq9MzP+U6yYIknoag/a+BXkDrrQdqqaM
 dNXH9sGripOQYbcUDTtty4hN1T6yvGg3jJ8sXYH+Nh0tbYpE2NTlTnQRFPJdvUjaBvLs
 qRgw==
X-Gm-Message-State: AOJu0YyPF05liXi+S5KI64Tzs0LT/P1gkKf6CLdWaeIkmT3aOLkHu945
 lViVUAV3BqEz2TVwjHYRmXN9KN0K+ROrVnnNi622uJQHgai29A==
X-Google-Smtp-Source: AGHT+IG+oR/BcTzPdlZKFcij2b6iXoz4vVgzWp/hI7hxnQxjGDOkUR4eiIdYXJT2hsWYycUv3/K/SzqYpoVNB1KMuFs=
X-Received: by 2002:a50:cd90:0:b0:557:e92:155f with SMTP id
 p16-20020a50cd90000000b005570e92155fmr1663909edi.71.1704726065390; Mon, 08
 Jan 2024 07:01:05 -0800 (PST)
MIME-Version: 1.0
References: <20231219213255.604535-1-nabihestefan@google.com>
 <20231219213255.604535-9-nabihestefan@google.com>
In-Reply-To: <20231219213255.604535-9-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2024 15:00:54 +0000
Message-ID: <CAFEAcA8awaf=fdPGk+YcV9zPjGNbhP0n=-L0p0VEwPe1U6tXRg@mail.gmail.com>
Subject: Re: [PATCH v9 08/10] hw/net: GMAC Rx Implementation
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 19 Dec 2023 at 21:33, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Nabih Estefan Diaz <nabihestefan@google.com>
>
> - Implementation of Receive function for packets
> - Implementation for reading and writing from and to descriptors in
>   memory for Rx
>
> When RX starts, we need to flush the queued packets so that they
> can be received by the GMAC device. Without this it won't work
> with TAP NIC device.
>
> When RX descriptor list is full, it returns a DMA_STATUS for software to handle it. But there's no way to indicate the software ha handled all RX descriptors and the whole pipeline stalls.

Please make sure you line wrap commit messages at an
appropriate line length.

> We do something similar to NPCM7XX EMC to handle this case.
>
> 1. Return packet size when RX descriptor is full, effectively dropping these packets in such a case.
> 2. When software clears RX descriptor full bit, continue receiving further packets by flushing QEMU packet queue.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> ---

> +    /* write frame part to memory */
> +    if (dma_memory_write(&address_space_memory, (uint64_t) rx_buf_addr,
> +                         *frame_ptr, to_transfer, MEMTXATTRS_UNSPECIFIED))
> +    {

Our coding style says the open brace of an if goes on the same line,
not on a line of its own.

> +        return -1;
> +    }

thanks
-- PMM

