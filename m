Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 605D9773AC4
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 16:48:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTNzl-0008WQ-E4; Tue, 08 Aug 2023 10:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTNzV-0008ST-Qf
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:47:21 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTNzT-0000tq-G0
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:47:21 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2682e33509bso4116020a91.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691506038; x=1692110838;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YqxlgfwsBzZZJGB03OjTy61Ik0nY2AvqboRprF4VLE4=;
 b=KBpdcEunsMNNdR34XFwsTPMHZBpa99ipPA5oJnGiKRjSXw46c9pgbEwkuoCm6v+Niz
 9/vLCKsmGNES0C1Uq78hQPtkzXU9hYKecpY1KzWkJ6Oma4rkOGkDZdIQElwDizNwiCQl
 7NuKDxNRsMmSA4M+SjdXwYnA9dVm2S6WXyHn59uRq2FhEikxP2p7MJOF6G6CbbazHZjj
 Mt/wP+ZJkkkctRu5YEnCoZKMtGZFETASRUoTX/VjrATflWZX/1m1Xmqw79EfqsPkSC4v
 uO32mjr416/XvBiqTbmUGC9emYX5CChI19Qatvi7NFtEQdj+jRhHZPUutQ6S4VGGq6GV
 DAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691506038; x=1692110838;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YqxlgfwsBzZZJGB03OjTy61Ik0nY2AvqboRprF4VLE4=;
 b=aNexxEqwQI1RT0fX3SbGr2jiFBzEzAYlozn/PWzqeebpZ56SMwFdI5BESh28it5Sd2
 A+UK5A958U6j6/bbHPXtfb5W/zsaMkiLoyxvo0AutA3yY1g+rRFw3tQbh1RyJuuFr/up
 L2a2oNsumVFQ/iPtSrqSBETe/ijdp3i9/qcla9h6Qczbdo+yiqB5uUFelP1kwEhM17rx
 JDdtYZiKdEdwl4LWWNKa+QNTfrK/phuJZMe49uMb17NjuN5vgMCB8nLKaCztbeEeh8r0
 AKGUtMZ0UVbePulWp0LZ3b4dE2jEWihBhdO5LU/wf3ke/wZvzTASx1nZ025G8q/yg3yi
 13mg==
X-Gm-Message-State: AOJu0YyyAmMtheIZpI8G/g+g5vcpEcZ5cHT2T6FQQFwxZKfiExHhv+MS
 FyVnzmovdpzdPZNwEljlE5USIQ==
X-Google-Smtp-Source: AGHT+IGjbwiuDS8MAyMaf9Ca3Uh5TANLm/uFiJlir+EeiSMfS87ZYKN0MXd3NV3FFP4aRdnAfLvH1g==
X-Received: by 2002:a17:90a:4308:b0:263:4815:cb9a with SMTP id
 q8-20020a17090a430800b002634815cb9amr11224976pjg.41.1691506037766; 
 Tue, 08 Aug 2023 07:47:17 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 pq8-20020a17090b3d8800b00267b38f5e13sm8039756pjb.2.2023.08.08.07.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 07:47:17 -0700 (PDT)
Message-ID: <2cdaf4c5-2151-0acf-8bc9-55ab719e874f@linaro.org>
Date: Tue, 8 Aug 2023 07:47:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Add support of callbacks after instructions to plugin api
Content-Language: en-US
To: Mikhail Tyutin <m.tyutin@yadro.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, alex.bennee@linaro.org,
 Aleksandr Anenkov <a.anenkov@yadro.com>
References: <20230808134435.2719-1-m.tyutin@yadro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808134435.2719-1-m.tyutin@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/8/23 06:44, Mikhail Tyutin wrote:
> Initially, we can only call the callback BEFORE instructions. This commit adds the ability to insert the callback AFTER instructions.
> 
> No callback call for control-flow instructions.

You're going to miss whole categories of instructions, not just control-flow.  You're 
going to miss anything that raises an exception.  The list goes on and on.  This is why we 
didn't implement this "after" hook in the first place.


r~


