Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 172277B86C6
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:41:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5mm-0007Og-I6; Wed, 04 Oct 2023 13:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo5mM-0006u9-T4
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo5mJ-0001kr-V4
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696440917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9mGNWR2eIHzZwrrNtg4Fe2Wagt3jKkIBXhtRwz1YWo=;
 b=Ha5KHw/vnvULkuZlol6+sZogWnrt+paRfxzwFoZN8YjTtTyMeLpFxIkdo3iOVBn/BTxHa6
 GWjUKwVQBNtnprQNnWhI56EDz7o2Qg7xPUXKAlEUbnZrU146VSXVU8FXqbW+GDxCAOmRlo
 0KJzX4sQkYxXxLM7BQkXczwHpde9XSw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-LRkGYYapPiSS9ztQuT37xQ-1; Wed, 04 Oct 2023 13:35:06 -0400
X-MC-Unique: LRkGYYapPiSS9ztQuT37xQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-41981d2dc9aso563851cf.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440906; x=1697045706;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w9mGNWR2eIHzZwrrNtg4Fe2Wagt3jKkIBXhtRwz1YWo=;
 b=pfNwiGxsfKmc86VyTeuZGCpQpJHdVXabe2IHjC+cbgYkF5B9+UxRm5VKpXOfP4T2yV
 HMkHBO72bsUs89AzE9eMtCP+TqllOSEojV7u0E570ad89afB00K2XZFhszax3u5SXBQ6
 MNPkmnE1oj9L80anir+Loemy0q1xlBq+0Q14ZV/y4FYKqDB/XLn36n4c0jM+cfvhSKYz
 MkwVEd1vdarLR1coXxpAITo7NyzoxUzXKH1TUQ3n3JmKH6RFY9ZM3Gellf9jWfHS02s6
 FdebFha8/Ls/UQYblIi/5HYSuC3oEj6+U/CPHocYuLyWgEmxkA3WGbBU71ShOE8JPdHg
 6+bA==
X-Gm-Message-State: AOJu0Yw00typdTmFxBVbxD/aPhKKqUnRQR57VxHDdshjgJHKCpIq9Yla
 wA9HGidA9AQH//ggnKZZxIDHU4vb7OmdRzJic6LysHyJ7VxKOYtk5lbtaSej9Jjd0SatbGLKjoX
 aN/uutDfpVQ/KUmg=
X-Received: by 2002:a05:622a:120d:b0:417:d134:31d9 with SMTP id
 y13-20020a05622a120d00b00417d13431d9mr3266082qtx.51.1696440905973; 
 Wed, 04 Oct 2023 10:35:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzv+DgybIaxbAYF8ih4TkBesNNyFeVqe+8wvxt2MtU0OzBeQmfsop1fbyHRDZfgLBTb86uqg==
X-Received: by 2002:a05:622a:120d:b0:417:d134:31d9 with SMTP id
 y13-20020a05622a120d00b00417d13431d9mr3266069qtx.51.1696440905705; 
 Wed, 04 Oct 2023 10:35:05 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 p12-20020ac8460c000000b0041815bcea29sm1357845qtn.19.2023.10.04.10.35.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 10:35:05 -0700 (PDT)
Message-ID: <e13885b5-06a2-599f-e0fe-c5e8f0671742@redhat.com>
Date: Wed, 4 Oct 2023 19:35:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Wshadow: Better name for 'optarg'?
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <14cd0201-1507-bfa8-fe9e-f482c35d21ca@linaro.org>
 <d688281c-d019-c1ff-6927-d1791911c57d@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <d688281c-d019-c1ff-6927-d1791911c57d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 04/10/2023 19.23, Richard Henderson wrote:
> On 10/4/23 03:05, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> I'm getting a bunch of errors for 'optarg' declared in <unistd.h>:
> 
> I thought things like this is why we were trying -Wshadow=local.
> 
> I think it's unlikely that we'll be able to prevent all such cases.

Given the broad range of operating systems and libraries that we support in 
QEMU, I agree with Richard - it will likely be impossible to enable that 
option without =local by default without risking that compilation breaks on 
some exotic systems or new versions of various libraries.

  Thomas



