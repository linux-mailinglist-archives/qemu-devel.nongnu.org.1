Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F383976BCE1
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 20:47:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQuOh-0008A9-W1; Tue, 01 Aug 2023 14:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQuOf-00089j-TP
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:47:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQuOe-0005av-D4
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690915623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JY8YIi0xe9P1p7dCxbLkQERCzKBkud8a8PAf0AQ0W6M=;
 b=YfwMXgRkA9luc5eemfJbhk2hddbz3OZIGj4EXf06QCLFY+/NN/+enurNmVGYk9Um10bEoQ
 xwK0lCPdlZG+zJEpoDIH2YM801QsfcmRj2RktyAAFHdKp0YIsf97LhhlkY44v06z5kC0jU
 W4rE/eIWABgvyfo2LPUsDgp4djhO5P4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-FLkwZWaGPGinUqpUqn8TMA-1; Tue, 01 Aug 2023 14:47:01 -0400
X-MC-Unique: FLkwZWaGPGinUqpUqn8TMA-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-56cd299ba92so3241307eaf.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 11:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690915620; x=1691520420;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JY8YIi0xe9P1p7dCxbLkQERCzKBkud8a8PAf0AQ0W6M=;
 b=cqqM9NZ3QxN8U0yGOM/Ruoiq6QN/nBiCN0vs2RHJQnI6mvd/dMN4xooDbjNVSniLeR
 toc6GpKGRrUA1VIPzcRZ+PWvyJ2qgmq+oo58XF+4+t1pF5e+5+h/Tyw2/4iQ0My8FnSC
 VQ8YRmZ3hEcAlv4Nqnq+cbwrbGLLSQegoHjeI4WLWhS+bB7JDIorr6i9onVuaSk2R8Ws
 MWXzhLbagwQJkZIB69DgJecFlrgjHPuyf5OUz6cqmRLsv8moImhyJYYBhlGv24Marp0Y
 rOglLJvh+cq07EaE7aj3ZEgDsW4NrDWBnvEuk2VXNaHFjHQC53Pu+2CQclFtDNdfPFaX
 lW3Q==
X-Gm-Message-State: ABy/qLbZXkb1HXZ0PaeWRtd3NNb+nTROBErZrLMOniHDnC0zH39S2OTm
 aOp2wfhEL9uzmdER/vPNW4yLx+J7pJIp1nwcQDH4MaUwhIg20fxDoMgoFyw8fhhRygCsTqt60dC
 2HCzabtMtLKecqcM=
X-Received: by 2002:a05:6358:339e:b0:139:d5b9:87d3 with SMTP id
 i30-20020a056358339e00b00139d5b987d3mr4459016rwd.5.1690915620649; 
 Tue, 01 Aug 2023 11:47:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHfIdPYbCOnPfObaIfjU/zTVtv6hqvt/8KCj5/AUBZh9RFotHGMQRSarNmtMIoMXRL4UAE5pw==
X-Received: by 2002:a05:6358:339e:b0:139:d5b9:87d3 with SMTP id
 i30-20020a056358339e00b00139d5b987d3mr4458999rwd.5.1690915620369; 
 Tue, 01 Aug 2023 11:47:00 -0700 (PDT)
Received: from [192.168.8.105] (tmo-081-137.customers.d1-online.com.
 [80.187.81.137]) by smtp.gmail.com with ESMTPSA id
 t7-20020a0cb387000000b0063d412a6154sm4602686qve.133.2023.08.01.11.46.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 11:46:59 -0700 (PDT)
Message-ID: <0489066f-83b5-4d15-e8bf-c1cc600f11f7@redhat.com>
Date: Tue, 1 Aug 2023 20:46:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/8] gitlab: speed up msys windows jobs with GCC
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230801130403.164060-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230801130403.164060-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 01/08/2023 15.03, Daniel P. Berrangé wrote:
> This is an alternative and/or complementary to Thomas' proposal
> to use CLang with msys:
> 
>    https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05402.html
> 
> First of all, the current msys installer we're using is over 12
> months out of date. Thus after running the install, pacman then
> replaces most of what we've just installed with new downloaded
> content. Using the most update installer cuts 3+1/2 minutes off
> the msys install time - 7 minutes becomes 3+1/2.
> 
> Secondly, QEMU defaults to compiling with -O2 and this is more
> computationally expensive for GCC. Switching to -O0 drops the
> build time from 60 minutes down to 45 minutes.
> 
> Thirdly, including debug symbols also has an overhead, and turning
> that off reduces time still further down to 38 minutes.
> 
> IOW, between all three changes, we can cut approx 25-26 minutes
> off the job execution time, bringing it nicely within the job
> timeout.
> 
> The actually phase of installing the mingw deps still accounts
> for about 10 minutes and has not been optimized.
> 
> Possibly the same trick of -O0 and skipping -g would also help
> the clang alternative Thomas' proposed. If so, that could be
> enough to let us enable more features / targets during the
> msys build.

I really like the idea! And I guess my idea with Clang needs some more work 
'til it is acceptable, so let's go with your idea for now to fix the timeout 
problem in the CI ... we can still optimize later with Clang in case we 
found a good solution for that ms_struct problem...

  Thomas



