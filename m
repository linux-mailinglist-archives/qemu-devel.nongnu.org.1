Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 577857BB2F1
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:20:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qog3r-0003cX-WC; Fri, 06 Oct 2023 04:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qog3l-0003UI-1q
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:19:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qog3b-00062w-MG
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:19:44 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-406402933edso16458585e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696580372; x=1697185172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h11Z+mlnXz51i4E7tgqt9kvXzxxGq325q3E9HlqboPg=;
 b=jwwau4N6Cy/ycDe83x4xQC7XgFMVKK1nyp4upwnSY9IRCZXw9FqTqEHhRUbeKCd3mP
 QyKeufqHRGh7Flk6Rdkz8bUNSGmScrURs7zUk8SJs7SYRd+wkb9Wr7ZPtIew/tQ/JEMF
 GmpTq9NoTLoAZfwoIMDy4bFtjQ+f+0DgeK6/vPg/UCYo+3zX/m8zpyBlN3TTfvxkoI7F
 o1c/HGsU1TLxpCV8ZYInPVUWKl6T4G9W7B1gSkVZHIAo7c7KNu8RhlDGbJdyY66YgknE
 lkeQwICO99x6krJf6RCNfYyMxZ3299cOKanfe1vxJzcc0wKIOQDRZ8YZ7PjOKHRaJFcz
 HZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696580372; x=1697185172;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h11Z+mlnXz51i4E7tgqt9kvXzxxGq325q3E9HlqboPg=;
 b=AtTfoo/Ito/aBCqhNdLuBkb3zYuCccbHVlEwtldzfBYl8P7N31cNWWcny6gsyHCSg2
 hX1H60gUJOkyYgX4PVMUFZScwf8SbUF6fW6RwXBiZjQmiOUvkS9Ya1BcNkQai4MmN0th
 gIErM8nepuhs3medYRlQZeiGRWc5pxSOTKoxT3Mp+5fqzOabpSZ2efBFbp4vT4mqs0gI
 TqVsx3Im/84u1cL3/qXs298mhYYtXpsRfvxT5OgL23U0bnpFmvNpWrCxj3qarjYbWAmX
 lDEWsfpaxbUr+VMRkOTJZkRRt4aG8QEDmE/IphQK1rlGUgq47uR4gTluS2V2Gs0ugB+B
 zpjw==
X-Gm-Message-State: AOJu0YwTJ1SIwqht26vDTkX0VumSstuTfpAPAHweo9erqTH7mieQkX5s
 oeH0YQzxu7QHI5aWCQBXG2u0tdvbMsP/Zp86720=
X-Google-Smtp-Source: AGHT+IEPRPSN2+xfuVAFVj7uQvSYmK7dMpK6zvYvQWUt8r20MBTfoJ+TLXvlROEouRVGpCrEndg/CA==
X-Received: by 2002:a7b:cd85:0:b0:406:5463:3f51 with SMTP id
 y5-20020a7bcd85000000b0040654633f51mr6666779wmj.25.1696580372566; 
 Fri, 06 Oct 2023 01:19:32 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.115.173])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a7bcd0c000000b003fefb94ccc9sm3165102wmj.11.2023.10.06.01.19.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 01:19:32 -0700 (PDT)
