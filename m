Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA6D82CCAD
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 13:29:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOd7k-00012Y-55; Sat, 13 Jan 2024 07:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOd7R-0000z2-U5
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 07:28:11 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOd7P-0007oF-LW
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 07:28:09 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2cdb50d8982so27731fa.2
 for <qemu-devel@nongnu.org>; Sat, 13 Jan 2024 04:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705148886; x=1705753686; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3JrSPlo67QqaghArN/ohSzkKAPbmcNxd8ZmhQFLdIZw=;
 b=QsIKlNwCPmj+cabXd3vEgJzinhj01FUALyiKPwTv2igNgsZNoe5EHhomhGzBPI0icA
 y/pOgkCWN2Osta5M0a9gvdFgHBtEvqvkDlDRiew275sGkmkh/DiorCQwrZGw4bMSQjoZ
 VHmztBv4tmZqoY+T8bIa16kGWgtQ5MQA/+CE2KgMXx3H8Wbc9kPRRekDy8jySFogQOQ2
 cwy9dKCBYQsoB1SeDWD3zGBstcQtnmV2SkyrOdotcv3M6sMBjT6I82C0V5XFs9XeBMBd
 PmXwRIGPvdMJ144jQPtse4XtifX7BDFU/yrwcRo4m4zLdWVV9Flpg78IEtE50iP+L/Wu
 iKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705148886; x=1705753686;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3JrSPlo67QqaghArN/ohSzkKAPbmcNxd8ZmhQFLdIZw=;
 b=NhQJKqDG4E6kEW+kw7p7NZp8365l8BaT0gW6tAWXpariP8lcpreyfvP1m52C0aebGR
 2g2MbZXFxiwYVonM2heO98WsDvc2xkuOyStSlUJ79/iDIuI+7Fh8RXk0R7mmHVLdnbs1
 zH5+H5DK7Q5hEtmvqzrK+R/ct817tIOCsL/BpEy5IDJM8WEECoB3C/ZniHjuRhmR8nG7
 m4i2MS09wiFrPdJTe8lbamF4uwPsctfC/+yMUgrH3C/SvlBfCw6nfmRZOTAAcSh3Mq79
 epi52n3rX2058x0L9L4pxz+p+0+Gs0bByW/M9o0v2QGDyNKJa9SR/mznnyLhrWU0V1Cr
 7Ltw==
X-Gm-Message-State: AOJu0Yx6nVtmA5DybbVVxjYbjDkF0mF3yjGQsXFMVyDPhCWPMMBPLelE
 eZblhSTQgkqV8SXF85QpHcORSCTUZw9ovXN+9/Gzunj5JYS1XA==
X-Google-Smtp-Source: AGHT+IGLKj9ANAZFOspb37EkhR9Au1apdWtGqq6IK7DEN7Igw2nbK540j4lESN7nLYqgNTzeRixe1ORLG7CP8ZKXQik=
X-Received: by 2002:a2e:9d03:0:b0:2cc:c7fb:ce0d with SMTP id
 t3-20020a2e9d03000000b002ccc7fbce0dmr1364897lji.93.1705148885899; Sat, 13 Jan
 2024 04:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20240110234232.4116804-1-nabihestefan@google.com>
 <20240110234232.4116804-4-nabihestefan@google.com>
In-Reply-To: <20240110234232.4116804-4-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 13 Jan 2024 12:27:33 +0000
Message-ID: <CAFEAcA9RAYK+GMQP5b18+Yfx5QXViZYmLW301+XrPfT4m++-7A@mail.gmail.com>
Subject: Re: [PATCH v12 03/10] hw/misc: Add qtest for NPCM7xx PCI Mailbox
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
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

On Wed, 10 Jan 2024 at 23:42, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Hao Wu <wuhaotsh@google.com>
>
> This patches adds a qtest for NPCM7XX PCI Mailbox module.
> It sends read and write requests to the module, and verifies that
> the module contains the correct data after the requests.
>
> Change-Id: I2e1dbaecf8be9ec7eab55cb54f7fdeb0715b8275
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>


> +/*
> + * Create a local TCP socket with any port, then save off the port we got.
> + */
> +static in_port_t open_socket(void)

This needs to be 'int', to avoid a compilation failure under
Windows, which doesn't define the in_port_t type.

> +{
> +    struct sockaddr_in myaddr;
> +    socklen_t addrlen;
> +
> +    myaddr.sin_family = AF_INET;
> +    myaddr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
> +    myaddr.sin_port = 0;
> +    sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
> +    g_assert(sock != -1);
> +    g_assert(bind(sock, (struct sockaddr *) &myaddr, sizeof(myaddr)) != -1);
> +    addrlen = sizeof(myaddr);
> +    g_assert(getsockname(sock, (struct sockaddr *) &myaddr , &addrlen) != -1);
> +    g_assert(listen(sock, 1) != -1);
> +    return ntohs(myaddr.sin_port);
> +}

thanks
-- PMM

