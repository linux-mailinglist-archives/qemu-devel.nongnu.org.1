Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFE77B8920
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 20:23:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo6VZ-0006HR-84; Wed, 04 Oct 2023 14:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo6VC-0006BX-4B
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo6V9-00039b-L5
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696443698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yMZabK+EUmiQGRbyfbOPpZy4NtlA8ORXgFUkwvVGiRk=;
 b=Gr3Ugo2Vdjz7m3Qw9XepwpQshjBTTwCyMvzNgBUvv+TSEhcXzPt26TfJqYZyTBZMoAUEKi
 5f3zmik/Xh0RUNPMWxXpaORP4hQ7byecSpXzEn3BAsSZGxvVSt9qevOJphFKZobnp95Why
 rTyJQVLGVEJjSsSLHuvlmml4Zba8xhM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-5XZ0faYdP2K4pk-HtnH8-w-1; Wed, 04 Oct 2023 14:21:35 -0400
X-MC-Unique: 5XZ0faYdP2K4pk-HtnH8-w-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4180de770f5so877241cf.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 11:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696443695; x=1697048495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yMZabK+EUmiQGRbyfbOPpZy4NtlA8ORXgFUkwvVGiRk=;
 b=qUlWOvsaeJEYCmlSPak0bNq4UQpk1D9tv0FXBDh9Acv2yT+8ABNqq4ccOxp0UPsWN9
 go4H8GyKFXegmyiwaIizod7IWPY/M9gmPnBxfyG32qwuKZzCn8893ZN6Oi6FmAHlCP4I
 uPmrSG/LNxIoSlJKMNr5xGKxE9liwQN1zgDqQrIkruhrncpCsZvxL4cNynORt8WpRCYV
 C8AMoavsBNiMn2vXwjvWx60yLMV4bhISRDD4ZGnZA9rIh8SLE3UGB8i/Lbsqqneom/ez
 3EsXxQiABomhv3o8+TZjkINwZvlM6xqrN7JksXPyIG2MF4c9K8463+k+51Q6uGtPh4Pp
 1XRg==
X-Gm-Message-State: AOJu0YzkUnie5RcI5DBWtvt0TA7r/v3X1WJXcP4TeocLUCEY2L5n3jwE
 Kwtl5eNLWkiUaMgdNBePOMKkV7FLli5sqvJn2vqWvgLpDyAGlgOtWpAXnnqwXMEF0FFbvlf/hH9
 q8EA7V7SZsH+eJyA=
X-Received: by 2002:a05:622a:d6:b0:415:21e2:5e38 with SMTP id
 p22-20020a05622a00d600b0041521e25e38mr3506484qtw.39.1696443694790; 
 Wed, 04 Oct 2023 11:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyV3DISmjhKYP95EasQeyOBdkWOU6fD0TQBmjNEl9mM+lhtdP346IcHRZM9sKvWDVqzofkLg==
X-Received: by 2002:a05:622a:d6:b0:415:21e2:5e38 with SMTP id
 p22-20020a05622a00d600b0041521e25e38mr3506470qtw.39.1696443694515; 
 Wed, 04 Oct 2023 11:21:34 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 s24-20020ac87598000000b004181d77e08fsm1381924qtq.85.2023.10.04.11.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 11:21:34 -0700 (PDT)
Message-ID: <a7101304-0296-558b-3730-73adb7b9da3c@redhat.com>
Date: Wed, 4 Oct 2023 20:21:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 1/1] qtest/migration: Support more than one QEMU binary
Content-Language: en-US
To: quintela@redhat.com, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20231003141932.2367-1-farosas@suse.de>
 <20231003141932.2367-2-farosas@suse.de>
 <3dd8e410-982b-3ea6-78aa-08c1ba26f8da@linaro.org>
 <ZRw5Myc/joWb6why@redhat.com> <874jj7u11d.fsf@suse.de>
 <87wmw24vzg.fsf@secure.mitica> <8734yqpedm.fsf@suse.de>
 <ZR2nTmmf8AaUV1g2@redhat.com> <875y3ms1hu.fsf@secure.mitica>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <875y3ms1hu.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 04/10/2023 20.09, Juan Quintela wrote:
> Daniel P. Berrangé <berrange@redhat.com> wrote:
>> On Wed, Oct 04, 2023 at 12:59:49PM -0300, Fabiano Rosas wrote:
>>> Juan Quintela <quintela@redhat.com> writes:
>>>
>>>> Fabiano Rosas <farosas@suse.de> wrote:
>>>>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>>>>
>>>>>> On Tue, Oct 03, 2023 at 05:24:50PM +0200, Philippe Mathieu-Daudé wrote:
>>>> [...]
> 
>>> I'm working on a cleanup of this patch to make it more integrated with
>>> libqtest. If we teach qtest_get_machines() to sometimes refresh the list
>>> of machines then it becomes way less code.
>>>
>>>> I think that it is just easier to pass the machine type we want to test
>>>> to whatever script we have.  Specially where [sane] architectures like
>>>> arm don't have a default machine type (no, I haven't double checked if
>>>> that has changed lately).
>>>
>>> We still need to enforce the same machine type for both binaries and a
>>> sane range of QEMU versions. I think our docs state that we only support
>>> migration from QEMU n->n+1 and vice versa? If the test will know what
>>> combinations are allowed, it could just go ahead and use those.
>>
>> Query the 'pc' (or 'q35' as appropriate) alias on both QEMU versions,
>> to resolve them into versioned machines.
>>
>> Then find which resolved machine version(s) exist in both QEMUs, and
>> prefer the src machine if multiple matches exist.
> 
> We only change Machine Type with each qemu version, so having to change
> it by hand don't look so complicated.
> 
> Let's assume for a moment that "pc" and "q35" machine types don't exist
> (rest of architectures needs to do a similar thing)
> 
> latest qemu has:
> pc-i440fx-8.2        Standard PC (i440FX + PIIX, 1996) (default)
> pc-i440fx-8.1        Standard PC (i440FX + PIIX, 1996) (default)
> pc-i440fx-8.0        Standard PC (i440FX + PIIX, 1996) (default)
> pc-i440fx-7.2        Standard PC (i440FX + PIIX, 1996) (default)
> 
> Previous version one has everything except 8.2
> 
> We want to test:
> 
> (this is what we do now)
> qemu-8.2 -M pc-i440fx-8.2  -> qemu-8.2 -M pc-i440fx-8.2
> 
> And we want to test additionally:
> 
> qemu-8.1 -M pc-i440fx-8.1  -> qemu-8.2 -M pc-i440fx-8.1
> qemu-8.2 -M pc-i440fx-8.1  -> qemu-8.1 -M pc-i440fx-8.1
> 
> And that is it.
> 
> So the thing that we need is a sane way to get qtest_init() to use the
> right machine type without inventing what machine type they want.  Not
> having a default machine type has other advantages, but that is a
> different discussion.

Not sure whether it's useful for you, but have a look at 
qtest_cb_for_every_machine() and qtest_is_old_versioned_machine() ... there 
is already some logic in there to find out the latest machine version, maybe 
you can re-use some of the code in there.

  Thomas


