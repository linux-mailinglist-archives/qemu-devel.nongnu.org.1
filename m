Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0C395B8D2
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Aug 2024 16:45:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh92n-00024j-68; Thu, 22 Aug 2024 10:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sh92l-00023m-Ih
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 10:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sh92j-0001Kw-GW
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 10:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724337842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YWBMDWxoQM7qmoRgoqijFhryUDrUNaT6IIkes2b4PwQ=;
 b=W3KepL9kUuZjq/Pg9o3r+ZwTWjCwH8XPVZsz1ztpPDJE/fOc0DvO/v7SrScH0qmOl0G0Qy
 Y8UJM20NJMRvQ2egPlhq/f8+VmzneoWYPAWJLeezNXzVu1XKRL1ijMgmsCMDXbN2zucV2y
 9HFOZ9R+c3WFaIMqeOXNRLMR59x3UC0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-AfcTDVvUNPuveoYh5jGoCA-1; Thu, 22 Aug 2024 10:44:01 -0400
X-MC-Unique: AfcTDVvUNPuveoYh5jGoCA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a1dbbe6e4cso107915085a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 07:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724337841; x=1724942641;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YWBMDWxoQM7qmoRgoqijFhryUDrUNaT6IIkes2b4PwQ=;
 b=lSs6pvqqcjDvDsWy5V5dA9hXKDZ2tWuK5uPlWuJOMwhICUYPAZCyqIXm6y0yKMsr/A
 MNO3Tw2AYcFdZi5VAkZlTI6vba0r8zlWwTanDYsjOcyXeA1Roo61zDOIyz2uzcpfSrvg
 x+158FYhwHZvxEuqNkECIqZHdLX0e4sOPdEj/K/AHjP9GvnNeLBAHImGlJZ7bifBynfN
 R/XnDZOOJtXZge1ktmuQ00sQdCnkhgi+md58F28fKuIiw5PA/AMnUE39krYw98Onos6o
 zweVqGkdlD5WSTpPeb2L2Z5zNFOb9YdBz7oclwDzRx5VBneAnOLHyjCWvN53kkKJb1f9
 xjlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJUFh+KT/wefJ7lljofIbNCOL3cCcJf+V5I/lWfs2ssIq7eCg+WYS754brgXbzbNnkOn803LrA7EoZ@nongnu.org
X-Gm-Message-State: AOJu0YxJR9uiZAKyG2oon2+50wYx/0OHqZwPAYD8kBvW3YS9KQxHiVId
 b5L/hIABgiQhemL01vkbejZ58GsNQhPQVUeKobV2eUkubadYrJlmp+NKJPdA2AoRIKi2ZLvg1EM
 zj1pf/rf4+dcXlgSvY6pojU/QnXuuhnRW/XvNKv5Hjq7LRbJas2fW
X-Received: by 2002:a05:620a:2445:b0:79f:9fa:8224 with SMTP id
 af79cd13be357-7a680a761b4mr198862685a.36.1724337840820; 
 Thu, 22 Aug 2024 07:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvfW4fRm+BMlhgSUk9bNRxpeP/6vgQO2g+8NoTSfbx2u1PKbKHDfsoblU12FTK5BW08zuqDw==
X-Received: by 2002:a05:620a:2445:b0:79f:9fa:8224 with SMTP id
 af79cd13be357-7a680a761b4mr198860485a.36.1724337840406; 
 Thu, 22 Aug 2024 07:44:00 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-177-41.web.vodafone.de.
 [109.43.177.41]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f3181adsm76255785a.9.2024.08.22.07.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 07:43:59 -0700 (PDT)
Message-ID: <8b2bfe4e-7b67-4ff0-ad9f-e077e03d0018@redhat.com>
Date: Thu, 22 Aug 2024 16:43:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Convert Aarch64 SBSA-Ref avocado
 tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240822114146.86838-1-philmd@linaro.org>
 <d8c744cf-0da1-42fc-92cc-f8bec8ca00e1@linaro.org>
 <b3d054b9-4ede-489c-bca5-b61b046dea50@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <b3d054b9-4ede-489c-bca5-b61b046dea50@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 22/08/2024 16.39, Philippe Mathieu-Daudé wrote:
> On 22/8/24 16:06, Marcin Juszkiewicz wrote:
>> On 22.08.2024 13:41, Philippe Mathieu-Daudé wrote:
>>>   # Timeouts for individual tests that can be slow e.g. with debugging 
>>> enabled
>>>   test_timeouts = {
>>> +  'aarch64_sbsaref' : 180,
>>
>> What kind of machine is able to run those tests in 180s? I bumped them to 
>> 2400s and got timeout (Macbook with M1 Pro).
>>
>> "make check-avocado" (with some AVOCADO_* vars to limit list of tests) 
>> shown me which test is run and pass/fail for each.
>>
>> "make check-functional-aarch64 V=1" shows me "1/4 
>> qemu:func-thorough+func-aarch64-thorough+thorough / 
>> func-aarch64-aarch64_sbsaref" and timeouts without information which tests 
>> pass, which fail.
>>
>> Maybe for QEMU project this is a progress. For me it is moving tests from 
>> working ones to "sorry, timeout, find out why" ones.
> 
> Sorry for the annoyance of switching from one framework to another
> one :/ Are you using Linux on your Macbook with M1 Pro? I'm using
> macOS and these tests currently don't work, so for me this is a
> huge win.
> 
> Most of the (long) time was spent in downloading the assets.
> 
> IIUC there is a way to pre-download without using the test timer
> (apparently Richard and Daniel use it) but I haven't found the way
> yet.

It's done automatically when you run "make check-functional" ... but I think 
it might get skipped if you run "make check-functional-<target>".

Anyway, you can do the precaching manually by running:

  make precache-functional

  HTH,
   Thomas


