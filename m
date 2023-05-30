Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBA8716005
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:38:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ybo-0005EI-9T; Tue, 30 May 2023 08:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3ybH-0004aR-8o
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:37:20 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3yav-0002jw-PK
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:37:14 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f004cc54f4so4952794e87.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685450214; x=1688042214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xj+iLiINqefgnt5kZosZHtx7moN7sXIAZMNLQ7bIJXI=;
 b=uM5ZOP0qmym2M5a5697zaKFm9QWjFHyevl0uj3kVlQs6iDdU/5/fvG+74NzLo6dy93
 9c0bIto9T74NHhLHJMqFcebpwN3XCIucmf3/X2XdWZsc6hsKLeeeBmp/M4gidnPIOzS7
 St2QA7BE5kLB32KOFEoXBcYNg6gXwBZX8ftXkzccXuWxqm4lE36+KjPa1xQ0rpIiC+9/
 tODhPDw10HIEZJycr34FRuPUk687KQ2D3aLugI/G2rXeatSLTAeVj+kLhmfh13AKwFEd
 yMhqqJAJhRlXGXYv+H6vi0jVaEXuU5p3vz9K8DkiZAwF9jeEy0TlVkTHJxzlY5MlI3GX
 NB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685450214; x=1688042214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xj+iLiINqefgnt5kZosZHtx7moN7sXIAZMNLQ7bIJXI=;
 b=eooFm3xbWbLPQsy5vc5unzSZsHuTRTj4J1cIw8edS7//khESdZxWFjitBsfztUqdZK
 rCExE652zsEM6nMQYeappyzLXnOIPRVyIf59umz4OxIRlydlOzNIVaFH8vd4eb/KcBd0
 eZjGVHQk8Z5wIEEygcgGKHFAU/SF2SqEodKku80zfDeT7+dbDxm/VB2JjnZkjdU9G2A7
 SegbwCYRBqOgOYOLF7AyEiIEW3GmPRtom4GkozqEtOjAGsBZsbtBSnC2twjwzZdKsX2H
 rYqKr+UTetV32ruBm8RiNempxq6LMz38Ugm2gTummWHo28LW4IOChg7wAMRG58sFS0zZ
 1Vpw==
X-Gm-Message-State: AC+VfDylR9tuOcAfLs8fsWRpov/cIKMW3gP7QBknmCEkHOlVlowKujQf
 3hmm4vknvVnHzIAu56fYrNqNQ8CB8xqk258fx9VmKA==
X-Google-Smtp-Source: ACHHUZ5B8t0sq41dk4Y5GiDnnMcdHeitCuqUXHn9klkBjkREmjL1vU3cqOO5jS6wtEyG8NPRU0wVfMzx9eR9yMC+oEg=
X-Received: by 2002:ac2:5626:0:b0:4f2:34f1:cf24 with SMTP id
 b6-20020ac25626000000b004f234f1cf24mr662955lff.22.1685450214427; Tue, 30 May
 2023 05:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230524113308.834675-1-marcin.juszkiewicz@linaro.org>
 <20230524113308.834675-4-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20230524113308.834675-4-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 13:36:43 +0100
Message-ID: <CAFEAcA-bjGmOn_hyT8a45c+jBnF_GuKBwB3XTOxqb7pzNJCdAg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] docs: sbsa: document platform version changes
To: marcin.juszkiewicz@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Wed, 24 May 2023 at 12:33, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> We plan to start adding more system information in DT so firmware does
> not have to use hardcoded values.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>  docs/system/arm/sbsa.rst | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
> index 016776aed8..922a29700d 100644
> --- a/docs/system/arm/sbsa.rst
> +++ b/docs/system/arm/sbsa.rst
> @@ -6,16 +6,35 @@ any real hardware the ``sbsa-ref`` board intends to look like real
>  hardware. The `Server Base System Architecture
>  <https://developer.arm.com/documentation/den0029/latest>`_ defines a
>  minimum base line of hardware support and importantly how the firmware
> -reports that to any operating system. It is a static system that
> -reports a very minimal DT to the firmware for non-discoverable
> -information about components affected by the qemu command line (i.e.
> -cpus and memory). As a result it must have a firmware specifically
> -built to expect a certain hardware layout (as you would in a real
> -machine).
> +reports that to any operating system.
>
>  It is intended to be a machine for developing firmware and testing
>  standards compliance with operating systems.

> +Platform versions
> +"""""""""""""""""

All this stuff about the DTB format isn't interesting to most
users, so we should put it at the bottom of the doc, below
the 'supported devices' part. Also, the subsection title should
be something like "Board-to-firmware interface", and it should
lead off with the text that clarifies that although the data
blob provided by the board is in DT format it is not intended
to be a complete compliant DT but is just a mechanism for
providing the firmware with specific information about the
non-discoverable components in the system.

> +
> +QEMU 7.1 brought support for "platform version major/minor" fields in
> +DeviceTree.

We don't generally document things in terms of which QEMU versions
they appeared in. The docs just say what the current status is.

> +
> +Version 0.0
> +'''''''''''
> +
> +It is a static system that reports a very minimal DT to the firmware for
> +non-discoverable information about components affected by the qemu
> +command line (i.e. cpus and memory). As a result it must have a firmware
> +specifically built to expect a certain hardware layout (as you would in
> +a real machine).
> +
> +Version 0.1
> +'''''''''''
> +
> +Additional data are provided in DT to the firmware:
> +  - address and size of GIC Distributor
> +  - address and size of GIC Redistributor
> +
> +Simple "/intc/reg" field is used.
> +
>  Supported devices
>  """""""""""""""""

thanks
-- PMM

