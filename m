Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C42075907A
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 10:42:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM2jy-0004gY-Iv; Wed, 19 Jul 2023 04:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qM2jt-0004fx-Ns
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 04:40:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qM2jp-00080V-PE
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 04:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689756043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RD/F8QJviL40T4Hsivm9yqgGZLcjkTClxb8Hg6m0zBg=;
 b=dawobXZ4jSxVDLkacKFC/P4f9/0HeDy1v/WLiKFW9C2D1IGWIvbkRodBkt4mzwIJ+S3ojo
 6FoaMMlwMGhQDHVIVNnK4tfkuyNGfumNasUVMy4zWLiimKo4k4ZGEZ3hdCOaCHw/02WtX6
 kF67MNWBBoKK0HEdEXr34qKKL+aU2/E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-XQGZ-wjnPhe1n8kDGXKwIg-1; Wed, 19 Jul 2023 04:40:41 -0400
X-MC-Unique: XQGZ-wjnPhe1n8kDGXKwIg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-2f2981b8364so4048609f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 01:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689756040; x=1692348040;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RD/F8QJviL40T4Hsivm9yqgGZLcjkTClxb8Hg6m0zBg=;
 b=jiiHbq2mT4jx3fvpnwVQshvDif5TRRqfTfLk8Aw37zF1mXDME5rB77m+QQqBg59U2O
 j4k31/M4vxppHxo518pEbmHwX/BKmjvskZiayyIFVFnZl57u7wwx0XLyQtq3tcRQ9k1U
 fPU7AJcbfQtbe9Z+9RA8aDKw9XIKrWKSdGICUVm2q2exfiPY3juaCxJyypeeUX/OCbGS
 nCKACM6M4OazpqU0k4et1bqfcwqQ/iTIVaoSUOBNBPe4uiQPqWEbVZd12UWZNthUj9EY
 eW3/5tayc4vIJ3Zy3jZZRvAJ/5twW7QfjrfNL2flKfP1C1v+LCt/OsanfaubZWh5vtvW
 LixQ==
X-Gm-Message-State: ABy/qLaPr/8IjJeOt57f0K3i0y5LXEeuCdzYFmlgRD2joCDvuMNh+rYF
 VqojKK7ER0tACzrM64XaMAtHjXzg+f1udPC36W/smNy/qitXa7zGlblwJZ4wBJ3QFSJqQ0QjgmH
 jqUeqj8UqMb/M0rk=
X-Received: by 2002:a5d:66c2:0:b0:315:94ea:31ad with SMTP id
 k2-20020a5d66c2000000b0031594ea31admr1643213wrw.66.1689756040400; 
 Wed, 19 Jul 2023 01:40:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFCyM9uBeKKR1UHm0ZIZLbI88lTj0p4VnLmOubxEHpKtIxAbVhi7t9gMCgOMrCHCZn1C9t3nA==
X-Received: by 2002:a5d:66c2:0:b0:315:94ea:31ad with SMTP id
 k2-20020a5d66c2000000b0031594ea31admr1643197wrw.66.1689756040026; 
 Wed, 19 Jul 2023 01:40:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:4f00:b030:1632:49f2:63?
 (p200300cbc74b4f00b030163249f20063.dip0.t-ipconnect.de.
 [2003:cb:c74b:4f00:b030:1632:49f2:63])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a5d4c4d000000b002c70ce264bfsm4711997wrt.76.2023.07.19.01.40.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 01:40:39 -0700 (PDT)
Message-ID: <581f6cc6-befb-4c6e-8ed6-191429d9be1c@redhat.com>
Date: Wed, 19 Jul 2023 10:40:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 07/14] target/s390x: Fix assertion failure in VFMIN/VFMAX
 with reserved type
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230718213531.117976-1-iii@linux.ibm.com>
 <20230718213531.117976-8-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230718213531.117976-8-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 18.07.23 23:21, Ilya Leoshkevich wrote:
> Passing reserved type to VFMIN/VFMAX causes an assertion failure in
> vfmin_res() and vfmax_res(). These instructions should raise a
> specification exception in this case.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: da4807527f3b ("s390x/tcg: Implement VECTOR FP (MAXIMUM|MINIMUM)")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/vec_fpu_helper.c | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/target/s390x/tcg/vec_fpu_helper.c b/target/s390x/tcg/vec_fpu_helper.c
> index 75cf605b9f4..f1671679879 100644
> --- a/target/s390x/tcg/vec_fpu_helper.c
> +++ b/target/s390x/tcg/vec_fpu_helper.c
> @@ -915,7 +915,7 @@ static void vfminmax32(S390Vector *v1, const S390Vector *v2,
>           float32 b = s390_vec_read_float32(v3, i);
>           float32 result;
>   

Why not check for invalid types once first and leave the rest of that function alone?

diff --git a/target/s390x/tcg/vec_fpu_helper.c b/target/s390x/tcg/vec_fpu_helper.c
index 75cf605b9f..e0b2a78632 100644
--- a/target/s390x/tcg/vec_fpu_helper.c
+++ b/target/s390x/tcg/vec_fpu_helper.c
@@ -910,6 +910,11 @@ static void vfminmax32(S390Vector *v1, const S390Vector *v2,
      S390Vector tmp = {};
      int i;
  
+    if (type > S390_MINMAX_TYPE_F) {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, retaddr);
+    }
+
      for (i = 0; i < 4; i++) {
          float32 a = s390_vec_read_float32(v2, i);
          float32 b = s390_vec_read_float32(v3, i);

-- 
Cheers,

David / dhildenb


