Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B1F82EC11
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 10:47:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPg25-00023p-E5; Tue, 16 Jan 2024 04:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPg1s-00020g-Tf
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 04:46:44 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPg1p-0003aW-Ep
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 04:46:44 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50e6ee8e911so11427393e87.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 01:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705398399; x=1706003199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aaCxHgpTz0zNjg821GaqEfG0bWMsLcZrke1pFcKjoqI=;
 b=If5xxEzFk8Hc1WwPaWF2I+oGMuTIgDsh5YGBItcbMBPvsxS3Xq5/+7GwwYVxrlGaJN
 0dPjZCL1Vc1ztETJ7mvcuZmfEsaT+XoBRGG1tiis38EmSsrRPCv/8Uq9kqvUyGI74emz
 r6+0JCdAkz6NbX9vijOo93NFu7Re6liFYlvTyEEJHijGzPX8eKCfqWSRAp7Fk+pF6IcQ
 i61WtwiNme39ztGz4v5pLVQNIOi18C8FWgZFJ0rbFr0gOeZ1vQm55TIVpMH+7OCh+vqi
 eJzaXyfERZui3RtB4U81Pzw6MXlHT7ZCYDcllOLLgmuJwU/YiJmvuPsqAdYsazX3+wdI
 6vCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705398399; x=1706003199;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aaCxHgpTz0zNjg821GaqEfG0bWMsLcZrke1pFcKjoqI=;
 b=kDbe35VWtUXeAG8InZuekGfTqoMz1AHQNnEd/m8RlPR1/2v0x/ZEJA4FqR2mke81B8
 VUpHrZmngxIe7/FwZzVlKk66tEjNwnm9H9pbc7IP1usvxNOEAYjB9gKIbLt65Nu0Pa33
 WpHDQsaSheMUv1rWVDCB8D3HKJTpPanAYN+zMXRRO+OVUbsSO4HK6RuB0s+UsOJtCSSu
 bhmc+hkcylwFKPC8GaRP+iMoBJxbvH9rqK30+NeWTVxBniX6m2+supk73XtpRdRi303l
 ngTJg3EP90dgW7xqmpwNcTticNkYmkzHDinpCsgYH8Rx3CX1+4aiZRZu78xtSI8cKEx5
 1KLg==
X-Gm-Message-State: AOJu0Yw0bekYkjlFNGFw7j+RRUxerY4mi2Aq45cV3L4V7Jh0+JMB8yxn
 6Fi57QkxwRQ4q8HJu14DGI7I5dQPxbLy3g==
X-Google-Smtp-Source: AGHT+IGMhpjc3wCc/MAUE/XSKyFq0nioO/yeMemjSQKd/CDLXtWdHp784sOdcXll3Bm6JINqAle8Jw==
X-Received: by 2002:a05:6512:224c:b0:50e:b2cf:4e20 with SMTP id
 i12-20020a056512224c00b0050eb2cf4e20mr3562031lfu.24.1705398399260; 
 Tue, 16 Jan 2024 01:46:39 -0800 (PST)
Received: from [192.168.69.100] ([176.187.209.30])
 by smtp.gmail.com with ESMTPSA id
 f19-20020a056402005300b00554af5ec62asm6555145edu.8.2024.01.16.01.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 01:46:38 -0800 (PST)
Message-ID: <7ac1ae78-dca4-4fda-a5e9-32b3a332f80e@linaro.org>
Date: Tue, 16 Jan 2024 10:46:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] qemu-options: Remove the deprecated -singlestep option
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20240112100059.965041-1-thuth@redhat.com>
 <20240112100059.965041-6-thuth@redhat.com>
 <7f24e391-e3ba-462c-ba30-2ea7ddb62795@linaro.org>
 <fdbe4b2d-b63a-4fcd-9747-08d713e17d22@redhat.com>
 <CAFEAcA-9EnvXKcrECsAKCMHPobLch4mKU0Yvb2+ZKALcFSiqaQ@mail.gmail.com>
 <ZaV0QxdfQJDnICdF@redhat.com> <87y1cp94j9.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87y1cp94j9.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 16/1/24 07:27, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Mon, Jan 15, 2024 at 05:39:19PM +0000, Peter Maydell wrote:
