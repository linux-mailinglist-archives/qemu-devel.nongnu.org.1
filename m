Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F027763141
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 11:08:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOaUs-0006it-2k; Wed, 26 Jul 2023 05:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qOaUo-0006if-9f
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 05:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qOaUm-0000Oe-NL
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 05:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690362466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ONGKr32sHgsV4ixmVOrm6/xWlBdG7G/wNgkWiOr7ooM=;
 b=Zv7Wc2Fev3KPWgOcaIzgsLXTrVCmrqzWUa7oXP8ZaPNUukU/vYo9YAjLgGjB4xE1V4LVyO
 AgCHVM1a+Cbc47KKoaIGIn0lC8FQfnkeJmdYNtj/lclY23NfKWp78WCDallIBV/vH4iufa
 Viaz7Z0iERjMdKjkSQMQQ4SVnjGx35Q=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-NLlFa21oMQ-ZNzXeXYAQtA-1; Wed, 26 Jul 2023 05:07:45 -0400
X-MC-Unique: NLlFa21oMQ-ZNzXeXYAQtA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fb89482c48so5614952e87.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 02:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690362464; x=1690967264;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ONGKr32sHgsV4ixmVOrm6/xWlBdG7G/wNgkWiOr7ooM=;
 b=BM+Xh3jDGeVIEVNcyFRmuvRrcrvUTKOa5t5mbGtI3L7NRuYvD8wjQ2VlRy9EsFj0zi
 r7qDUd+0PaEWS/XJuIa370cVcBHbEB8iz6aqTdRX81aj2z9ca4CvV8n3035XK2bzvVUE
 +BqprGZFNsE7v8nuzFEyhXxuX5vKU+nO5LBSOCRJnL9Y47nTOxiWAS0qZWzcll/wDNp9
 5+fCnQuXKgA83nUj8DckK47R0wRhoWQ8QuoO472VgowJJSPaNxIrr7c0Xq2QkOTdPE2x
 IG8o+N8+daQwV4x2URuAboy9/cw5GD28C3gi28izqX+N4YpuWQEQWJn3u7zCADXYoUUX
 9Nqw==
X-Gm-Message-State: ABy/qLYeypSX++l8uAK28+KDsa4Rs0frbq55Tph4NifM3tis74x4AvQi
 T5oERKBetW1m2r2O2nK2wblhVF7FKR718Bt9Rfya+7lv9aPKvCDim1cQ6vL7jjNKAyMVH2i8GuT
 tHKMBJKnRUhGlt0U=
X-Received: by 2002:ac2:5bc7:0:b0:4f8:8be4:8a82 with SMTP id
 u7-20020ac25bc7000000b004f88be48a82mr885959lfn.22.1690362463953; 
 Wed, 26 Jul 2023 02:07:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFM2jdeh+Tcmxxm8EwYVyyhvBHyb0wjDf0c9X4fLApZg4rDccZrbuc/rU8gAsAzfCKddw3IOQ==
X-Received: by 2002:ac2:5bc7:0:b0:4f8:8be4:8a82 with SMTP id
 u7-20020ac25bc7000000b004f88be48a82mr885942lfn.22.1690362463577; 
 Wed, 26 Jul 2023 02:07:43 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-0.web.vodafone.de. [109.43.176.0])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a7bcbc6000000b003fb739d27aesm1409528wmi.35.2023.07.26.02.07.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 02:07:42 -0700 (PDT)
Message-ID: <92f09c35-6ccd-5f5f-2176-6bf6c49d61cf@redhat.com>
Date: Wed, 26 Jul 2023 11:07:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: avocado test failing INTERRUPTED for "Missing asset"
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Jan Richter <jarichte@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <CAFEAcA--tJPhQO49W3BDO1MABQFHrr50MU=q54TFYpbkOxVWHw@mail.gmail.com>
 <ad623dea-4ed8-6e06-3c70-60fcf863a79e@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <ad623dea-4ed8-6e06-3c70-60fcf863a79e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 26/07/2023 09.33, Philippe Mathieu-Daudé wrote:
> On 25/7/23 19:13, Peter Maydell wrote:
>> Currently this CI job is failing:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/4737819946
>>
>> because:
>>
>> (05/59) 
>> tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_exynos4210_initrd:
>> INTERRUPTED: Missing asset
>> https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb\nRunner
>> error occurred: Timeout reached\nOriginal status: CANCEL\n{'name':
>> '05-tests/avocado/boot_linux_console... (90.67 s)
>>
>> Why is a "Missing asset" causing a timeout after 90 seconds,
>> rather than being accounted as a "SKIP" ("missing requirements
>> in the test environment" sounds like what we have here) ?
> 
> Maybe something to report to upstream Avocado.

We're back to using Avocado v88.1 in QEMU. We first need someone who can 
update to the latest Avocado release and take care of the remaining 
problems... This is *very* frustrating.

  Thomas


