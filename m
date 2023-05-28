Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25234713BEC
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 20:56:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3LXs-0001vd-NI; Sun, 28 May 2023 14:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3LXr-0001vK-6g
 for qemu-devel@nongnu.org; Sun, 28 May 2023 14:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3LXo-0000ma-6u
 for qemu-devel@nongnu.org; Sun, 28 May 2023 14:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685300106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxFc2o3FMbesK0zW7Z/kMfXVsp+XUE2tKxamXJBAOPs=;
 b=UlnIOt2Mo2Sww25sLXkP2dwgToyMLT2JLGBRvgpkLIv/59t7rM2iCJ/aixQgSI5rtfl8cK
 v/rzF04FVTFJsjnAnz6O2AMQG5BaqN0wBKsmjIEuNX2CdS7KREU8PSvOb0av0XbF022tXr
 OSMV1DcjxVUSydG9kuhaVlQOQSyeemg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-vfC0aqrjP_W9oP83Mqs2yg-1; Sun, 28 May 2023 14:55:05 -0400
X-MC-Unique: vfC0aqrjP_W9oP83Mqs2yg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30ac4ed46e8so3451321f8f.0
 for <qemu-devel@nongnu.org>; Sun, 28 May 2023 11:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685300104; x=1687892104;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bxFc2o3FMbesK0zW7Z/kMfXVsp+XUE2tKxamXJBAOPs=;
 b=Ls2aC8wYOdb4WLqGNsr0dsHsDjhm/oQ4dEWT4bEAS04USG2NpBWFYbcPdx19Pi3dVX
 qTUFMB105JNIiKiM7S778pwtjviN51pQW2Udq89IUYO3Y2ueFtRIPMJbE2so0VhfvmWI
 ZcO7ePTxJce2OMVHlFHz7ml3FHc+fmT5E0+CpOjoZKwXQc+EpClLSZc1tEb2E1pySKYs
 JueiMfcLHb6MEvgZKP6QxIOw47TWiE/5JOEDtyNfBTI8WpvnZc7PZl4xmSJBTNsApmnP
 IIj4+6bKfgYDPSXtRwQBJhzpfYO47lTjefENDHEQZxt1ZSFm+jXwUzRuEFqEPudaa25r
 vv5w==
X-Gm-Message-State: AC+VfDwpzo9CshoEukb+WwPM1rbrBEyGt8wVISQmPQ9z3x5a3QxVqPbS
 Xf49xUaH0Xr8KWKxKujnqg65CHTzfWfP77XW3OEOkUvMAqT77N8tYMf6HzztgCtXxA1VPybQz9e
 X36ZGJedprKkP9VQ=
X-Received: by 2002:a5d:6e05:0:b0:2f9:8e93:d376 with SMTP id
 h5-20020a5d6e05000000b002f98e93d376mr7492049wrz.56.1685300104155; 
 Sun, 28 May 2023 11:55:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ClvPecWdoxGSV9k1qCv9pETUYX7fOE58UnRs+HL/XTiC6AldEgBLEaLNiwgulDsYTXOYpsg==
X-Received: by 2002:a5d:6e05:0:b0:2f9:8e93:d376 with SMTP id
 h5-20020a5d6e05000000b002f98e93d376mr7492042wrz.56.1685300103947; 
 Sun, 28 May 2023 11:55:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451?
 (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de.
 [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
 by smtp.gmail.com with ESMTPSA id
 a18-20020adfe5d2000000b003079c402762sm11314184wrn.19.2023.05.28.11.55.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 May 2023 11:55:03 -0700 (PDT)
Message-ID: <2fccfeb4-06dd-a8ff-82a3-053295cb83c8@redhat.com>
Date: Sun, 28 May 2023 20:55:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/4] target/s390x: Fix LCBB overwriting the top 32 bits
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230526181240.1425579-1-iii@linux.ibm.com>
 <20230526181240.1425579-2-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230526181240.1425579-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On 26.05.23 20:12, Ilya Leoshkevich wrote:
> LCBB is supposed to overwrite only the bottom 32 bits, but QEMU
> erroneously overwrites the entire register.
> 
> Fixes: 6d9303322ed9 ("s390x/tcg: Implement LOAD COUNT TO BLOCK BOUNDARY")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/insn-data.h.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
> index bcc70d99ba2..e41672684aa 100644
> --- a/target/s390x/tcg/insn-data.h.inc
> +++ b/target/s390x/tcg/insn-data.h.inc
> @@ -486,7 +486,7 @@
>       F(0xb343, LCXBR,   RRE,   Z,   x2h, x2l, new_P, x1_P, negf128, f128, IF_BFP)
>       F(0xb373, LCDFR,   RRE,   FPSSH, 0, f2, new, f1, negf64, 0, IF_AFP1 | IF_AFP2)
>   /* LOAD COUNT TO BLOCK BOUNDARY */
> -    C(0xe727, LCBB,    RXE,   V,   la2, 0, r1, 0, lcbb, 0)
> +    C(0xe727, LCBB,    RXE,   V,   la2, 0, new, r1_32, lcbb, 0)
>   /* LOAD HALFWORD */
>       C(0xb927, LHR,     RRE,   EI,  0, r2_16s, 0, r1_32, mov2, 0)
>       C(0xb907, LGHR,    RRE,   EI,  0, r2_16s, 0, r1, mov2, 0)

Thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


