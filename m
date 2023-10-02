Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E13457B59F8
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 20:26:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnNc6-00033U-8E; Mon, 02 Oct 2023 14:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qnNbz-00030K-VW
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 14:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qnNbu-0001IR-QU
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 14:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696271136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTliFEQqqDscEY85+ia3aQuTCjPzbplNKd0ISjs5fSw=;
 b=agKGHAwY+tBa3KWOiRI5D7IoOl2GOTej1AeYCotBFVW9VXyHgpDEMkJawBBlHFllufIx/k
 yr3bA3aNwLE4Yy3oUMetQobGffAhCUTP1NDIcTHd/TGRZ9y0chGJoSt8OZ/RiDIvk/xAm3
 ZqHudGxtje0Xrk1pQZJ8Rbof+3HchEA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-WN0vV11_N5-12I6OdEMq-g-1; Mon, 02 Oct 2023 14:25:34 -0400
X-MC-Unique: WN0vV11_N5-12I6OdEMq-g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65b1c33bf59so583276d6.3
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 11:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696271134; x=1696875934;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VTliFEQqqDscEY85+ia3aQuTCjPzbplNKd0ISjs5fSw=;
 b=JDS0BbT3mnpT558WkhbUR2/XWo8CxckdYQ9pP5RwV0Ck4ZledFe16t66vZ9d48H93x
 u6ZjmOlhAnYoy05TtjqsM2iLDGROcwyO9uaNzVxh29G5I9KOOQjbXvki0RltHsMOn/op
 Pe5FMK1Slcw3BCrNI6WOi5/fnQ6IZXlBRk40gs9PW3/F3XJVqGXl8UoELsRcIf4fywYy
 vKVg4974bMQ9DVwhof44ksqPys83Ce8PwhnZ9jvx8Ql4M2iCWTuQkbRjuZ9o33phvknG
 Atf1+KqUDaZwOUpLJZxBLJZt3eR+rXp2u73B2daR1SFBrVaSxtV0kBeiSxv5DmXvQNNW
 vbIQ==
X-Gm-Message-State: AOJu0Yw7wjmhgDiSn9rXKNtcjxDXLVoVtuIiLDKoRZpNsfkQVD53CFrj
 AOaxqNAPzGyTiLiJK5LlZaABJrm2NhTQVaECbrql7dB2N8gxcBbEm5VS0UGw8JwqTV+g3NABWSx
 qQ+9j1LEwWs2Hvd8=
X-Received: by 2002:a0c:f08f:0:b0:655:f1a4:ac5f with SMTP id
 g15-20020a0cf08f000000b00655f1a4ac5fmr13246130qvk.8.1696271134271; 
 Mon, 02 Oct 2023 11:25:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtJR4qkFnvNYdBtWZ8ho7hYjEIjs0YjG5ITo+ORU0cyJXnXbTXlN45hsZouloUXFWOdwE1vg==
X-Received: by 2002:a0c:f08f:0:b0:655:f1a4:ac5f with SMTP id
 g15-20020a0cf08f000000b00655f1a4ac5fmr13246120qvk.8.1696271134015; 
 Mon, 02 Oct 2023 11:25:34 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-123.web.vodafone.de.
 [109.43.177.123]) by smtp.gmail.com with ESMTPSA id
 n6-20020a0ce486000000b0065cfb75fe81sm4454411qvl.67.2023.10.02.11.25.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 11:25:33 -0700 (PDT)
Message-ID: <9312569b-75c8-e179-af95-42c4fae76807@redhat.com>
Date: Mon, 2 Oct 2023 20:25:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: MAINTAINERS still leaves more files uncovered than I'd like
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87lecp6w7x.fsf@pond.sub.org>
 <89b74108-0379-97c8-455e-cb0c5058785c@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <89b74108-0379-97c8-455e-cb0c5058785c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 02/10/2023 08.18, Philippe Mathieu-Daudé wrote:
> Hi Markus,
> 
> On 29/9/23 13:43, Markus Armbruster wrote:
>> Back in 2014 (time flies), I posted
>>
>>      Subject: MAINTAINERS leaves too many files uncovered
>>      Message-ID: <87mw8rumhb.fsf@blackfin.pond.sub.org>
>>      https://lore.kernel.org/qemu-devel/87mw8rumhb.fsf@blackfin.pond.sub.org/
>>
>> I updated my findings in 2015, 2016 (at commit e00da552a0d), and 2018
>> (at v3.1.0-rc2).  This is another update, at commit 36e9aab3c56.
>>
>> Unsurprisingly, the number of files in the tree
>>
>>      $ git-ls-files | wc -l
>>
>> grows over time:
>>
>>      year  2014  2015  2016  2018  2023
>>      #     3746  4387  4921  6461  9788
>>
>> Looks exponential to me, doubling every seven years or so.
>>
>> The number of .c files has grown more slowly:
>>
>>      year  2014  2015  2016  2018  2023
>>      #     1836  1945  2132  2633  3588
>>
>> The number of .c files not covered by MAINTAINERS
> 
> [...]
> 
>> hw/sensor/dps310.c
>> hw/sensor/emc141x.c
>> hw/sensor/lsm303dlhc_mag.c
>> hw/sensor/max31785.c
>> hw/sensor/meson.build
>> hw/sensor/tmp105.c
>> hw/sensor/tmp421.c
> 
> I sent a patch for these but the community didn't
> seem very interested back then:
> https://lore.kernel.org/qemu-devel/20230220110235.24472-1-philmd@linaro.org/

As long as nobody complains, I'd say just go for it and put it in your next 
pull request :-)

  Thomas


