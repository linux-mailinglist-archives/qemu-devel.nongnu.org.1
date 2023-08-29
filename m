Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB6C78D063
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:23:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nu-0001lN-Bw; Tue, 29 Aug 2023 19:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qb5ZN-0008JW-Qk
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:44:13 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qb5ZL-0006xt-Nb
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:44:13 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fe15bfb1adso7607151e87.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693341850; x=1693946650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=SNVkbyFCBk1eYmxROyDbG5wU7GD6JvrhJGxLhA8BnYQ=;
 b=WDRylMcXkgALfvf4EwAIoq9BwEhfDBVzATnhHl51OFKKKK2z6+psSKf28ta0Ty59aE
 7O2mvXKjEcVn7ooEV+LodZtJwg+tEjSQNhuXpYrXN5Ydk8RmwvSyIuFAlCvZHFWIxJOC
 9hGkjS4A48cN6/fXTA/mZCnCYKgvNu1utxdt6Q+Lw1rfQLgxqJYQ5AJAvBnLr7mEujTs
 w6e8N53ZQvyOMPMBnzfMqTkmDWwSaUq8r8qxG9yrU9YDea1GHiSv+bmKFQTzE4eJuHOc
 rxgw3q4LR79uo3R9M1jZGj9i6wPFYHWAkhZgAZ+FDvzE0+oJzHpoOPRtRMeUnAU5I+JA
 gsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693341850; x=1693946650;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SNVkbyFCBk1eYmxROyDbG5wU7GD6JvrhJGxLhA8BnYQ=;
 b=YP898d5Q9mpMJtjwTRk++iNjHBW9EoP+HBYtlDjsGhgu4MbBbmqEk7SHIyRQTf5Ho6
 r7CXS9eOZZhAMOrkI3ZCJhWvqNrULFnIZFB92YPkKRt/VHyeWI32gS8lKNZC9YOozpKK
 jmS4pcb3RsDa4EXFZO+IpRa02lWDSk143gUyZtwb48IRLt2YiWdDOLolrLgXiVOoEJ21
 zpjUeTrroEO98Tn6tgLtHKe4WioaAMRm4AKjov+GSAFz81BcBuRH/kOcOK9nyHGjddcF
 K2NhldrWecRP6pyvern/Vn9L0jUtKk17sqF2STWV59zq5A+tU+OYP8Hi9tV2yGjO/ru8
 VVAQ==
X-Gm-Message-State: AOJu0YyQHB8rqQh/H9+orRD4UkbHom2cftoQAzPjAAx5oMesqc3L28xJ
 r5WnM21D1R4pJPFOzTta71phpA==
X-Google-Smtp-Source: AGHT+IGl95YFMkiKnRO3xMlYwBOnE0MrDtaSIY/FXelQQNCsFl8++kHw2iOvexzBwrjIb9uMMkU+kw==
X-Received: by 2002:a05:6512:368c:b0:500:aaea:1494 with SMTP id
 d12-20020a056512368c00b00500aaea1494mr40678lfs.41.1693341849777; 
 Tue, 29 Aug 2023 13:44:09 -0700 (PDT)
Received: from [192.168.200.206] (83.11.188.80.ipv4.supernova.orange.pl.
 [83.11.188.80]) by smtp.gmail.com with ESMTPSA id
 j8-20020ac253a8000000b005009b979e3dsm2070657lfh.303.2023.08.29.13.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:44:09 -0700 (PDT)
Message-ID: <fd3665ae-da56-9d86-ff91-b1efa107671b@linaro.org>
Date: Tue, 29 Aug 2023 22:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCIe: SLT attribute mismatch: 0xFF020100 instead of 0x20100
Content-Language: pl-PL, en-GB, en-HK
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Gowtham Siddarth <gowtham.siddarth@arm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <56aa4acb-d54c-a457-5a32-9258cec1ac96@linaro.org>
 <CAFEAcA81xq_yEXYdtAXtkqcdR=MHagSNf5rXOtt+AwohMY_=BQ@mail.gmail.com>
 <20230829093909-mutt-send-email-mst@kernel.org>
 <43653986-c04f-0076-637b-9061f9702f77@linaro.org>
 <20230829130617-mutt-send-email-mst@kernel.org>
 <ff230439-5d76-1f50-a25a-1fd666c3f369@linaro.org>
 <20230829161732-mutt-send-email-mst@kernel.org>
 <601619fb-5f1e-4b93-3dd1-b415d0ee8979@linaro.org>
 <20230829163929-mutt-send-email-mst@kernel.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20230829163929-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

W dniu 29.08.2023 o 22:40, Michael S. Tsirkin pisze:
>> It passes with sbsa-ref (which is not using QEMU versioning).
>>
>> Fails (as expected) when used new property for each pcie-root-port
>> (ignore line breaks):
>>
>> "-device pcie-root-port,
>>    x-pci-express-writeable-slt-bug=true,
>>    id=root30,chassis=30,slot=0"
> 
> could you also check with -machine pc-q35-8.1 instead of this
> property?

BSA ACS is AArch64 only.

