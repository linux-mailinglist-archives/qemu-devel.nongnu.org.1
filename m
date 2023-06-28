Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39377740D04
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 11:35:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qERYx-0006EB-Sc; Wed, 28 Jun 2023 05:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qERYw-0006DZ-6b
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 05:34:10 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qERYg-0007f2-Q5
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 05:34:03 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-991aac97802so461021066b.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 02:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687944833; x=1690536833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ec6r5akzGewRJ7+7ce+plzjZVn8nN0iVNZG3u753EhM=;
 b=kkiQJ4kI1iFvI4CR4ddhuEHFCJASJlbAw6ByUtTIToMfKPKTufwf4nWb/J5cgLFh+a
 0Krqhi0n6IBH2IUwPylKdmkoA5g0VW6wgq2leNxFFFLYIK1HNkfH3nFLeK3RDggWNHDh
 mAUXH2Qa8ztuMj7KOzZONmnbPfGZK17BN22v3bx8CsV7dKBdpfLSaPwoiCn6+bwtMHpN
 grp9hSEPXmlX16GcZnE0VbUvyOl7Ov8cH9ipti+v1zFiyI/fCSt9vZw7t56j3diHM7mu
 ahanb/ul3v4t55Sv/14LPp6WyljyKLIxVWS2SVvPl4Aecktbvsw47D+Qda9PuxPKpNvZ
 HfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687944833; x=1690536833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ec6r5akzGewRJ7+7ce+plzjZVn8nN0iVNZG3u753EhM=;
 b=UAfc4JGv3yOC/u/2TVIXpU/7/bcAXK5/FeljpQpMfhccr2iAb4ronKMKA2HmH+zRy+
 cho8Ui/XenOwtpNaBI0KDYHE50A9UoXtCUvkcyBRHqdd4Tus5FKhyLdBK2lBw2/UoNQs
 iGZGNv24jViarr8sIzMhbDG3AtpRC+ZJs/DHFNjdLu66KRIQrfDWK4swu+9nKvMFSSsE
 vDY1LtGfnfk0igVMumC0jer4Y8VYzWsc5PGN+FQdl8EVB7IOcoAS/p52oQvfatrmk3Fj
 /bSIz+eAJISLtdLii/Y+ws33yl5uhrwGTRdSw/o/Pazo1OZiiTb58kZyC77p7lqr9nqU
 HltA==
X-Gm-Message-State: AC+VfDyYCsYxM8SQXpt4+jK321QiDYGtfvfzcfS+SjxKbjez/TIiyU2u
 pG4y4aKcDIcGi5G+Vuc2/ix/pw==
X-Google-Smtp-Source: ACHHUZ62/17bpm/dcPRkduJBwvVDBz7VCNsEeS/C5YNAnay9fz8pu3DaDr5YjC4Rmjr9Bv1ybVGiFw==
X-Received: by 2002:a17:906:d54f:b0:988:a632:774a with SMTP id
 cr15-20020a170906d54f00b00988a632774amr29047063ejc.27.1687944833102; 
 Wed, 28 Jun 2023 02:33:53 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a17090682c300b00992025654c4sm2062913ejy.182.2023.06.28.02.33.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 02:33:52 -0700 (PDT)
Message-ID: <ba3833be-1b0d-3814-c4de-79375264eb4e@linaro.org>
Date: Wed, 28 Jun 2023 11:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/4] target/ppc: Make checkstop actually stop the system
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230627134644.260663-1-npiggin@gmail.com>
 <20230627134644.260663-4-npiggin@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230627134644.260663-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 6/27/23 15:46, Nicholas Piggin wrote:
> +    vm_stop(RUN_STATE_GUEST_PANICKED);

Calling qemu_system_guest_panicked(NULL) seems to be more correct.

Though I'm not really sure the difference from cpu_abort(), which would also care for 
dumping cpu state.


r~

