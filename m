Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E7482A8F4
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:21:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqJ5-00004s-6G; Thu, 11 Jan 2024 03:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNqJ2-0008U3-Ba
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:20:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNqJ0-0001yd-6h
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704961249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=se2TJ/M8HxQZwPMm9JXFStoBFrGQIhPB5He5diRapq8=;
 b=HqpJvF+dbIppCeR82VoaNC6jQgIwLAQaM/WYG3H+8BYvVPeemglkebiG9J7eX/jvXRGTJL
 i+aAy38uiq4LyO56+XSsc618tYbFPQqrR5Yw9C/CMRlVd1MsKCIz3Ewpak/NgHGMMGbn4V
 nvUG4bO+iqTIkSztVdR6J4JbLbcGpcc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416--df6qz9IMUOX_BShIuu4Tw-1; Thu, 11 Jan 2024 03:20:47 -0500
X-MC-Unique: -df6qz9IMUOX_BShIuu4Tw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7833330e2d5so230311685a.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 00:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704961247; x=1705566047;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=se2TJ/M8HxQZwPMm9JXFStoBFrGQIhPB5He5diRapq8=;
 b=aGEmJ7fOcU8QlEmXQ0Xt0Xtj4+KX/SZh8jn3w3ooIHa8Di3rBtnqE7yZDUrApTJ+Ey
 N2nicf5VgOPzhBk+YZfnJZ06XxPiZYvN81Mh6Vp6x07kAs4AxRjtQ2icjZbni/k4lq2H
 JDpbQuStflLlq+vLemPcMN1zXuVHvDhfWtBkFoknEzAoSy4XmJbUW17WFof6vyE69rC2
 lWvbqNbTWhg4uVC18P23cbr6qY+eMdFZycCOUYEz8w69fq2fZix5dd4+9z33Bs8Gx7BS
 5uMvqVGghB1QbUULicFqRATweQrb8kAKQMh0U4nWQ9KDfCEE0NT6uT9abAYodjcxTzOE
 T+gw==
X-Gm-Message-State: AOJu0YwpYr2+nAT/Fds2PaaFSl16Gw/TNgkEURHYti3P3910D9Xc8ZfR
 MYLX9Gjn6DPjEhOq5fKWpcKEVOuVFoESKT1gpiUIixnTcSLHCbZbKkwdiO+oDk+FhdncnZzBr+G
 1wpts7hgb095ZRaeCYBub2sE=
X-Received: by 2002:ad4:5ccc:0:b0:680:fee5:9b47 with SMTP id
 iu12-20020ad45ccc000000b00680fee59b47mr929993qvb.76.1704961246987; 
 Thu, 11 Jan 2024 00:20:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFB9UEcBM1yu4dILGZHVU3WbEL9L95EN73jdFEGT/ZS4ulsxUQEHDimpccmuKszXkkxUOtzow==
X-Received: by 2002:ad4:5ccc:0:b0:680:fee5:9b47 with SMTP id
 iu12-20020ad45ccc000000b00680fee59b47mr929987qvb.76.1704961246776; 
 Thu, 11 Jan 2024 00:20:46 -0800 (PST)
Received: from [10.33.192.181] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 fb12-20020ad44f0c000000b0067f626a5b2esm150353qvb.74.2024.01.11.00.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 00:20:46 -0800 (PST)
Message-ID: <96bdddb5-e15c-469f-b74b-7e82049888f1@redhat.com>
Date: Thu, 11 Jan 2024 09:20:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [NOTFORMERGE PATCH 2/2] gitlab: Add Loongarch64 KVM-only build
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Zhiguo Wu <wuzhiguo@loongson.cn>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Beraldo Leal <bleal@redhat.com>, WANG Xuerui <git@xen0n.name>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>
References: <20240102172239.69452-1-philmd@linaro.org>
 <20240102172239.69452-3-philmd@linaro.org>
 <dbc7f2c6-15c0-4d5a-abf7-8946ff2d03cb@redhat.com>
 <4cc9ab90-c1bc-03d3-d82e-a763199fa029@loongson.cn>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <4cc9ab90-c1bc-03d3-d82e-a763199fa029@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/01/2024 08.37, gaosong wrote:
> Hi,
> 
> 在 2024/1/11 下午3:10, Thomas Huth 写道:
>> On 02/01/2024 18.22, Philippe Mathieu-Daudé wrote:
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> Used to test 
>>> https://lore.kernel.org/qemu-devel/20231228084051.3235354-1-zhaotianrui@loongson.cn/
>>
>> So why is it NOTFORMERGE ? Don't we want to test KVM-only builds for 
>> loongarch in the long run?
>>
>>  Thomas
>>
> I think we can drop this title.
> 
> I tested this job by the latest loongarch kvm patches.  buf I find a 
> test-hmp check error.
Can you recreate the error manually? i.e. compile with configure 
--disable-tcg and then run:

  V=2 QTEST_QEMU_BINARY=./qemu-system-loongarch64 tests/qtest/test-hmp

That should likely provide you with a hint where it is crashing

  Thomas


