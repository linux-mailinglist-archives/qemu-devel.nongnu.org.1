Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E76207BF8CA
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 12:38:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqA7S-0006rE-Sj; Tue, 10 Oct 2023 06:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqA7Q-0006mA-EK
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 06:37:40 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqA7O-0005QT-Pt
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 06:37:40 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5041cc983f9so6630069e87.3
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 03:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696934257; x=1697539057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tg7P1EztHNIkMXzSPhcAdvWMO8kYwgQvGwMi6seBK6Q=;
 b=GGPo+/tFNRJF4e40rFX24h5qD5wxLFcblCb1Bgee+/l0otnpQmF0wHR7QaZya3P+FE
 bgItS2TgNAIhXqU9C1jV93KCA+gwmV8aKIMm2R+N0HMuFIpTCH40ZiD814zrBhrWeX1J
 8+9n9ICoFm882EBFkjiBxTfVv10LrufNCc5N+QaKRvJrR4YS0WhFDk2w5Fswk7x3ZWeq
 I0rqmDBnHCD/LsWcoS54X/1ZN/AYt+lyCLxmD4r7bBz6T0lKJrMepnwaaIv2XrV3WKyj
 JZCdBHUMoThIkUpTz8OfYcqBk5mxLQITEDyhIc0kqPuRQH1ILygkd/SiwPR21Flj4AlP
 7Xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696934257; x=1697539057;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tg7P1EztHNIkMXzSPhcAdvWMO8kYwgQvGwMi6seBK6Q=;
 b=Kjesk2vRV1SiU3VLIhIMeazLfI1Ha9oBhaIIN2uaecREaTGvJp/qn4K8jI0IwlTLgJ
 2n26xmxIL08kddsnaV3hMzf7R/XJW9hCJZgYKP4AIM0CfuuePRBbN04l86+I5iwD9qew
 ErfBkDwLH+Wj3EDfW/uxxGURIt+ibE77ak5uA/s0wJ+OtQ2S39MgBRt5tWLBbbwT4WkY
 9070Nlifoqc7rLBITyep9aA2Sp63b+kChu1pu/i5W5kOekvNmZVwSdrmhcEVoztKqY9e
 xaNrdTSsIyXoMZtec/4s7z/YTFnGZ9nJonkyPR5j/D0TN7rytx8Th8CD78AABAKvWK/Y
 25OQ==
X-Gm-Message-State: AOJu0Yy3rL0fn4ugVINqHzKHO5Cv2lAdMHNiiMYq3TUFPcgBFfWIs0ih
 uDMKBN0Fcbr0Tyb1cdE96C+crQ==
X-Google-Smtp-Source: AGHT+IH7exa3XOZS70jR7zFie2DJ6Q9QERoMYvJEgWM979mOYX62e/xkJdGewqRYeq32iRY3abLUfg==
X-Received: by 2002:a19:7917:0:b0:503:c51:74d7 with SMTP id
 u23-20020a197917000000b005030c5174d7mr12299260lfc.17.1696934256789; 
 Tue, 10 Oct 2023 03:37:36 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 c12-20020a05600c0acc00b00402f713c56esm13766767wmr.2.2023.10.10.03.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 03:37:36 -0700 (PDT)
Message-ID: <7e3e43ec-8b97-cd63-ce50-6859b78ca5f7@linaro.org>
Date: Tue, 10 Oct 2023 12:37:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] tests/qtest: Use qtest_get_base_arch()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Nicholas Piggin
 <npiggin@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Jeuk Kim
 <jeuk20.kim@samsung.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>
References: <20231010074952.79165-1-philmd@linaro.org>
 <20231010074952.79165-5-philmd@linaro.org>
 <a3ff5135-2fd1-b3dd-f576-129ef08b47be@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <a3ff5135-2fd1-b3dd-f576-129ef08b47be@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/10/23 11:58, Thomas Huth wrote:
> On 10/10/2023 09.49, Philippe Mathieu-Daudé wrote:
>> Additionally use qtest_get_arch_bits() when relevant.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/qtest/ahci-test.c           |  5 ++---
>>   tests/qtest/am53c974-test.c       |  4 +---
>>   tests/qtest/bios-tables-test.c    |  6 +++---
>>   tests/qtest/boot-sector.c         |  6 +++---
>>   tests/qtest/device-plug-test.c    |  6 ++----
>>   tests/qtest/drive_del-test.c      | 16 ++++++----------


>> @@ -1867,8 +1867,7 @@ int main(int argc, char **argv)
>>       }
>>       /* Check architecture */
>> -    arch = qtest_get_arch();
>> -    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
>> +    if (strcmp(qtest_get_base_arch(), "x86")) {
>>           g_test_message("Skipping test for non-x86");
>>           return 0;
>>       }
> 
> While this change makes sense (unifying two checks into one) ...
> 
>> diff --git a/tests/qtest/am53c974-test.c b/tests/qtest/am53c974-test.c
>> index ed3ac7db20..dc41182a38 100644
>> --- a/tests/qtest/am53c974-test.c
>> +++ b/tests/qtest/am53c974-test.c
>> @@ -253,11 +253,9 @@ static void test_reset_before_transfer_ok(void)
>>   int main(int argc, char **argv)
>>   {
>> -    const char *arch = qtest_get_arch();
>> -
>>       g_test_init(&argc, &argv, NULL);
>> -    if (strcmp(arch, "i386") == 0) {
>> +    if (!strcmp(qtest_get_base_arch(), "x86") && 
>> qtest_get_arch_bits() == 32) {
> 
> ... this change looks more cumbersome now (doing two checks now instead 
> of one), at least at the current point in time. Do you urgently need 
> this for your refactoring? If not, I'd maybe postpone such changes that 
> make the checks more compilcated to a later point in time.

I wanted to replace qtest_get_arch() completely, but not that simple :(


