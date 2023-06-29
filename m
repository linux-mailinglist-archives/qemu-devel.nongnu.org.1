Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD5B7423CF
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 12:16:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEoh4-0007Rv-Jg; Thu, 29 Jun 2023 06:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEoh2-0007RV-0e
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEogz-0004UZ-5B
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688033759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+o2Z+AY3SMhCmVLLuNUdY5h3t7GxmtiWYbpQ2O5ZK8=;
 b=IQx2GAsRa0Qng9lvLtPXStIlYP84FFsXFKTbDmQVtVnluaPfxOUb2jIikwoVAfN0kOkV5v
 SY6eVRMBYFcDrhbjBTGeAMBic3GRzZzV55zQfqn6+pbEweQmth/+sDtuBjMpwrhBrh9viX
 Wt9Ac7tvd/3qznsuEMp11xqE5eLj/kA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-93Us5fxBMqeNCLRRv7Rf6A-1; Thu, 29 Jun 2023 06:15:58 -0400
X-MC-Unique: 93Us5fxBMqeNCLRRv7Rf6A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f81f4a7596so2943315e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 03:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688033757; x=1690625757;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V+o2Z+AY3SMhCmVLLuNUdY5h3t7GxmtiWYbpQ2O5ZK8=;
 b=Rf4EpraXuJqC+hyc0hcft20lJ+qKGJ5ZbDj44b4ZeCXOXMlY/qeVos/TTHw1nWykcv
 k+I/2xh0KHP+lzh6P8jkjcGxBVSYLEq/HK1vc6wiSSGVrzE+Wle5M9wjSJ843Th4Dl+B
 j/6dQT2mVC6m9r0mONRqwVgyWnZC9QwF2JPmbkax2VTgvD/k9bY6MH99BTiw/lM3Muc6
 AQm/7WOjlsRX2x6Ct0fnxbX8c3U6gxVp5zLwZ+seY5HJGctLia343esGYviAPCmq53Rk
 uD58VyzQbVtbOD5fj1n6KhzblxWpl4BSnHPblluI1gIfH2e905roIueZ3w9txRa/s4Zx
 m7wA==
X-Gm-Message-State: AC+VfDyHVT5Y5fzRk9I1HBJJCHQGUtvrrxWeqfJsZ/7Mx/QsOIEZ3sqT
 r2/Y2ZobrmckC6bJbmt1I8rS5qmCaR39ciQRyNx/3Ze62oIYR5kgMJChMIYCV9rrHSCyOgL0Qkl
 8ZH8WRha0N0i93cw=
X-Received: by 2002:a7b:cb99:0:b0:3f9:c9bc:401 with SMTP id
 m25-20020a7bcb99000000b003f9c9bc0401mr19761166wmi.33.1688033756959; 
 Thu, 29 Jun 2023 03:15:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5g3Oz67Pa9+F1Nrp26h2qdCUhCqDhYdEuGmdWEMKKBlVf9q3m9iN5I6q21ex6yE6vIDB5jrA==
X-Received: by 2002:a7b:cb99:0:b0:3f9:c9bc:401 with SMTP id
 m25-20020a7bcb99000000b003f9c9bc0401mr19761154wmi.33.1688033756651; 
 Thu, 29 Jun 2023 03:15:56 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a7bc8ca000000b003fbad1b4904sm4795032wml.0.2023.06.29.03.15.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 03:15:56 -0700 (PDT)
Message-ID: <3b47989a-1efa-df45-c49c-0ae77b4679b6@redhat.com>
Date: Thu, 29 Jun 2023 12:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [qemu-web PATCH v2] Fix installation instructions for
 Debian/Ubuntu
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
References: <20230629092425.183618-1-thuth@redhat.com>
 <3021d649-84ce-fc61-4788-3102258eba41@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <3021d649-84ce-fc61-4788-3102258eba41@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 29/06/2023 12.09, Michael Tokarev wrote:
> 29.06.2023 12:24, Thomas Huth пишет:
>> There is no package called "qemu" here - thus use the two meta-packages
>> "qemu-system" and "qemu-user-static" instead.
>>
>> While we're at it, add a note for people who might not need all
>> emulator binaries - in that case it makes sense to have a look
>> at the list of available packages first.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu-web/-/issues/8
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   v2:
>>   - Separate the installation instruction for system and user-mode
>>   - Add a note for people who don't need all targets
>>
>>   _download/linux.md | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> This looks like a -trivial material, I can pick it up and it'll go
> there if no one picks it before.

No worries, this is for the qemu-web repository, I can commit it there directly.

  Thomas



