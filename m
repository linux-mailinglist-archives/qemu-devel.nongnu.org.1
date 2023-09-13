Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 825A979ED7C
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 17:42:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgRys-0000WW-D8; Wed, 13 Sep 2023 11:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgRyn-0000Tk-3h
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgRyj-0006Xi-Cr
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694619631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7wQZgsRotTzKuf4fRL9l80Nh9mocniKKPjhGczoG0v0=;
 b=Wf89hgCoUmkrwZSXFxcM4R7hcEObePmmSV3N70uXT83gg7Mxi9UoXmvhXAtJAhj3QsZ11R
 ujyNoLDwZjDxjhp5igoQGViUONTDSIDoIr3xyM6KmwEmE7//AYfaK52i1TC9vgyLasHdjX
 S51ftVLED2hYTIqHSR+b7QK5kSBQDC4=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-w3WsatUdMQqkSc3KjBrxeg-1; Wed, 13 Sep 2023 11:40:30 -0400
X-MC-Unique: w3WsatUdMQqkSc3KjBrxeg-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7a28090eb26so1046241.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 08:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694619629; x=1695224429;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7wQZgsRotTzKuf4fRL9l80Nh9mocniKKPjhGczoG0v0=;
 b=lZyV79xf9gFLQ0bvgVBf/7lmkKvCZIPZjKDg+ZF1njEpEYiyXrfpdlil+xkQ2x2Fqp
 49ab53A14qhyS1TXpV9ekDmSxsfqxKc02Sg096/fqV/xQKt+kenwAaOz+8qCAD4YXG4p
 vWvoP8XLfaOKN64wzthJXHO1dpS/956Zs5lCCBvujYJp40A/0fBhjzS9dKMRarRzy9oe
 smhnLDuKAL1JCUybJf3fIXtc/CFwwo4fAJRBMptNesH8xW+nT38Ur3g1ZI1UlxqffO0K
 G9YmgG8w1lO2nRKK7Dd4K5XD+R91t1bMSZ6OXI/uGbWFarXE59K+o7UvrFZn0LIJOMsZ
 Td7w==
X-Gm-Message-State: AOJu0YxwoaV6kq9uMi6MSkIKWteNmI8uMBAj9DJDOneqNP7udjTyNMvq
 dO+ZNBRP1i7HWgMJS0W+EiwdVXAOc9SunzWz8HVvVTDLK2RFVkttcEzxNYDRoHDBj77I0PHIwWl
 yxy/A04lpX2U7iNk=
X-Received: by 2002:a67:f352:0:b0:44d:40b1:926d with SMTP id
 p18-20020a67f352000000b0044d40b1926dmr2447764vsm.32.1694619629531; 
 Wed, 13 Sep 2023 08:40:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuArVPWTp0tjBQxScSbJZ0Obhy+geuhKy2oCRGC+tNSII4zpHcb70pkekkkEjncCqRQuDJfQ==
X-Received: by 2002:a67:f352:0:b0:44d:40b1:926d with SMTP id
 p18-20020a67f352000000b0044d40b1926dmr2447750vsm.32.1694619629284; 
 Wed, 13 Sep 2023 08:40:29 -0700 (PDT)
Received: from [192.168.0.2] (ip-109-43-179-28.web.vodafone.de.
 [109.43.179.28]) by smtp.gmail.com with ESMTPSA id
 kr14-20020a0562142b8e00b0064f5174bc84sm3826587qvb.20.2023.09.13.08.40.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 08:40:29 -0700 (PDT)
Message-ID: <03ed6dda-d80a-c0eb-595b-ce6a87d4df91@redhat.com>
Date: Wed, 13 Sep 2023 17:40:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Did Avocado assets hashing system changed?
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: avocado-devel@redhat.com, Cleber Rosa <crosa@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <4169f3e6-96b8-81af-ef09-35629b34caa7@linaro.org>
 <ZQHTR9UIdViemD2k@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <ZQHTR9UIdViemD2k@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 13/09/2023 17.20, Daniel P. Berrangé wrote:
> On Wed, Sep 13, 2023 at 04:17:24PM +0200, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> We are trying to figure out why old assets saved in our Avocado
>> cache (which we populate in our various CI jobs) isn't used
>> anymore.
>>
>> Trying to reproduce locally, I see for example:
>>
>> 2023-09-13 14:39:18,834 test             L0520 INFO | START
>> 14-tests/avocado/machine_mips_malta.py:MaltaMachine.test_mipsel_malta_yamon
>> 2023-09-13 14:39:18,834 test             L0205 DEBUG| DATA
>> (filename=output.expected) => NOT FOUND (data sources: variant, test, file)
>> 2023-09-13 14:39:18,861 asset            L0339 INFO | Asset not in cache,
>> fetching it.
>> 2023-09-13 14:39:18,862 download         L0067 INFO | Fetching
>> http://www.imgtec.com/tools/mips-tools/downloads/yamon/yamon-bin-02.22.zip
>> -> /home/philippe.mathieu-daude/avocado/data/cache/by_location/70c32932b7794b6b37a5040a8808ac943699b944/yamon-bin-02.22.zip.csi3gk2v
>> 2023-09-13 14:39:18,940 asset            L0144 INFO | Temporary asset file
>> unavailable due to failed download attempt.
>> 2023-09-13 14:39:18,940 asset            L0378 ERROR| HTTPError: HTTP Error
>> 403: Forbidden
>>
>> I remember this test used to pass last year, so checking the file I
>> can see:
>>
>> $ find ~/avocado/data/ -name yamon-bin-02.22.zip\* -ls
>>    1489611   6629 -rw-r--r--   1 philmd primary   6776580 Dec 30  2022 /home/philmd/avocado/data/cache/by_location/c1961386ba52f06c6005b48cd32195a371152769/yamon-bin-02.22.zip
>>    1489613      1 -rw-r--r--   1 philmd primary        46 Dec 30  2022 /home/philmd/avocado/data/cache/by_location/c1961386ba52f06c6005b48cd32195a371152769/yamon-bin-02.22.zip-CHECKSUM
>>
>> But the hash is different... Looking at QEMU git history we haven't
>> changed the URL in tests/avocado/machine_mips_malta.py, so I wonder,
>> did Avocado changed its asset hashing during the last year?
> 
> How can it have changed when we've been pinned to avocado 88.1 for
> ages now, not consuming new versions ?

We've temporarily switched to version 101 some months ago, see commit 
ec5ffa0056389c3c.

  Thomas


