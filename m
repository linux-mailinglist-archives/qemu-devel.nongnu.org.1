Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A19759889
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 16:38:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM8JS-00042T-NT; Wed, 19 Jul 2023 10:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM8JR-00042L-1y
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM8JI-0008Sm-8o
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689777467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rMF0HDiFpD0l5r7/W8RBOzk+xdFlJkpAM9N7P62eZw0=;
 b=MS5JS83B0UkIMZBqA+FUvYwbKmDoG0LlxPwsPVuOt7XrJMRdS2I27/dlVaoZ6mkW5UOiqn
 loOTr8bsOHaAFdYPxbgH6/aQdH3bSOMmotRPR5WC/6FGsedXEFMyS1Rxn8azyx400YX5XG
 o4SvKjvII6dIZ7ATiAMclp9I4MV+HSg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-AkvGXX4xMcmFzSLpC0QKPw-1; Wed, 19 Jul 2023 10:37:46 -0400
X-MC-Unique: AkvGXX4xMcmFzSLpC0QKPw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fc0855dcc5so36940065e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 07:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689777465; x=1692369465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rMF0HDiFpD0l5r7/W8RBOzk+xdFlJkpAM9N7P62eZw0=;
 b=SSrh7B4Yu/vz+H7TsP76ngQrwf5y8eMaoXUA8EsZx95CZq9+DdsXW5dqYJrvqY4zCw
 NEJ8QfhIa2Qc71NVTZYcd8TvMfM1+TmdwncUHYkOKpwhhNZ91HcZJ4j5FvtW+fyAUbB2
 oidhxNqfSmBTDyhataN3ajcQ9X7cFMpKsxHWtZk4HRom8Z9BxTphw5dlLIEdG0rxyDd8
 PsDvAq0sNneXTGVJrudI/mGZXKwjkiMDjEwKqpQ9H1HF/vTb48Z7qXiiOx/hzkCoY4kP
 faIPhEg2PTgR4Fz2SeXj4dHLJQ9b5Mjzg3vngciyRVJezkvnV2/kGeOtrHbw39Cmz6E5
 vyTA==
X-Gm-Message-State: ABy/qLaXPEZwcoFHcXyKqNFRSmU5viojqujntZgv24pIUQTAnpLovVpQ
 5HfHZaZsTwVXcF3alZ/ABdtJK8/T/SCyU4h+cvH/NSxehtp67f0/AFggZ4hJhbF46EzP/FOqog6
 KsBphRN5hjtcKi2Q=
X-Received: by 2002:a1c:4b10:0:b0:3fb:b248:67c with SMTP id
 y16-20020a1c4b10000000b003fbb248067cmr4872759wma.22.1689777465138; 
 Wed, 19 Jul 2023 07:37:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFMEDLv3v7MwEdGthJvxoeOGAJ4im9maNFz6Z13y9sV6f/3iz/NuEvI0ODGNvJsl2Zy68Ge4A==
X-Received: by 2002:a1c:4b10:0:b0:3fb:b248:67c with SMTP id
 y16-20020a1c4b10000000b003fbb248067cmr4872742wma.22.1689777464843; 
 Wed, 19 Jul 2023 07:37:44 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b003fc16ee2864sm1830380wmi.48.2023.07.19.07.37.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 07:37:44 -0700 (PDT)
Message-ID: <0d84400a-37c7-66ca-b0ea-c361e2ff3c53@redhat.com>
Date: Wed, 19 Jul 2023 16:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 11/14] tests/tcg/s390x: Test ICM
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20230719094620.363206-1-iii@linux.ibm.com>
 <20230719094620.363206-12-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230719094620.363206-12-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 19/07/2023 11.44, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.softmmu-target |  1 +
>   tests/tcg/s390x/icm.S                   | 32 +++++++++++++++++++++++++
>   2 files changed, 33 insertions(+)
>   create mode 100644 tests/tcg/s390x/icm.S

Tested-by: Thomas Huth <thuth@redhat.com>


