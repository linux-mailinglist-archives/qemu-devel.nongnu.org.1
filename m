Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F24F746AD4
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:40:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGaci-0000Xy-Bv; Tue, 04 Jul 2023 03:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGacg-0000X2-79
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:38:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGacc-0002bk-4Y
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688456325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZr7XeWrA9whrigxsfjGFrN++6Y1VwZq7Kktv4r27KA=;
 b=R6hDMdgtWgP0j/fJf9xezqPC0bYIdEkvgCd3pkkbuiFq+tiqYZQeO5jTrodvsinhJYweTG
 Yx9R0B3UHEBu8C03/gmLWsz4xbEAzlqGAYE6SQ76FYSNBoIBezbExuXxmvh/LuZtDIPIaD
 XgFQ6493Pfp6aADyaQIzx8iwl4MFFo0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-yoqymspxP26o2Jr6DP_p_A-1; Tue, 04 Jul 2023 03:38:44 -0400
X-MC-Unique: yoqymspxP26o2Jr6DP_p_A-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4ecb00906d0so4903215e87.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 00:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688456323; x=1691048323;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GZr7XeWrA9whrigxsfjGFrN++6Y1VwZq7Kktv4r27KA=;
 b=il+Vj1h/zETSb8jHlv7JKalZC5lvn5Uo1zC4g5u3zyDs5WDNCQOjYPNh4OdQtIc8uT
 3L0rPlcSkbYk6TfwIdHx/lYdEkYy6clDTRu8ordOSbQJScJY2tdAOVBS0u8bsCr23IoR
 yxfXLIaL7RK5A4/37zw+XaDbwxkPiLWnnLj+9q3JKOPcZWgrpGWuU7S1qPgu16YIZLOG
 lkGNTW3oK7/7dgXRJ3mNmhNQuTbZ3Z9KCqYog2Z3duytUmH/1GwtOnb9+mfR2oTjPcZS
 B0SdUaetoxedY9N1uZOJolwaewnml3QKUMUGp6CWmJSPzXhxYGRNrR/v3YoDupLixUdU
 SDCA==
X-Gm-Message-State: ABy/qLYzksT8jnECJ0lDCOV7p4sinRacq+vljMBdd5g24qAPbRDSpXdR
 zRsl3DXiaMfDGDbC7OeT1IahNGX/hEiABP28ZwBHdZ9U0+FRhXTxXyDFfclaHFyH1UjGkuYSL98
 Os5CqYXj+WAlj0iQ=
X-Received: by 2002:a05:6512:3683:b0:4fb:7626:31a2 with SMTP id
 d3-20020a056512368300b004fb762631a2mr7920244lfs.43.1688456322934; 
 Tue, 04 Jul 2023 00:38:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEzfbVKkoPDDAi4f8AB+Va++PhzgpCZBCTstRz0+ihBLPmIQHZdLb8Que3OvGLnqrLs3HL4OA==
X-Received: by 2002:a05:6512:3683:b0:4fb:7626:31a2 with SMTP id
 d3-20020a056512368300b004fb762631a2mr7920231lfs.43.1688456322548; 
 Tue, 04 Jul 2023 00:38:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2?
 (p200300d82f305a00b30de6bc74c3d6f2.dip0.t-ipconnect.de.
 [2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2])
 by smtp.gmail.com with ESMTPSA id
 n20-20020a7bc5d4000000b003fbe0da2a06sm1298187wmk.28.2023.07.04.00.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 00:38:42 -0700 (PDT)
Message-ID: <4ad5f5f5-ea7d-4619-6d8c-cb3cdf629860@redhat.com>
Date: Tue, 4 Jul 2023 09:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 02/12] target/s390x: Fix EPSW CC reporting
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-stable@nongnu.org
References: <20230703155801.179167-1-iii@linux.ibm.com>
 <20230703155801.179167-3-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230703155801.179167-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 03.07.23 17:50, Ilya Leoshkevich wrote:
> EPSW should explicitly calculate and insert CC, like IPM does.
> 
> Fixes: e30a9d3fea58 ("target-s390: Implement EPSW")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


