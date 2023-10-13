Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 414277C7F23
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:59:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD3S-0004sn-Hz; Fri, 13 Oct 2023 03:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qrD36-0004fC-8K
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qrD33-0006dG-Qw
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697183847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZ81yx83Esuspo/MllHZsYgpqECWGlfFwvTqA7xjPbY=;
 b=fLBFQBHAuKr2HrBuwa9NP7rivAeKrAbITNW00z6y8F8SYHP3ZyAP45+qYkqUKGGbJVsV/M
 KwJLJS0FQ0ZDpRPzHGJr3ztN7TMWNkTV0h9kLEojaSxC4+eQ2eoGZxC35gddOUK7KenxK7
 HhkB/TkLax7CkYwpKquMRnWc+AwgMYk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-4UEDoW1hPUKqyRLUv8oowg-1; Fri, 13 Oct 2023 03:57:26 -0400
X-MC-Unique: 4UEDoW1hPUKqyRLUv8oowg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32d33e3aea5so1288909f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183845; x=1697788645;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cZ81yx83Esuspo/MllHZsYgpqECWGlfFwvTqA7xjPbY=;
 b=ReynJ//VpHaCAIhYCfGuin5XqoMRVeNOkyX44Ei1LFaeBT2zQHbtfN96KXYeZGhZzm
 69SzsUqpBlQ9cteu9+o1w8b5Vw1EUkhISrVqARwZGdb0OKsM9+B/fHtmlfYgkuVMEeQE
 sw0Jo0qU+lABpUga7zkD+gH77vSbXKCBNi6oIzNGDWTV7mfmhvSDXLpo1WpRuXyjr2C6
 YY6+Y5frjfGbp/haeHii8FNPiGml0zKrr0vi/JU7h/3QE8Ca+cgRiQ196BtjNP3cHHjo
 LKYOueHeB3mJpi0DWZLBR18dC6cwKnzFB9e5k8C5GdAJZo82r0winICPTysRZsTKxUrD
 bZUw==
X-Gm-Message-State: AOJu0Yxfpx/kLbz8gZe5JUwDE/82VRK9elnI1XW2vPb/gPfLCgKhBHmw
 lZWm3qjsY4f01o9mH09m7fAU0QfeRhqDIlVF3SjoO8zBtWWY40IBjAAPd3NCga60K8atPFCqlNT
 L2UL2p7Ihs4y8c6w=
X-Received: by 2002:a5d:470a:0:b0:321:4ab6:9b28 with SMTP id
 y10-20020a5d470a000000b003214ab69b28mr22314340wrq.16.1697183845002; 
 Fri, 13 Oct 2023 00:57:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8l2/SV8zW9Q9Y3EMyJyfWERcjcbl7Twl32vZsKUsTwvJZcXxg4tJN6fZNAjNbiskyZH86Hw==
X-Received: by 2002:a5d:470a:0:b0:321:4ab6:9b28 with SMTP id
 y10-20020a5d470a000000b003214ab69b28mr22314317wrq.16.1697183844596; 
 Fri, 13 Oct 2023 00:57:24 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6028.dip0.t-ipconnect.de. [91.12.96.40])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a05600001c900b0032179c4a46dsm20182313wrx.100.2023.10.13.00.57.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 00:57:24 -0700 (PDT)
Message-ID: <2c759236-876e-9169-624e-267d23da1405@redhat.com>
Date: Fri, 13 Oct 2023 09:57:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 26/78] target/s390x: add fallthrough pseudo-keyword
Content-Language: en-US
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
 <18070bd006c48fe9966502ef6877d12a489135f1.1697183082.git.manos.pitsidianakis@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <18070bd006c48fe9966502ef6877d12a489135f1.1697183082.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 13.10.23 09:47, Emmanouil Pitsidianakis wrote:
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
> 
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


