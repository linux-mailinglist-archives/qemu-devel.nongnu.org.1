Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD9579295E
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 18:52:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdZGE-00018N-FN; Tue, 05 Sep 2023 12:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdZGC-00017I-D5
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:50:40 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdZGA-0003x9-4d
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:50:40 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50091b91a83so4540399e87.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693932636; x=1694537436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xyx8dhvICNG2imFMfltLdNZeGf7fNxfpF2tddSVvQxY=;
 b=BDdbOZYL8fDyqLQAO7JjfwI2rWxi2D0403MRfGAfpJcQGVQR/HRwZXfoXQfB3odiqe
 8VqnX2mlv5b0YnjhwabsYdC9nTTc3CxMN0zcX040+v3icxZ8hH6lf6ep2RQLqrQZV8as
 l4Y1xWc3lsn9+OkkC3CS3/NEtJOoYOJsxPgSNbQpSG/1htrZ7a+7fb4tgHqst8+6O/OD
 yoDTI6+GKjuTejQPFHpwoBZmcM3+pOpqvKZXgR7E7hbwPV3Gl0Wu3766fIn20JZFisY/
 T7uLcqtpU+lAB0v/CiHh63o5eXlxZ0y8owug04H1NmLUWP6Rkw8m6Y87TRcxYcTjNRJI
 IyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693932636; x=1694537436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xyx8dhvICNG2imFMfltLdNZeGf7fNxfpF2tddSVvQxY=;
 b=TpIUwwcDFJAE2oK8osZbifIFCxPATfBzoO6Y1u+g041p0GlrkGroVJ7lRo7WmTdHC6
 mSbFjFtoxYhacdsKR5OmtbxRHGZY7S1Y1JCIN4dcVz9uO3q7NbbG59SUWLIvTc3RRabA
 VsgHUEH33VkjcggJHSvYq1LmLMBBr17vBD6cHp285VWfdG2jv7j6pYQi3sidGdgmS2zL
 VQUHnOejjHR7CfkRniHwdMUm+u89Z+BQ63moqB99bIbsSf6qZTV7jZkQD0xf+hUtlugg
 G06T4fGiv4Ez3wilP9oTj6cmkXXUE4geT0bER2pg9jhLAZz5YaGocVOxFsOKDnSQV3T4
 H7JQ==
X-Gm-Message-State: AOJu0Yzb3JjcbjhAk/PVw51txA0YtnbhlCco+jTEkXtlvXpLMrK2ZMKw
 LwXZ82gs5EbuDdhOcqoaYvRvpg==
X-Google-Smtp-Source: AGHT+IE3mk4kxaYoB6C5+A2wFg/NUmj5GY00RFF/eZsLoon08eBX7sscIRJGIJ4/JF77nfEXCuKTyg==
X-Received: by 2002:a05:6512:2393:b0:500:b5db:990b with SMTP id
 c19-20020a056512239300b00500b5db990bmr317967lfv.47.1693932636380; 
 Tue, 05 Sep 2023 09:50:36 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 p5-20020a7bcc85000000b003fe1a96845bsm20670457wma.2.2023.09.05.09.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 09:50:36 -0700 (PDT)
Message-ID: <ba47753d-2b9f-4ef9-d715-7624a4be5172@linaro.org>
Date: Tue, 5 Sep 2023 18:50:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] iothread: Set the GSource "name" field
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <20230904144811.4218-1-farosas@suse.de> <ZPdNCkLk4icmtxf0@x1n>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZPdNCkLk4icmtxf0@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 5/9/23 17:45, Peter Xu wrote:
> On Mon, Sep 04, 2023 at 11:48:11AM -0300, Fabiano Rosas wrote:
>> @@ -189,11 +193,14 @@ static void iothread_init(EventLoopBase *base, Error **errp)
>>           return;
>>       }
>>   
>> +    thread_name = g_strdup_printf("IO %s",
>> +                        object_get_canonical_path_component(OBJECT(base)));
>> +
>>       /*
>>        * Init one GMainContext for the iothread unconditionally, even if
>>        * it's not used
>>        */
>> -    iothread_init_gcontext(iothread);
>> +    iothread_init_gcontext(iothread, thread_name);
>>   
>>       iothread_set_aio_context_params(base, &local_error);
>>       if (local_error) {
> 
> I think thread_name might be leaked if error here.  Thanks,

Oops, good catch. Better switch to g_autofree.

