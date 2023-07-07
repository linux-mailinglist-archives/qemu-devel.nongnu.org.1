Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CB374AC90
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 10:11:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHgYf-0002ZJ-B5; Fri, 07 Jul 2023 04:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHgYe-0002Z1-3L
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:11:16 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHgYc-0006xM-GK
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:11:15 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51d9128494cso1944193a12.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 01:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688717472; x=1691309472;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QaBZtVOgK6LuBIVuOGcFhwUlKUgTAK3ZZXYuQI2MdP0=;
 b=XJV5HDQBou3nJiD1b1IzA1GyTTQgLvbxrkVkArGngdd3ccyjY+uZ7Ci1ndx5FsJZNW
 Bpottu7T0uuEwSWq8eR/W7m/lrBd0BtTkRRnmXPd47C1yj2L8ZlK2WnE8Q1cNhAWZkb7
 mCBVKmRglSQUdsd67ZWuFvliJKpMYaE98tcp2vuKi5XqjcxLfbB/n+AebcprBbZCq+A8
 QuBEVfRuTcc9VwxVLL2puI7Txo1i8thtQ6PzZtbpM0YwgxEEgoiMy7C3cotaqtaTrqyR
 6roj5td0ZCBLF2OHj5RRARXrR8ZZqgpL+rwHLJn/hOTFy7b5Xgsv4mz8oL7xPYK6cVwI
 e5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688717472; x=1691309472;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QaBZtVOgK6LuBIVuOGcFhwUlKUgTAK3ZZXYuQI2MdP0=;
 b=eqHKeKp2J4kW/Ysc/EaS8lAuXW0AHig40rGIzpMtL3egSWYozOYtuxD04S79zrkpXM
 eRXe0ggojNrmWU2Ji+Ii8Tg5Ye3NJLa6txkv+WiKDplJw+nmkazR4kXA07VDIGH7RZZx
 jLE5kSSJ/aU3nC7q47odmv1b+INzBWQyAZcA/KKoY7kfKtLR7FLsAOP4e/Tzm9xk7vWW
 GrGkJQ/ioNpMj6B7+ZACKJLrrshGr5V9dgDp1jqgl3nhXfk95Mu71ozhCfK5qi3o28Kj
 f1ReOnVYptLZqip5FYP02zms75EzNdnz4obN8X3KQGqb8Ulv2hQv8WU8GZF3vZpqjv1Q
 HoDQ==
X-Gm-Message-State: ABy/qLb1YNH+RSa/gRfex1hJmj1YKkBBBmK5jAPBjgpgS1ReqFsentZw
 rhkHPt3E2NJEDDhmU3E1vDQbrA==
X-Google-Smtp-Source: APBJJlGUGOCbVtkoltONT0bpPxb8qup4y0/GRNiLEWlxIj7LF72swZPkJPOj34EqTFCoMCpDL1JSvw==
X-Received: by 2002:a05:6402:890:b0:51d:d41b:26a5 with SMTP id
 e16-20020a056402089000b0051dd41b26a5mr3990890edy.14.1688717472211; 
 Fri, 07 Jul 2023 01:11:12 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 ay1-20020a056402202100b0051bed498851sm1723824edb.54.2023.07.07.01.11.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 01:11:11 -0700 (PDT)
Message-ID: <cdd729e8-6bf7-620f-186b-b816dc0545fe@linaro.org>
Date: Fri, 7 Jul 2023 10:11:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 0/6] target/ppc: Few cleanups in kvm_ppc.h
Content-Language: en-US
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>,
 kvm@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
References: <20230627115124.19632-1-philmd@linaro.org>
 <bf8cc98d-662b-c4ce-2837-a70c79b0e5e6@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <bf8cc98d-662b-c4ce-2837-a70c79b0e5e6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/7/23 09:24, Daniel Henrique Barboza wrote:
> Phil,
> 
> I queued all patches to ppc-next. I fixed up patch 3 to not move the 
> cpu_list
> macro as Greg suggested. If you're strongly attached to it let me know and
> I'll remove it from the queue.

Sorry for missing that earlier, sure, no problem!

> Greg, feel free to send your R-b in patch 3 if patch 3 with this change 
> pleases
> you.
> 
> 
> Daniel


