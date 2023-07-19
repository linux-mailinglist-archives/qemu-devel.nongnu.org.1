Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5908675987B
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 16:37:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM8Hy-00033c-AW; Wed, 19 Jul 2023 10:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM8Hr-0002ys-JM
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM8Hp-0008Ct-PX
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689777377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pvbMDOEAjDLYAoA8N5Qw69/qxnJP1NabCfSOWd0pcXU=;
 b=JA1saXLRbPf7TLSNP+ZTQpmexLm8fQMZtsfkhpOgfjlV6S9XkoTejsWLC59Cf4emWFv3S8
 4fr+LIKNv6PvE3erFHfVFLD1uX8kke+l+ZCxg+3ma0pkrezu8R8bqVfD/Vu0nNBWAX/vrZ
 DD0x2TAxJXna1qCAf/5hkuChQg0Jv+Q=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-yQhJKRk7MG6GdJYqDze9ug-1; Wed, 19 Jul 2023 10:36:14 -0400
X-MC-Unique: yQhJKRk7MG6GdJYqDze9ug-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fccf211494so5693799e87.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 07:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689777371; x=1692369371;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pvbMDOEAjDLYAoA8N5Qw69/qxnJP1NabCfSOWd0pcXU=;
 b=Alrz9cJdCCYT4v0+RBy/yv0lpnZ1C0mmv+tf9T2/7R98Iad/CpQTQMQo3hQnI5dimM
 g/rfl3H65MW7hOyzMxTQA88A+7YOLxd/QRBzr3KiBIlNMYnA/IxVNpQPxWzqpY/Q8E64
 C1jOZCMfFZ6NYfyMRbGavyqlDd19SVAnWYt7EKvRMJlXlln9j2pBFaeGr/+7UMyGYJFT
 fV4tywSqRSgd0tlGROMy1zfpj+gj49ry7KPx2hqu47EP0QsFD9q3g5Ld7OEuTns8/8xT
 CUUYccmde0XnZrSequttOyRK58p+T6OrvqS24N7KO9qldQBxvImMjlM6HWkq2pmBsYq+
 X3hA==
X-Gm-Message-State: ABy/qLYnGfG/yxzlHZOOLFi+Q/nVoG7ARr0s/pWFE/BrkC/FAh12Wi02
 m0LMlhywxNZ3QdVNVz0A5voWm26wul2mY65xY5/LfUGaxv7NB5jipl85n3YTm8Hwjrb7Ryf1IPL
 MSo8YTAEIB6+Q6bo=
X-Received: by 2002:a05:6512:3287:b0:4fb:741f:75bf with SMTP id
 p7-20020a056512328700b004fb741f75bfmr47263lfe.16.1689777370991; 
 Wed, 19 Jul 2023 07:36:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEGn5ktEpwtrmEYJz08xD3Oq6HWnphlWp/t+NEbzmacFtpC+ZjsVhkFMuYoku1PzbnHeftLyQ==
X-Received: by 2002:a05:6512:3287:b0:4fb:741f:75bf with SMTP id
 p7-20020a056512328700b004fb741f75bfmr47256lfe.16.1689777370651; 
 Wed, 19 Jul 2023 07:36:10 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 q3-20020a05600c46c300b003fc3b03caa5sm2179225wmo.1.2023.07.19.07.36.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 07:36:10 -0700 (PDT)
Message-ID: <22dca072-98cc-7352-9f26-65d6a067bb25@redhat.com>
Date: Wed, 19 Jul 2023 16:36:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 10/14] tests/tcg/s390x: Test CLM
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20230719094620.363206-1-iii@linux.ibm.com>
 <20230719094620.363206-11-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230719094620.363206-11-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 19/07/2023 11.44, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.softmmu-target |  1 +
>   tests/tcg/s390x/clm.S                   | 29 +++++++++++++++++++++++++
>   2 files changed, 30 insertions(+)
>   create mode 100644 tests/tcg/s390x/clm.S

Tested-by: Thomas Huth <thuth@redhat.com>