Message-ID: <a427d678-1ae8-61fd-07f7-47496aba4dfe@linaro.org>
Date: Fri, 6 Oct 2023 10:19:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] pc-bios/meson.build: Silent unuseful DTC warnings
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20231006064750.33852-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231006064750.33852-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/10/23 08:47, Philippe Mathieu-Daudé wrote:
> QEMU consumes some device tree blobs, so these have been committed
> to the tree in as firmware, along with the device tree source used
> to generate them. We know the blobs are "good enough" to have QEMU
> boot a system, so we don't really maintain and rebuild the sources.
> 
> These blobs were generated with older 'dtc' binaries. We use the
> v1.6.1 version since 2021 (commit 962fde57b7 "dtc: Update to version
> 1.6.1").
> 
> Since commit 6e0dc9d2a8 ("meson: compile bundled device trees"),
> if dtc binary is available, it is directly used to compile the
> device tree sources. New versions of 'dtc' add checks which display
> warnings or errors. Our sources are a bit old, so dtc v1.6.1 now
> emit the following warnings on a fresh build:
> 
>    [163/3414] Generating pc-bios/canyonlands.dts with a custom command
>    pc-bios/canyonlands.dts:47.9-50.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
>    pc-bios/canyonlands.dts:210.13-429.5: Warning (unit_address_vs_reg): /plb/opb: node has a reg or ranges property, but no unit name
>    pc-bios/canyonlands.dts:464.26-504.5: Warning (pci_bridge): /plb/pciex@d00000000: node name is not "pci" or "pcie"
>    pc-bios/canyonlands.dts:506.26-546.5: Warning (pci_bridge): /plb/pciex@d20000000: node name is not "pci" or "pcie"
>    pc-bios/canyonlands.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
>    pc-bios/canyonlands.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
>    pc-bios/canyonlands.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
>    pc-bios/canyonlands.dts:268.14-289.7: Warning (avoid_unnecessary_addr_size): /plb/opb/ebc/ndfc@3,0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>    [164/3414] Generating pc-bios/petalogix-s3adsp1800.dts with a custom command
>    pc-bios/petalogix-s3adsp1800.dts:258.33-266.5: Warning (interrupt_provider): /plb/interrupt-controller@81800000: Missing #address-cells in interrupt provider
>    [165/3414] Generating pc-bios/petalogix-ml605.dts with a custom command
>    pc-bios/petalogix-ml605.dts:234.39-241.5: Warning (interrupt_provider): /axi/interrupt-controller@81800000: Missing #address-cells in interrupt provider
>    [177/3414] Generating pc-bios/bamboo.dts with a custom command
>    pc-bios/bamboo.dts:45.9-48.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
>    pc-bios/bamboo.dts:87.13-154.5: Warning (unit_address_vs_reg): /plb/opb: node has a reg or ranges property, but no unit name
>    pc-bios/bamboo.dts:198.3-50: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
>    pc-bios/bamboo.dts:87.13-154.5: Warning (interrupts_property): /plb/opb: Missing interrupt-parent
>    pc-bios/bamboo.dts:100.14-108.6: Warning (interrupts_property): /plb/opb/ebc: Missing interrupt-parent
> 
>  From QEMU perspective, these warnings are not really useful. It is
> the responsibility of developers adding DT source/blob to QEMU
> repository to check the source doesn't produce warnings, but as
> long as the blob is useful enough, QEMU can consume it. So these
> warnings don't add any value, instead they are noisy and might
> distract us to focus on important warnings. Better disable them.
> 
> 'dtc' provides the '--quiet' option for that:
> 
>    $ dtc --help
>    Usage: dtc [options] <input file>
> 
>    Options: -[qI:O:o:V:d:R:S:p:a:fb:i:H:sW:E:@AThv]
>      -q, --quiet
>            Quiet: -q suppress warnings, -qq errors, -qqq all
> 
> Update meson to disable these unuseful DTC warnings.
> 

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
(see 
https://lore.kernel.org/qemu-devel/CAFEAcA-WJ9J1YQunJ+bSG=wnpxh1By+Bf18j2CyV7G0vZ=8b7g@mail.gmail.com/)

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v2: Complete $Subject
> 
> Note, meson outputs "Generating dts" instead of "Generating dtb".
> ---
>   pc-bios/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/pc-bios/meson.build b/pc-bios/meson.build
> index e67fa433a1..162663fed6 100644
> --- a/pc-bios/meson.build
> +++ b/pc-bios/meson.build
> @@ -95,7 +95,8 @@ foreach f : [
>           output: out,
>           install: get_option('install_blobs'),
>           install_dir: qemu_datadir,
> -        command: [ dtc, '-I', 'dts', '-O', 'dtb', '-o', '@OUTPUT@', '@INPUT0@' ])
> +        command: [ dtc, '-q', '-I', 'dts', '-O', 'dtb',
> +                        '-o', '@OUTPUT@', '@INPUT0@' ])
>     else
>       blobs += out
>     endif


