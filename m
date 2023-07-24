Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B0C75EC6E
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 09:24:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNpuz-0008Ao-8y; Mon, 24 Jul 2023 03:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNpuu-00089L-ME
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 03:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNpus-0005BC-Uv
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 03:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690183415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4dBfsQWv6ZCZ8w44qchhHluCSarQNpAQrj8KDirrlpI=;
 b=HBGCpQSVDy5luItdQS8hzdFPxJo6Qz94Dj/H7lU5zfP8vC2l4hJDvOOyXGMVdWOVB7sRmQ
 hE2xlp6Aj9gYk+Wb5NuQ64+1O7qXPnumth+Mm1bxNphHTewO+gHjmAwtn+dYr9VI17ZM0a
 JrtGdXFde1fQxkRyl8asVU3d1ZctRxU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-qwH-zTgOP7ypndGbN6nl5g-1; Mon, 24 Jul 2023 03:23:33 -0400
X-MC-Unique: qwH-zTgOP7ypndGbN6nl5g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-2f2981b8364so2444687f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 00:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690183412; x=1690788212;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4dBfsQWv6ZCZ8w44qchhHluCSarQNpAQrj8KDirrlpI=;
 b=LyVQk1IWd1th5FNrnnuQpZ6pSLedJheglf6cXvUwX9z9Ln8XXgjPZN8YcopTmgGDsy
 3iIOubeNQ3QFq7iZeSa3cL/6qYzQeWf2hlUkPnG7KcVuMmiTwBMlzYu9DpaNWpgNTp7C
 QJeL3x16SFwTWKSTEz2FKr1EgfCYatvIIRVh19nocTL0HqWBmJCs+AQn2ikqS02KS5FM
 mEOK/ERNP5rjxzjlqxyuhITluCMC4Mqz71JVu5KQR0TSt+OpGBam8hJchGdbV9GEbUdM
 aU720Lj5VQQtKyGPvbgx9Kn0WRoieCx0UIopXNQzFhAdvNjtKMldnEBMh6A2RpR+LRjz
 vsWg==
X-Gm-Message-State: ABy/qLYWyv08j7hUtKVehYXEgwnZM7ID7fh5PWpTnSFYIyY7iU3FPHHF
 pQmu9Tg1WRA2o+TuPxKisq9rfIhRk+6zg06Ku3eV6seVuo77d5PEw1qOjTz1ZIs+ja3s8Nh1xPI
 Sckwzf1QGswBq9rTn8HAfA28=
X-Received: by 2002:a5d:528d:0:b0:314:3985:b291 with SMTP id
 c13-20020a5d528d000000b003143985b291mr7439268wrv.15.1690183412609; 
 Mon, 24 Jul 2023 00:23:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE/X6IqGRIjKf+HbgW3dSd1ed7ZOAKQ8YFuj/OJOgIG2xoB0nLHsc7XWT0h+Oc+y1/MWBz85A==
X-Received: by 2002:a5d:528d:0:b0:314:3985:b291 with SMTP id
 c13-20020a5d528d000000b003143985b291mr7439259wrv.15.1690183412329; 
 Mon, 24 Jul 2023 00:23:32 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-165.web.vodafone.de.
 [109.43.177.165]) by smtp.gmail.com with ESMTPSA id
 q4-20020a5d6584000000b002c70ce264bfsm11907288wru.76.2023.07.24.00.23.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jul 2023 00:23:31 -0700 (PDT)
Message-ID: <57bab3e4-f7bb-de3d-d651-46c9d1cc6ea2@redhat.com>
Date: Mon, 24 Jul 2023 09:23:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/6] trivial-patches for 2023-07-16
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20230716115801.1505288-1-mjt@tls.msk.ru>
 <02d123c8-92c6-c7e2-02df-d9ed9d9ba980@tls.msk.ru>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <02d123c8-92c6-c7e2-02df-d9ed9d9ba980@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 16/07/2023 14.05, Michael Tokarev wrote:
> 16.07.2023 14:57, Michael Tokarev пишет:
>> The following changes since commit 7d07a21ec003724475566073404c5893e36de5e5:
>>
>>    tree-wide spelling fixes in comments and some messages: hw/9pfs 
>> (2023-07-16 13:59:17 +0300)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/mjt0k/qemu.git/ tags/trivial-patches-pull
>>
>> for you to fetch changes up to 7d07a21ec003724475566073404c5893e36de5e5:
>>
>>    tree-wide spelling fixes in comments and some messages: hw/9pfs 
>> (2023-07-16 13:59:17 +0300)
>>
>> ----------------------------------------------------------------
>> trivial-patches for 2023-07-16
>>
>> This contains a doc fix for riscv and reviewed spelling fixes.
>> ----------------------------------------------------------------
> 
> This meant to be a PULL request, not PATCH series.. :)

I guess you have to resend with a PULL in the subject?

  Thomas



