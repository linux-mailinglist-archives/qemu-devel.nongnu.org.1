Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8C4769842
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 15:53:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTJc-0004Q5-Ef; Mon, 31 Jul 2023 09:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTJU-0004OI-HS
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:51:57 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTJR-0002tp-Au
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:51:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fe1e1142caso13576035e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 06:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690811511; x=1691416311;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9C61sNBuLzkP1k7MRGfWxhB6WPJh2Tq71aTnep3VwTY=;
 b=hgL3LJ4UbBI66bG/QiBth9eUNg5I+oqxWFsmTMTz1CCwJSbu61BSpk0r/IdaOeHuka
 Gx3C7ghuD3CaQffRhxbvAaISlraH7FmeBl4U/lvb2m6BnJQwHjazCPFTJvbCpgKahCbZ
 0BGtLzVHJ21k4/pyfYFYH0Na+Abts0XOdUYIZqMreN17bT5DnMsMdxAZbUkAYKwQxKDl
 fZlUFoAkHd1QbHHDGDWPHgKT2HRtJsEkUIbJ5eH0KGP1FyzfSuZwfTGPAy11imywQxbH
 qCLJBGB09vPQZWLgHMIFdpBumwCCTuqxcJKIlnVnuIqzPFY+hXkQYxvCbnRH363Tgp9s
 l9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690811511; x=1691416311;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9C61sNBuLzkP1k7MRGfWxhB6WPJh2Tq71aTnep3VwTY=;
 b=S7xP5UnGq0AKiWnSybp9bTewCq05dj0/bRuQD/NnPJO5GenTLJs+velYL9cYq51rd9
 iqU2/3adfKvSGR5erp0sTbrKyjtcxYuYihVS9QdnQ+Z0G/ZOkXrnbQ+SdHKQlN5c7cUh
 6UJyxleiKaS2PbmMwrtbpoN3uhBlfOTwePfUuzhhocqQbVfhTtgotshPA04bXSZ921og
 nq3+xY4fBJ5QZQgxnSEQeIAWOWmJS1pveJ9RiRKKO5zOvA122RvuPqY/+WccSxbljU4G
 GEsfOacvlZ8OA6dXCVXHrzhLXjmW0vDWYsCMknPFTR/wy7JEW+VJ4LngCLuWdk6kBYh3
 pBkw==
X-Gm-Message-State: ABy/qLato7c934BP9nMe5XUb0UkpA4Q7dZgEaHCewMYw/9CWRNe8EDpc
 Oi0TR0TpYgWpXnT3YLqL+OvCVA==
X-Google-Smtp-Source: APBJJlHILCBJRNZrn5crmer00CWRWg2FEycLAoJ3X2ChQegv8+/byit6ZlNXsw37noTTEhadIYXccw==
X-Received: by 2002:adf:ef05:0:b0:315:8f4f:81b8 with SMTP id
 e5-20020adfef05000000b003158f4f81b8mr8322326wro.50.1690811511118; 
 Mon, 31 Jul 2023 06:51:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.198.42])
 by smtp.gmail.com with ESMTPSA id
 h4-20020adffa84000000b0031417fd473csm13249602wrr.78.2023.07.31.06.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 06:51:50 -0700 (PDT)
Message-ID: <f087def2-31f9-f18a-c6e1-03243af04b5e@linaro.org>
Date: Mon, 31 Jul 2023 15:51:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 02/24] gdbstub: Introduce GDBFeature structure
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Rolnik
 <mrolnik@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Laurent Vivier
 <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Stafford Horne <shorne@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20230731084354.115015-1-akihiko.odaki@daynix.com>
 <20230731084354.115015-3-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230731084354.115015-3-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 31/7/23 10:43, Akihiko Odaki wrote:
> Before this change, the information from a XML file was stored in an
> array that is not descriptive. Introduce a dedicated structure type to
> make it easier to understand and to extend with more fields.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   MAINTAINERS             |  2 +-
>   meson.build             |  2 +-
>   include/exec/gdbstub.h  |  9 ++++--
>   gdbstub/gdbstub.c       |  4 +--
>   stubs/gdbstub.c         |  6 ++--
>   scripts/feature_to_c.py | 44 ++++++++++++++++++++++++++
>   scripts/feature_to_c.sh | 69 -----------------------------------------
>   7 files changed, 58 insertions(+), 78 deletions(-)
>   create mode 100755 scripts/feature_to_c.py
>   delete mode 100644 scripts/feature_to_c.sh


> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 7d743fe1e9..bd5bc91dda 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -10,6 +10,11 @@
>   #define GDB_WATCHPOINT_READ      3
>   #define GDB_WATCHPOINT_ACCESS    4
>   
> +typedef struct GDBFeature {
> +    const char *xmlname;
> +    const char *xml;
> +} GDBFeature;
> +
>   
>   /* Get or set a register.  Returns the size of the register.  */
>   typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int reg);
> @@ -38,7 +43,7 @@ void gdb_set_stop_cpu(CPUState *cpu);
>    */
>   extern bool gdb_has_xml;
>   
> -/* in gdbstub-xml.c, generated by scripts/feature_to_c.sh */
> -extern const char *const xml_builtin[][2];
> +/* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
> +extern const GDBFeature gdb_features[];
Maybe clearer named gdb_static_features[].

