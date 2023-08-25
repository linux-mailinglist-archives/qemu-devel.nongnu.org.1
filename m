Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D29788886
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 15:25:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZWoc-0003Hg-K6; Fri, 25 Aug 2023 09:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZWoY-0003GP-9i
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZWoU-0002Ec-BX
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692969921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBm+dFzhR/Sa5cY+lnGTcHY2ZTS1ltDxAgoeNtKT0h4=;
 b=WjsiG9ObXD+xxBu6CSiJj5ssdtq60LQa1puzH58OhxoB53r1wjdNBqSXL+YzfXy2WoYhrV
 M9QImEl6UhLB6Y47ER73Gj7Yk7GcOw/Ec9edqfcMyCEI22M+jxIOuoJpP6KH6rzoCGguXR
 BQ++ortl0Y3AlmTcR9brbvTX12Xg2FQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-bKeKT23UOfWOqQPExjhR_w-1; Fri, 25 Aug 2023 09:25:20 -0400
X-MC-Unique: bKeKT23UOfWOqQPExjhR_w-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5218b9647a8so850122a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 06:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692969919; x=1693574719;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EBm+dFzhR/Sa5cY+lnGTcHY2ZTS1ltDxAgoeNtKT0h4=;
 b=GS1FCxgtRJOdO5amBH+Cs0zHlGXoveYteitbYLfnQO/z5caM2MgESChJisPNjtAeUX
 xmJEr9aWlDK6SC0+2pKeyVsw8VUmGHdmYblubrzWrIs3jiK7OOJ5Z6Q7SwJES4UpmmJm
 GIKc0SLC5jGj95/YDu26LwcNBMYpyxxR2aN2k9Sux3oB/nbPv2NGtLt1y0zBFGs8rNW/
 1JG1Kdh6eQHW8/MsW9nqCTSmT5SUFDS7rDxV/Q+1y4trv84WtRVXGQsKHssFmV1mV0gW
 Cwwy75qkVolRWEKRaOWt9UYmLKwgF2Ixt3RnhhB66IO7GM6DQ8boNJkvjS2pG/E1H66N
 8Mdw==
X-Gm-Message-State: AOJu0YxXDFOdF6PcJWFt9q9FRGSJOiMCS/ubiT8g5gukS8pe2UEHkbxB
 HVmF3dRSNl1tnTYeaNdB3CZTikIkuuSrTobefWfr5D248A5szbIjJlCeHp1lphd6PZMnHXVbFs+
 sQF59RdSFwX4qp4s=
X-Received: by 2002:a05:6402:2051:b0:523:cbc0:8d2d with SMTP id
 bc17-20020a056402205100b00523cbc08d2dmr13340774edb.18.1692969919171; 
 Fri, 25 Aug 2023 06:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgiYtbgXvdjVHrY+pC1QJCBXZXR++6V6xKXSyT+8kkdR4aNU6eSdJdDxtYKR5azRHvFEJuaA==
X-Received: by 2002:a05:6402:2051:b0:523:cbc0:8d2d with SMTP id
 bc17-20020a056402205100b00523cbc08d2dmr13340761edb.18.1692969918810; 
 Fri, 25 Aug 2023 06:25:18 -0700 (PDT)
Received: from ?IPV6:2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37?
 (p200300cfd70f5ee06d7a84866b838d37.dip0.t-ipconnect.de.
 [2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a056402185500b00528dc95ad4bsm1010825edy.95.2023.08.25.06.25.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 06:25:17 -0700 (PDT)
Message-ID: <21064da8-3ced-decc-47e1-3b4528320436@redhat.com>
Date: Fri, 25 Aug 2023 15:25:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 0/9] Misc fixes for throttle
To: zhenwei pi <pizhenwei@bytedance.com>, berto@igalia.com, kwolf@redhat.com
Cc: qemu_oss@crudebyte.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20230728022006.1098509-1-pizhenwei@bytedance.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230728022006.1098509-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.57, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 28.07.23 04:19, zhenwei pi wrote:

[...]

> Zhenwei Pi (9):
>    throttle: introduce enum ThrottleDirection
>    test-throttle: use enum ThrottleDirection
>    throttle: support read-only and write-only
>    test-throttle: test read only and write only
>    cryptodev: use NULL throttle timer cb for read direction
>    throttle: use enum ThrottleDirection instead of bool is_write
>    throttle: use THROTTLE_MAX/ARRAY_SIZE for hard code
>    fsdev: Use ThrottleDirection instread of bool is_write
>    block/throttle-groups: Use ThrottleDirection instread of bool is_write

Thanks, applied to my block branch:

https://gitlab.com/hreitz/qemu/-/commits/block

Hanna


