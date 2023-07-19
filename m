Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E612759084
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 10:44:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM2ma-0005kn-Ud; Wed, 19 Jul 2023 04:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qM2mW-0005kU-1Y
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 04:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qM2mU-0002Jk-D7
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 04:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689756213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NLGNbIzsLPoMz4a9R4y33c4wUSjqsYp99tFJaLePP2k=;
 b=KhxYLva+Vg0Q2+8LEAKT2uJNdeLI51mpy7NZBS7J2kyURxughagpWMXZTl+ih2PaWKX/ae
 gQPAMEi95qD49mk6s9+O0TmsNBcGTfzGuYI1pSvY/aY/YS/wgj8sKE9djN+jJ0jOlw428j
 1nWzJMg7wBgytLWuvXYTXJvdExC0XKs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-MjK5c3M9MDy4RIw5SEn7FA-1; Wed, 19 Jul 2023 04:43:32 -0400
X-MC-Unique: MjK5c3M9MDy4RIw5SEn7FA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fbe4cecd66so37680325e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 01:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689756211; x=1692348211;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NLGNbIzsLPoMz4a9R4y33c4wUSjqsYp99tFJaLePP2k=;
 b=ZDsYaFAHtG+4Kinxyk6CrtSj2XG1nAMkM2ypblZ6BxCw6JxYzk9wOqePDweSj5NVAC
 et96TRAmxPXK9fob1m5+APRbHrz7iLpo1yKr8q2Ce6da2OAvOHmsFaaWUcuGmNNKmqJT
 6ImBVVt/+xL1y107/9sJjx+emSymfLQ2sxxGM//gi3x6FeSX8vbscQUqsyQ+/4H0TK4E
 QrpuiZdXizXX4W4b9KnCCizl6ykX/JD9MOrDy+04qMZWkk07jFB2FaiYXfNvIRUnHj6D
 uFgZ5dVRigy4HccxQ1gUPvb5qmHLVfVUWK2PpjBu6zetzhYf0InQyb4TrjbOZjI5n6sm
 gA5w==
X-Gm-Message-State: ABy/qLaqEasKSDL+yLAy6nHkGhpt013Uk3/ellOCYKLf1cdLzA8clVpr
 CItFhKXmBV+pwy/DGgSiAPxCftHGBUb+V2JPDY45ox1R8B3CCGdghjf8HTP+HgKsxLra6yYdCTZ
 KPHFA1qflSqdf1tS+/mIt590=
X-Received: by 2002:a05:600c:b41:b0:3fc:85c:5ed2 with SMTP id
 k1-20020a05600c0b4100b003fc085c5ed2mr1340938wmr.11.1689756211238; 
 Wed, 19 Jul 2023 01:43:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEfCbHDs337j5oHQZNSzZsQZmGNVoNa9wMjwm0zw8UH14wHdVK/hFcrI052INwm+ijZWCRQAQ==
X-Received: by 2002:a05:600c:b41:b0:3fc:85c:5ed2 with SMTP id
 k1-20020a05600c0b4100b003fc085c5ed2mr1340924wmr.11.1689756210863; 
 Wed, 19 Jul 2023 01:43:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:4f00:b030:1632:49f2:63?
 (p200300cbc74b4f00b030163249f20063.dip0.t-ipconnect.de.
 [2003:cb:c74b:4f00:b030:1632:49f2:63])
 by smtp.gmail.com with ESMTPSA id
 y26-20020a05600c365a00b003fbb5506e54sm1111611wmq.29.2023.07.19.01.43.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 01:43:30 -0700 (PDT)
Message-ID: <5058bda7-94f4-8001-eb8d-7b770c09a5bf@redhat.com>
Date: Wed, 19 Jul 2023 10:43:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 05/14] target/s390x: Make MC raise specification exception
 when class >= 16
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230718213531.117976-1-iii@linux.ibm.com>
 <20230718213531.117976-6-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230718213531.117976-6-iii@linux.ibm.com>
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

On 18.07.23 23:21, Ilya Leoshkevich wrote:
> MC requires bit positions 8-11 (upper 4 bits of class) to be zeros,
> otherwise it must raise a specification exception.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 20d143e2cab8 ("s390x/tcg: Implement MONITOR CALL")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/excp_helper.c | 2 +-
>   target/s390x/tcg/translate.c   | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
> index 228aa9f2373..3da337f7c72 100644
> --- a/target/s390x/tcg/excp_helper.c
> +++ b/target/s390x/tcg/excp_helper.c
> @@ -639,7 +639,7 @@ void monitor_event(CPUS390XState *env,
>   void HELPER(monitor_call)(CPUS390XState *env, uint64_t monitor_code,
>                             uint32_t monitor_class)
>   {
> -    g_assert(monitor_class <= 0xff);
> +    g_assert(monitor_class <= 0xf);
>   
>       if (env->cregs[8] & (0x8000 >> monitor_class)) {
>           monitor_event(env, monitor_code, monitor_class, GETPC());
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index 2d7cc8963b4..4b32c2333c2 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -3184,9 +3184,9 @@ static DisasJumpType op_lcbb(DisasContext *s, DisasOps *o)
>   
>   static DisasJumpType op_mc(DisasContext *s, DisasOps *o)
>   {
> -    const uint16_t monitor_class = get_field(s, i2);
> +    const uint8_t monitor_class = get_field(s, i2);
>   
> -    if (monitor_class & 0xff00) {
> +    if (monitor_class & 0xf0) {
>           gen_program_exception(s, PGM_SPECIFICATION);
>           return DISAS_NORETURN;
>       }

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


