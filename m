Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED71D70DDFA
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:51:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SPT-0000R4-Cx; Tue, 23 May 2023 09:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q1SPB-0008WT-M6
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:50:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q1SP8-0001yR-Vu
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684849821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UYl8ByTKSQDr2ZSG9nKYPq4XXdcha9Lkdbdege/HY5A=;
 b=Yj7TrKprGb9la+zUd+0LbBv0Rdc7kwPf+eWwhEqFKnyQoxj7OEGOV/tdy0WgQUL6xZFHy3
 aOHJ6+8092DTAm/ZjmhDduW/FgdU/mBfDG4qy7YvsiDowGChmurmtq7Td3s1BySfqlMD7t
 7UtxMAs7LzK/5iTWRnpnJ5zctr7pBAQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-q2x5aOc9N0OPkbTI-ypnIg-1; Tue, 23 May 2023 09:50:19 -0400
X-MC-Unique: q2x5aOc9N0OPkbTI-ypnIg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3094b683f3dso2274625f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849818; x=1687441818;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UYl8ByTKSQDr2ZSG9nKYPq4XXdcha9Lkdbdege/HY5A=;
 b=QR0nCnAf82dl/hDlomm/fFPiywmhSMA5AK2YEKqsX8Lkhu1eNjsWTa9xhLoSc9JczG
 TajL1uU/AJaD9McM5zCzQQjuSX8N5bbIckl7SQQRTQkrzjOCQW0TWcUqBfuERQ85fjou
 7Cx3nPw9OxFY+jSCHyzupcjB+W28WII8N4EpVUA9BqfTVeyybkJq4WPldkeOggBSHV5I
 Dmq84YNZcvEMxKNkPmAkliFu8vEWIZ2YvROseB/1mbQHHX/VVjkn0KUTfu+KBNOB2kDB
 oufr/OF46zCYx99EdY1zgFzVy8X8Tq5P1d/ORbSnEaNsNRFFS5l4YRDm3vEd4JbojLP1
 +XIg==
X-Gm-Message-State: AC+VfDwOddYC71PCCF8Zxwf37pBkzdwk9tBJl56JfjaU20f9/loWlvpu
 p5eDnwmlgbChRte/usvMLXa5ptI+Mxu5TqewYFlA7nzjvt61txc8XGANh9tRbOLN9E7hZlb7cQa
 GyIUIAondaVRB/kQ=
X-Received: by 2002:adf:fdd2:0:b0:307:8e50:34c6 with SMTP id
 i18-20020adffdd2000000b003078e5034c6mr9897997wrs.52.1684849818541; 
 Tue, 23 May 2023 06:50:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ686ZGdmHaLF0UXyC73xDKSjE3OacBVB33Uy5fC2UNMwUQB0fI1Dr7EHfRQ6IFvyCIjtmLjbA==
X-Received: by 2002:adf:fdd2:0:b0:307:8e50:34c6 with SMTP id
 i18-20020adffdd2000000b003078e5034c6mr9897977wrs.52.1684849818178; 
 Tue, 23 May 2023 06:50:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd?
 (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de.
 [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d4dc5000000b0030644bdefd8sm11197342wru.52.2023.05.23.06.50.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 06:50:17 -0700 (PDT)
Message-ID: <53a49201-d174-936c-10a1-08eaa4d98552@redhat.com>
Date: Tue, 23 May 2023 15:50:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 15/27] target/s390x: Use tcg_gen_qemu_{ld, st}_i128 for
 LPQ, STPQ
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-16-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230523134733.678646-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 23.05.23 15:47, Richard Henderson wrote:
> No need to roll our own, as this is now provided by tcg.
> This was the last use of retxl, so remove that too.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Cc: qemu-s390x@nongnu.org
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/cpu.h               |  3 --
>   target/s390x/helper.h            |  4 ---
>   target/s390x/tcg/mem_helper.c    | 61 --------------------------------
>   target/s390x/tcg/translate.c     | 30 +++++-----------
>   target/s390x/tcg/insn-data.h.inc |  2 +-
>   5 files changed, 9 insertions(+), 91 deletions(-)
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index c47e7adcb1..f130c29f83 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -76,9 +76,6 @@ struct CPUArchState {
>   
>       float_status fpu_status; /* passed to softfloat lib */
>   
> -    /* The low part of a 128-bit return, or remainder of a divide.  */
> -    uint64_t retxl;
> -

Nice!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


