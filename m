Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFF17121C0
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:02:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2SOs-0005Wr-1I; Fri, 26 May 2023 04:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2SOn-0005WM-9A
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2SOl-0002eJ-SF
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685088127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gv7BppRhwmi+BKHwjNyLohMWxBDW2wK0ahUSQ15bND0=;
 b=Nw6/2yRJlTzlZ1ULHTyGN+CdsSZ4xr925rb7qZvj03IwYwb/86xIgPUDWiPgK2mflCz4dm
 GmyGUB4sEcMtkoHuUmf8HOMRDtox8VXI/iUep4pE8uOGKDIF5c7JwsTBNwdQngcFvECwCu
 OlhRhIQwWEfAeIKa1cjN/4ebdeUf0is=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290--rx0ls1ONZip68bzCcogXQ-1; Fri, 26 May 2023 04:02:05 -0400
X-MC-Unique: -rx0ls1ONZip68bzCcogXQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f518f2900eso3646765e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 01:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685088124; x=1687680124;
 h=content-transfer-encoding:in-reply-to:subject:from:cc:references:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gv7BppRhwmi+BKHwjNyLohMWxBDW2wK0ahUSQ15bND0=;
 b=G5SztJLBWK+ktN80eyf9Kgp4uQNaGuCehoSuseAtx1kh0b0FfNtVE6W/Ik9zDatOGW
 24pqk92ORhvdwZTfvu2LAG1CBZ4ADI9dSYJZTNp5XdiKPXenFP70EvqSPHC72Nt14ec9
 Xhk38s2kQrhfrAasnPKgFhQ4FqxjisgSOSL5Fif6d+xpDM566+rmqZ8olVt8AwFH8Bnz
 w8D6N0/KO5LMvS5JGCMmUwFqYnm4iphEvxsotgRUpz39wuSUxne0pyk6yPl/LjDtuOM7
 K8+C3Eyrwi82qZX8LWVUF25N7Kt/1mgYhvScXTSVpOYs+N4yYccSuqVyFktq/v2fAFZD
 Ya1w==
X-Gm-Message-State: AC+VfDzUQdXNJXxevi4RncI97NLCjCfehzPScs0phQhBEDhdlW/h17Rh
 Ja7bZomL3bjmPcJSbsWUMSJvsjfTlCFwGbmohaWcMKKVV5o7/u/dGwouldpt7xEIxaKc8hS5VtS
 vF92T1NKKEY5v2CA=
X-Received: by 2002:a7b:cd15:0:b0:3f6:490:a7f3 with SMTP id
 f21-20020a7bcd15000000b003f60490a7f3mr681078wmj.9.1685088124114; 
 Fri, 26 May 2023 01:02:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ilgr/2eBvayv5KFHO9qh98zlxESyQPPHib59LlF59SlsN4r2wkDfceOgnibHbrh2zbVBsJA==
X-Received: by 2002:a7b:cd15:0:b0:3f6:490:a7f3 with SMTP id
 f21-20020a7bcd15000000b003f60490a7f3mr681060wmj.9.1685088123816; 
 Fri, 26 May 2023 01:02:03 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-189.web.vodafone.de.
 [109.43.176.189]) by smtp.gmail.com with ESMTPSA id
 p25-20020a7bcc99000000b003f1751016desm4442574wma.28.2023.05.26.01.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 01:02:03 -0700 (PDT)
Message-ID: <333138b6-401b-d863-c2cf-90e36d16cc97@redhat.com>
Date: Fri, 26 May 2023 10:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
References: <7b1805ad-56fd-77f7-48f7-fdf80f6a2e5b@linaro.org>
 <d1ab807e-3a9a-91b9-ad52-2d46c06ff54b@linaro.org>
Cc: Hanna Czenczek <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: io-qcow2 failures on zfs
In-Reply-To: <d1ab807e-3a9a-91b9-ad52-2d46c06ff54b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 25/05/2023 20.29, Richard Henderson wrote:
> Ping.
> 
> On 5/19/23 15:44, Richard Henderson wrote:
>> I'm doing some testing on one of the Linaro build machines and I reliably see
>>
>> Summary of Failures:
>>
>> 712/790 qemu:block / 
>> io-qcow2-150                                                 ERROR         
>> 5.24s   exit status 1
>> 777/790 qemu:block / 
>> io-qcow2-copy-before-write                                   ERROR        
>> 16.31s   exit status 1
>> 779/790 qemu:block / 
>> io-qcow2-244                                                 ERROR        
>> 37.10s   exit status 1
>>
>> This is x86_64 ubuntu 22.04, same as my laptop, so the only thing I can 
>> think is the filesystem type:
>>
>> hackpool-0/home/richard.henderson /home/richard.henderson zfs 
>> rw,nosuid,nodev,noatime,xattr,noacl 0 0
>>
>> Any thoughts?

What output do you get when running the tests directly? i.e.:

cd tests/qemu-iotests/
./check -qcow2 150
./check -qcow2 copy-before-write
./check -qcow2 244

  Thomas


