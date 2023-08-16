Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAF977E3DE
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 16:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWHfh-0001oa-D4; Wed, 16 Aug 2023 10:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWHff-0001ng-9N
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:38:51 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWHfZ-0006r7-Ux
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:38:51 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5656a5c6721so3393870a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 07:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692196724; x=1692801524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3vy8irCiRjxMGBJh0syZf8K1Z4YgDdsyyDlPabU98/8=;
 b=x8rzI/3Gk1L9a++ypsDEVz4oBAAs7VKx3tb+V3iWbDGmU0gP5V+aPL7tfdo5gaARxk
 fmZJDiy9mtbV9495LZOpMYhuMxc6zfXoe5RjkCmQoNMmpOjqwSXPv+lAcIY99cg28br/
 +7nVYdf7zWdNXqLiWGr31UlOECR9U8ijCiZ3uG6R+Xe43osvI7AE/7iC4NNrU6F5nGwh
 zkL8RUfc2aHBCq+rkoyFKVwcd9kKV4GWs5+98YpkPE7Ie0JoC3OafIYSWQ+7PxxQeewc
 aLjQ5SYq2DuLFARk3b48eWKDbEnL/ETosOUKeOIJQ2zfz6Zhf9zl2Z9iHhH9eT6MC7RQ
 mFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692196724; x=1692801524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3vy8irCiRjxMGBJh0syZf8K1Z4YgDdsyyDlPabU98/8=;
 b=hfZaWi/efdF2Pu9Ir0IUFVQeWf0ApHBO9ySZmAWs1F2DrmD9mXo1MGlEdYJ/TyhN1r
 CjbqYI7EbC2AYhU6ne1zSMbbQXIQp41MURfr1dcQctYseiIGcXm5CpsY8aYBuYYRxSIB
 irunOyZrW5OeKIYG3pQ3Jc9CO4XVOkM0bGuwjwrYBQ2TjUzNaZNEn8RVbI1AJmWv6OMN
 Jgbz9Ma3od47oyApL6DPt65EjkcVObq8oGEqy5Ubo85k2YSYSxc+33SVA+E/d+L66TQT
 CU4rJfphBG6zziEedLV5Eemo1ZPTx50UyC+DafapP01jlanjYdxnuXjAO/mBSjHzuCMz
 V8Bg==
X-Gm-Message-State: AOJu0YwOckFQFYyooICgeai4PSxRaVJAx+I1t9NqQnWcnYj8jDiaF0ge
 pUinEQ6Ai91KX5iybltUDUChiw==
X-Google-Smtp-Source: AGHT+IGcqiNtrNuajrTf+29kskQGA475FZAvML+xRhY5mG/vnZT+amGohpdfiWyS6YCLyboM4JPYEw==
X-Received: by 2002:a17:90a:eb08:b0:268:1745:b61 with SMTP id
 j8-20020a17090aeb0800b0026817450b61mr1537149pjz.34.1692196724023; 
 Wed, 16 Aug 2023 07:38:44 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a17090aca8d00b00262eccfa29fsm13139260pjt.33.2023.08.16.07.38.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 07:38:43 -0700 (PDT)
Message-ID: <dc86c2d7-5e8e-4774-ae69-161c90eceef9@daynix.com>
Date: Wed, 16 Aug 2023 23:38:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 21/24] plugins: Allow to read registers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
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
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
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
 <20230731084354.115015-22-akihiko.odaki@daynix.com>
 <87y1idpseh.fsf@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87y1idpseh.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2023/08/15 0:05, Alex Bennée wrote:
