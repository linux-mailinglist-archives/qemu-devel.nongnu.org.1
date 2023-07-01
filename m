Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA68744830
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 11:22:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFWnP-0007pZ-E6; Sat, 01 Jul 2023 05:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qFWnM-0007p3-Ou
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 05:21:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qFWnL-0008UI-9w
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 05:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688203289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wjqyowq607VGCBQhyCIPxxIJY5w8/s2MlVxShcKElGU=;
 b=Nf1jK/x6mLOxzQqEIp4e23nvYPGFn+B33Iozc6EIq0anpvUAQlNEqMotZu69VmUgCgkwTN
 1IOZcFixYRZ5Q9qTQkIwvLQZtAzIhRSwZi4cPG5fRvuu7INKbZl+eLLkw+jtIfJqJhmbQL
 RPgY8AjclqrOSbOMt+tUC1eOCEEcoHg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-q3n_2rvqPgePwEfCDsFvoA-1; Sat, 01 Jul 2023 05:21:28 -0400
X-MC-Unique: q3n_2rvqPgePwEfCDsFvoA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-51dd5868fddso3138582a12.1
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 02:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688203287; x=1690795287;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wjqyowq607VGCBQhyCIPxxIJY5w8/s2MlVxShcKElGU=;
 b=OQ8O4onpLFK+rd1/J8CLnnvL2QCt2BBG+xkTlKy/PRCxu+6iPOcwG7/rNE1718z49e
 xERKRrv+qebmCob6AoT7YLqE0tLHkJb1D12hNItwzkNsmXXR8QP/v0zivYTQgTN01EKn
 q0auJqLkJsMVMtZT+CZUb42sx0tPIP1rNDx+GHF7k2Z0sNxPCgvnqdgQQW+icJUZUHIE
 aC87akBqPTx30SuHJdHHK/3s1BgEDEjER5RPDn6er0x6n1zpOShpEyvQQF+OaWd0C4Tg
 YWvc74v9ByGxwAQ8drooKyTCgrDHyoqgNK/uHBrgo1HRX4oJmbPrg93POsIj8Y/sXHxa
 ncWA==
X-Gm-Message-State: ABy/qLYgO4HyJO8/bkj6z1k1p6npAWlLSE3l5MnaqygDzL+jqNTcCoPf
 3gmr+aB4gHmivg1J8S/y1Gx6HYPRWlbYlFVyxCsqjWkgEzE934WctPAWUIFt/+SQkVU3Q/in6WL
 q0zADEJTAUaFl3tk=
X-Received: by 2002:a05:6402:12d4:b0:51d:a012:ec2 with SMTP id
 k20-20020a05640212d400b0051da0120ec2mr4618893edx.3.1688203287391; 
 Sat, 01 Jul 2023 02:21:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEFZIVxcoTjWndV0Ertiz9mNuT16Z15gDWAt2/yNvamF4OrS9jtOLOUIGgmgPga2idW9W2dYg==
X-Received: by 2002:a05:6402:12d4:b0:51d:a012:ec2 with SMTP id
 k20-20020a05640212d400b0051da0120ec2mr4618882edx.3.1688203287114; 
 Sat, 01 Jul 2023 02:21:27 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c?
 ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.googlemail.com with ESMTPSA id
 md24-20020a170906ae9800b00992f8110a2bsm1344960ejb.150.2023.07.01.02.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 02:21:26 -0700 (PDT)
Message-ID: <6e7f39df-1ad4-d155-6d80-37dd89a28f6a@redhat.com>
Date: Sat, 1 Jul 2023 11:21:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/9] Collapse CPUNegativeOffsetState into CPUState
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, eduardo@habkost.net,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, peter.maydell@linaro.org,
 wangyanan55@huawei.com
References: <20230630122551.21766-1-anjo@rev.ng>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230630122551.21766-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 6/30/23 14:25, Anton Johansson via wrote:
> CPUNegativeOffsetState is a struct placed immediately before
> CPUArchState in the ArchCPU struct.  Its purpose is to ensure that
> certain fields (CPUTLBDescFast, IcountDecr) lay within a small negative
> offset of CPUArchState in memory.  This is desired for better
> code-generation on arm[32|64] and riscv hosts which has addressing
> modes with 12- and 11 bits of displacement respectively.

The purpose is also to ensure that general purpose registers stay close 
to the beginning of the CPUArchState and thus can also be accessed with 
a small displacement.

Can you check if this becomes worse for any architecture?  On some 
64-bit targets, 8 bytes * 32 registers is 512 bytes and it's a 
substantial part of the 11 bits that are available.

Paolo


