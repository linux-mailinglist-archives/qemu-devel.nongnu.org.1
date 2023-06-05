Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 546AA722291
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:49:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q66pS-0000Ta-AY; Mon, 05 Jun 2023 05:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66pM-0000TE-9s
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:48:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66pK-00069u-0f
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685958516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GYVYZuLvdZMl0iMLjQaUuztFa8CeN6BcnVxZhODyVEs=;
 b=IElPIG5//4EA6J1S7U+pexVJLYxvW7VfqpPavuFO5Hz6rN4Je+fQ7qQnMKgfcdc+yu2YTg
 VJW2qB22PMluFqJhjkb8hOLezSKGHLuZz4n1tnb+HoM2ah127VzuEyyuXiTZZ+rutKJ0IR
 LxApEXmqoDubP2slEbDkaj5Stjlid3M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-lpISVM0iM4SSXdimKJzK3A-1; Mon, 05 Jun 2023 05:48:35 -0400
X-MC-Unique: lpISVM0iM4SSXdimKJzK3A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a348facbbso371212766b.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 02:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685958514; x=1688550514;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GYVYZuLvdZMl0iMLjQaUuztFa8CeN6BcnVxZhODyVEs=;
 b=USNd+2SoHe/QXuEA70uX6P1KZah3pioavmaudDydB8DgPWfI/V2erYRr6758R0uux8
 Prq1zzphWQMasPx8TVHtSDOVroxlz5wfCwx9443/zKFyKHCzkmShmQumPZHIGTuWsFDy
 SGBLVnvUx3CnYGNLOM6JQybFts+cs5KcDeiD83zmgzDqdztZtk5HoiLfVFPYZTxCF5kH
 GqUQV4Q2dzd37KARORoP5/qQwyQFJQUnm6QtLJTrYt3grzMm7TAnnlTBLwRe0/ntn8HR
 S/ClnZ+av4Svn/bhJeyBXxiL3vqedzkU2EaBXV0MT+f+AlGe+f++63xRC4jrXYq0aSCC
 zuXg==
X-Gm-Message-State: AC+VfDxeB98WRLYvUXW/XQ5UN3XXlGw5et7g1T2AUGi2WG5T5+21pNSh
 OD8XoJogz7iUI6w8qQA4mgmBOopL8WHn497EJin1wtXJaxViQjvPd0NgfCu2GnrWB54PEFXRsS4
 mwkj5XvmxW5rVsEw=
X-Received: by 2002:a17:907:6e11:b0:94e:8559:b5c5 with SMTP id
 sd17-20020a1709076e1100b0094e8559b5c5mr5731899ejc.64.1685958514344; 
 Mon, 05 Jun 2023 02:48:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4YP4fOTDpkt+1MTHrAmqlM/3j3B5bE+GIHjRKKTDhSULcv9MZpWI2OQMK+iRToKoym1IrCTg==
X-Received: by 2002:a17:907:6e11:b0:94e:8559:b5c5 with SMTP id
 sd17-20020a1709076e1100b0094e8559b5c5mr5731885ejc.64.1685958514028; 
 Mon, 05 Jun 2023 02:48:34 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c?
 ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.googlemail.com with ESMTPSA id
 g15-20020a1709061c8f00b00965a52d2bf6sm4066978ejh.88.2023.06.05.02.48.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 02:48:33 -0700 (PDT)
Message-ID: <c1227ef3-259d-0855-f02c-7d62dd574072@redhat.com>
Date: Mon, 5 Jun 2023 11:48:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] meson.build: Use -Wno-undef only for SDL2 versions
 that need it
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, qemu-trivial@nongnu.org
References: <20230605082748.53989-1-pbonzini@redhat.com>
 <4352552f-67ba-b964-7a7e-b13c9b19a27c@redhat.com>
 <a6fc91db-a4e3-e9b7-ee51-d07cd4982f02@redhat.com>
In-Reply-To: <a6fc91db-a4e3-e9b7-ee51-d07cd4982f02@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

On 6/5/23 11:05, Paolo Bonzini wrote:
> 
>> On 05/06/2023 10.27, Paolo Bonzini wrote:
>>> Queued, thanks.
>>
>> Please unqueue it again, I'm still seeing some issues with the patch 
>> (not sure why yet):
>>
>> https://gitlab.com/thuth/qemu/-/jobs/4411089009
> 
> Yeah, noticed that myself now. 😄

I think all you need is:

diff --git a/meson.build b/meson.build
index 025523f2065..3ec35c96fea 100644
--- a/meson.build
+++ b/meson.build
@@ -1345,7 +1345,7 @@ if sdl.found()
                       #include <SDL.h>
                       #include <SDL_syswm.h>
                       int main(int argc, char *argv[]) { return 0; }
-                     ''', dependencies: sdl, args: '-Wundef')
+                     ''', dependencies: sdl, args: ['-Wundef', '-Werror'])
      sdl = declare_dependency(compile_args: '-Wno-undef',
                               dependencies: sdl,
                               version: sdl.version())

Paolo