> 
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> It is based on GDB protocol to ensure interface stability.
> 
> See comments bellow.
> 
>> The timing of the vcpu init hook is also changed so that the hook will
>> get called after GDB features are initialized.
> 
> This might be worth splitting to a separate patch for cleaner bisecting.
> 
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/qemu/qemu-plugin.h   | 65 ++++++++++++++++++++++++++++++++++--
>>   cpu.c                        | 11 ------
>>   hw/core/cpu-common.c         | 10 ++++++
>>   plugins/api.c                | 40 ++++++++++++++++++++++
>>   plugins/qemu-plugins.symbols |  2 ++
>>   5 files changed, 114 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>> index 50a9957279..214b12bfd6 100644
>> --- a/include/qemu/qemu-plugin.h
>> +++ b/include/qemu/qemu-plugin.h
>> @@ -11,6 +11,7 @@
>>   #ifndef QEMU_QEMU_PLUGIN_H
>>   #define QEMU_QEMU_PLUGIN_H
>>   
>> +#include <glib.h>
>>   #include <inttypes.h>
>>   #include <stdbool.h>
>>   #include <stddef.h>
>> @@ -51,7 +52,7 @@ typedef uint64_t qemu_plugin_id_t;
>>   
>>   extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
>>   
>> -#define QEMU_PLUGIN_VERSION 1
>> +#define QEMU_PLUGIN_VERSION 2
>>   
>>   /**
>>    * struct qemu_info_t - system information for plugins
>> @@ -218,8 +219,8 @@ struct qemu_plugin_insn;
>>    * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
>>    * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
>>    *
>> - * Note: currently unused, plugins cannot read or change system
>> - * register state.
>> + * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot change
>> + * system register state.
>>    */
>>   enum qemu_plugin_cb_flags {
>>       QEMU_PLUGIN_CB_NO_REGS,
>> @@ -664,4 +665,62 @@ uint64_t qemu_plugin_end_code(void);
>>    */
>>   uint64_t qemu_plugin_entry_code(void);
>>   
>> +/**
>> + * struct qemu_plugin_register_file_t - register information
>> + *
>> + * This structure identifies registers. The identifiers included in this
>> + * structure are identical with names used in GDB's standard target features
>> + * with some extensions. For details, see:
>> + *
>> https://sourceware.org/gdb/onlinedocs/gdb/Standard-Target-Features.html
> 
> I'm not super keen on baking GDB-isms into the plugin register
> interface.

I used GDB names here because I just didn't want to invent feature 
register names again. We can use any other register name dictionary if 
desired.

> 
>> + *
>> + * A register is uniquely identified with the combination of a feature name
>> + * and a register name or a register number. It is recommended to derive
>> + * register numbers from feature names and register names each time a new vcpu
>> + * starts.
> 
> Do you have examples of clashing register names from different feature
> sets?

No. A possible situation that the feature name matters is that a vendor 
extension becomes a standard extension with some modifications. In such 
a case, plugins written for the ratified standard extension may reject 
to work with the processor with the original vendor extension. While 
such a situation has not happened for QEMU and it's unlikely to happen, 
I'm advising to use feature name for register identification just for 
caution.

> 
>> + *
>> + * To derive the register number from a feature name and a register name,
>> + * first look up qemu_plugin_register_file_t with the feature name, and then
>> + * look up the register name in its @regs. The sum of the @base_reg and the
>> + * index in the @reg is the register number.
>> + *
>> + * Note that @regs may have holes; some elements of @regs may be NULL.
>> + */
>> +typedef struct qemu_plugin_register_file_t {
>> +    /** @name: feature name */
>> +    const char *name;
>> +    /** @regs: register names */
>> +    const char * const *regs;
>> +    /** @base_reg: the base identified number */
>> +    int base_reg;
>> +    /** @num_regs: the number of elements in @regs */
>> +    int num_regs;
>> +} qemu_plugin_register_file_t;
>> +
>> +/**
>> + * qemu_plugin_get_register_files() - returns register information
>> + *
>> + * @vcpu_index: the index of the vcpu context
>> + * @size: the pointer to the variable to hold the number of returned elements
>> + *
>> + * Returns an array of qemu_plugin_register_file_t. The user should g_free()
>> + * the array once no longer needed.
>> + */
>> +qemu_plugin_register_file_t *
>> +qemu_plugin_get_register_files(unsigned int vcpu_index, int *size);
> 
> I think I'd rather have a simpler interface that returns an anonymous
> handle to the plugin. For example:
> 
>    struct qemu_plugin_register;
>    struct qemu_plugin_register qemu_plugin_find_register(const char *name);
> 
>> +
>> +/**
>> + * qemu_plugin_read_register() - read register
>> + *
>> + * @buf: the byte array to append the read register content to.
>> + * @reg: the register identifier determined with
>> + *       qemu_plugin_get_register_files().
>> + *
>> + * This function is only available in a context that register read access is
>> + * explicitly requested.
>> + *
>> + * Returns the size of the read register. The content of @buf is in target byte
>> + * order.
>> + */
>> +int qemu_plugin_read_register(GByteArray *buf, int reg);
> 
> and this then becomes:
> 
>    int qemu_plugin_read_register(GByteArray *buf, struct qemu_plugin_register);
> 
> in practice these can become anonymous pointers which hide the
> implementation details from the plugin itself. Then the details of
> mapping the register to a gdb regnum can be kept in the plugin code
> keeping us free to further re-factor the code as we go.
> 
> The plugin code works quite hard to try and avoid leaking implementation
> details to plugins so as not to tie QEMU's hands in re-factoring. While
> the interface provided is technically GDB's, not QEMUs I don't think its
> a particularly nice one to expose.

Unfortunately "struct qemu_plugin_register" will not work. C requires 
the size of the struct to be known before a declaration of a function 
that uses the struct as a return value or parameter.

The best thing we can do is to add typedef just in a manner similar to 
qemu_plugin_id_t.

I added a function that returns all register information instead of a 
function that looks up a register so that a plugin can enumerate 
registers. Such capability is useful for a plugin that dumps all 
registers or a plugin that simulates processor (such a plugin may want 
to warn if there are unknown registers).

I'm just using GDB regnum here because I just needed some numbers. The 
numbers are actually arbitrary and I intentionally did not assure that 
the numbers are identical with what GDB use in the documentation 
comments. We may use any other arbitrary numbers as we want in the future.

> 
> <snip>
> 

