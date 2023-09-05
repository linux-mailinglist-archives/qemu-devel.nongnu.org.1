Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E67557921DF
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 12:32:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdTL3-0008Nq-TE; Tue, 05 Sep 2023 06:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdTK8-0008Cu-Fl
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:30:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdTK1-00024b-LZ
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693909812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9tkPiFVOtTMBpGZNUGZlRg4YEUIDL3/ZxLyXweQL4o4=;
 b=AKDX7s6dwaziIDt/maNnRVj4n6E5Vk90D9fAwPtwwmEcT2U6ooHZ2xwaJxcLdZpXXrHXzx
 UwSmLsc79ZFQCWLesZ3bqqZjxqwx5VUNAYh/YpiPT3aNb4wXgptCdvBcdGt2p+XwuAvihS
 afYqv3s/8cJpa2sLpF+5bz6XkznUus8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-HjbRWBJMMM6x4wk0utXIWA-1; Tue, 05 Sep 2023 06:30:11 -0400
X-MC-Unique: HjbRWBJMMM6x4wk0utXIWA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4005f0a53c5so15105325e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 03:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693909810; x=1694514610;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9tkPiFVOtTMBpGZNUGZlRg4YEUIDL3/ZxLyXweQL4o4=;
 b=V0hMFk1zxM1LMSOO5ST4jGcU7ui4Ou5L0R/jLHM82l8m0HUv+DkeP+KjfmkCTd0OEp
 E0HB1Ijn8tnohtJavKPEnEkNZhXo07/8ghB/hQKj0u8admi2RlJEUEYxwR9nMSqJM76j
 1l69gf+QJojEurW8aSuFfz2sUHZ/IhOBITcT5mEuaZcHvNgNL0JyknahjgndFJtdjSBg
 UPAmoTdl2WzmSBJa7eZlDf6Ea4lJVn3vdMr5BbeXQ1AuTBKs0LNULdtNCAitMjmnfohv
 EFAZtn76RHJwiQ8NXM4U8U2879/4dIKi71vkQvG6vSH2kThAayV5rmu5FkFWXBCTGBxy
 5ziA==
X-Gm-Message-State: AOJu0Yy9kPbcLrSCRi6W3fI3xo7socrYvFIMvcg1of3B8r+fjF/pxWJ+
 18uVve/vHvtahf9VzVaN16sctyr///TXGSvYrq/XtWQRtRT/XHXUh9riyUMHc3StEPuA8O2kJ44
 5xLNehyMW+GuuhvA=
X-Received: by 2002:a1c:771a:0:b0:3fb:c9f4:1506 with SMTP id
 t26-20020a1c771a000000b003fbc9f41506mr9030001wmi.1.1693909810353; 
 Tue, 05 Sep 2023 03:30:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm5gHFH7QP361n6hFVCLTiM8cfRqiJ8upWB5VV0Peo4VhTOmN/aW9WCf1EEBbhXWti+ero9Q==
X-Received: by 2002:a1c:771a:0:b0:3fb:c9f4:1506 with SMTP id
 t26-20020a1c771a000000b003fbc9f41506mr9029983wmi.1.1693909810069; 
 Tue, 05 Sep 2023 03:30:10 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-5.web.vodafone.de. [109.43.176.5])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a7bc8d6000000b00401c9228bf7sm16408062wml.18.2023.09.05.03.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 03:30:09 -0700 (PDT)
Message-ID: <0b57a1d4-4911-7000-5bd1-a554dc31a987@redhat.com>
Date: Tue, 5 Sep 2023 12:30:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] docs/system/replay: do not show removed command line
 option
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
References: <20230905100757.298689-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230905100757.298689-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 05/09/2023 12.07, Paolo Bonzini wrote:
> Cc: qemu-trivial@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   docs/system/replay.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/system/replay.rst b/docs/system/replay.rst
> index 3105327423c..ca7c17c63da 100644
> --- a/docs/system/replay.rst
> +++ b/docs/system/replay.rst
> @@ -181,7 +181,7 @@ Audio data is recorded and replay automatically. The command line for recording
>   and replaying must contain identical specifications of audio hardware, e.g.:
>   
>   .. parsed-literal::
> -    -soundhw ac97
> +    -audio pa,model=ac97
>   
>   Serial ports
>   ------------

Reviewed-by: Thomas Huth <thuth@redhat.com>


