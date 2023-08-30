Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F09C78D378
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 09:07:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbFHB-0000C3-Nt; Wed, 30 Aug 2023 03:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbFH5-0000Bg-LY
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 03:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbFH2-0004A1-GW
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 03:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693379155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7SQCfDxJvzhIEERVnIQQoRPg9KzwyryGlasM0mGfWMg=;
 b=El1/GOITc9dUp1s4/zZC0k8d+Mbn5IvP+Et3BBIS38nePeIoMzrW490+V0LSZP7L6cxkGp
 j2s5zIwQRUlS3zXjmrilHZf9z33TpC9fNztqnZWMVEwrJ9DtH2ZleT502uAvbhq/hbRrIa
 +mjfrPcWkSxu70gK2PzxQjHMgU3FJCY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-5KuspsiVNDOEdSwOIfjgcQ-1; Wed, 30 Aug 2023 03:05:54 -0400
X-MC-Unique: 5KuspsiVNDOEdSwOIfjgcQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31c5c47807aso3328692f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 00:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693379153; x=1693983953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7SQCfDxJvzhIEERVnIQQoRPg9KzwyryGlasM0mGfWMg=;
 b=PPw4mfEF33pogh0ldIEr7Z5H2nzcJNlJZEORx3b5R9TnYele7zYFc1RXIzPb9n6bbI
 Sa3nEZrhUEOQVdrhzL3IyfBHQS8ZwcBOPk/HFwzpz49nwYNbkaZFhZNUO0VG/CTEhoZm
 2+4buaSg0eKJqC0AwzO6nhuWSZhSx//GLRSR+ZB4t/j0Ni6cLAfCFDCItfyxShyg0zxX
 WMh+iWtLrN5FFrqp2yWVW3CBiIt+8ZRpIPddfC/lXyUfpAdbyIZz1/CCDF+RJNdwoUMG
 x3EWGHFS8WZ+C/wFb3CRcwc19ZeloTmfPapKayjqHIldQOJRhc2Flz4UR8w1LzoU71br
 Rh6Q==
X-Gm-Message-State: AOJu0YzWc7wn0wS4Ys12n8CHHCN60yhYRUxiD/v/JapOA8tGc6pWiLNH
 1Ov1f/lTajTesSrR/8V6e0WBV3NTz/t1UKpblGDa7UYcy+qDLA0ehFLHwFeNgIDRuHXXbvrnwoE
 x5Yw2fbNBDRgo3Ms=
X-Received: by 2002:adf:f1c8:0:b0:319:6997:942e with SMTP id
 z8-20020adff1c8000000b003196997942emr954119wro.8.1693379152996; 
 Wed, 30 Aug 2023 00:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4Je2W4anOCgKluYCPXsuBiE2Y5Yi+sszZPnllNAxTYNsa1t5VgbsnS4GlDEcSoSTcpQw34w==
X-Received: by 2002:adf:f1c8:0:b0:319:6997:942e with SMTP id
 z8-20020adff1c8000000b003196997942emr954097wro.8.1693379152729; 
 Wed, 30 Aug 2023 00:05:52 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-145.web.vodafone.de.
 [109.43.179.145]) by smtp.gmail.com with ESMTPSA id
 j2-20020adfb302000000b0031ddf6cc89csm610480wrd.98.2023.08.30.00.05.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 00:05:52 -0700 (PDT)
Message-ID: <0cdc9d0c-b146-e55f-cd2d-81e6827e64e4@redhat.com>
Date: Wed, 30 Aug 2023 09:05:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 8/8] hw/fsi: Documentation and testing
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org, clg@kaod.org, 
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20230830022638.4183766-1-ninad@linux.ibm.com>
 <20230830022638.4183766-9-ninad@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230830022638.4183766-9-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 30/08/2023 04.26, Ninad Palsule wrote:
> Added FSI document
> Added basic qtests for FSI model.
> Added MAINITAINER for FSI
> Replaced some qemu logs to traces.

Sorry, that's not how we rework patch series in the QEMU development 
process. Please squash the log traces changes into the patches that 
introduced the original code, and please put the MAINTAINERS update, 
documentation and qtests into separate patches.

  Thanks,
   Thomas



