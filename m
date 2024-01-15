Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0858682DAA7
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 14:55:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPNQD-0003v2-Ea; Mon, 15 Jan 2024 08:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rPNQB-0003ud-P8
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 08:54:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rPNQ9-0004ki-DF
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 08:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705326872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JPyxqDLPfNADJ/zRfsa1o4q6OFfR0NDRuaAzeqziSKo=;
 b=eve9yBQ/mtbBpukhXVC1rnfAc8yp6KmyFBu3bfQUKD8DfbMEmt1WrSlAvMzhucrQDWC2SA
 bflKvBHcr+Q6sF986Q4gQ/ERpM20QffoJ2QLtGugQwBnr2aIXHXoUtj4CWBpLgIGfqTLbK
 3LeFJljCOx182x1jmNqPqdUKRln9fnw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-krCxk9BlOBaY4MDcw4nfUw-1; Mon, 15 Jan 2024 08:54:31 -0500
X-MC-Unique: krCxk9BlOBaY4MDcw4nfUw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-68148956d0fso47316876d6.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 05:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705326870; x=1705931670;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JPyxqDLPfNADJ/zRfsa1o4q6OFfR0NDRuaAzeqziSKo=;
 b=fE02eIs1awmZa4OsZXLa3iEqjiWdonZqSzYYlkLZWeeZyuGVOdqmZM9T9mZPN6b4uz
 6UGQjBL9UAfZApFbzhB12ACbr20UhIXod0jTHtxz+E4bSI+/soFCnDqDPNnfCOiI7zgX
 daSaI41ZA2xuP+Q7UGdzW1c5CHf2dku/iEzOxyqFlvbw2HB86PN/+p3ftxym5qs/isX2
 2JBftFVIdobeVyJjVz3P7NZDKmU7ayW/+v5zMQgiAykQ5isrfpUhxrb2uOPMdKZ7hVD/
 NXvRv8pnSeQ2iRbMt4VBPzNyLpd9T6Igm6peTVGaun7JVnQAtP5nPG3XQUDHNDtowURS
 /CZQ==
X-Gm-Message-State: AOJu0Yzl8fYUP2lZi4k+//1BByrf4j+4P7ie/2PJaM3iCClY8Lo+/0rr
 JEkLNsk70CoAHxRpAILux7GHKX0/Do/F/N3LIffHn4tddkLfnR9vzF9awkSc1eqeFO3pR6jLg+w
 JsDNvqCnRxinwf2Cday+03b8=
X-Received: by 2002:a05:6214:f6e:b0:681:2257:f1 with SMTP id
 iy14-20020a0562140f6e00b00681225700f1mr7791158qvb.13.1705326870614; 
 Mon, 15 Jan 2024 05:54:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF58CtgdZCeL9TZ9LkaIQOOuwr2xmP2VQpYg7Wtm9Oat3IUkqzeXYBZPG1/eVB2wZEplf5CAw==
X-Received: by 2002:a05:6214:f6e:b0:681:2257:f1 with SMTP id
 iy14-20020a0562140f6e00b00681225700f1mr7791146qvb.13.1705326870307; 
 Mon, 15 Jan 2024 05:54:30 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-232.web.vodafone.de.
 [109.43.176.232]) by smtp.gmail.com with ESMTPSA id
 c18-20020a37e112000000b0078343592844sm2884777qkm.15.2024.01.15.05.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 05:54:30 -0800 (PST)
Message-ID: <fdbe4b2d-b63a-4fcd-9747-08d713e17d22@redhat.com>
Date: Mon, 15 Jan 2024 14:54:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] qemu-options: Remove the deprecated -singlestep option
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20240112100059.965041-1-thuth@redhat.com>
 <20240112100059.965041-6-thuth@redhat.com>
 <7f24e391-e3ba-462c-ba30-2ea7ddb62795@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <7f24e391-e3ba-462c-ba30-2ea7ddb62795@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 12/01/2024 16.39, Philippe Mathieu-Daudé wrote:
