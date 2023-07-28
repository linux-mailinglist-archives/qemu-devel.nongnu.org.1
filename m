Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C374766A3F
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 12:24:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPK3y-0000Du-7c; Fri, 28 Jul 2023 05:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qPK3v-0000Bf-Ce
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 05:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qPK3t-00085y-QA
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 05:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690537624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjEp4IT1Pu3C8/YB1CFL65lRQcW0UIFIsLBxr2oBMyA=;
 b=d0xS71/vEkFE+6UwTMr7VjGqkU6F94WsO6LJiesOUTqRNbMomQB2Iw/UiWyjvQ+dQgMU1G
 98Vkh6b4Oj1VzAF1Sa2pZCQ+1fzOEqLUH7tZAjbWgjrFMRs/kQXqUTfbvFyUk24T2p0WKw
 eDmlb7iVo0juqjPNqzuebsZwDe3JzQU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-DBp34cRdObqFaB6yarYGVA-1; Fri, 28 Jul 2023 05:47:03 -0400
X-MC-Unique: DBp34cRdObqFaB6yarYGVA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-522a85b4caaso261138a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 02:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690537621; x=1691142421;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MjEp4IT1Pu3C8/YB1CFL65lRQcW0UIFIsLBxr2oBMyA=;
 b=ZO52uTP+upoarP+wT7MVrXBTLv+kniVYXiya3fnyHSWhEK1Z0VxwRaFb7oObIHCOMy
 OOqwGPdePfIHkM4XzohyffweOQ0PMWQGeWrgeEqvuDCrzoa6tT2MpfsF9gsPq5HhNT7w
 deFzCCYBY0Tn+eBWIuB+9qSc+qCjgr13W+32m6CXIMpPG3BNW4OKOiJ2z7rFTrk2oXWu
 QxAVb4Ol5+E6axj0xGwStd5qEXID/wqtHI2OM97sFL8haNPYJX3M8WMkkM7b+0v2cIQx
 pf3I48nB1z49jGXT/HmDdf6vn5U9g1VEAqkJJW1qVBA8ksLv7ipLzPb3NElxoL9ZYJiH
 8IcA==
X-Gm-Message-State: ABy/qLbxVXzcRmIDkPZfmG2Rz6oAT2LOS8NFmgFXHoc/9540C8lS/0id
 9Z6ohp2pS+m6Y40iHTR4jTAdg9ipSJBftZ9ieLK+N1bF4g0t1bsgbLPsWID7lGDpiPEUkFeTVdj
 0vUdCigIcCaI+j/lgSmwfHZQ=
X-Received: by 2002:a05:6402:270f:b0:51e:588b:20ca with SMTP id
 y15-20020a056402270f00b0051e588b20camr5749414edd.8.1690537621779; 
 Fri, 28 Jul 2023 02:47:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlECajQ1dd8WbYozrsJ1O5N/ffFMC+x4xMcnmfuEwWFQortKuE9i0BKtWkI+9bP8Wa76yZE2hw==
X-Received: by 2002:a05:6402:270f:b0:51e:588b:20ca with SMTP id
 y15-20020a056402270f00b0051e588b20camr5749398edd.8.1690537621505; 
 Fri, 28 Jul 2023 02:47:01 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 y23-20020aa7c257000000b005226f281bc5sm1607756edo.25.2023.07.28.02.47.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 02:47:00 -0700 (PDT)
Message-ID: <807ee713-ff9e-5277-3495-5fa4c0b0e86d@redhat.com>
Date: Fri, 28 Jul 2023 11:47:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 9/9] block/throttle-groups: Use ThrottleDirection
 instread of bool is_write
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, berto@igalia.com, kwolf@redhat.com
Cc: qemu_oss@crudebyte.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20230728022006.1098509-1-pizhenwei@bytedance.com>
 <20230728022006.1098509-10-pizhenwei@bytedance.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230728022006.1098509-10-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 28.07.23 04:20, zhenwei pi wrote:
> 'bool is_write' style is obsolete from throttle framework, adapt
> block throttle groups to the new style:
> - use ThrottleDirection instead of 'bool is_write'. Ex,
>    schedule_next_request(ThrottleGroupMember *tgm, bool is_write)
>    -> schedule_next_request(ThrottleGroupMember *tgm, ThrottleDirection direction)
>
> - use THROTTLE_MAX instead of hard code. Ex, ThrottleGroupMember *tokens[2]
>    -> ThrottleGroupMember *tokens[THROTTLE_MAX]
>
> - use ThrottleDirection instead of hard code on iteration. Ex, (i = 0; i < 2; i++)
>    -> for (dir = THROTTLE_READ; dir < THROTTLE_MAX; dir++)
>
> Use a simple python script to test the new style:
>   #!/usr/bin/python3
> import subprocess
> import random
> import time
>
> commands = ['virsh blkdeviotune jammy vda --write-bytes-sec ', \
>              'virsh blkdeviotune jammy vda --write-iops-sec ', \
>              'virsh blkdeviotune jammy vda --read-bytes-sec ', \
>              'virsh blkdeviotune jammy vda --read-iops-sec ']
>
> for loop in range(1, 1000):
>      time.sleep(random.randrange(3, 5))
>      command = commands[random.randrange(0, 3)] + str(random.randrange(0, 1000000))
>      subprocess.run(command, shell=True, check=True)
>
> This works fine.
>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   block/block-backend.c           |   4 +-
>   block/throttle-groups.c         | 161 ++++++++++++++++----------------
>   block/throttle.c                |   8 +-
>   include/block/throttle-groups.h |   6 +-
>   4 files changed, 90 insertions(+), 89 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


