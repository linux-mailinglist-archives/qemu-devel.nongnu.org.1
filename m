Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0CB964330
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Aug 2024 13:36:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjdR7-0002nB-Ku; Thu, 29 Aug 2024 07:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sjdR4-0002lA-R1
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 07:35:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sjdR2-0003Kv-UE
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 07:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724931328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j1ujaW8DZbgjy6h17GbvOw9MwJIxWCXNp+emv6sJ2zI=;
 b=Yb9C8mZFKM/7GlrS+y/w7cl74GNDBeynSoELNPGrMXnMCRLxNIDNLA/7l4+jl+vm0oM5Z2
 29P2O/VQ1kET7hZths3Wgnxhyo13kHg3ar8GCwAq2JPSp+J3QckdhcZepJzil13MfCXWxF
 oZV2ZSO9EP0FXsNpLo29pi9lqPvyLrc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-ktJnneEHNRip6LxTw3Oeqg-1; Thu, 29 Aug 2024 07:35:25 -0400
X-MC-Unique: ktJnneEHNRip6LxTw3Oeqg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3717ddcae71so429083f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 04:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724931324; x=1725536124;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j1ujaW8DZbgjy6h17GbvOw9MwJIxWCXNp+emv6sJ2zI=;
 b=iLni4A+1BkpVV8qKrIF/brUBRmUVIGYERa8/7VjLuCrlthNkFAq+FtGyvIyGD9wScW
 0R4EZpXDPkufz/fi78XWA9H55clLgor4ANy7z8eeRyZ40L59L2KS2B6SZsJFo2uQZM9p
 fKN/j5c7oiXlh43RUkb7TtvzWjU3esww5gTFGVhnYVVmtTqLENYnJ+cC58mXncg5Xr7X
 LS7AjvoG4gEglQQXCJVg5r8cMJjYonSqx7WsOhqtvyHdvthh63rqp0LypzlKcp3tbi3k
 C7KY4mbjtrXfnLv24a2q1GG+rC80GPtH4vDrU0oob4L/2K4gQiOaYxB4jR0jOvPwqDT4
 bp3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGJOtWOLWp85YCF4tbs1XxKujv1hfbryUl5wHxeMBiw7WIy2MhNfawLcc8kkqEJyI45y0R2Q2//ad4@nongnu.org
X-Gm-Message-State: AOJu0YxE4WHPFzKFK/jv+/X4v/0Y/zp/TO3Xg7SlXh6Fr/bf4y/FdHp7
 rqZJ9/UhHrtc+Gho/UEfIvxyjFvcC7+UULm+o7ChP9UyYMjF8lf5cPPGVL+4HuRw2giO2ez6Ceg
 kGdDayFbYvL596h2xTTsc840QkQdShr2mX9X07MNgD+pQNZxT9m2z
X-Received: by 2002:a05:6000:4d0:b0:371:8e50:2d06 with SMTP id
 ffacd0b85a97d-3749b58123emr1673107f8f.43.1724931324307; 
 Thu, 29 Aug 2024 04:35:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaA74YMvM1yvFuO2AtLOnNAyps1L/HLKZhgZHos7H9vdqzV4MQEt2kKFzrTZnXQ7jZngiB6g==
X-Received: by 2002:a05:6000:4d0:b0:371:8e50:2d06 with SMTP id
 ffacd0b85a97d-3749b58123emr1673076f8f.43.1724931323829; 
 Thu, 29 Aug 2024 04:35:23 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-179-35.web.vodafone.de.
 [109.43.179.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6a10353sm13289255e9.1.2024.08.29.04.35.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 04:35:23 -0700 (PDT)
Message-ID: <37bd851e-4957-443c-9e7a-949ee2eaf3d8@redhat.com>
Date: Thu, 29 Aug 2024 13:35:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 35/35] docs/devel/testing: Add documentation for
 functional tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-36-thuth@redhat.com> <ZtBOvBh-keKVeCni@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZtBOvBh-keKVeCni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 29/08/2024 12.34, Daniel P. Berrangé wrote:
> On Wed, Aug 21, 2024 at 10:27:36AM +0200, Thomas Huth wrote:
>> Document the new functional testing framework. The text is originally
>> based on the Avocado documentation, but heavily modified to match the
>> new framework.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   docs/devel/testing/functional.rst | 269 ++++++++++++++++++++++++++++++
>>   docs/devel/testing/index.rst      |   1 +
>>   docs/devel/testing/main.rst       |  12 ++
>>   3 files changed, 282 insertions(+)
>>   create mode 100644 docs/devel/testing/functional.rst
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
>> +The tests should be written in the style of the Python `unittest`_
>> +framework, using stdio for the TAP protocol. The folder
>> +``tests/functional/qemu_test`` provides classes (e.g. the ``QemuBaseTest``
>> +and the ``QemuSystemTest`` classes) and utility functions that help
>> +to get your test into the right shape.
> 
> One gotcha when using TAP protocol is that you can't just spew
> debug info to stdout/stderr. Each line of debug info needs to
> be prefixed with '#' so it is interpreted as diagnostic output.

Actually, that's the great thing about pycotap (in comparison to other 
Python TAP implementations that I've seen), it helps you to get this right: 
By instantiating the TAPTestRunner like this:

     tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
                                test_output_log = pycotap.LogMode.LogToError)

The stdio output gets redirected to stderr. And the meson test runner is 
fine by collecting the error messages from stderr and showing them to the 
user in the right way in case the test failed (and puts them into the log 
file if the test succeeded).

But yes, the doc text is a little bit sparse on this topic, I'll try to 
elaborate in the next iteration.

  Thomas


