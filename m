Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B737A476B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:44:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBjH-0005qb-IJ; Mon, 18 Sep 2023 06:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBjF-0005qK-8u
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:43:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBjD-0005DB-L0
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:43:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4050bd2e33aso7346925e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695033821; x=1695638621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pFVcv3At1tpqy5ocuGKbqeWT7U4d/ULHbRYO9tOGfr4=;
 b=QYnTTTY90j0puY/kCyxlCyS+WSYSqngtuUi9eeZnqi3l7lEDDgDsn4sBvEBBJy1aWq
 rZWXgaV3rA13lPsjimQssCgzwp1KsO7jL8Ga6m1SIpojM5/XaRTKGBnoWd6DyCAbQy84
 3O17rx8EjT8WGyH2pdy7JivspvaBImLG/sFvsuCdz413jHBoYuSYlynrTyz/RxxB5FxH
 nRi6uXQP7qMiSoFobCmI2Vewfgd8PyixiKX7C/RyqO9FuH/zOEvu+zDNhjYQ56xPm8Yg
 tlApzo3ts1CjfdjzJeL0eYU+KzL94AYAs8GrAPH010EM+gndP9xKaDdGUAmvJp3p69tL
 tbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695033821; x=1695638621;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pFVcv3At1tpqy5ocuGKbqeWT7U4d/ULHbRYO9tOGfr4=;
 b=q6Nj+YztrI/a+TBp512nnkg3mFeuy6B6euln5sjdXfi8mad8SfsAeVwlzJ0l0SZ8sL
 wOlj3rtkXwBtyK70wtkZNwsFqnxnbdn2IuCCd7MSbi8YdrMaD2nZUGt8aLFWv56j3qSI
 xkADw6k2GOXN9+9OEzjBedsYjXoZ6vT0xw1OPYFhdTp9N3E6nihEAlZj4jTXVEni4Wxh
 icKlbSlLw+8dO8rdR3y32fMkPkQtrEo9et7b9pPXV7XtNJgrm3rYpVxCdAUVjPckrTqK
 87NmtmTbUPKM0mTQZ20ojnRwrYNpGCH7pKn1GTC0adDdjZU6fLMuBKIG3gLPlD2QzSlk
 UNqw==
X-Gm-Message-State: AOJu0YyQC4u8Exr6hlRZIJYfhPvyNOLeqEYf+7KMtFpP4ca4cjjys8H7
 megUO5MGez2oN8xzoW22obXYlw==
X-Google-Smtp-Source: AGHT+IE7hhz3iPDwI6FDuXDU4qXtOjA4ejlZKkwYLhcDXxiV9UDrtoZntwSGOHBudOW2ifOvcmvpqA==
X-Received: by 2002:adf:f34f:0:b0:31f:f1f4:ca8e with SMTP id
 e15-20020adff34f000000b0031ff1f4ca8emr7676524wrp.36.1695033821457; 
 Mon, 18 Sep 2023 03:43:41 -0700 (PDT)
Received: from [192.168.95.175] (5.red-88-29-175.dynamicip.rima-tde.net.
 [88.29.175.5]) by smtp.gmail.com with ESMTPSA id
 n7-20020a5d6b87000000b0031ae8d86af4sm12213084wrx.103.2023.09.18.03.43.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 03:43:41 -0700 (PDT)
Message-ID: <15ee52cd-54eb-8629-328c-0e2d6b4e6950@linaro.org>
Date: Mon, 18 Sep 2023 12:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] tests/qtest/netdev-socket: Do not test multicast on Darwin
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Jason Wang <jasowang@redhat.com>
References: <20230918062549.2363-1-philmd@linaro.org>
 <4e43c72f-823f-7267-baa8-9a2fac4ed47e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <4e43c72f-823f-7267-baa8-9a2fac4ed47e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 18/9/23 08:35, Thomas Huth wrote:
> On 18/09/2023 08.25, Philippe Mathieu-Daudé wrote:
>> Do not run this test on Darwin, otherwise we get:
>>
>>    qemu-system-arm: -netdev 
>> dgram,id=st0,remote.type=inet,remote.host=230.0.0.1,remote.port=1234: 
>> can't add socket to multicast group 230.0.0.1: Can't assign requested 
>> address
>>    Broken pipe
>>    ../../tests/qtest/libqtest.c:191: kill_qemu() tried to terminate 
>> QEMU process but encountered exit status 1 (expected 0)
>>    Abort trap: 6
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/qtest/netdev-socket.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)


> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> I'll queue this for my next pull request.

Great, thank you Thomas!


