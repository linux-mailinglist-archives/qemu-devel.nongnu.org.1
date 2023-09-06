Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0371A7938B4
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:45:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdp4h-0003jN-I8; Wed, 06 Sep 2023 05:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qdp4c-0003iO-Fp
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qdp4a-0002xv-8y
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693993423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7vefdYlMR/8ArdCua+cW/iz5J210AzDO/E5mu7BSKJE=;
 b=ccTVjIZIYvmAgfsUXB5CjQ4BNq1ExBrYt6AfFF0Rljo6vOcy8x34KPf74N/cfBXdsN61dH
 FxlC4qxpQmmUL8AgI0ny2DcwqEYGx4ygc4jdRC94RONMHYRSm9fKIhXHo/6hN7JvT83SmB
 UEQJrQh2mDHhqQGXIRIQWeFgO3YzaTo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-xTsPfm51PR2tozrFdRZ7Dw-1; Wed, 06 Sep 2023 05:43:41 -0400
X-MC-Unique: xTsPfm51PR2tozrFdRZ7Dw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5009ee2287aso3768978e87.2
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 02:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693993420; x=1694598220;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7vefdYlMR/8ArdCua+cW/iz5J210AzDO/E5mu7BSKJE=;
 b=S7rVtZ/LpxiXE1i1DC7hTAOfQm5RvwCuRkV0U/kiAiXIO5BrZmqRsZzC7Sf8YORllm
 YoI/sl1TUSh3EPfK23/jz0FerDfUi4B3w5XDVc7VeDv0BQUOb+PpXj0tulpQ2lloMYJg
 fX3OYKrCQQZJc4w2/e+uh5Xi2ZKYLvZEJglH/VgbJoPIovL3E80TvmZkLme/6dDEQLd1
 rZZ8HMaJKp/wCkooIHrfAecUig2IHtdwlduQ2drneNj6zjXRj8S9lKqLrqY/k60GFX/V
 ufAqjz9gpSu1OSxKEt8AQQHpeedPlWwINrk6teR8uWVgmluqsC2SEwwiSrbOCi4FDnSN
 /DMg==
X-Gm-Message-State: AOJu0Yyy+CIjf4/4ayR+spkP8x0BIcP1JMVhhK/LZcqdewm4pMvMb6u4
 ZIlSjdeIRewsq/KGN+1PB8fL8uolES2AYyXtGoDtXDZHPctP4Gh+phQ0dD+Q5b4L8j7r99PB74C
 m76HjmZqkc0bCZS8jX/fshbs=
X-Received: by 2002:a05:6512:3b95:b0:501:bee7:487b with SMTP id
 g21-20020a0565123b9500b00501bee7487bmr2207166lfv.11.1693993420462; 
 Wed, 06 Sep 2023 02:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+kyCh8ge5omnOO19l81ywndCSnl3vv4iOpfU70qjIprwIBa/mvZhLPu1h129TM4P09QBp6g==
X-Received: by 2002:a05:6512:3b95:b0:501:bee7:487b with SMTP id
 g21-20020a0565123b9500b00501bee7487bmr2207152lfv.11.1693993420099; 
 Wed, 06 Sep 2023 02:43:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:6c00:92a4:6f8:ff7e:6853?
 (p200300cbc70c6c0092a406f8ff7e6853.dip0.t-ipconnect.de.
 [2003:cb:c70c:6c00:92a4:6f8:ff7e:6853])
 by smtp.gmail.com with ESMTPSA id
 fj15-20020a05600c0c8f00b003fe2bea77ccsm19856818wmb.5.2023.09.06.02.43.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 02:43:39 -0700 (PDT)
Message-ID: <12cb4d92-948b-d87b-8fe6-57e3bbcee248@redhat.com>
Date: Wed, 6 Sep 2023 11:43:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] sysemu/xen: Allow elision of xen_hvm_modified_memory()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Xu <peterx@redhat.com>
References: <20230905122142.5939-1-philmd@linaro.org>
 <20230905122142.5939-4-philmd@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230905122142.5939-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

On 05.09.23 14:21, Philippe Mathieu-Daudé wrote:
> Call xen_enabled() before xen_hvm_modified_memory() to let
> the compiler elide its call.
> 
> Have xen_enabled() return a boolean to match its declaration
> in the CONFIG_XEN_IS_POSSIBLE case.
> 
> Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


