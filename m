Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCBC769907
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:08:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTYT-0000pN-7m; Mon, 31 Jul 2023 10:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTYE-0000ju-PY
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:07:12 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTYD-0005xi-8Z
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:07:10 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbc244d384so42266105e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690812427; x=1691417227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MNXzbOuzwne6T+Fhq8Wttj9IAVKYfk25AgTqchmK4eE=;
 b=kn+sKm7xhv8hmiOYkDwDyHDE8/UR6ZC4f6AYDRSJl/tc8EQ6DrQZ+cpMBIUXetHFsU
 brhhaM/emV3bDMOkGgAxKLjDlYWvrC/Xvsk66Q/AHIIgi1dDzLeXy+CYkmirhLfMowTk
 85dJcvO9qwHew7e53KK5FycIk/QQFAkaIHxtSNiyMqvG3FNoBFq0DJk8NlPan2YB/DGc
 Iq1yZxGe94fnNp88tWT4vxLQf2wCQadTxZJt3YGDpexDKz8/gHtPocvtwpcQ1H0n49es
 p8TQiLss9lRnNeWG1PKAQj6VtJ/as++lXMMMFKD0HimY6XAh3Sg2kJSwQ93DL4DPqEco
 U2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690812427; x=1691417227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MNXzbOuzwne6T+Fhq8Wttj9IAVKYfk25AgTqchmK4eE=;
 b=hYglLBu8BM/65SqVQYEDujGpfc4CfhaXE/kX23W107hVd5J52nAV78jUjcRKtFU6sy
 1YAHILKhyD6R412CeJVp4YVVKulK62PROLdm1QQdcXLloRDLSALfUaYlPZZq2Xsirq/s
 siekUGwQzxxZnNn07BBFjtsuLD8whQSrnK5deUlVz+k1DQ+MVnQi41TgHzZuX7yizMSN
 50aGca4xEk11aze4pq9WFg4i0NYoMbyBYID/E63sDPDGy8sHExvEopOfqHZ7bYsMkxxB
 VMX3AAP/JIeb0yrQZ8a30CrSZp743zyi2KJP7X8rAEr4R0uy3pWZldCvlt2iBUcg9FFh
 en+g==
X-Gm-Message-State: ABy/qLZcoyJNRH1alWW6sJ7vyfbVveejjh8MT9oS7z36AdrZ+hO7xOTn
 qiefmXO2RZK3Wogy8YsFBIiNEg==
X-Google-Smtp-Source: APBJJlHkygpXJ4bYSmm6N/2E+g1mKjrjLwfwyLSNED2AqMv6uEqitny6fkl1Sk5kZQoImFfR4f5h3w==
X-Received: by 2002:a05:600c:2113:b0:3fb:4055:1ddd with SMTP id
 u19-20020a05600c211300b003fb40551dddmr34852wml.28.1690812427043; 
 Mon, 31 Jul 2023 07:07:07 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.198.42])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a05600c114f00b003fbb5506e54sm11432330wmz.29.2023.07.31.07.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 07:07:06 -0700 (PDT)
Message-ID: <bd032cc2-043b-f8e6-6561-2305a252be02@linaro.org>
Date: Mon, 31 Jul 2023 16:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 5/6] include/qemu/compiler: Fix problem with
 gcc_struct and Clang
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Vikram Garhwal <vikram.garhwal@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Tong Ho <tong.ho@amd.com>,
 Frederic Konrad <fkonrad@amd.com>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-6-thuth@redhat.com>
 <CAFEAcA9PuwSzaWXJYrF9PTs8Yz9oG6_sUY=p7S5rnx6NiS1HeQ@mail.gmail.com>
 <6ca265d4-0dad-3725-1cd5-84da685bc63a@redhat.com>
 <ZMevxyEiwvZXSBIC@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZMevxyEiwvZXSBIC@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 31/7/23 14:57, Daniel P. Berrangé wrote:
> On Mon, Jul 31, 2023 at 11:10:58AM +0200, Thomas Huth wrote:
>> Anyway, using bitfields in structs for exchanging data with the guest is
>> just way too error-prone, as you can see in the discussion about that
>> VTD_IR_TableEntry in my other patch. We should maybe advise against
>> bitfields in our coding style and point people to registerfields.h instead
>> for new code? ... so that we use QEMU_PACKED mainly for legacy code. Would
>> it then be OK for you, Peter, to go on with this approach?
> 
> The registerfields.h usage doesn't seem to be documented at all from the
> quick look I had. IOW, in addition to a mention in coding style, it would
> be nice if someone can document the general usage pattern for it.

Cc'ing ex-Xilinx folks.

> With regards,
> Daniel


