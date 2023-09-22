Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2079A7AB669
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 18:46:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjjHI-0006VW-4X; Fri, 22 Sep 2023 12:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qjjHG-0006VB-PU
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qjjHD-0007Cf-Ts
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695401107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orxQpsM0tfFUYhXmOTpAitVO6mwhFiXwuBODXV+ysts=;
 b=IuE+p7ItGN1uwyW0OrKm0az18vPK5zjx+OFl/fi3aNtRD7CoWyEhpCTAkBBfJe1HoIf0CV
 k+DLC7ufTG+AL7mkPW6oqtfaPAOyQl5DWbPbAXUvp6LMpagSrsMZY/fRfa+Ul5ngZpj8YN
 XDwe00ThkTYOJF4HggYtcUN3kBIeBy0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-T1hB1b17Na2xIbJF9GPt5g-1; Fri, 22 Sep 2023 12:45:05 -0400
X-MC-Unique: T1hB1b17Na2xIbJF9GPt5g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31f3eaa5c5eso1516345f8f.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 09:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695401104; x=1696005904;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=orxQpsM0tfFUYhXmOTpAitVO6mwhFiXwuBODXV+ysts=;
 b=Rzy365jzdcWYCx66TtjS0bskoTWnYAZUT+VpC5W0PpEmnQRn6bWrxZzUV9Tn3WAMgl
 DAv/ItXTIW0YDnZJ3PtTYzanetFXVjmh91afOHr9JoxzjrDzu4dtU/GpB68AtF+P/3d6
 3lIxWDas6Zj4+o85Zcezdy8ZJs6kxRSm/umhX7ztLafYs6m+dXaFowrv72uJWveCrGMb
 1Q1OEWKb6ebkEEBglwdSvJ4wcSc4fmkqB6rIuLLVwvIGw/OH9Ij9kbzn3FWsGFXKMKfk
 +VozaiSnYfvAI39LYwT4fvDFUnQyIu+Pqx3bDXdHpdXPuQPVWAiKI38NOT4Wgsak+hYW
 Id6A==
X-Gm-Message-State: AOJu0Yw9h9dZ1eyc3+KCLrl9Ot/iUt2g6+rS/KQXcy3Xg2EEANaCaFRM
 QhrZVMcoHw2lD5zEzIjasJW/j+rLuEctj2ycUxhap00K/aYhrKAkiR4HLCR+SecHsa/QWfQdpQg
 NM8Kc+3MxJN5s8C8=
X-Received: by 2002:adf:b649:0:b0:31f:b402:5aaa with SMTP id
 i9-20020adfb649000000b0031fb4025aaamr253298wre.8.1695401104315; 
 Fri, 22 Sep 2023 09:45:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkRT2godja1zeQDYhaKmoO7V5fh740lml91rfg7eIYrml2FaoJ2E29jSDtYb679uKDuh7tHg==
X-Received: by 2002:adf:b649:0:b0:31f:b402:5aaa with SMTP id
 i9-20020adfb649000000b0031fb4025aaamr253261wre.8.1695401103855; 
 Fri, 22 Sep 2023 09:45:03 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-48.web.vodafone.de.
 [109.43.176.48]) by smtp.gmail.com with ESMTPSA id
 k6-20020adfe3c6000000b003196e992567sm4849488wrm.115.2023.09.22.09.45.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 09:45:03 -0700 (PDT)
Message-ID: <8df33f0f-c394-5eb8-ca0c-5601790745f8@redhat.com>
Date: Fri, 22 Sep 2023 18:45:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] tests/tcg: Add -fno-stack-protector
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, "Edgar E . Iglesias"
 <edgar.iglesias@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org
References: <20230731091042.139159-1-akihiko.odaki@daynix.com>
 <20230731091042.139159-3-akihiko.odaki@daynix.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230731091042.139159-3-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 31/07/2023 11.10, Akihiko Odaki wrote:
> A build of GCC 13.2 will have stack protector enabled by default if it
> was configured with --enable-default-ssp option. For such a compiler,
> it is necessary to explicitly disable stack protector when linking
> without standard libraries.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   tests/tcg/mips/hello-mips.c       | 4 ++--
>   tests/tcg/Makefile.target         | 2 +-
>   tests/tcg/aarch64/Makefile.target | 2 +-
>   tests/tcg/arm/Makefile.target     | 2 +-
>   tests/tcg/cris/Makefile.target    | 2 +-
>   tests/tcg/hexagon/Makefile.target | 2 +-
>   tests/tcg/i386/Makefile.target    | 2 +-
>   tests/tcg/minilib/Makefile.target | 2 +-
>   tests/tcg/mips/Makefile.target    | 2 +-
>   9 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/tcg/mips/hello-mips.c b/tests/tcg/mips/hello-mips.c
> index 4e1cf501af..0ba5f1bf23 100644
> --- a/tests/tcg/mips/hello-mips.c
> +++ b/tests/tcg/mips/hello-mips.c
> @@ -5,8 +5,8 @@
>   * http://www.linux-mips.org/wiki/MIPSABIHistory
>   * http://www.linux.com/howtos/Assembly-HOWTO/mips.shtml
>   *
> -* mipsel-linux-gcc -nostdlib -mno-abicalls -fno-PIC -mabi=32 \
> -*                  -O2 -static -o hello-mips hello-mips.c
> +* mipsel-linux-gcc -nostdlib -mno-abicalls -fno-PIC -fno-stack-protector \
> +                   -mabi=32 -O2 -static -o hello-mips hello-mips.c

You've lost the "*" at the beginning of the comment line here.

But apart from that nit, the patch looks sane to me.

Cc:-ing Alex Bennée ... could pick this patch up?

  Thomas

