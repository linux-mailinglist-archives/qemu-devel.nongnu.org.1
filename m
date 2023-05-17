Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ACF70603C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 08:36:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzAlG-0001m1-UA; Wed, 17 May 2023 02:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pzAl1-0001i2-Rz
 for qemu-devel@nongnu.org; Wed, 17 May 2023 02:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pzAl0-0000Tn-B2
 for qemu-devel@nongnu.org; Wed, 17 May 2023 02:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684305329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5lAhWbMrcn3Vor0+3V+u8UZDAN8MSmW6vmbkDpZWnsI=;
 b=E3lkv0JghleN6aFoUO3N/dvMa8RsweWZyg/sdCA4CjxMFPXw86+iIWx0ePTi+YfVDIFaIe
 y9raEvNrgJO+Pyx4EfDvKynnyc/7K5mT0mQPAltvsy5DLuHVZBEvNn+ixvodD5kjaH8tc5
 KVZsYxMAKGk/nFK6EQBPSIrFmW/pWi0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-gaIEOG6pP2qkF4t-7Y2yaw-1; Wed, 17 May 2023 02:35:13 -0400
X-MC-Unique: gaIEOG6pP2qkF4t-7Y2yaw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3076fc5c278so233171f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 23:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684305312; x=1686897312;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5lAhWbMrcn3Vor0+3V+u8UZDAN8MSmW6vmbkDpZWnsI=;
 b=FX9/EHH08N62fSW7J8OJhu7FkG+OY6wTC2QhU0BAntBHTi4TySXlv+ZoRAG09fZmnw
 f0J6FZ/7uADUxG+f1/aEjWRvov6MvLzMHRMiA6xFWyjRBCtq/IpMx7YZDZEdHC2fwX79
 s7tYf3KFjYq16Dw/vllogZnRK++SXM/SpRc6x5LEWUr7YwbGDXdk0wUgzg8LamRLWG47
 O/UZEmOEdzL2y10zBsIf4+7awkrYgtqRTiyUNv5ChLdkLii+ibV8P6iXi2zURLgPpv9H
 a8RWZEjZETEZd3r3UEzQOuIaaUD0yIks2Lyy4jQX8VnJSzw6i7KrtNTHvlsU2EmPCyIW
 /e/Q==
X-Gm-Message-State: AC+VfDwgp2CcA83OxGWoBuZvRIv0+5V8ShDeKnwCi6I4pLZW9JpppwSI
 0YFYvXzcuD6f1NQH0dCuEXp8mcWuGTwCP1GcGJSg+U5a3tkHHkMla4kANOtcug5bSHcqx8t6Ec4
 DQXBmpX5PBPDcVjw=
X-Received: by 2002:a5d:4a91:0:b0:306:2e62:8d2e with SMTP id
 o17-20020a5d4a91000000b003062e628d2emr31498287wrq.1.1684305312249; 
 Tue, 16 May 2023 23:35:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4RGEdM5wID6eECO805ertfDJvanaEKWcjyiLhjmn5doTbNhYzbGZzFnX7sa9fTIayuJUKBEg==
X-Received: by 2002:a5d:4a91:0:b0:306:2e62:8d2e with SMTP id
 o17-20020a5d4a91000000b003062e628d2emr31498274wrq.1.1684305311979; 
 Tue, 16 May 2023 23:35:11 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-218.web.vodafone.de.
 [109.43.177.218]) by smtp.gmail.com with ESMTPSA id
 z18-20020adff752000000b00309382eb047sm1530756wrp.112.2023.05.16.23.35.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 23:35:11 -0700 (PDT)
Message-ID: <1bf4cc29-fa46-03b3-715d-2cfd4afdf90b@redhat.com>
Date: Wed, 17 May 2023 08:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] async: Suppress GCC13 false positive in aio_bh_poll()
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20230420202939.1982044-1-clg@kaod.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230420202939.1982044-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.666, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 20/04/2023 22.29, Cédric Le Goater wrote:
> From: Cédric Le Goater <clg@redhat.com>
> 
> GCC13 reports an error :
> 
> ../util/async.c: In function ‘aio_bh_poll’:
> include/qemu/queue.h:303:22: error: storing the address of local variable ‘slice’ in ‘*ctx.bh_slice_list.sqh_last’ [-Werror=dangling-pointer=]
>    303 |     (head)->sqh_last = &(elm)->field.sqe_next;                          \
>        |     ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
> ../util/async.c:169:5: note: in expansion of macro ‘QSIMPLEQ_INSERT_TAIL’
>    169 |     QSIMPLEQ_INSERT_TAIL(&ctx->bh_slice_list, &slice, next);
>        |     ^~~~~~~~~~~~~~~~~~~~
> ../util/async.c:161:17: note: ‘slice’ declared here
>    161 |     BHListSlice slice;
>        |                 ^~~~~
> ../util/async.c:161:17: note: ‘ctx’ declared here
> 
> But the local variable 'slice' is removed from the global context list
> in following loop of the same routine. Add a pragma to silent GCC.

I think this should also go into the next stable release (now on CC:), we're 
already getting bug reports about this:

  https://gitlab.com/qemu-project/qemu/-/issues/1655

  Thomas



