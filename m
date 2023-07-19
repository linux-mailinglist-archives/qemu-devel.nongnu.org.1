Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F2475920E
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 11:50:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM3mt-00053z-Ee; Wed, 19 Jul 2023 05:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qM3mW-0004ph-Fl
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 05:47:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qM3mU-00034Y-DS
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 05:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689760056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l5lpPxOlivmRQjLmCiz86pz7TBlkqYFVgXEk8xbx6y0=;
 b=ekDkPS5sBdAtZahITNDPOBe4FHXk2z2UARp4rBm0OBfwQPYPOqp4D9zCQMjUTC/afFiPoC
 eWYClEUI2njuFgYmWkZIYg3gu9EnEL2d3IbE9KHziczQ3VQ6NYxRA/8PXOT/RSNti0mOuG
 Jg+58x+YJqg8QvDKECK65P4wNXUi0F4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-PTnHW2a-NE2PgsR4YE8gzA-1; Wed, 19 Jul 2023 05:47:35 -0400
X-MC-Unique: PTnHW2a-NE2PgsR4YE8gzA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso3722927f8f.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 02:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689760054; x=1692352054;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l5lpPxOlivmRQjLmCiz86pz7TBlkqYFVgXEk8xbx6y0=;
 b=A/h8nr/xM5fge/CXIle9951Ho3lhpUzCpj/kD5fEA0R22NunQkx25gV/yhxzPDajrY
 9jkuxtjde0JV0Rkfj+3t8921hCrgrk+mUokv18rYzRcMDAtwAqJDvad/n2S53oiu9zVX
 PlgePS37tSKEdxwokuO2tFeAgvE1AxF/9MpzjgjtE42hgIdUDPHHVdvS+PsBRhuscj2C
 N1mMn7UdpKhuu0u3/rZujZnz+6xA8e1xP80SQEDkXdprfJYimxWesa0im9yQ/lkHiP66
 6XKwV5H+EY9FVe7YtNRo/QTWe3sfKGsFsVnJQWg8h+NziUxkCTn0SXhkydwat6DXDg38
 4rHw==
X-Gm-Message-State: ABy/qLYUHCa6UuXLJCgFFv89TKyECvmHwB6D0UAhUEhmqWVE9tX5+pdv
 Mx14CeoABTivYAKnYBeY+qutPM/GDurP9VHUvMj7U09ZD1urlIm8oId9m+/kmFuk8SkHkIQeGWy
 zCMeiInma3vjKDYs=
X-Received: by 2002:adf:fe49:0:b0:314:1ca4:dbd9 with SMTP id
 m9-20020adffe49000000b003141ca4dbd9mr13720533wrs.27.1689760054516; 
 Wed, 19 Jul 2023 02:47:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEhQameE1MFxsKiq7aZp7eGiQPCIcfoaO3mLHlXEKQMszeTviqRSuG0hwOlrNcTP7xnF8mvwQ==
X-Received: by 2002:adf:fe49:0:b0:314:1ca4:dbd9 with SMTP id
 m9-20020adffe49000000b003141ca4dbd9mr13720520wrs.27.1689760054179; 
 Wed, 19 Jul 2023 02:47:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:4f00:b030:1632:49f2:63?
 (p200300cbc74b4f00b030163249f20063.dip0.t-ipconnect.de.
 [2003:cb:c74b:4f00:b030:1632:49f2:63])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a5d6349000000b0030e52d4c1bcsm4862825wrw.71.2023.07.19.02.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 02:47:33 -0700 (PDT)
Message-ID: <62807a3b-f341-52dc-fa79-e8f72754752c@redhat.com>
Date: Wed, 19 Jul 2023 11:47:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 07/14] target/s390x: Fix assertion failure in
 VFMIN/VFMAX with type 13
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230719094620.363206-1-iii@linux.ibm.com>
 <20230719094620.363206-8-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230719094620.363206-8-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

On 19.07.23 11:44, Ilya Leoshkevich wrote:
> Type 13 is reserved, so using it should result in specification
> exception. Due to an off-by-1 error the code triggers an assertion at a
> later point in time instead.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: da4807527f3b ("s390x/tcg: Implement VECTOR FP (MAXIMUM|MINIMUM)")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/translate_vx.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/tcg/translate_vx.c.inc b/target/s390x/tcg/translate_vx.c.inc
> index 43dfbfd03f6..f8df121d3d3 100644
> --- a/target/s390x/tcg/translate_vx.c.inc
> +++ b/target/s390x/tcg/translate_vx.c.inc
> @@ -3047,7 +3047,7 @@ static DisasJumpType op_vfmax(DisasContext *s, DisasOps *o)
>       const uint8_t m5 = get_field(s, m5);
>       gen_helper_gvec_3_ptr *fn;
>   
> -    if (m6 == 5 || m6 == 6 || m6 == 7 || m6 > 13) {
> +    if (m6 == 5 || m6 == 6 || m6 == 7 || m6 >= 13) {
>           gen_program_exception(s, PGM_SPECIFICATION);
>           return DISAS_NORETURN;
>       }

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


