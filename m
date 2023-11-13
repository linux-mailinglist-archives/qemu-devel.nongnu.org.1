Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3307E96CC
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 07:55:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2QpU-0001dt-8h; Mon, 13 Nov 2023 01:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2QpQ-0001df-Na
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 01:53:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2QpO-0003ie-IV
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 01:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699858424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZHYpzn/aVyRpljqOeyZm8kfFjRqrlWb5TALmQ8TjviY=;
 b=cZ7pM80UAIoLk6VmgX9Tqqw3sHfO6sG3TYXm+/cqA4NFJx+pMhWZCkrmhY1A7tKZX9+M1r
 /l/CkHeohH/5RzyeP44IzvHWsAY7qcq4E7YrZi6ISVdeul9OADilGazkmy5ymEGxypVUID
 Bn01+pYgKGOfuWOHioIT6zNEQee+xSQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-07cShf_4OSe9FPVh4u6tMw-1; Mon, 13 Nov 2023 01:53:42 -0500
X-MC-Unique: 07cShf_4OSe9FPVh4u6tMw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41e58a33efaso51140781cf.2
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 22:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699858421; x=1700463221;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZHYpzn/aVyRpljqOeyZm8kfFjRqrlWb5TALmQ8TjviY=;
 b=Q10rLkNaE73lEgGqqdJsQsiYDpKEcDUXAca509CUAOT5ELq3TMRu9Je3mHn23vBKUK
 h1kvXoRdSmNgLZKWGgw8zGALRBFt0/RBoAMrvvVwJ/266mR4NxD8P7iyJzGgyA2JPYYn
 +Mssg9iV1HSID3BZz+eCCW46tW2PntAl0PJBMONYzRR6c27rV7THe24l0vvldQHQHw8o
 3ZNVLvv6PxmaCQcmC3+0vtUKynroCuQxzl7CQDoPDYel2FPuh6DXp1EW40KHbpjho6Zs
 1cKWQGzCnoD5ykQQCyL9Z+5xQ1plQlB+INxvmymossuIYGiobXgeUdx9kFHmPev39OYa
 9gRA==
X-Gm-Message-State: AOJu0YzybqfMnbzzwZ/CJggwoHf4ULZ0DHXoDHpxSQAATHH4d2gMoWhD
 QrhRugSgs8VESPnqkYbCFMSixyoX3rFB68vnTjvtbap/8trlrURcm5t6+O95zoux1mBXAl0JOYw
 CTrcBdAY3elIemJ0=
X-Received: by 2002:a05:622a:1355:b0:3fd:dab5:9430 with SMTP id
 w21-20020a05622a135500b003fddab59430mr8225558qtk.16.1699858421557; 
 Sun, 12 Nov 2023 22:53:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZxwsa/n2GUZ/5wkUIcaSHdbnmAiHnRVRX1coDfwONpUz+3MV6hbVsVg7/NcLSe9PwKG0laQ==
X-Received: by 2002:a05:622a:1355:b0:3fd:dab5:9430 with SMTP id
 w21-20020a05622a135500b003fddab59430mr8225547qtk.16.1699858421326; 
 Sun, 12 Nov 2023 22:53:41 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-177-79.web.vodafone.de.
 [109.43.177.79]) by smtp.gmail.com with ESMTPSA id
 q1-20020ac87341000000b0041e211c5d0bsm1731996qtp.6.2023.11.12.22.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Nov 2023 22:53:41 -0800 (PST)
Message-ID: <90658733-23ab-4227-9639-9b378b062556@redhat.com>
Date: Mon, 13 Nov 2023 07:53:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-8.2] .gitlab-ci.d/cirrus.yml: Promote NetBSD job
 as gating
Content-Language: en-US
To: Reinoud Zandijk <reinoud@gorilla.13thmonkey.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Beraldo Leal <bleal@redhat.com>
References: <20231109153510.92353-1-philmd@linaro.org>
 <737f6fe5-cf3e-4fdd-b5d8-28f71a2fa9e6@linaro.org>
 <ZU0PuHyw8X8e/p0j@redhat.com>
 <52df2072-a26e-4e73-afe0-65a877bafbdc@redhat.com>
 <ZU6cxnwMOqOEBu-F@gorilla.13thmonkey.org>
 <ZU-65RIut9TWbx_F@gorilla.13thmonkey.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZU-65RIut9TWbx_F@gorilla.13thmonkey.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/11/2023 18.33, Reinoud Zandijk wrote:
> On Fri, Nov 10, 2023 at 10:12:38PM +0100, Reinoud Zandijk wrote:
>> On Thu, Nov 09, 2023 at 06:15:51PM +0100, Thomas Huth wrote:
>>> On 09/11/2023 17.58, Daniel P. Berrangé wrote:
>>>> On Thu, Nov 09, 2023 at 04:35:56PM +0100, Philippe Mathieu-Daudé wrote:
> ...
>>> You're right, Daniel. Seems like both, the Cirrus netbsd and the openbsd job
>>> are currently broken and only output some help text instead of compiling
>>> QEMU:
>>>
>>>   https://gitlab.com/philmd/qemu/-/jobs/5497861511#L6834
>>>
>>> ... that's why the finish so fast.
>>>
>>> IIRC last time I've seen them "working", they were running into the 80
>>> minute timeout again.
>>>
>>> So the netbsd and openbsd job are indeed not very useful anymore. I think we
>>> should rather remove them and add a proper job via our own custom
>>> KVM-capable runners instead.
>>
>> Even though I am a co-maintainer of the NetBSD support for Qemu I am not quite
>> sure what testcase this is. Is this a regression test of installing NetBSD
>> from an ISO? That somehow times out? Where can I find the resulting console
>> output? Maybe the installer changed?
> 
> Re-reading the thread its about compiling Qemu on NetBSD. Doh. I am a novice
> to the test kit you use so please forgive me if I don't make sense. Am I right
> that it does install NetBSD OK, it then comes up and then tries to compile
> Qemu on it but it fails due to some Python errors in the test script? Does it
> use NetBSDs pkgsrc with its patches or has it its own method of dealing with
> them?

No worries, the "make vm-build-netbsd" test itself is just working fine 
(after applying Philippe's fix from here: 
https://lore.kernel.org/qemu-devel/20231109150900.91186-1-philmd@linaro.org/ ).

This thread here is about the CI job that could run in the gitlab-CI... it's 
got a quite complicated setup - NetBSD is running as KVM guest on a runner 
on cirrus-ci.com, and that whole thing is triggered by a gitlab-CI job - so 
this setup is often broken and thus does not run by default in the CI.
That's why I suggested to remove the job and replace it by a job that 
directly runs in a KVM-capable runner on the gitlab-CI instead of taking the 
detour via cirrus-ci.com.

  Thomas




