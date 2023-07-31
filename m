Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 444E9768F26
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 09:47:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQNcH-0001KP-GG; Mon, 31 Jul 2023 03:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQNc5-0001Ge-Rq
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQNc3-0003N4-Em
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690789602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7U6z31L1yNwWi9trHUTUdQ1wcJjxcTZbObPL+gqrFaM=;
 b=FCGOXRROFGoIT1JMT/ntN/JxoWtJyuq3lZKPEQyG/gv/H9cr9ORcKS6/Jmh9o27gEq+efy
 a/h8/E94LRc6hlcvVLU7ABEy+9vuxqpiUDSoNijSGzEp4ZbnX22SdUxEMU1irED7fWDNNc
 HWeSH9tEc/gm2Hab4+WQfLMr3lesnTg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-9M7eMy3ZMySkNjX0vzo4TQ-1; Mon, 31 Jul 2023 03:46:40 -0400
X-MC-Unique: 9M7eMy3ZMySkNjX0vzo4TQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7682705c039so518365585a.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 00:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690789600; x=1691394400;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7U6z31L1yNwWi9trHUTUdQ1wcJjxcTZbObPL+gqrFaM=;
 b=Zy0d743RcCwc4vgk1/Q1hLkWdDikS5fhJj7gjlkorlSAODdFWmVJUrT3b8iXaJNicH
 MIMmlcE5n9td6P8M04WpPLpLyTJAu/EKUFoxnO9G7q1+R0Pj0JOXOK297N4DADaVjAB6
 2xmmiAxjV8ftnND05OHFu1RAd05uJemvW2127xpKFYXRUQH3nSkPDTRZhxwUIJtujOC9
 9g4NLT+3YXuMDVl2QuEdvu/W/dut+YM8wxlew2yz3QGJ8+2qtyc+KQfCpWXYhBMTcOPZ
 uhpI0XYagTpGyNT/mxbvqOenfu+qD7Gu7Ps678CPha2bJogh2JJNPdPe2uklx7nBaQpI
 I9SA==
X-Gm-Message-State: ABy/qLYu8jMgMUyqyYJhGaBlEzNAIWJa6VIrog8ZQ7mqQAQMiKSOuDt0
 N1mNCgti6XD7RSWM+9ikKNcVLNqxt73Sh5PAhMH5Mvy6p+w6R3Afiqumsun/y+WZN4wBm3JqyJ6
 hb0sPrlqPw9CEo1s=
X-Received: by 2002:a05:620a:4001:b0:768:cfe:297d with SMTP id
 h1-20020a05620a400100b007680cfe297dmr11214708qko.73.1690789600291; 
 Mon, 31 Jul 2023 00:46:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGkpHg7Jmp8rrK7/X0HWw4PoknfFddYIK14ljSKM8CIV0j0G+CDCRXxyXYGD38BqrHgMzGMag==
X-Received: by 2002:a05:620a:4001:b0:768:cfe:297d with SMTP id
 h1-20020a05620a400100b007680cfe297dmr11214688qko.73.1690789599953; 
 Mon, 31 Jul 2023 00:46:39 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a05620a159400b00767b7375eadsm3069911qkk.39.2023.07.31.00.46.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 00:46:39 -0700 (PDT)
Message-ID: <c887c365-e4ab-a2e5-25b3-3685b7737f4a@redhat.com>
Date: Mon, 31 Jul 2023 09:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] pc-bios/optionrom: Add -fno-stack-protector
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org
References: <20230731065904.5869-1-akihiko.odaki@daynix.com>
 <20230731065904.5869-2-akihiko.odaki@daynix.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230731065904.5869-2-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 31/07/2023 08.58, Akihiko Odaki wrote:
> A build of GCC 13.2 will have stack protector enabled by default if it
> was configured with --enable-default-ssp option. For such a compiler,
> it is necessary to explicitly disable stack protector when linking
> without standard libraries.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   pc-bios/optionrom/Makefile | 2 +-
>   pc-bios/s390-ccw/Makefile  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
> index b1fff0ba6c..f220d81f2c 100644
> --- a/pc-bios/optionrom/Makefile
> +++ b/pc-bios/optionrom/Makefile
> @@ -19,7 +19,7 @@ quiet-command = $(call quiet-@,$2 $@)$1
>   override CPPFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>   
>   override CFLAGS += -march=i486 -Wall $(EXTRA_CFLAGS) -m16
> -override CFLAGS += -ffreestanding -I$(TOPSRC_DIR)/include
> +override CFLAGS += -ffreestanding -fno-stack-protector -I$(TOPSRC_DIR)/include
>   
>   cc-test = $(CC) -Werror $1 -c -o /dev/null -xc /dev/null >/dev/null 2>/dev/null
>   cc-option = if $(call cc-test, $1); then \
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index acfcd1e71a..446d448913 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -38,7 +38,7 @@ OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
>   EXTRA_CFLAGS += -Wall
>   EXTRA_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -fno-common -fPIE
>   EXTRA_CFLAGS += -fwrapv -fno-strict-aliasing -fno-asynchronous-unwind-tables
> -EXTRA_CFLAGS += -msoft-float
> +EXTRA_CFLAGS += -fno-stack-protector -msoft-float
>   EXTRA_CFLAGS += -std=gnu99
>   LDFLAGS += -Wl,-pie -nostdlib
>   

Both Makefiles seem to add -no-stack-protector in other lines already, so 
this patch does not seem to be necessary?

  Thomas


