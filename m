Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DD4746AD7
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:40:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGaeC-0001Ca-4S; Tue, 04 Jul 2023 03:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGadw-00012r-5a
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:40:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGadr-00030U-Ro
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688456407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WgIOH4GSLlUb9123PF62xkbUmafbzV8ZfRXZiZ49JLw=;
 b=Y6C/JHanACIL6ptxvFIi/1XBYI4ZZgy2vFfYh6XXpVXMaonu72BjEq7ehsfJM+jmsgdMMa
 WpT/ZPolMt8B6ENPVCK6vGkULROaORUWmvXExUrlTPuXrNN4AEtQjCfQL2ybdcvWwj3DlD
 3L6r9gLnvw/GeDUR9L79uj8m+AnfURo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-gegw0VAgNpek3SXxHCv_Mg-1; Tue, 04 Jul 2023 03:40:05 -0400
X-MC-Unique: gegw0VAgNpek3SXxHCv_Mg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31273e0507dso3064501f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 00:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688456404; x=1691048404;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WgIOH4GSLlUb9123PF62xkbUmafbzV8ZfRXZiZ49JLw=;
 b=MBpyrYwlvqq3P8mx3EkrOaB0PrFgM1Tw6lsPDR0m82/XduibE+md+RkotD/o0X1WC9
 5x5mZgjXSDUQ7Rjkr9nY5pmpen/2kGoczsZc7Ps5my/vTUlQ93N4a1ZMgv9dIbswRfDW
 7HfOgii8y1x8yPFtETskhyWY9ejK2dAIbJtaJdYcUm2MGK/qvKQzIhOs/YQqdB5gTL44
 AgUi7icXSjwJEXfCYAhqlZnbGGXVwDBjjNfSKw9dvM2010+Hq8kbqKFXtH0yStNMNEpE
 l3YolYx85qnwq9Cbty8ID5K1BxRb7oINYOo/qbubTkMr3EKYnJxiVVdqa4LQDL3q6HjK
 OBbQ==
X-Gm-Message-State: ABy/qLY2awhs4KgcbHUueZwLJSA0ffDKo2CviWIwaEB8Uu71ZIv/M70j
 8iTuJnypjAB/jkasBGwmObBNo9sNAT9iy5MIhB47I2t648bCrJZFVrukMQGIOaGBruUTCikEFP5
 Q2jeOHbwIstpUAsE=
X-Received: by 2002:a5d:670a:0:b0:313:eadf:b82d with SMTP id
 o10-20020a5d670a000000b00313eadfb82dmr8916250wru.69.1688456404646; 
 Tue, 04 Jul 2023 00:40:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFD0nwoIft7CcG00uTp5TvoGKmORvHeskiN5n1qqDQ8NMex8mnmzKiPMza0VeM6TwMhhp7aog==
X-Received: by 2002:a5d:670a:0:b0:313:eadf:b82d with SMTP id
 o10-20020a5d670a000000b00313eadfb82dmr8916236wru.69.1688456404334; 
 Tue, 04 Jul 2023 00:40:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2?
 (p200300d82f305a00b30de6bc74c3d6f2.dip0.t-ipconnect.de.
 [2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b003143b032b7asm3149597wrx.116.2023.07.04.00.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 00:40:03 -0700 (PDT)
Message-ID: <717cf436-facf-9a9d-f074-b2fc76902bbe@redhat.com>
Date: Tue, 4 Jul 2023 09:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 03/12] target/s390x: Fix MDEB and MDEBR
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-stable@nongnu.org
References: <20230703155801.179167-1-iii@linux.ibm.com>
 <20230703155801.179167-4-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230703155801.179167-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 03.07.23 17:50, Ilya Leoshkevich wrote:
> These instructions multiply 32 bits by 32 bits, not 32 bits by 64 bits.
> 
> Fixes: 83b00736f3d8 ("target-s390: Convert FP MULTIPLY")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


