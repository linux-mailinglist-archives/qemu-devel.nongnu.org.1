Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C41397A60BA
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 13:09:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiYbB-0007Z3-Vd; Tue, 19 Sep 2023 07:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qiYb2-0007Vx-Of
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qiYay-0003lF-0W
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695121721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bm7nvchheDtinawKhHnyKGOlFrqEGYvPPdB6vm6lJbU=;
 b=UkAyQKOHKyMuswFl1Czpi8rEqGUhBpt9n3EU7mcsqCmwGlvvy9vtovRtRReYFEuHJLPhpy
 x7EWIGj1pOWgjeUjIPvX8uKGW5Gir7oiGWm+PqvseKidFLQTgJTfg7xF/A6++kVf4jALW7
 zQDwygc+jl+7nS3Ve5APSO6kQ3QC7mg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-X_uuSvW2PwOiH1D4AuQxQw-1; Tue, 19 Sep 2023 07:08:40 -0400
X-MC-Unique: X_uuSvW2PwOiH1D4AuQxQw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99c8bbc902eso411217066b.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 04:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695121719; x=1695726519;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bm7nvchheDtinawKhHnyKGOlFrqEGYvPPdB6vm6lJbU=;
 b=TBtd4KT8Dr1Oy7r85DDKuZdkxTg6+Ev8iRYfo2i57UEz2GNSIhc80gOiFOuoZB5x2j
 +/t16dPQ0zK97rsxAo1QGqmXIkUXpE8c3AIfkUTgGkiUtfiqnLnIBmMfNo3SHun9W4F3
 71eSnhsN26gNmcnw77gjP+CZeJhTHbhvNxHy4Cka+3O2OJiSOhwV0xk8hdQxYrLrBvf8
 Sb4LvYeAyMuD0Dg9UljEg4YPFVlqtfDXkb7HiQEL5AlAOK7I2VerCn9+AVRpW0tjloDD
 hSxE7aKfbh/esyZ78/oScVgmPgzaDFUPL/NRxDE7HyQtUP/epSG60tsFaTkRIAIDu3Lb
 rh7Q==
X-Gm-Message-State: AOJu0YxnHoT7fqVkXwZk5Jkqfpgk2RMAXmLcFUMmMlDg2bG1/Nr0MzN0
 CiL67dfefWPl5DcHf2oIRz4crQljKjFBNOi0Iace7gWEEaKbfEP4vFUQNKEShscSIf4EdcH5IbT
 ILYfg3r+jM3u36A8=
X-Received: by 2002:a17:906:1baa:b0:99d:ed5e:cc79 with SMTP id
 r10-20020a1709061baa00b0099ded5ecc79mr10250647ejg.31.1695121719007; 
 Tue, 19 Sep 2023 04:08:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/1cnj6g4a6XuMGCWU5nB82AYI664Lqcegyl5/PIYv47BUULWS6hBiy2abYdrv79tK5T0u+A==
X-Received: by 2002:a17:906:1baa:b0:99d:ed5e:cc79 with SMTP id
 r10-20020a1709061baa00b0099ded5ecc79mr10250633ejg.31.1695121718686; 
 Tue, 19 Sep 2023 04:08:38 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a170906410900b0099cc3c7ace2sm7775577ejk.140.2023.09.19.04.08.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 04:08:38 -0700 (PDT)
Message-ID: <f4fc8c7b-5208-908e-c76e-d9c8735abda4@redhat.com>
Date: Tue, 19 Sep 2023 13:08:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 6/8] iotests/{024, 271}: add testcases for qemu-img
 rebase
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com
References: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
 <20230915162016.141771-7-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230915162016.141771-7-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15.09.23 18:20, Andrey Drobyshev wrote:
> As the previous commit changes the logic of "qemu-img rebase" (it's using
> write alignment now), let's add a couple more test cases which would
> ensure it works correctly.  In particular, the following scenarios:
>
> 024: add test case for rebase within one backing chain when the overlay
>       cluster size > backings cluster size;
> 271: add test case for rebase images that contain subclusters.  Check
>       that no extra allocations are being made.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   tests/qemu-iotests/024     | 60 ++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/024.out | 43 +++++++++++++++++++++++++
>   tests/qemu-iotests/271     | 66 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/271.out | 42 ++++++++++++++++++++++++
>   4 files changed, 211 insertions(+)

Interestingly, the new case in 024 hangs before this series.  So it 
isn’t just an optimization, but a fix, actually!

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