>>> On Mon, 15 Jan 2024 at 13:54, Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>> On 12/01/2024 16.39, Philippe Mathieu-Daudé wrote:
>>>>> Hi Thomas
>>>>>
>>>>> +Laurent & Peter
>>>>>
>>>>> On 12/1/24 11:00, Thomas Huth wrote:
>>>>>> It's been marked as deprecated since QEMU 8.1, so it should be fine
>>>>>> to remove this now.
>>>>>>
>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>
>>>>> StatusInfo::singlestep was deprecated at the same time,
>>>>> can we remove it?
>>>>>
>>>>> IOW could we complete your patch with this?
>>>
>>>>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>>>>> index ca05502e0a..08bc99cb85 100644
>>>>> --- a/qapi/run-state.json
>>>>> +++ b/qapi/run-state.json
>>>>> @@ -106,25 +106,15 @@
>>>>>   #
>>>>>   # @running: true if all VCPUs are runnable, false if not runnable
>>>>>   #
>>>>> -# @singlestep: true if using TCG with one guest instruction per
>>>>> -#     translation block
>>>>> -#
>>>>>   # @status: the virtual machine @RunState
>>>>>   #
>>>>>   # Features:
>>>>>   #
>>>>> -# @deprecated: Member 'singlestep' is deprecated (with no
>>>>> -#     replacement).
>>>>> -#
>>>>>   # Since: 0.14
>>>>>   #
>>>>> -# Notes: @singlestep is enabled on the command line with '-accel
>>>>> -#     tcg,one-insn-per-tb=on', or with the HMP 'one-insn-per-tb'
>>>>> -#     command.
>>>>>   ##
>>>>>   { 'struct': 'StatusInfo',
>>>>>     'data': {'running': 'bool',
>>>>> -           'singlestep': { 'type': 'bool', 'features': [ 'deprecated' ]},
>>>>>              'status': 'RunState'} }
>>>>
>>>> Uh, oh, that's a bigger change already ... can we safely remove the field
>>>> here without upsetting 3rd party apps that rely on this interface?
>>>
>>> That was the whole point of marking it 'deprecated' in the JSON,
>>> I thought? We don't think anybody's using it, we've given fair
>>> warning, isn't the next step "remove it"? Markus, you're the
>>> expert on QAPI deprecations...
>>
>> Yes, it is fine to delete it without thinking further about possible usage,
>> unless someone steps forward quickly with new information that wasn't known
>> when the deprecation was added....
> 
> Concur.

Thanks all for the feedback.

Thomas, are you OK to post a v2 with the changes I suggested
or do you want me to do it?

> Supporting data:
> 
> commit 34c18203d472c5bf969ebd87dc06c7c3a957efc4
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Mon Apr 17 17:40:41 2023 +0100
> 
>      qmp: Deprecate 'singlestep' member of StatusInfo
>      
>      The 'singlestep' member of StatusInfo has never done what the QMP
>      documentation claims it does.  What it actually reports is whether
>      TCG is working in "one guest instruction per translation block" mode.
>      
>      We no longer need this field for the HMP 'info status' command, as
>      we've moved that information to 'info jit'.  It seems unlikely that
>      anybody is monitoring the state of this obscure TCG setting via QMP,
>      especially since QMP provides no means for changing the setting.  So
>      simply deprecate the field, without providing any replacement.
>      
>      Until we do eventually delete the member, correct the misstatements
>      in the QAPI documentation about it.
>      
>      If we do find that there are users for this, then the most likely way
>      we would provide replacement access to the information would be to
>      put the accelerator QOM object at a well-known path such as
>      /machine/accel, which could then be used with the existing qom-set
>      and qom-get commands.
>      
>      Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>      Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>      Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>      Reviewed-by: Markus Armbruster <armbru@redhat.com>
>      Message-id: 20230417164041.684562-11-peter.maydell@linaro.org
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 6f5e689aa4..d5eda0f566 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -199,6 +199,20 @@ accepted incorrect commands will return an error. Users should make sure that
>   all arguments passed to ``device_add`` are consistent with the documented
>   property types.
>   
> +``StatusInfo`` member ``singlestep`` (since 8.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``singlestep`` member of the ``StatusInfo`` returned from the
> +``query-status`` command is deprecated. This member has a confusing
> +name and it never did what the documentation claimed or what its name
> +suggests. We do not believe that anybody is actually using the
> +information provided in this member.
> +
> +The information it reports is whether the TCG JIT is in "one
> +instruction per translated block" mode (which can be set on the
> +command line or via the HMP, but not via QMP). The information remains
> +available via the HMP 'info jit' command.
> +
> [...]
> 