>   *
>   */
>   #define __NR_SYSCALL_BASE	4000
> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index 3d7837d3b8..c43020d990 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -123,7 +123,7 @@ else
>   # For softmmu targets we include a different Makefile fragment as the
>   # build options for bare programs are usually pretty different. They
>   # are expected to provide their own build recipes.
> -EXTRA_CFLAGS += -ffreestanding
> +EXTRA_CFLAGS += -ffreestanding -fno-stack-protector
>   -include $(SRC_PATH)/tests/tcg/minilib/Makefile.target
>   -include $(SRC_PATH)/tests/tcg/multiarch/system/Makefile.softmmu-target
>   -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
> index 617f821613..55f8609897 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -49,7 +49,7 @@ endif
>   # bti-1 tests the elf notes, so we require special compiler support.
>   ifneq ($(CROSS_CC_HAS_ARMV8_BTI),)
>   AARCH64_TESTS += bti-1 bti-3
> -bti-1 bti-3: CFLAGS += -mbranch-protection=standard
> +bti-1 bti-3: CFLAGS += -fno-stack-protector -mbranch-protection=standard
>   bti-1 bti-3: LDFLAGS += -nostdlib
>   endif
>   # bti-2 tests PROT_BTI, so no special compiler support required.
> diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
> index 0038cef02c..3473f4619e 100644
> --- a/tests/tcg/arm/Makefile.target
> +++ b/tests/tcg/arm/Makefile.target
> @@ -12,7 +12,7 @@ float_madds: CFLAGS+=-mfpu=neon-vfpv4
>   
>   # Basic Hello World
>   ARM_TESTS = hello-arm
> -hello-arm: CFLAGS+=-marm -ffreestanding
> +hello-arm: CFLAGS+=-marm -ffreestanding -fno-stack-protector
>   hello-arm: LDFLAGS+=-nostdlib
>   
>   # IWMXT floating point extensions
> diff --git a/tests/tcg/cris/Makefile.target b/tests/tcg/cris/Makefile.target
> index 43587d2769..713e2a5b6c 100644
> --- a/tests/tcg/cris/Makefile.target
> +++ b/tests/tcg/cris/Makefile.target
> @@ -30,7 +30,7 @@ AS	= $(CC) -x assembler-with-cpp
>   LD      = $(CC)
>   
>   # we rely on GCC inline:ing the stuff we tell it to in many places here.
> -CFLAGS  = -Winline -Wall -g -O2 -static
> +CFLAGS  = -Winline -Wall -g -O2 -static -fno-stack-protector
>   NOSTDFLAGS = -nostartfiles -nostdlib
>   ASFLAGS += -mcpu=v10 -g -Wa,-I,$(SRC_PATH)/tests/tcg/cris/bare
>   CRT_FILES = crt.o sys.o
> diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
> index 87ed2c90b9..f839b2c0d5 100644
> --- a/tests/tcg/hexagon/Makefile.target
> +++ b/tests/tcg/hexagon/Makefile.target
> @@ -19,7 +19,7 @@
>   EXTRA_RUNS =
>   
>   CFLAGS += -Wno-incompatible-pointer-types -Wno-undefined-internal
> -CFLAGS += -fno-unroll-loops
> +CFLAGS += -fno-unroll-loops -fno-stack-protector
>   
>   HEX_SRC=$(SRC_PATH)/tests/tcg/hexagon
>   VPATH += $(HEX_SRC)
> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
> index fdf757c6ce..3dec7c6c42 100644
> --- a/tests/tcg/i386/Makefile.target
> +++ b/tests/tcg/i386/Makefile.target
> @@ -35,7 +35,7 @@ run-test-aes: QEMU_OPTS += -cpu max
>   #
>   # hello-i386 is a barebones app
>   #
> -hello-i386: CFLAGS+=-ffreestanding
> +hello-i386: CFLAGS+=-ffreestanding -fno-stack-protector
>   hello-i386: LDFLAGS+=-nostdlib
>   
>   # test-386 includes a couple of additional objects that need to be
> diff --git a/tests/tcg/minilib/Makefile.target b/tests/tcg/minilib/Makefile.target
> index c821d2806a..af0bf54be9 100644
> --- a/tests/tcg/minilib/Makefile.target
> +++ b/tests/tcg/minilib/Makefile.target
> @@ -12,7 +12,7 @@ SYSTEM_MINILIB_SRC=$(SRC_PATH)/tests/tcg/minilib
>   MINILIB_SRCS=$(wildcard $(SYSTEM_MINILIB_SRC)/*.c)
>   MINILIB_OBJS=$(patsubst $(SYSTEM_MINILIB_SRC)/%.c, %.o, $(MINILIB_SRCS))
>   
> -MINILIB_CFLAGS+=-nostdlib -ggdb -O0
> +MINILIB_CFLAGS+=-nostdlib -fno-stack-protector -ggdb -O0
>   MINILIB_INC=-isystem $(SYSTEM_MINILIB_SRC)
>   
>   .PRECIOUS: $(MINILIB_OBJS)
> diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
> index 1a994d5525..5d17c1706e 100644
> --- a/tests/tcg/mips/Makefile.target
> +++ b/tests/tcg/mips/Makefile.target
> @@ -14,6 +14,6 @@ MIPS_TESTS=hello-mips
>   
>   TESTS += $(MIPS_TESTS)
>   
> -hello-mips: CFLAGS+=-mno-abicalls -fno-PIC -mabi=32
> +hello-mips: CFLAGS+=-mno-abicalls -fno-PIC -fno-stack-protector -mabi=32
>   hello-mips: LDFLAGS+=-nostdlib
>   endif


