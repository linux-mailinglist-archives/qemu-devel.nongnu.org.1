Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B44073D9D9
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:34:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhfd-0005Wi-LN; Mon, 26 Jun 2023 04:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhfR-0005P7-P8
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:33:50 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhfP-0005jS-OQ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:33:49 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b69e6cce7dso13182571fa.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687768426; x=1690360426;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=57OuGhGvNeFjSxOym8U/poa3TljwCBqLYA/QxJygo4Q=;
 b=MqAStT0zGRAfQRbfYpGJJvZ71MzYK+dtQtwtoE23pnaHXKswHGm/6U3tuR6qmVisgd
 Pnfgv3uUFFgT47ag/9YVNchlGfrtU8oxoW6Fakox1trFzLLtOIHi8aMKbtuJomn9aMhE
 B0dp6+2UjWjm9i0YHHE3hUzyT5FKzizJpxGj0QiZwN1eEOCftt3ym5NqIw7+LrqV+918
 HuqR/HO6sNB8VwVS6nXJ9h45TTZC6NTtSNLHTRBO00cqQ3XGIz2zTylWjiZ/kiIy5AV7
 89nP/3zk6kjuYadZN1iKXvTlTO/fDE2cxHt9qUiSIsgDYBTb7Z1fQgkWHoWmlMcLTQdK
 v7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687768426; x=1690360426;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=57OuGhGvNeFjSxOym8U/poa3TljwCBqLYA/QxJygo4Q=;
 b=Pq/JSFj9ZdY24zgJLObxSdCoDgX0YBLut6w9/1dCF1fn1tEAaH11B10sxNB7CnOXAC
 yvxDWK3psNKRIClChakEgitM5ccN79K1f+BKCDaz+hefMg1MLA1pG7iQb4Ze7wD2Ee1x
 xJczHK83+cXTUHabdVa0/p0M55KzrqNtSMJSc+7QwkZZQgaCssR5SZ0VUTlydIQso5qL
 Wi36+AHx7Bd9lfOb9eA0hTaI+C3eHv1OmlNAZg1fej4Q30uqcFiq5imNPmE8NL1E4957
 X9BUcmjwalcsK4I/3D/ncjDE0vEu837NHVJJk0ff455Gmbj82/5g4GM4dtQkvKv6BZOO
 nodg==
X-Gm-Message-State: AC+VfDwBnh05D2DTz79Q3rB6d7114CsaqGs8N2kljk1CQ8vpdpD8Nt0a
 FfaBrLvX7+keZwmNp7ptWmfKaA==
X-Google-Smtp-Source: ACHHUZ4+cvh3wrLsamQLNOXGy1YHIUA/u5PV5xzBOC2A/XvZ2tslkmtbdKu5ajqhuSyiP8y7qbf81A==
X-Received: by 2002:a2e:9849:0:b0:2b5:1b80:2640 with SMTP id
 e9-20020a2e9849000000b002b51b802640mr11604718ljj.29.1687768426014; 
 Mon, 26 Jun 2023 01:33:46 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 m24-20020a7bcb98000000b003f727764b10sm7008620wmi.4.2023.06.26.01.33.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 01:33:45 -0700 (PDT)
Message-ID: <9146533e-d7c4-7ccf-935c-4b1eccd4980a@linaro.org>
Date: Mon, 26 Jun 2023 10:33:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH-for-8.1] accel: Remove HAX accelerator
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, libvir-list@redhat.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230623230837.4194-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623230837.4194-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/24/23 01:08, Philippe Mathieu-Daudé wrote:
> HAX is deprecated since commits 73741fda6c ("MAINTAINERS: Abort
> HAXM maintenance") and 90c167a1da ("docs/about/deprecated: Mark
> HAXM in QEMU as deprecated"), released in v8.0.0.
> 
> Per the QEMU deprecation policy, we shouldn't remove it before
> QEMU release v8.2.0. However per the latest HAXM release (v7.8),
> the latest QEMU supported is v7.2:
> 
>    Note: Up to this release, HAXM supports QEMU from 2.9.0 to 7.2.0.
> 
> (https://github.com/intel/haxm/releases/tag/v7.8.0)
> 
> The next commit (https://github.com/intel/haxm/commit/da1b8ec072)
> added:
> 
>    HAXM v7.8.0 is our last release and we will not accept
>    pull requests or respond to issues after this.
> 
> As of commit b455ce4c2f, it became very hard to build and test
> HAXM. Its previous maintainers made it clear they won't help.
> It doesn't seem to be a very good use of QEMU maintainers to
> spend their time in a dead project. Save our time by removing
> this orphan zombie code before the QEMU v8.2 release.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS                                   |    8 -
>   docs/about/build-platforms.rst                |    2 +-
>   docs/about/deprecated.rst                     |    6 -
>   docs/about/removed-features.rst               |    9 +-
>   docs/system/introduction.rst                  |    3 -
>   meson.build                                   |    7 -
>   include/exec/poison.h                         |    1 -
>   include/hw/core/cpu.h                         |    2 +-
>   include/sysemu/hax.h                          |   49 -
>   include/sysemu/hw_accel.h                     |    1 -
>   target/i386/hax/hax-accel-ops.h               |   31 -
>   target/i386/hax/hax-i386.h                    |   98 --
>   target/i386/hax/hax-interface.h               |  369 ------
>   target/i386/hax/hax-posix.h                   |   61 -
>   target/i386/hax/hax-windows.h                 |   88 --
>   accel/stubs/hax-stub.c                        |   24 -
>   hw/intc/apic_common.c                         |    3 +-
>   softmmu/cpus.c                                |    6 -
>   softmmu/vl.c                                  |    6 -
>   target/i386/hax/hax-accel-ops.c               |  105 --
>   target/i386/hax/hax-all.c                     | 1141 -----------------
>   target/i386/hax/hax-mem.c                     |  323 -----
>   target/i386/hax/hax-posix.c                   |  305 -----
>   target/i386/hax/hax-windows.c                 |  485 -------
>   accel/stubs/meson.build                       |    1 -
>   meson_options.txt                             |    2 -
>   qemu-options.hx                               |    8 +-
>   .../ci/org.centos/stream/8/x86_64/configure   |    1 -
>   scripts/meson-buildoptions.sh                 |    3 -
>   target/i386/hax/meson.build                   |    7 -
>   target/i386/meson.build                       |    1 -
>   31 files changed, 13 insertions(+), 3143 deletions(-)
>   delete mode 100644 include/sysemu/hax.h
>   delete mode 100644 target/i386/hax/hax-accel-ops.h
>   delete mode 100644 target/i386/hax/hax-i386.h
>   delete mode 100644 target/i386/hax/hax-interface.h
>   delete mode 100644 target/i386/hax/hax-posix.h
>   delete mode 100644 target/i386/hax/hax-windows.h
>   delete mode 100644 accel/stubs/hax-stub.c
>   delete mode 100644 target/i386/hax/hax-accel-ops.c
>   delete mode 100644 target/i386/hax/hax-all.c
>   delete mode 100644 target/i386/hax/hax-mem.c
>   delete mode 100644 target/i386/hax/hax-posix.c
>   delete mode 100644 target/i386/hax/hax-windows.c
>   delete mode 100644 target/i386/hax/meson.build


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

