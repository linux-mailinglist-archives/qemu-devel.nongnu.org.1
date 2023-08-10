Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3196C777730
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 13:36:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU3wI-0004mV-28; Thu, 10 Aug 2023 07:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU3wC-0004lv-R8
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:34:44 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU3w7-0003Hy-Bv
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:34:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e5747so4560035e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 04:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691667277; x=1692272077;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p8eHg7rMTTBiisZADDmuu9dD4Ylv5kltdlP2rjuo+oc=;
 b=s7wqHlnhimziffbpz9R8BViPrk6AJbecjRhTIDqbXiXWLwE6dXZuXA71UVugQxAKoo
 T7aLhDPnHFjHYyeRkBZrHj0qKsfusPuoRoAR+nE6sa2UUPBr672lGzm/svYQZz3wOnW5
 jm0wgJYPwQiFd6Um5w5k3MTKzVNYqyBNaW9WM/vyv/jf1j30eFVugdDwPDt0NOfjPxBu
 zjTf1k3h+39w8SU3ZumXEvxTsnUqbREt/pSBZPGFqP9a2BKY0QJdsBPv54J6gh2f6gDY
 va9icy2FZkCo6+NUqx9gXDj4xdspVLJuALEoc7UCZbI9OUtNwqyL00lGKsp7ut7CzUA4
 PcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691667277; x=1692272077;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p8eHg7rMTTBiisZADDmuu9dD4Ylv5kltdlP2rjuo+oc=;
 b=iAP33W5E+mGhpN/XYLbvbg+ADJGlrAn0RBt4gDCXSNfw/7r7v6bo8cxvjHHQn+p0L5
 Gc6sgl7Y1VI1ixW2sUq7Riz1ek//MICPsK/8FdepzHcDql13UScPzRcBhKmaH0Kk0U5X
 X0HZu8hVDWNAnO5Q7+qg/zvRr1wYyPaxt/V/RujlalkZU4aHcntgFjPbiVSgBOH/WtJK
 wf/rsNhBY+tJFiUrelGY3bwQ8lTmUNCHIOAy76fyNguwoZkJREiQuvCo/aNiUcvqMPEA
 nHzt/RSzlEex4jz5ha5KSGYxmGBIKPWENvz82DM7ROfLQGZ1tK7HEEz94HgfpQ+6cYRf
 uZOA==
X-Gm-Message-State: AOJu0YzjCxLGjUSK8WEiOdsGdtx3g09+9sxAjqVsvwf89wD6nEpZtgSo
 cI8f42qDsODnXNYFzbOiTOMZX1TCm+s9Zlc2rmk=
X-Google-Smtp-Source: AGHT+IFYgFOZxc1Pe9qluAl9MthvmektDynpIhnpPagsA4KgA6JoKefwsVUMYcmXsqV7eTbVXdzYTQ==
X-Received: by 2002:a05:600c:3b96:b0:3fe:10f8:8714 with SMTP id
 n22-20020a05600c3b9600b003fe10f88714mr1414521wms.7.1691667276785; 
 Thu, 10 Aug 2023 04:34:36 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.65])
 by smtp.gmail.com with ESMTPSA id
 26-20020a05600c22da00b003fbb618f7adsm1851311wmg.15.2023.08.10.04.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 04:34:36 -0700 (PDT)
Message-ID: <41a215d5-4ae6-dfa3-a61e-c21fd8ca311d@linaro.org>
Date: Thu, 10 Aug 2023 13:34:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] roms: Support compile the efi bios for loongarch
Content-Language: en-US
To: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>
References: <260307952ffe5382a55d66a4999034490e04f7df.1691653307.git.lixianglai@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <260307952ffe5382a55d66a4999034490e04f7df.1691653307.git.lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On 10/8/23 09:42, xianglai li wrote:
> 1.Add edk2-platform submodule
> 2.Added loongarch UEFI BIOS support to compiled scripts.
> 3.The cross-compilation toolchain on x86 can be obtained from the link below:
> https://github.com/loongson/build-tools/tree/2022.09.06
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Bibo Mao <maobibo@loongson.cn>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> ---
>   .gitmodules            |  3 +++
>   meson.build            |  2 +-
>   pc-bios/meson.build    |  2 ++
>   roms/edk2-build.config | 14 ++++++++++++++
>   roms/edk2-build.py     |  4 ++--
>   roms/edk2-platforms    |  1 +
>   6 files changed, 23 insertions(+), 3 deletions(-)
>   create mode 160000 roms/edk2-platforms
> 
> diff --git a/.gitmodules b/.gitmodules
> index 73cae4cd4d..0cb57123fa 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -43,3 +43,6 @@
>   [submodule "tests/lcitool/libvirt-ci"]
>   	path = tests/lcitool/libvirt-ci
>   	url = https://gitlab.com/libvirt/libvirt-ci.git
> +[submodule "roms/edk2-platforms"]
> +	path = roms/edk2-platforms
> +	url = https://github.com/tianocore/edk2-platforms.git

See "Topic 4" in [*].

  > We do need to be careful about GPL compliance (making sure users
  > have the source if we provide them the compiled firmware blob
  > for a GPL'd piece of firmware); but we don't need to necessarily
  > ship the sources in the exact same tarball as the blob.

  > [...]

  > Users of QEMU from git don't get a great firmware experience either,
  > since the firmware is in submodules, with all the usual git submodule
  > problems.

edk2-platforms.git use the same license than edk2.git, 
BSD-2-Clause-Patent, which is compatible with GPLv2. At least this is not
edk2-non-osi.git.

Still, we should discuss this generic issue before going forward with
this patch IMO.

Regards,

Phil.

[*] 
https://lore.kernel.org/qemu-devel/CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com/

