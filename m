Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1119B792238
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 13:42:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdURh-0005VY-JC; Tue, 05 Sep 2023 07:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdURY-0005VN-Np
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdURW-0000Wk-5b
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:42:04 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-uREqh246PdOOskFqyaIPRg-1; Tue, 05 Sep 2023 07:41:59 -0400
X-MC-Unique: uREqh246PdOOskFqyaIPRg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31ad607d383so1207927f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 04:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693914118; x=1694518918;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oOCdmyDsz6PYqztGDqyG3VhGHwtpfdTOD9dM2ciVqHw=;
 b=CD0WYrAVnJUMfLq7hsIxwNbO8FBL/ult8RIvdAwAGRWDXXe33BwAERZogjFwOKkgZs
 qmOTnhWg4ffDsCOVH+UnhVrrAulXe+4iumkOJMPem6S0WaBxBqhXQHGq4s6vXHLQzpZb
 CZSqh4ug4Umci3EGvgH8jgdZTxc0aOBMpo1k4FI88lyiweFTk+tzMaianoP7BPJ7ZZVA
 IIXfaNj0zTX8vb4bl1V/1gf2VqO6EzXKaOWLvOgOKba3pxLokiydVQC/Xs9YHXsvFAIN
 cQC6swoC4dWIk623QDlCGw54lkWJj+3pjutAnnI+acBo/Ca8NljunnSAegMxtwv1wUoT
 Ulzg==
X-Gm-Message-State: AOJu0YzyBf4vAGm9F6ACqIAe1l1xQOZwod9tZEAOJ6k8/Bvig6CyHbat
 UkDiu22XnYExmOUzZb42LvZpHwYPFwlPIaUUqelmK7UkU0ud3gr7eXgwxGhqnjOdRtHgv33NHm2
 t4R62Gbd1bX9xx54=
X-Received: by 2002:adf:e3cd:0:b0:316:f25c:d0b3 with SMTP id
 k13-20020adfe3cd000000b00316f25cd0b3mr9990935wrm.22.1693914118804; 
 Tue, 05 Sep 2023 04:41:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPwIPGEGnuk/Sj5oCqSIapao8C95Y5Rz9pqC/bhsFBu/1GCFitAUCWzCHewvuzRX3udFUQsA==
X-Received: by 2002:adf:e3cd:0:b0:316:f25c:d0b3 with SMTP id
 k13-20020adfe3cd000000b00316f25cd0b3mr9990925wrm.22.1693914118557; 
 Tue, 05 Sep 2023 04:41:58 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-5.web.vodafone.de. [109.43.176.5])
 by smtp.gmail.com with ESMTPSA id
 bt12-20020a056000080c00b0031433443265sm11523948wrb.53.2023.09.05.04.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 04:41:58 -0700 (PDT)
Message-ID: <89e56b56-44d8-4d87-384d-bb12d4fbc9ee@redhat.com>
Date: Tue, 5 Sep 2023 13:41:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] audio: remove QEMU_AUDIO_* and -audio-help support
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20230905101944.307701-1-pbonzini@redhat.com>
 <12deb1fe-5a9d-ba44-8867-62f674ecfdf4@redhat.com>
 <4c044b4c-87cd-c81b-6d4e-e7c8b8622098@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <4c044b4c-87cd-c81b-6d4e-e7c8b8622098@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 05/09/2023 12.55, Paolo Bonzini wrote:
> On 9/5/23 12:39, Thomas Huth wrote:
>>>
>>> +        dolog("Device %s: audiodev default parameter is deprecated, 
>>> please "
>>> +              "specify audiodev=%s\n", name,
>>> +              QTAILQ_FIRST(&audio_states)->dev->id);
>>
>> You said that you removed the default handling ... so this log message 
>> looks suspicious ... is this code block still required?
> 
> I was referring to the ".can_be_default" argument, maybe I should change 
> "default audio backend" to "default audio driver" in the commit message? 

No, I think it's fine. Thanks for the clarification!

Reviewed-by: Thomas Huth <thuth@redhat.com>


