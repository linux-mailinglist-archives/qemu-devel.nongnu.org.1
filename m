Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A057BB2DB
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:14:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qofxY-00083D-8W; Fri, 06 Oct 2023 04:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qofxX-000833-6k
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:13:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qofxV-0004Ko-6T
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696579995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HK23EELMmUHJwkrn+YEHdocM9d/2IoxvMhPbIoflhJA=;
 b=HMPSnbecSmN8+wHW2mRCaePYvEXeTqI02zP9HVEzW0wKFTd4tIxQA352Ywki0aKK0NIXWO
 0n+6DlnCQyOo9OBToJBnh03sf+BtzlgTg7cb9EtA7C3YhFc5OqaeX4K69wlkcOM4wGv+P+
 iQzfGcOL74NuYWcJp5+hEGQOqDSwSE8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-3NrA_XQwP66Q4CBuRd4p6A-1; Fri, 06 Oct 2023 04:13:12 -0400
X-MC-Unique: 3NrA_XQwP66Q4CBuRd4p6A-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41957273209so17351931cf.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 01:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696579991; x=1697184791;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HK23EELMmUHJwkrn+YEHdocM9d/2IoxvMhPbIoflhJA=;
 b=FWcD1kVeuirCFmcrYbfOkJ1QRz11+HNsZXsPVvIAy+IrLEPkxPE0a8PT01FrANvyRK
 HOPD2DPi+RnixDyT9LJ+j1gaNTD3Lf3y7d3/KEUmdEtCq56IUF/AS8jYmxD3wyNRXo23
 7oIb0heX+bWeYWv4nlGzUDqGGT+4UQ+cmuRff8YLIy3rgX02e3AzsJRvK/2+Wa8xgnvQ
 ucq9Oyxugtz/uKS11iZSYQ8k4KNGY09piBcvgjiqZvSRgvempl7rqUmsgVIg6dDBROme
 JWrqipmNQZmP5WaQszo2Zg6ejPoQL7Yuo9m6F7dI/V6wmfnpfoowl+PjsNMEP1OkZeyx
 2WDg==
X-Gm-Message-State: AOJu0Yy7BWhEppUubASP863e3Nphf41LFe5wRZOfctRPzlcX6Z+drHZs
 bFBwi3RlYOac/qHkPArs+8b/ZelLSZ0HJyDSIyDmbP/aPzxMjlEq0s4Jz2qaBBm7Eksw39uWBiZ
 I6ZbIIM1ZfVqfwLc=
X-Received: by 2002:ac8:4e86:0:b0:417:f85b:5a5a with SMTP id
 6-20020ac84e86000000b00417f85b5a5amr8080268qtp.5.1696579991574; 
 Fri, 06 Oct 2023 01:13:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWSn3CHwB1AEMGlf2qt1XRfbIm16PehGBGeA9Xqq2ndQmgP9DTaNxdJNMZmLi+m44yAZwOOA==
X-Received: by 2002:ac8:4e86:0:b0:417:f85b:5a5a with SMTP id
 6-20020ac84e86000000b00417f85b5a5amr8080252qtp.5.1696579991224; 
 Fri, 06 Oct 2023 01:13:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 r1-20020ac85e81000000b00419ab6ffedasm1099295qtx.29.2023.10.06.01.13.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 01:13:10 -0700 (PDT)
Message-ID: <9fb5e05e-1772-e21b-0f82-56b4e9135c3b@redhat.com>
Date: Fri, 6 Oct 2023 10:13:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] pc-bios/meson.build: Silent unuseful DTC warnings
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20231006064750.33852-1-philmd@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20231006064750.33852-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 10/6/23 08:47, Philippe Mathieu-Daudé wrote:
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


Why not try fixing the .dts instead ? These still exist under Linux :

   ./arch/powerpc/boot/dts/canyonlands.dts
   ./arch/powerpc/boot/dts/bamboo.dts


C.




> 
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


