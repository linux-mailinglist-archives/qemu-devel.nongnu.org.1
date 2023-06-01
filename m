Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B87C719689
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:13:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4eMB-00019I-Ip; Thu, 01 Jun 2023 05:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4eMA-00017r-0O
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:12:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4eM8-0003DB-FI
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685610746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kbnLurNJsGrPihHXy53s0qeIDJdmg1VMPiEt1Ty6FsY=;
 b=cH9Mj40Wxo24vxgq5prc77ESnreZuSOAy7tulklYqOB88DjXzH/QCOMXT7+HJvSZMhAPyV
 zSbIi7w/B6p1++NNW8ZamzeSKiYJ0JNc3Yr3fcEqBlACza2Xhf8ShMbd4N6SwLuQ/Cv0ge
 RwAmUDAzrHl37hD+BsaM+LL1c2IwIWs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-XCO2wUZBMCCIAdLSoaESWA-1; Thu, 01 Jun 2023 05:12:25 -0400
X-MC-Unique: XCO2wUZBMCCIAdLSoaESWA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b1a4ab96b6so2417971fa.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685610744; x=1688202744;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kbnLurNJsGrPihHXy53s0qeIDJdmg1VMPiEt1Ty6FsY=;
 b=NY+HHRRop030xmy4+7xp/DJzXWtuUc0TsBpqObrgKDiiYvWJB31HxldCqbqcb4+0mG
 FWkys0AQdX/zSwtbggCFPSjb3Yey9LCCcl6eb1MUqnQA1qlWejJEqXk53A5h1alcPXyv
 8DIVjex62PmsRleHBtrMwSMs85yh44rQTEPiIRX3VJvFXMSAezd54kvYBSPoWb+rVE9G
 3RPQc3Xua6EHR+X6j9a4nV+GdxaxWLLivv3K2xtfF5wxLzoGITXFRSaBbOgb5tkokFZM
 T1KGd8/XXxIQ9ydVVorFuWJQH+NNXQkP/+nYL6PWJqKAPyUWOk4xc6+0nhr8FqMe8une
 aKIg==
X-Gm-Message-State: AC+VfDy4bh76n0/Xtbp+fYKl4S2NGShBtQfjAnYCrSGZBMQPUR0Iu7ka
 6sQV3rM9RzKe9sBcZTBobMz/mbmvYHhjyPbcAIoKv2WC8YaTBS3HqqRqz4U1nTmeTcCKjWEV919
 QMOWOZ/umQu6c3fW0eeL2ySA=
X-Received: by 2002:a2e:3a04:0:b0:2b0:790e:95ab with SMTP id
 h4-20020a2e3a04000000b002b0790e95abmr4105478lja.31.1685610743981; 
 Thu, 01 Jun 2023 02:12:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ452LDBrH4ZMUxPhf06cLBD9VRrnDkek+5nhW6lb9NEF0VsCLDNvYQwBn+qcm7tWwL8TPfgLA==
X-Received: by 2002:a2e:3a04:0:b0:2b0:790e:95ab with SMTP id
 h4-20020a2e3a04000000b002b0790e95abmr4105466lja.31.1685610743682; 
 Thu, 01 Jun 2023 02:12:23 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-86.web.vodafone.de.
 [109.43.178.86]) by smtp.gmail.com with ESMTPSA id
 bg22-20020a05600c3c9600b003f4283f5c1bsm8372844wmb.2.2023.06.01.02.12.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 02:12:22 -0700 (PDT)
Message-ID: <ae3fd7f8-863d-5a78-8483-0ccd2ffe511d@redhat.com>
Date: Thu, 1 Jun 2023 11:12:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] docs: build-system: rename "default-configs" to
 "configs"
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20230523133117.2278587-1-kchamart@redhat.com>
 <740eaa77-a217-8272-2eb3-51df11764447@redhat.com> <ZHhUBHCHnx+2fNG+@pinwheel>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <ZHhUBHCHnx+2fNG+@pinwheel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 01/06/2023 10.17, Kashyap Chamarthy wrote:
> On Wed, May 31, 2023 at 04:22:34PM +0200, Thomas Huth wrote:
>> On 23/05/2023 15.31, Kashyap Chamarthy wrote:
>>> Commit 812b31d3f9 (configs: rename default-configs to configs and
>>> reorganise, 2021-07-07) did the rename.
>>>
>>> Reflect that update also in the documentation.
>>>
>>> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
>>> ---
>>>    docs/devel/build-system.rst | 12 +++++------
>>>    docs/devel/kconfig.rst      | 40 ++++++++++++++++++++-----------------
>>>    2 files changed, 28 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
>>> index 1894721743..20ebcc9ac6 100644
>>> --- a/docs/devel/build-system.rst
>>> +++ b/docs/devel/build-system.rst
>> ...
>>> @@ -457,7 +457,7 @@ Built by Meson:
>>>      TARGET-NAME is again the name of a system or userspace emulator. The
>>>      config-devices.mak file is automatically generated by make using the
>>>      scripts/make_device_config.sh program, feeding it the
>>> -  default-configs/$TARGET-NAME file as input.
>>> +  configs/$TARGET-NAME file as input.
>>
>> This hunk does not apply anymore - but I think it can simply be dropped now.
> 
> Just for my own clarity, which precise part do you suggest to be
> dropped?

The above line seems to be gone, so it does not need fixing anymore, I 
think. You'll see it when you rebase your patch.

  Thomas



