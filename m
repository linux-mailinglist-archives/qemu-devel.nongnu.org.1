Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC587697AC
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 15:33:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQT0q-0004us-VB; Mon, 31 Jul 2023 09:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQT0b-0004gb-72
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:32:28 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQT0Z-0006Ii-Pl
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:32:24 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-686f19b6dd2so2859266b3a.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690810342; x=1691415142;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qA6thExMMXJkyGHzexY+V4aBKe9NBakxHIryUUSoUHs=;
 b=zV57vkkmk+xrVuWGWTMvzhQmq5fSoLBpXtUYznfcYcBm6f3Wm3LCOnDN5OFx1gfJVi
 ecCsvGegFka91GECA3egaBx4oCzd/uJgMHDE1ZviEpeYOuPRTijWQeAHdE/yHTLz4qhl
 pB4tMsAUjorpMLyOdoNLmNUkuG/k9IRzQIYgad3roGI84n35vStCEgu3Ia0+lnm9x7tx
 TqtZda69bCDo75Rf3Doqj0tSYL4D1GLKMrbtupz7JGoD+G3Gbpr/EHK4Uk5Fn5z9TlPI
 cnYmFD0oP8g1N6ZE/DpUi60bNKs1OzZ+Q2aeAmC/4UUypU711nFe8kAwauOps7CQq9B4
 Yu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690810342; x=1691415142;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qA6thExMMXJkyGHzexY+V4aBKe9NBakxHIryUUSoUHs=;
 b=SS0DwwyLqkIz5kQU3FggeSJbp+EbMQIwCGQIFcGIBmyHGD5ZQ3Y3muQvAhAUlwXEPh
 OIUybFuhElYlH6DnFSO0Au/1MNQdMLXMIxB5uBawItwK6QV4T1h8egFmBSpGe808WD1p
 g+5SBUTyl/i3KOqQWF6++EuIYWMf9fHSEnsOjqj1gnqnN1qEjaiGxNVswPs8hlSX73BV
 FhRZHqCtdEG9v/YCFCdEQbly8z7yWp1nTpG8tZlOTLvuJQ+uGzbG+ei9rJy3OCcW3NC2
 jgHlp6p5Nkl1+0wzw8yZCg2/7xgoM4PAia03ZJZrXGGCajakWdL2juhnrimWp2I+Jnqy
 PPhQ==
X-Gm-Message-State: ABy/qLZTzdKP0Nu6FpWt2MDAIYxULsoNYHxlNL4wFsFJBtP/H5d7/uen
 ajwIZDABIyJiPng+LwjR3+FsMxD14NflezOgP2c=
X-Google-Smtp-Source: APBJJlFSEOqRUvoBtWlbvbCBGjMmIXsEPb2Phqk6E5EBR7FcDHvcXLzMXIDALYLd64cBERLW8OQMYw==
X-Received: by 2002:a05:6a00:983:b0:686:25fe:d575 with SMTP id
 u3-20020a056a00098300b0068625fed575mr11860637pfg.11.1690810341738; 
 Mon, 31 Jul 2023 06:32:21 -0700 (PDT)
Received: from [10.4.77.224] ([118.103.63.129])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a62e20f000000b0068664ace38asm7863256pfi.19.2023.07.31.06.32.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 06:32:21 -0700 (PDT)
Message-ID: <9f2a49dd-75ce-4e23-3873-0ad4fd78277b@daynix.com>
Date: Mon, 31 Jul 2023 22:32:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <20230731080317.112658-4-akihiko.odaki@daynix.com>
 <CAFEAcA_gdK_nSkiaJQ2mDPeb3Se39AYN+DkDg1U-D2CJ1vUOuQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA_gdK_nSkiaJQ2mDPeb3Se39AYN+DkDg1U-D2CJ1vUOuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/07/31 20:44, Peter Maydell wrote:
> On Mon, 31 Jul 2023 at 09:04, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> MAP_FIXED_NOREPLACE can ensure the mapped address is fixed without
>> concerning that the new mapping overwrites something else.
> 
> MAP_FIXED_NOREPLACE only came in with Linux 4.17. So
> I think we still need to handle the "mapped address
> is not the one we asked for" error condition, because
> it can happen on older host kernels that ignore the
> MAP_FIXED_NOREPLACE flag.
> 
> thanks
> -- PMM

MAP_FIXED_NOREPLACE is substituted with MAP_FIXED before passing to the 
host with patch 1. The NOREPLACE constraint is still ensured by 
inspecting the guest page table.

Regards,
Akihiko Odaki

