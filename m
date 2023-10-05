Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8617B9C9D
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 12:50:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoLvS-0002vJ-Gr; Thu, 05 Oct 2023 06:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoLvH-0002sy-7h
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 06:49:39 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoLv1-0002uX-Ju
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 06:49:37 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-77410032cedso52860985a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 03:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696502962; x=1697107762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nvhoarw2s5D8qnjSofXdRvDUGt9cIisJAOgZV+77eVY=;
 b=cFhf+Ow/5GafHkZXkmM2talUUq4xDotRuZt867X8OvgaBnELX6OUWfJEoMZcN80tqW
 RtTE4iHhNEZMxetybYOcBhBuGhkBDpg06rB2xdLfSv44ANCe+JDSOhLYVZ69EkoactQT
 I01mYeMYzHy7scFyHwDaNIjDJHpwL2AizUkCLKWqvKkG0VQSlLJYYzsVdbAVCB5Be+TN
 PPsOvX2dxn4vyga8yeaLcO8qEi/FrC2MwtWzxbnQA89gAZvorJyHSwhPsa5Wr+LbMm0e
 GhXmlSRbuA7wLRQR8kPDjvgVEl48cXLdklJ1lWpvO6m9xWBD4frQMQYAMKn/dkIso2Oc
 vgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696502962; x=1697107762;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nvhoarw2s5D8qnjSofXdRvDUGt9cIisJAOgZV+77eVY=;
 b=FO0rG6HfpqFMolpEuTePHlnFuwKUmvG3EMb/bbiJfuAz9cJv2PL7Sg9vha2NWe6WfW
 zdcK/DWcKRGR+s5uHqDrzMtZ4hzIc4IDEKZgmCibCPaSnmDrSj1edr3dGL8vQywhl3TF
 UL4FPmMvck1YkoMDw4hZd1WBxrXMknTZ+qkU8M00+YVGXyuaMKtFGj8yH2pATz7mWZ8r
 1cMioEyvhNAwp2eLYOCg6FnRpCthsuznwVRx0/VLTY4qH0WCdu8EzZPHrGpV7dhCkLQP
 tNL9++ruhAUzQolHubiOdo9vzOPMm7VZJnHv02G4Ni+OCmTLaXGNBUOnHq1xUUsBlRQD
 oX/A==
X-Gm-Message-State: AOJu0YxBBOsAhGh6mUsbWRkQ2bpupdxWowxRqbhOd7RBJF80ZB2PcCOk
 BVOjdKOBD8N3hMGTrTNloxXJBg==
X-Google-Smtp-Source: AGHT+IEQ5R26b/Y9NOj0fNTCvg09pi2bvWZZ/UV+E68fzeaa1fHJHbsDcwRlusjGhqTg+JCQAzSPTQ==
X-Received: by 2002:a05:620a:b5b:b0:772:4851:163d with SMTP id
 x27-20020a05620a0b5b00b007724851163dmr4782036qkg.14.1696502962568; 
 Thu, 05 Oct 2023 03:49:22 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 vr3-20020a05620a55a300b007756fe0bb17sm395568qkn.19.2023.10.05.03.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 03:49:22 -0700 (PDT)
Message-ID: <d5a41446-a1f1-62b7-0c18-c1b881012de8@linaro.org>
Date: Thu, 5 Oct 2023 12:49:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 14/16] softmmu/vl: Clean up global variable shadowing
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231004120019.93101-1-philmd@linaro.org>
 <20231004120019.93101-15-philmd@linaro.org> <8734yp8mwy.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <8734yp8mwy.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x731.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/10/23 10:59, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Fix:
>>
>>    softmmu/vl.c:1069:44: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>>    static void parse_display_qapi(const char *optarg)
>>                                               ^
>>    softmmu/vl.c:1224:39: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>>    static void monitor_parse(const char *optarg, const char *mode, bool pretty)
>>                                          ^
>>    softmmu/vl.c:1634:17: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>>        const char *optarg = qdict_get_try_str(qdict, "type");
>>                    ^
>>    softmmu/vl.c:1784:45: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>>    static void object_option_parse(const char *optarg)
>>                                                ^
>>    /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
>>    extern char *optarg;                    /* getopt(3) external variables */
>>                 ^
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> How much we care about the shadowing is unclear, but that doesn't matter
> if the patches make sense even if we pretend global @optarg doesn't
> exist.  Let's check that.
> 
>> ---
>>   softmmu/vl.c | 26 +++++++++++++-------------
>>   1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> index 98e071e63b..ae1ff9887d 100644
>> --- a/softmmu/vl.c
>> +++ b/softmmu/vl.c
>> @@ -1066,12 +1066,12 @@ static void select_vgahw(const MachineClass *machine_class, const char *p)
>>       }
>>   }
>>   
>> -static void parse_display_qapi(const char *optarg)
>> +static void parse_display_qapi(const char *optstr)
>>   {
>>       DisplayOptions *opts;
>>       Visitor *v;
>>   
>> -    v = qobject_input_visitor_new_str(optarg, "type", &error_fatal);
>> +    v = qobject_input_visitor_new_str(optstr, "type", &error_fatal);
>>   
>>       visit_type_DisplayOptions(v, NULL, &opts, &error_fatal);
>>       QAPI_CLONE_MEMBERS(DisplayOptions, &dpy, opts);
> 
> The actual argument is a string that is either JSON or KEY=VALUE,...
> The fact that it's always an option argument now (actually the value of
> global @optarg) is irrelevant here.
> 
> parse_display_qapi() passes its parameter to
> qobject_input_visitor_new_str() parameter @str, which passes it to
> qobject_from_json() parameter @string if JSON, or else to keyval_parse()
> parameter @params.
> 
> I'd rename @optarg to @str here, like you do in the next hunk, to not
> suggest a connection to CLI.  Not a demand.

OK.


>> -static void object_option_parse(const char *optarg)
>> +static void object_option_parse(const char *optstr)
>>   {
>>       QemuOpts *opts;
>>       const char *type;
>>       Visitor *v;
>>   
>> -    if (optarg[0] == '{') {
>> -        QObject *obj = qobject_from_json(optarg, &error_fatal);
>> +    if (optstr[0] == '{') {
>> +        QObject *obj = qobject_from_json(optstr, &error_fatal);
>>   
>>           v = qobject_input_visitor_new(obj);
>>           qobject_unref(obj);
>>       } else {
>>           opts = qemu_opts_parse_noisily(qemu_find_opts("object"),
>> -                                       optarg, true);
>> +                                       optstr, true);
>>           if (!opts) {
>>               exit(1);
>>           }
> 
> Same argument as for parse_display_qapi(), and same suggestion.
> 
> If this goes though my tree, I can implement my two suggestions, if you
> agree.

Sure, thank you!

> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 


