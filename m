Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC487644CB
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 06:18:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOsAW-0000Vj-N2; Thu, 27 Jul 2023 00:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qOsAT-0000VS-Qh
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 00:00:02 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qOsAR-0001j4-Hl
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 00:00:01 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b8b4748fe4so3475935ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 20:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690430389; x=1691035189;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/yqdaNsi5GrAVWOGVMi2fv2JptWRvTUhD4C2lbwOzz0=;
 b=by9NBLserPxYUQaSQZ0aJhGmnUTkIcvVdzrm+uooPQn4Dv2kxuBXb+2YTvu0WvwKPq
 tyEE3yLz0zRoZm4e2Sjzbm3rLLEQY79J7j1BJQqZvBc6F5leyrOaX5OYHKpZQ6ZgbFHh
 Tcfh5n7RoRx+Al6iyu3SP0gW3gOCRsrTY4Tfbh8TOx7DLTboRFsw78FN9ENYjXMhUKqu
 UZpBzVcNVzbJditNy5Am+b6YVigvfmxGKkudT7ka7b0+7mtPygtIwFbv9v6tmBXd9LfO
 7u9sZaY8LV5/V8qy0FX1flI/RGx9A6QPtmNHG3rMCkVOAnzNchneMHDjMsDpJzG6mJJs
 SbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690430389; x=1691035189;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/yqdaNsi5GrAVWOGVMi2fv2JptWRvTUhD4C2lbwOzz0=;
 b=Iav6lCeyfH3wMnOAzjMz+28iw9DKTylag+4kst1/G21l/ogFc4tEbHzZDOD+LzmjeU
 e6KBdHLPJI1yDhcYxEhL79RF/MyznfzCIySIzj7ClGWa9tft7SBfB4wOLG1znmpmsFUT
 hvR/sQjxip6su6BWaLzuP7apq4OKNc3DlQ9BE5GMl7GINFHJBsxr+4xqGXVOD8gPzh1g
 3pS6SKBzExOXncOpVERtl9AtFQUm5DR5kX8LdUPv0qJSYPIKhA5yRpw4XGAndLZFvoPe
 35PpNT836FSTqIEq9AVQJPSfZlR+nFSOgPf42I8bTN1r/iSqzI3olzU2cl7Ne9eGhgTg
 zcDA==
X-Gm-Message-State: ABy/qLbFNCR+PR3didDNjCtpMKaqwwASboqTAo74xSn4/cLSwo9TE+Nt
 gbC9rTlLJu7t4w5TxhTh1IC2FA==
X-Google-Smtp-Source: APBJJlE9tgiF+DueIeWCj67t03z7AKn1OGlFW3pOHxTPlZ0l/7Fqhlu/bPZKYNpfIW9GyTaTpTX/7Q==
X-Received: by 2002:a17:902:e850:b0:1b6:4bbd:c3a7 with SMTP id
 t16-20020a170902e85000b001b64bbdc3a7mr3647932plg.66.1690430389403; 
 Wed, 26 Jul 2023 20:59:49 -0700 (PDT)
Received: from [10.254.120.136] ([139.177.225.229])
 by smtp.gmail.com with ESMTPSA id
 jk17-20020a170903331100b001b9e59d6ddesm363574plb.124.2023.07.26.20.59.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 20:59:48 -0700 (PDT)
Message-ID: <35f53340-dda3-c25d-41c7-b717da6a9121@bytedance.com>
Date: Thu, 27 Jul 2023 11:59:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] memory: avoid updating ioeventfds for some
 address_space
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, david@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230725112037.1762608-1-hongmianquan@bytedance.com>
 <ZMFbxFnv82AWlzLD@x1n>
From: hongmainquan <hongmianquan@bytedance.com>
In-Reply-To: <ZMFbxFnv82AWlzLD@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=hongmianquan@bytedance.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



在 2023/7/27 1:45 上午, Peter Xu 写道:
> On Tue, Jul 25, 2023 at 07:20:37PM +0800, hongmianquan wrote:
>> When updating ioeventfds, we need to iterate all address spaces,
>> but some address spaces do not register eventfd_add|del call when
>> memory_listener_register() and they do nothing when updating ioeventfds.
>> So we can skip these AS in address_space_update_ioeventfds().
>>
>> The overhead of memory_region_transaction_commit() can be significantly
>> reduced. For example, a VM with 8 vhost net devices and each one has
>> 64 vectors, can reduce the time spent on memory_region_transaction_commit by 20%.
>>
>> Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Should be for 8.2, though.  Please always copy Paolo for memory related
> patches.  I hope Paolo can see this.
> 
Thanks, I hope so. Also, I'm not quite sure what 'Should be for 8.2' 
means. Does it imply that there will be changes to this logic after 
version 8.2?

