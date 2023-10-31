Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8777DD0B5
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:40:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqqR-0001tn-Rf; Tue, 31 Oct 2023 11:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxqqP-0001tC-VH
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:39:53 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxqqO-0003Ry-1H
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:39:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40906fc54fdso45717835e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698766790; x=1699371590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MF7a/BRW4kCGoykaPKCqsh6VW4a6BvXL1sD91Ivk96Y=;
 b=V1YiYy2bGP0BYuMXCf1cKnCbyVA7bprL7s95sXwcgKw5lZIhlSdmgm4OXjmO2Y2o33
 yHECzRuLBNkEY2BGIc2ItPRUzKzHyPJo5dNpQ3udNxgjStddRKQUYkpCEg1CQ3rtQs8/
 SQhFnmyD1yRC5Jg4Gj7CRVCZl6EFNSiKZSBSQiLHAKE1gVeDT0O9bc1CKgJdfqbBBNg7
 DQ1XlDdV1iN6QB0Q3AoqPKjTvsP0b0Zggi95dBbFhPxmpTdnIupG8IP9il3S/E4ghoZ1
 QBjSP14FSgRFe8m/luvvOyD0uGVNQd2lwtpN1RTLZpvmBuYbOeXs8Bbc9wVljuXxbM/a
 BI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698766790; x=1699371590;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MF7a/BRW4kCGoykaPKCqsh6VW4a6BvXL1sD91Ivk96Y=;
 b=xEQqS6g3Uja7aWhLyxFNR8BTRd8KEuBuhw0Mwnav1+BIZdzbYF28OWNW9AZhAWieEP
 r3YOn0pxhM81p8eDuw3kO3/kTWWWqzaYZCLb71Xd79UwtMKIiU2ZfY2MCdwCOMVMu/vI
 SX5OVfSmmMr6JBi1RoE+qmzw4wNzcrXa+a8358QEJak5z0ejq9jmLA9hEnEl+d8snaZe
 MUIy2LvcfxEjzp03oKfYs+Qbel8svAumYdXAvFd61hj5dtNv72rGgRq7NFBZBtgi7ZmS
 ItmKddjBJDZZxVGFWEEqC0f/PoJJ2q9YvJfzWReUBu5NNIeHi4wu8p/eq6r7BikEDoAJ
 tbYg==
X-Gm-Message-State: AOJu0YyOQ4hcJsO9l72QfRritiPqiNMiwMYpwGUdyQCnsiH0UTcm7oJS
 05CeI+W5ftAxr5WCuaUZhbnychH0VN3EVhxNNjw=
X-Google-Smtp-Source: AGHT+IEsVoBL7F6FqgigYfsAPvM7/4ZM9J3Dh7hlHKhxej9HFkTOj8edNGQbq2W51OH7votA7DW0Sg==
X-Received: by 2002:a05:600c:a44:b0:3fc:dd9:91fd with SMTP id
 c4-20020a05600c0a4400b003fc0dd991fdmr10782581wmq.40.1698766790392; 
 Tue, 31 Oct 2023 08:39:50 -0700 (PDT)
Received: from [192.168.69.115] (gjh33-h01-176-171-208-14.dsl.sta.abo.bbox.fr.
 [176.171.208.14]) by smtp.gmail.com with ESMTPSA id
 h10-20020a05600c350a00b004064cd71aa8sm2092243wmq.34.2023.10.31.08.39.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 08:39:50 -0700 (PDT)
Message-ID: <9994c0ae-57af-d3b3-520d-7cbbee543778@linaro.org>
Date: Tue, 31 Oct 2023 16:39:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 6/8] docs/specs/virt-ctlr: Convert to rST
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230927151205.70930-1-peter.maydell@linaro.org>
 <20230927151205.70930-7-peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230927151205.70930-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.053,
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

On 27/9/23 17:12, Peter Maydell wrote:
> Convert docs/specs/virt-ctlr.txt to rST format.
> 
> I added the name of the device to give readers a bit more idea
> of which device we're actually documenting here.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/specs/index.rst                        |  1 +
>   docs/specs/{virt-ctlr.txt => virt-ctlr.rst} | 12 +++++-------
>   2 files changed, 6 insertions(+), 7 deletions(-)
>   rename docs/specs/{virt-ctlr.txt => virt-ctlr.rst} (70%)


$ ./scripts/get_maintainer.pl -f docs/specs/virt-ctlr.txt
get_maintainer.pl: No maintainers found, printing recent contributors.
get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.

$ ./scripts/get_maintainer.pl -f hw/misc/virt_ctrl.c
Laurent Vivier <laurent@vivier.eu> (maintainer:virt)
qemu-devel@nongnu.org (open list:All patches CC here)

Cc'ing Laurent.

Maybe worth squashing:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index cd8d6b140f..2fe435ea9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1283,6 +1283,7 @@ F: include/hw/char/goldfish_tty.h
  F: include/hw/intc/goldfish_pic.h
  F: include/hw/intc/m68k_irqc.h
  F: include/hw/misc/virt_ctrl.h
+F: docs/specs/virt-ctlr.rst

---

> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index ee84b8109d6..8d30968650b 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -29,3 +29,4 @@ guest hardware that is specific to QEMU.
>      ivshmem-spec
>      pvpanic
>      standard-vga
> +   virt-ctlr
> diff --git a/docs/specs/virt-ctlr.txt b/docs/specs/virt-ctlr.rst
> similarity index 70%
> rename from docs/specs/virt-ctlr.txt
> rename to docs/specs/virt-ctlr.rst
> index 24d38084f7f..ad3edde82d2 100644
> --- a/docs/specs/virt-ctlr.txt
> +++ b/docs/specs/virt-ctlr.rst
> @@ -1,9 +1,9 @@
>   Virtual System Controller
>   =========================
>   
> -This device is a simple interface defined for the pure virtual machine with no
> -hardware reference implementation to allow the guest kernel to send command
> -to the host hypervisor.
> +The ``virt-ctrl`` device is a simple interface defined for the pure

Clearer.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +virtual machine with no hardware reference implementation to allow the
> +guest kernel to send command to the host hypervisor.
>   
>   The specification can evolve, the current state is defined as below.
>   
> @@ -11,14 +11,12 @@ This is a MMIO mapped device using 256 bytes.
>   
>   Two 32bit registers are defined:
>   
> -1- the features register (read-only, address 0x00)
> -
> +the features register (read-only, address 0x00)
>      This register allows the device to report features supported by the
>      controller.
>      The only feature supported for the moment is power control (0x01).
>   
> -2- the command register (write-only, address 0x04)
> -
> +the command register (write-only, address 0x04)
>      This register allows the kernel to send the commands to the hypervisor.
>      The implemented commands are part of the power control feature and
>      are reset (1), halt (2) and panic (3).


