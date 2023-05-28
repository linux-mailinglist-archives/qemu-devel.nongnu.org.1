Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1A1713BED
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 20:56:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3LYZ-00026b-DJ; Sun, 28 May 2023 14:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3LYW-00024b-Bh
 for qemu-devel@nongnu.org; Sun, 28 May 2023 14:55:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3LYU-00017o-OP
 for qemu-devel@nongnu.org; Sun, 28 May 2023 14:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685300150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KA8j3PEeQxcyl0HCyxv5ni5fZ26yWXhHnkr6QCIb5v0=;
 b=QfU2FSIyBvVVi++Jou+7l58NCgs8tkIUARdH8e6L1OgGKZfK6t65hkTZl3HATKXfsXfMVo
 Ua9nRLuhZHINxNnisQd7DG3BsDtedw2+XjmNlC4CdfcOpDxNKdQ/OKby1/IYZmUWOHVpco
 j6TUL/NgCVPsHmj+UjKF5cJLolNjcTY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-wj1TVlF5P16fWAhkpQAOzA-1; Sun, 28 May 2023 14:55:48 -0400
X-MC-Unique: wj1TVlF5P16fWAhkpQAOzA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30ade645c59so661948f8f.2
 for <qemu-devel@nongnu.org>; Sun, 28 May 2023 11:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685300147; x=1687892147;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KA8j3PEeQxcyl0HCyxv5ni5fZ26yWXhHnkr6QCIb5v0=;
 b=LLBEDukQpkhZYOtqVhQM1OIGPSmei4IoH6/RUGNdsE3kGrUTR7VdrLx5cuqdg5GCay
 APLYawsua5jniElRSPrJp7jcHmdT6RzJnIJ7zTokb3fQUFCIRe+LP9TPNkkRjJbLCCla
 VMW+fNPkX1GmCZVmVS9oRyzpSQRpWjn3MfN5waxjvRFs5FERfFtp207R96TzynQeniQN
 DoxyBt/5SzXvCaNBdBz+jMuVzXpMTPA/6h8H89D67ZoVYe8kUiXUDWMy4MjnbGsmmsQo
 FJx4G4vPxv00rY/7mGm0SMYE7TtvsopxhRUQATKLqvuNwzWjS+U5boM0RsQ4WV90vPZI
 Un5g==
X-Gm-Message-State: AC+VfDwe84wgDjTdNu1pmYLgPKreYOrxGmpEwzEH+DIun6dPgYVopWD7
 Z6Fl4tAoEpUP/ieOJ0f8DNdROj9KHyux6xIST/vWYjbequ1dwKEE7ycNYClzZZGYKrISeYk3ouQ
 AcZLPZV8prpw92uo=
X-Received: by 2002:a05:6000:371:b0:307:83a4:3d3b with SMTP id
 f17-20020a056000037100b0030783a43d3bmr6774914wrf.54.1685300147321; 
 Sun, 28 May 2023 11:55:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4MtrhvIlIJBIgwP0HG5qvp/DRBTCMyd7NLse7dAHVBSEUeVox0M6mUmoTOHrk7xofOQeGalw==
X-Received: by 2002:a05:6000:371:b0:307:83a4:3d3b with SMTP id
 f17-20020a056000037100b0030783a43d3bmr6774905wrf.54.1685300146961; 
 Sun, 28 May 2023 11:55:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451?
 (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de.
 [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
 by smtp.gmail.com with ESMTPSA id
 a18-20020adfe5d2000000b003079c402762sm11315534wrn.19.2023.05.28.11.55.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 May 2023 11:55:46 -0700 (PDT)
Message-ID: <05da9119-2efe-e629-164d-7a9ee109395f@redhat.com>
Date: Sun, 28 May 2023 20:55:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/4] target/s390x: Fix LOCFHR taking the wrong half of R2
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Mikhail Mitskevich <mitskevichmn@gmail.com>
References: <20230526181240.1425579-1-iii@linux.ibm.com>
 <20230526181240.1425579-4-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230526181240.1425579-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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
> LOCFHR should write top-to-top, but QEMU erroneously writes
> bottom-to-top.
> 
> Fixes: 45aa9aa3b773 ("target/s390x: Implement load-on-condition-2 insns")
> Cc: qemu-stable@nongnu.org
> Reported-by: Mikhail Mitskevich <mitskevichmn@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/1668
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/insn-data.h.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
> index e41672684aa..937e18ea9d9 100644
> --- a/target/s390x/tcg/insn-data.h.inc
> +++ b/target/s390x/tcg/insn-data.h.inc
> @@ -564,7 +564,7 @@
>       C(0xec46, LOCGHI,  RIE_g, LOC2, r1, i2, r1, 0, loc, 0)
>       C(0xec4e, LOCHHI,  RIE_g, LOC2, r1_sr32, i2, new, r1_32h, loc, 0)
>   /* LOAD HIGH ON CONDITION */
> -    C(0xb9e0, LOCFHR,  RRF_c, LOC2, r1_sr32, r2, new, r1_32h, loc, 0)
> +    C(0xb9e0, LOCFHR,  RRF_c, LOC2, r1_sr32, r2_sr32, new, r1_32h, loc, 0)
>       C(0xebe0, LOCFH,   RSY_b, LOC2, r1_sr32, m2_32u, new, r1_32h, loc, 0)
>   /* LOAD PAIR DISJOINT */
>       D(0xc804, LPD,     SSF,   ILA, 0, 0, new_P, r3_P32, lpd, 0, MO_TEUL)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