> Hi Thomas
> 
> +Laurent & Peter
> 
> On 12/1/24 11:00, Thomas Huth wrote:
>> It's been marked as deprecated since QEMU 8.1, so it should be fine
>> to remove this now.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   docs/about/deprecated.rst       |  6 ------
>>   docs/about/removed-features.rst |  7 +++++++
>>   system/vl.c                     | 18 +-----------------
>>   qemu-options.hx                 |  8 --------
>>   4 files changed, 8 insertions(+), 31 deletions(-)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index b50cfe596b..81a5149f1e 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -63,12 +63,6 @@ as short-form boolean values, and passed to plugins as 
>> ``arg_name=on``.
>>   However, short-form booleans are deprecated and full explicit 
>> ``arg_name=on``
>>   form is preferred.
>> -``-singlestep`` (since 8.1)
>> -'''''''''''''''''''''''''''
>> -
>> -The ``-singlestep`` option has been turned into an accelerator property,
>> -and given a name that better reflects what it actually does.
>> -Use ``-accel tcg,one-insn-per-tb=on`` instead.
>>   User-mode emulator command line arguments
>>   -----------------------------------------
>> diff --git a/docs/about/removed-features.rst 
>> b/docs/about/removed-features.rst
>> index a8546f4787..d5c60ff47f 100644
>> --- a/docs/about/removed-features.rst
>> +++ b/docs/about/removed-features.rst
>> @@ -482,6 +482,13 @@ Use ``-run-with async-teardown=on`` instead.
>>   Use ``-run-with chroot=dir`` instead.
>> +``-singlestep`` (removed in 9.0)
>> +''''''''''''''''''''''''''''''''
>> +
>> +The ``-singlestep`` option has been turned into an accelerator property,
>> +and given a name that better reflects what it actually does.
>> +Use ``-accel tcg,one-insn-per-tb=on`` instead.
>> +
>>   QEMU Machine Protocol (QMP) commands
>>   ------------------------------------
>> diff --git a/system/vl.c b/system/vl.c
>> index c125fb9079..809f867bcc 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -181,7 +181,6 @@ static const char *log_file;
>>   static bool list_data_dirs;
>>   static const char *qtest_chrdev;
>>   static const char *qtest_log;
>> -static bool opt_one_insn_per_tb;
>>   static int has_defaults = 1;
>>   static int default_audio = 1;
>> @@ -2308,19 +2307,7 @@ static int do_configure_accelerator(void *opaque, 
>> QemuOpts *opts, Error **errp)
>>       qemu_opt_foreach(opts, accelerator_set_property,
>>                        accel,
>>                        &error_fatal);
>> -    /*
>> -     * If legacy -singlestep option is set, honour it for TCG and
>> -     * silently ignore for any other accelerator (which is how this
>> -     * option has always behaved).
>> -     */
>> -    if (opt_one_insn_per_tb) {
>> -        /*
>> -         * This will always succeed for TCG, and we want to ignore
>> -         * the error from trying to set a nonexistent property
>> -         * on any other accelerator.
>> -         */
>> -        object_property_set_bool(OBJECT(accel), "one-insn-per-tb", true, 
>> NULL);
>> -    }
>> +
>>       ret = accel_init_machine(accel, current_machine);
>>       if (ret < 0) {
>>           if (!qtest_with_kvm || ret != -ENOENT) {
>> @@ -3057,9 +3044,6 @@ void qemu_init(int argc, char **argv)
>>               case QEMU_OPTION_bios:
>>                   qdict_put_str(machine_opts_dict, "firmware", optarg);
>>                   break;
>> -            case QEMU_OPTION_singlestep:
>> -                opt_one_insn_per_tb = true;
>> -                break;
>>               case QEMU_OPTION_S:
>>                   autostart = 0;
>>                   break;
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 9be6beb5a0..033fa873e4 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -4357,14 +4357,6 @@ SRST
>>       from a script.
>>   ERST
>> -DEF("singlestep", 0, QEMU_OPTION_singlestep, \
>> -    "-singlestep     deprecated synonym for -accel 
>> tcg,one-insn-per-tb=on\n", QEMU_ARCH_ALL)
>> -SRST
>> -``-singlestep``
>> -    This is a deprecated synonym for the TCG accelerator property
>> -    ``one-insn-per-tb``.
>> -ERST
>> -
>>   DEF("preconfig", 0, QEMU_OPTION_preconfig, \
>>       "--preconfig     pause QEMU before machine is initialized 
>> (experimental)\n",
>>       QEMU_ARCH_ALL)
> 
> This is the system part, what about the user part?
> 
> StatusInfo::singlestep was deprecated at the same time,
> can we remove it?
> 
> IOW could we complete your patch with this?
> 
> -- >8 --
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index b47763330c..a1ae93664a 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -63,17 +63,6 @@ as short-form boolean values, and passed to plugins as 
> ``arg_name=on``.
>   However, short-form booleans are deprecated and full explicit ``arg_name=on``
>   form is preferred.
> 
> -
> -User-mode emulator command line arguments
> ------------------------------------------
> -
> -``-singlestep`` (since 8.1)
> -'''''''''''''''''''''''''''
> -
> -The ``-singlestep`` option has been given a name that better reflects
> -what it actually does. For both linux-user and bsd-user, use the
> -new ``-one-insn-per-tb`` option instead.
> -
>   QEMU Machine Protocol (QMP) commands
>   ------------------------------------
> 
> @@ -145,20 +134,6 @@ accepted incorrect commands will return an error. Users 
> should make sure that
>   all arguments passed to ``device_add`` are consistent with the documented
>   property types.
> 
> -``StatusInfo`` member ``singlestep`` (since 8.1)
> -''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -The ``singlestep`` member of the ``StatusInfo`` returned from the
> -``query-status`` command is deprecated. This member has a confusing
> -name and it never did what the documentation claimed or what its name
> -suggests. We do not believe that anybody is actually using the
> -information provided in this member.
> -
> -The information it reports is whether the TCG JIT is in "one
> -instruction per translated block" mode (which can be set on the
> -command line or via the HMP, but not via QMP). The information remains
> -available via the HMP 'info jit' command.
> -
>   QEMU Machine Protocol (QMP) events
>   ----------------------------------
> 
> diff --git a/docs/user/main.rst b/docs/user/main.rst
> index f478635396..7e7ad07409 100644
> --- a/docs/user/main.rst
> +++ b/docs/user/main.rst
> @@ -98,9 +98,6 @@ Debug options:
>      This slows down emulation a lot, but can be useful in some situations,
>      such as when trying to analyse the logs produced by the ``-d`` option.
> 
> -``-singlestep``
> -   This is a deprecated synonym for the ``-one-insn-per-tb`` option.
> -
>   Environment variables:
> 
>   QEMU_STRACE
> @@ -251,6 +248,3 @@ Debug options:
>      Run the emulation with one guest instruction per translation block.
>      This slows down emulation a lot, but can be useful in some situations,
>      such as when trying to analyse the logs produced by the ``-d`` option.
> -
> -``-singlestep``
> -   This is a deprecated synonym for the ``-one-insn-per-tb`` option.
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index ca05502e0a..08bc99cb85 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -106,25 +106,15 @@
>   #
>   # @running: true if all VCPUs are runnable, false if not runnable
>   #
> -# @singlestep: true if using TCG with one guest instruction per
> -#     translation block
> -#
>   # @status: the virtual machine @RunState
>   #
>   # Features:
>   #
> -# @deprecated: Member 'singlestep' is deprecated (with no
> -#     replacement).
> -#
>   # Since: 0.14
>   #
> -# Notes: @singlestep is enabled on the command line with '-accel
> -#     tcg,one-insn-per-tb=on', or with the HMP 'one-insn-per-tb'
> -#     command.
>   ##
>   { 'struct': 'StatusInfo',
>     'data': {'running': 'bool',
> -           'singlestep': { 'type': 'bool', 'features': [ 'deprecated' ]},
>              'status': 'RunState'} }

Uh, oh, that's a bigger change already ... can we safely remove the field 
here without upsetting 3rd party apps that rely on this interface?
Anyway, I withdraw my patch for -singlestep ... this should be handled by 
someone who's more familiar with these pieces of the code.

  Thomas


