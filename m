Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FABB74D1B6
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:35:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInIu-0003y2-O6; Mon, 10 Jul 2023 05:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qInIY-0003oU-RJ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qInIU-0007oG-KX
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688981699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/cAgj2MxnFYLBEMVpJlgLKlu9F4Hbs/CmV+7eg2ncS8=;
 b=ipJ6TpI8ojRkooKnWSa7QOJe3jOivCnWSboIzZmW6/2tRXkkzVP0n47QcW410EfatBxxs4
 wlNNZscVJg30Daq2u2LqeXhUqOMnD6OqmU89g0SzBBLl46ZQTM8s0dzMXR1bnOm/6g4/5i
 IhYzXLQp/si0V5N7r19VPjyujfINhos=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-uwGQ6QezOn2KfrzhBZfbyA-1; Mon, 10 Jul 2023 05:34:57 -0400
X-MC-Unique: uwGQ6QezOn2KfrzhBZfbyA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-63511adcf45so52192206d6.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688981697; x=1691573697;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/cAgj2MxnFYLBEMVpJlgLKlu9F4Hbs/CmV+7eg2ncS8=;
 b=fOOuEcwK2EDA4cHQ5l03wjtOwyY0epsG8MTgD5J7EFqxH1+2akOOGdv5EwLGmU0KU5
 Pdi3eilzL4NVQ82BiXqtl5b8ho047tZSg/7QyoexGkQsZt2brVjhvBAlGK5KgcFyFFrj
 bmiFrt1nSaxC4VSoHOc5vF2zxw1VFwCVxjZhsXJAdAOorezmEQxIgBOAneh0h/tapqJS
 JzJNoqwBIoccGdRK8jgeRnQ/kXNq2tE3GEi0/xw1yhFJ+04zTSDEg6h4DCMDRCI1MffX
 z9kCUHyq5DvoYt7jmxUyUdEx34L+viLJK5qMXLmjmasL+M5r5AcspNW4hFFzPepdIUX1
 +/TA==
X-Gm-Message-State: ABy/qLZWj2aVv51RMTo/XmIBQ7I5rmyxXwZIq7j7v6eQkqLpL5HGzCIC
 IEJGDz/ucV+CS917ZpJBBYZQnjknfbkNaEdhjtDPqTvJHoodLdGs0eA5Y9S366VzezF1xgNggoM
 lPbpEgKSonx6R4NGKKNO5qXw=
X-Received: by 2002:a0c:8ccc:0:b0:626:2e70:1f94 with SMTP id
 q12-20020a0c8ccc000000b006262e701f94mr9679255qvb.18.1688981697210; 
 Mon, 10 Jul 2023 02:34:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHh7Tuk22yiD8Es1QM2WfQlYc2HcnvYThYRaM1bZU4vZLU5Ocbb2qXcmpnCoFMHgiuDxtTHyQ==
X-Received: by 2002:a0c:8ccc:0:b0:626:2e70:1f94 with SMTP id
 q12-20020a0c8ccc000000b006262e701f94mr9679245qvb.18.1688981696972; 
 Mon, 10 Jul 2023 02:34:56 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-116.web.vodafone.de.
 [109.43.179.116]) by smtp.gmail.com with ESMTPSA id
 m20-20020a0cdb94000000b00636e767d445sm5356390qvk.62.2023.07.10.02.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 02:34:56 -0700 (PDT)
Message-ID: <738648c3-677a-3f4d-e2ee-48d7b6c56716@redhat.com>
Date: Mon, 10 Jul 2023 11:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 2/4] QGA VSS: Replace 'fprintf(stderr' with qga_debug
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230710091439.1010553-1-kkostiuk@redhat.com>
 <20230710091439.1010553-3-kkostiuk@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230710091439.1010553-3-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 10/07/2023 11.14, Konstantin Kostiuk wrote:
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   qga/vss-win32/install.cpp   | 12 ++++++------
>   qga/vss-win32/requester.cpp |  9 +++++----
>   2 files changed, 11 insertions(+), 10 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


