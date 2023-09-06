Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE65679352B
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 08:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdlnI-0001DF-Us; Wed, 06 Sep 2023 02:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdlnG-0001CF-0Z
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 02:13:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdlnD-0005bn-Q1
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 02:13:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-401d10e3e54so31458865e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 23:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693980814; x=1694585614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EuLEapTNMkBr3rA414Ddjh5KFea9U9gbs9TqOE42laE=;
 b=s0AnJtd35rR2EPjsjhGBm017//7OJP5FAtAA/ObqjEdJU8inlqdzCwBjnn1Nd4+o3+
 GdGtJCjuLr8yiXA5wNxJS8lYnS7umFWAG9tT7h/EyNSp58VM4FPOyruBRxrOKVtjq/Cw
 phTMCbdUr/fIB9N1P6esIJwfVcTszclnF1uaurLRiJIXWo8us2fwbKnWgbxJBAvpu11z
 6nUx0/8T1Y9WWtlU9WA9rB1Ikaz6VWHy1cHPzJQPQ39lzbiTIaU8Zk5igvTOCSnGsaF5
 8MOikdlwyv2d21E/FsQNiInXL759+xt9RUEcMPXEM0lzEBlmS4NZFntnSC1T8V6Q+qjO
 IlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693980814; x=1694585614;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EuLEapTNMkBr3rA414Ddjh5KFea9U9gbs9TqOE42laE=;
 b=ElrVm/qgarpBhmNt7zPTcmk44h6rw2xnX32oMVBAYDzyGPuV4KzaCdcTRGHcIPyFSx
 dQVvG1xzH0194c3jPn8278p0K2BHjx9WvpleXBwQV6cS/dYDYS6gzn+pPkIOoDtWjpYx
 shKO2Ohb8bMZtWUJTx1skVzksFDOudFFEht5ifWAAnyMNBRoYuNobCssU0soGvyFCKO9
 uoUThQs8BxC+xri4NeQaoZYvZL9iNMxBp4bADeQY7gjmD7RkiSqGILi2J9TKGSRrt+1g
 xxcr3bb9LdWnMEApWzFEZRrPsSNQe7VO+FAMifvpm8SABCxm3zEKs+NwDT0+sJNd+Zf1
 2sIg==
X-Gm-Message-State: AOJu0Yy1ds4Xu3AbUJZ18vzXj2nPuAroziRZAyBG2PrAhske+gGQyTar
 /HMlv6B68Tpm9rzfLi73/Egrhg==
X-Google-Smtp-Source: AGHT+IGRMefYUe20wIMT1qzuxfigXwVjpr5K+Xl4AEGs0ht0a4eQ6N3WvgkauowMkbqrOBsF4F8rEg==
X-Received: by 2002:a05:6000:1816:b0:319:8b19:d5c8 with SMTP id
 m22-20020a056000181600b003198b19d5c8mr1550986wrh.2.1693980814130; 
 Tue, 05 Sep 2023 23:13:34 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 x18-20020a5d4452000000b0031431fb40fasm19388792wrr.89.2023.09.05.23.13.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 23:13:33 -0700 (PDT)
Message-ID: <2b6df154-de47-ab4c-d315-a541935d1276@linaro.org>
Date: Wed, 6 Sep 2023 08:13:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v5 0/4] Virtio shared dma-buf
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, kraxel@redhat.com,
 cohuck@redhat.com, Fam Zheng <fam@euphon.net>
References: <20230802090824.91688-1-aesteve@redhat.com>
 <CADSE00JRMvQ6Ye445xon0GoCDSsp7oAY_B--rABooabMTraoaQ@mail.gmail.com>
 <20230905164451-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230905164451-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi Michael,

On 5/9/23 22:45, Michael S. Tsirkin wrote:
> I was hoping for some acks from Gerd or anyone else with a clue
> about graphics, but as that doesn't seem to happen I'll merge.
> Thanks!

I made few late comments. Patch #3 doesn't build (thus
break git-bisections). I also have some concern about locking.
I'd rather see a v6, do you mind dropping v5 from your queue?

Thanks,

Phil.

> On Mon, Aug 21, 2023 at 02:37:56PM +0200, Albert Esteve wrote:
>> Hi all,
>>
>> A little bump for this patch, sorry for the extra noise.
>>
>> Regards,
>> Albert


