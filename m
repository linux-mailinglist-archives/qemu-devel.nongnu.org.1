Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CDA70E95B
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:06:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1b4R-0006lb-VT; Tue, 23 May 2023 19:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1b4O-0006l1-T9
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:05:32 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1b4N-0003QD-BX
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:05:32 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-25367154308so219869a91.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684883129; x=1687475129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i0qDhaWHJ2m0RXLCNjVzVRYeuNpjl1GZQDKkg7X2g1A=;
 b=ZQBNexeQe3RG6Qt/YY+f2a7CfqZlOYB8Seb/aj6OHLY3VVaiq5fi3j05UqYFnx+plL
 UGsE/Zicm+A8thGS6YkOBy+UP62m8bMf6ZJuqcQ5m+QMax19YAN6UHlLWDkvAa0EItJS
 nBPNDaEWaiKwL+MJYc0mlJ22AKDWzkNgP1N7QGWDNl3nR9u6Qp8WEan7CX9e/BonBVmt
 yCfx8HTYiM3weqh5NyXx0zoJYFxAdYu2L5VsAhwX+m29kHj4YeX0yEp3rxSW+a6SDVMk
 Rz4abknFfoRG2D5Ki6rKgfSZegeeoJNBx2o1yEwKqhKbicGwnp4KkEDaFvuu0kr9/tqE
 duzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684883129; x=1687475129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i0qDhaWHJ2m0RXLCNjVzVRYeuNpjl1GZQDKkg7X2g1A=;
 b=MZ2ZuCg1hiUlEvRzj+F+cfBoV0am3h/u+bPIM1zAnLBEWJK6GrRc3yZWvNWWu7Mo8e
 isFnXfzktm0643374fztc87m0uvTZsJ6aH54b7he4QXKBXYRPPg5noLot7hZGXMjYKpA
 LBqJ/tZTdNB4IUXAhlUswhuY360/1taEu79ZaUmMmU1V0vI0nRnSidx6metCQ1Ah6F6e
 BDk2YRYHeWOsG2hMfZnkbmL90Iaz/NMpggiAfUY2q4KrWheKywdr3YwZTyDZqoma/4vq
 dLvRDrONc/m+geIgiB9iZ210XsmAACoypaxGax1bJydNPkAvjK8jaPNYNlipfdVb26vc
 8+sw==
X-Gm-Message-State: AC+VfDy7g59PvlHGn8fifaV/FZGZA80UOrhPFUwLtP2o5NZYEncVCDrV
 pT7nxzHjjDthEPEa2DOZe/MftQ==
X-Google-Smtp-Source: ACHHUZ5U8SEdpEU9w1+on1uGba2WWUWe08/zIq+bqApJwLL8geuPXNwLyr0kPc0LojnRkgM2+mCEVw==
X-Received: by 2002:a17:90b:38e:b0:255:33ba:7bf8 with SMTP id
 ga14-20020a17090b038e00b0025533ba7bf8mr12104326pjb.23.1684883129722; 
 Tue, 23 May 2023 16:05:29 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 ge13-20020a17090b0e0d00b002310ed024adsm88409pjb.12.2023.05.23.16.05.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 16:05:29 -0700 (PDT)
Message-ID: <de43b8bf-e7ba-072b-1c9c-48e0b5c5aa1a@linaro.org>
Date: Tue, 23 May 2023 16:05:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 10/10] accel/tcg: include cs_base in our hash
 calculations
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Eric Blake <eblake@redhat.com>,
 libvir-list@redhat.com, Yanan Wang <wangyanan55@huawei.com>
References: <20230523125000.3674739-1-alex.bennee@linaro.org>
 <20230523125000.3674739-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523125000.3674739-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 05:50, Alex Bennée wrote:
>   static inline uint32_t qemu_xxhash5(uint64_t ab, uint64_t cd, uint32_t e)
>   {
> -    return qemu_xxhash7(ab, cd, e, 0, 0);
> +    return qemu_xxhash8(ab, cd, e, 0, 0);
>   }
>   
>   static inline uint32_t qemu_xxhash6(uint64_t ab, uint64_t cd, uint32_t e,
>                                       uint32_t f)
>   {
> -    return qemu_xxhash7(ab, cd, e, f, 0);
> +    return qemu_xxhash8(ab, cd, e, f, 0);
> +}

The last two arguments are 32 bit.  Better as

   qemu_xxhash8(ab, cd, 0, e, f);


r~

