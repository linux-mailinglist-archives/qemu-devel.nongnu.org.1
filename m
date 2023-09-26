Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E757AED80
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:59:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql7f1-0006mc-IC; Tue, 26 Sep 2023 08:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ql7ew-0006mD-9i
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ql7eu-0004O6-Pd
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695733163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=akB9kuMJm+7SEKJzwdGzYOrLEA/taW/RaLBgoERu5kc=;
 b=F5xUQAGKdF0tXs+t2pp1Ki/xLy67PeHBPw5s1xdm6MhrNIYi5whqlzLph9G5vVSw4jWcvr
 TlnUkwzP3wbk26ahEzPY6HpKeMYJnTSwp2Ab0oGQ2CK+eder9IlsWm1QGfPT5tNbakfZFE
 UtYatjbAxjEREyAy76FX3hfmikp+YL0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-4e-8CfDkMsSMenUjXvRggA-1; Tue, 26 Sep 2023 08:59:21 -0400
X-MC-Unique: 4e-8CfDkMsSMenUjXvRggA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-65b034d7082so87304866d6.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 05:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695733161; x=1696337961;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=akB9kuMJm+7SEKJzwdGzYOrLEA/taW/RaLBgoERu5kc=;
 b=l2aWf9Cdqmgu2enGuh0zUc5K470t04Pvq4NI2KtljTXBJEgeicIolvaSS/FHoQ+Q+J
 FWSkTxF3frq4gZGF+so7CzV5ZKo7QQk9Gk7CGQr6ozOyp2afpkfSmHFuLTfZFU5GSAtP
 EuI+55M+kP2ggjAUxHoa0c7opIz64d8ImyOlu7Wf3BJoU+JT8/FZTVHzmd3ounkJXzZ4
 tr96ozb2AgGZp/q824pIZb+f/fEpuumpHeMVISCjHgRrltxIH8jSrpYWaYbvBBKyiAqw
 7OUD3Zjmp3xURtkPcV1kveuFJhdM0v4sgDmuOecUHcLxzUTpTFVcFw5gp/W+P7W3I4dE
 P0YQ==
X-Gm-Message-State: AOJu0Yw8ojYV4FC6DZQQSbDsJ9kgCqayngBpwhobhi8sJvcusmpV9Kik
 zryJTuiWX51OO2uEzZOtZqpvH/37aA5RFKQ5wV8pKeM8yroZkcVSlVGP5Rgu8aXjA9TiuPTojQj
 +PxLjrornzrth6wo=
X-Received: by 2002:a05:6214:4304:b0:658:9cf2:15df with SMTP id
 oe4-20020a056214430400b006589cf215dfmr9301544qvb.8.1695733161423; 
 Tue, 26 Sep 2023 05:59:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlp+2Bf/aULNoVAKS2F874eVVLb9qZ4GfrKIJrCpZpDKPMZAYfOVXkVAEMuq8Qa8zxIsAzxA==
X-Received: by 2002:a05:6214:4304:b0:658:9cf2:15df with SMTP id
 oe4-20020a056214430400b006589cf215dfmr9301528qvb.8.1695733161075; 
 Tue, 26 Sep 2023 05:59:21 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-114-189.web.vodafone.de.
 [109.42.114.189]) by smtp.gmail.com with ESMTPSA id
 oj2-20020a056214440200b0065af4977ea3sm3228155qvb.24.2023.09.26.05.59.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 05:59:20 -0700 (PDT)
Message-ID: <a20d141c-8fe4-08bc-5276-a5a6c3d08d0e@redhat.com>
Date: Tue, 26 Sep 2023 14:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] m68k: Silence -Wshadow=local warnings in the m68k code
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230925185603.106945-1-thuth@redhat.com>
 <87jzsd3z5q.fsf@pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <87jzsd3z5q.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 26/09/2023 14.19, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> Rename the innermost variables to make the code compile
>> without warnings when using -Wshadow=local.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Clashes with patches from Philippe and Laurent:
> 
>      [PATCH v2 05/22] target/m68k: Clean up local variable shadowing
>      [PATCH] disas/m68k: clean up local variable shadowing
> 
> You guys figure out how to combine them, please :)

Ok, then never mind about my patch.
Anyway, it's getting confusing what has already been fixed and what not ... 
could you please pick up all patches that are available so far and send a 
pull request for them?

  Thanks,
   Thomas


