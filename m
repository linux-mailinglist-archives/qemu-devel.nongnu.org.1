Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 954AB7468AA
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 07:03:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGYA5-0006ZJ-Of; Tue, 04 Jul 2023 01:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGYA3-0006Z0-HI
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 01:01:11 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGYA0-0002yI-Fc
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 01:01:11 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-55779047021so2899768a12.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 22:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688446866; x=1691038866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7qpS1SgUzvm/KwFc/nZs5YR6nR+kqC3ghrNHtkUczIo=;
 b=K5UGdhQkqICu/FrRMyhoPieYLT7Qxmon4bNYExEl2g3oJZ4jBJ3X4W+vsP/ZR0kptl
 kErSTeBBaCxlkpEs30wixrbkekfzwQUK8WaxWypNcjsEydkt4rXHw6i9RIX2wp7ntRzy
 l3jza8ls+yAK7hRwEZcOfeulrAccY4BEJNULfXiQKXPdAP4Tbtkpb19PTJX04+QyEBuc
 1UYpZJmfXuqE9VRR+X3jKp+fLTEOErDXFJEZKe2/28D1p0Dk0EqvFkKIogPPbDWZ9oai
 IDnGgP+d9wSwpcZaWGJpUpnpTKsxGhROu6kEieEoWWzlSt4YQRa4U+h1/fBJAj8O8Gjw
 UjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688446866; x=1691038866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7qpS1SgUzvm/KwFc/nZs5YR6nR+kqC3ghrNHtkUczIo=;
 b=YRBqXuMpZvQUnKXXy1c2e+P7ygKZJnhhBqxTGwfpawpMDauZdLzGAtdz9fNH3ZqsbD
 0SMtH8D5qqOSxGvJaXOoHBfP1V4wBeGj4PC2HD8A/geSKro6yf+sO4HXNFhc2gYiv3Z+
 /a74OXl4EdMeStlDpTgXLKbVTNXtxV0yCoOVZ49gDO6DOck826JU2z51moaO4R2Ki63p
 1LHKm+Qf6b3sX8wtKPnOmx9hQD3DfeNn7y8rzMiamtKDSFR2GrS4MxbDEgPBIVRMznVh
 x2R9BzjvcD60PpdjxkdvUoJSFmMan2jEEIULPUr9SL/ZHaC/CJNV+HJ7NNm8NFqMJjh2
 NOaQ==
X-Gm-Message-State: AC+VfDztySjoQSnSaoV+6HR2o1JWrZavwYXqSe+YqiNF7WhvhytU4Bxx
 tnYTX0DTI6RlEDnKevbc2/LYIg==
X-Google-Smtp-Source: ACHHUZ6N8upp2RdJKCS/je7mN0CekbaJv8QTAa537gTF5Qsxpd4xlGySsPvT37CkHlt65g3M54W/4g==
X-Received: by 2002:a05:6a21:339d:b0:116:5321:63bf with SMTP id
 yy29-20020a056a21339d00b00116532163bfmr9339662pzb.41.1688446866280; 
 Mon, 03 Jul 2023 22:01:06 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 t12-20020a170902b20c00b001a95f632340sm16096432plr.46.2023.07.03.22.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 22:01:05 -0700 (PDT)
Message-ID: <d6368f95-3adf-9d49-82b4-a138a32010a4@daynix.com>
Date: Tue, 4 Jul 2023 14:01:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
To: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20230630041937-mutt-send-email-mst@kernel.org>
 <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
 <20230630043734-mutt-send-email-mst@kernel.org>
 <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
 <20230630055717-mutt-send-email-mst@kernel.org>
 <FB764864-ADD3-4017-8313-ED40A833A81B@redhat.com>
 <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
 <bf351f8b-1c8a-8a7a-7f44-17c9ba18f179@daynix.com>
 <DFB3B0B7-1F61-4779-9833-2AF1BA3BDFA6@redhat.com>
 <2ffee496-ec63-ad04-a90b-8c2fadbf3657@daynix.com>
 <20230702005916-mutt-send-email-mst@kernel.org>
 <63B46F8F-A52C-4BFC-BAFD-06ACAF2AA6E1@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <63B46F8F-A52C-4BFC-BAFD-06ACAF2AA6E1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/07/03 15:08, Ani Sinha wrote:
> 
> 
>> On 02-Jul-2023, at 10:29 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Sat, Jul 01, 2023 at 04:09:31PM +0900, Akihiko Odaki wrote:
>>> Yes, I want the slot number restriction to be enforced. If it worries you
>>> too much for regressions, you may implement it as a warning first and then
>>> turn it a hard error when the next development phase starts.
>>
>> That's not a bad idea.
> 
> If we had not enforced the check strongly, the tests that we fixed would not get noticed.
> 

Perhaps so, but we don't have much time before feature freeze. I rather 
want to see the check implemented as warning in 8.1 instead of delaying 
the initial implementation of the check after 8.1 (though I worry if 
it's already too late for 8.1.)

