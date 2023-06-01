Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6536A719BFF
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:23:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hKC-0004IN-Vv; Thu, 01 Jun 2023 08:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q4hK1-00044e-RW
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:22:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q4hJy-0000C5-UE
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685622146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSKD3P83MbZh067oRhg9s3nDZZ4+oIWE19Br1HlCraU=;
 b=DVG+5DRY+jpdLt2GHEUW4LAKWcFaImWubLKEnze0YI8LHgb6BS9oAMInPGGXHSP+Gzo6Bj
 1wihOBxxNco7mpXTu4z8RH9Wev+Pz9Nz8rkyRNXf8RJzQN3I0hjsJfzXCeP0xag30RW5w+
 bGgokx+Uc3ErUAtV/k5xByzzvZADrIw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-SwBEqfVEMQOVMw0uBuXINw-1; Thu, 01 Jun 2023 08:22:25 -0400
X-MC-Unique: SwBEqfVEMQOVMw0uBuXINw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f613f5d290so14462455e9.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 05:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685622144; x=1688214144;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HSKD3P83MbZh067oRhg9s3nDZZ4+oIWE19Br1HlCraU=;
 b=Egjs50yKcUAGOtB5ORRF8PQVIn2nu0VgpD57c/GElTZqFSOuL22aJO0iW7aoEHaF8o
 G84j7wRDkP3QNV9nQww0aa4whgLYhoyv8Vq3TrdvPHbHKCFFkpP6Wif6RXjtmlZzX3uc
 pk+wHwlsOb6i0XoicxFv+sDJBtJmq1MkuFQR56FXBD1eLRZwr8UoRVGPSHQUcc+UM1NH
 UjecVYx8RSrpTcZmt2mDX68tm21V2qo1KYwNJBTy2Um30WFsKyooR2VQbcussaIem/2U
 XhO+eEY9aSJpE5LlO9ffxPk1DgA+QxYShJcfafcmrl0ZiPCGzz30+y+tVA1VIGio28sF
 cQmQ==
X-Gm-Message-State: AC+VfDz0bNFm6xuFEiTZafqTUSER6IOz5c64O+uwiVBVwRnlJB/8NWmJ
 Qk7HWz2d70So2aAqzh2g82bh5Mat6DwcI9IG4fou+kWpkWIpBrVxbQfJHKw/NEfPCgRRR4w+4Ro
 UJ/Z3YiO23/Aj6gdvRy7hDBPI9dgEF5iBZCwvu1Nwnh1x2S2lFBxETaNwjpePox6UFV2cTZk=
X-Received: by 2002:a05:600c:a391:b0:3f6:e79:3a8e with SMTP id
 hn17-20020a05600ca39100b003f60e793a8emr2310574wmb.12.1685622143980; 
 Thu, 01 Jun 2023 05:22:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5G4Whsgtbd9rqAQsVGSj2OviC3/BjR1uf5jkgyn0dy7kw30Bb5mqs7rVdtcLUnFT8/snyotw==
X-Received: by 2002:a05:600c:a391:b0:3f6:e79:3a8e with SMTP id
 hn17-20020a05600ca39100b003f60e793a8emr2310555wmb.12.1685622143572; 
 Thu, 01 Jun 2023 05:22:23 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 n5-20020adffe05000000b00307bc4e39e5sm10274974wrr.117.2023.06.01.05.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 05:22:22 -0700 (PDT)
Message-ID: <b6bd9dee-8503-1c30-87ac-43eb34fe7c31@redhat.com>
Date: Thu, 1 Jun 2023 14:22:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] memory-device: Track used region size in DeviceMemoryState
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20230601121447.272487-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230601121447.272487-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 01.06.23 14:14, David Hildenbrand wrote:
> Let's avoid iterating over all devices and simply track it in the
> DeviceMemoryState.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Not my week for sending patches, ignore this one, it's a duplicate with 
#10 ...

-- 
Thanks,

David / dhildenb


