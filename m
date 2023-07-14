Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4774D753637
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 11:14:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKEr6-0003gH-VA; Fri, 14 Jul 2023 05:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qKEr1-0003g8-Q3
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 05:12:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qKEqz-00063e-F3
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 05:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689325963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7aPeo5jIwr63l4+tR69b8a/71grYNDjyzmPIULjHpAo=;
 b=RcJTbZSw6IzWb2NbfYCM0j6ggRaA0F44mw38pAf5WgqJCXDZo4YeBJc9M5AXiAyKeBO5pc
 v2loQYQXV1vm51CDs+lf9LSrglDSQh61z0FWR5H1B7lPukNjSd9dN4JCZNSEdPsgdN4rPT
 nSpj9ykCu5vZ6BGfoXfIllW6xewOdAM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-oUmkL2BKOm2E-fYEk3DjDw-1; Fri, 14 Jul 2023 05:12:41 -0400
X-MC-Unique: oUmkL2BKOm2E-fYEk3DjDw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7659b44990eso176069385a.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 02:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689325959; x=1691917959;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7aPeo5jIwr63l4+tR69b8a/71grYNDjyzmPIULjHpAo=;
 b=RDmXZLR+X+2GfMFvV9GNyIpI6pkvCKN8U5aA9ia3HRfRwUvZegTqLQ1SOY6tnm00fG
 AcUv/VHJx9+fHIYGv6KlaqfAvRl2HSVlD021UfxVAMDmo9Fe+6RF/CYZHJFZwAz6cNdM
 KsS8lXwGw/W4VXM+9OUCAkDKMj5qvZQ0S23JODPkQBez/0Rk1RChJdeVpFB8m0PFlEyj
 I4KpRgYbCCyEkApLaqs12cXi/ioUeLAh3CNNxZ9ZM0fkjv7mlRNQXaBDZdmxgpzNfBU9
 GIfMlQpei/J6ZEvKQfR89EuRaLIUaor9E6Tnh0fKqe7FkY+J1eP8zfDF66JJ0srB3O5Y
 ZfhA==
X-Gm-Message-State: ABy/qLZWA4BZf+ywpDcFDEsSAEa8c53oohEci59hJ1khU2PRWbs2wFyS
 0XhRro9eKTWqRe+/DIiHL6a3R7TCi6WOFWDId9s00kVmIuT7sMs+BtBs0tDBhqaSpdH3rK0HBgZ
 DdlsaEM9Y4prA+9Q=
X-Received: by 2002:a05:620a:8a83:b0:767:8083:dd44 with SMTP id
 qu3-20020a05620a8a8300b007678083dd44mr3274854qkn.69.1689325959699; 
 Fri, 14 Jul 2023 02:12:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEuCwaw0lFIIORMWeSg5BmCqOJ8xlvFqf7IhkVbZheVUZPDSA2Fx+SXe9lIPfTPDY/OD3P/fQ==
X-Received: by 2002:a05:620a:8a83:b0:767:8083:dd44 with SMTP id
 qu3-20020a05620a8a8300b007678083dd44mr3274847qkn.69.1689325959462; 
 Fri, 14 Jul 2023 02:12:39 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-249.web.vodafone.de.
 [109.43.177.249]) by smtp.gmail.com with ESMTPSA id
 s21-20020a05620a16b500b00767ded911a3sm3548907qkj.116.2023.07.14.02.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 02:12:39 -0700 (PDT)
Message-ID: <c9435ba6-25ef-d286-f40c-7e9e0bb449fd@redhat.com>
Date: Fri, 14 Jul 2023 11:12:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH for-8.1] tcg: Use HAVE_CMPXCHG128 instead of
 CONFIG_CMPXCHG128
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230713202327.12662-1-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230713202327.12662-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 13/07/2023 22.23, Richard Henderson wrote:
> We adjust CONFIG_ATOMIC128 and CONFIG_CMPXCHG128 with
> CONFIG_ATOMIC128_OPT in atomic128.h.  It is difficult
> to tell when those changes have been applied with the
> ifdef we must use with CONFIG_CMPXCHG128.  So instead
> use HAVE_CMPXCHG128, which triggers -Werror-undef when
> the proper header has not been included.
> 
> Improves tcg_gen_atomic_cmpxchg_i128 for s390x host, which
> requires CONFIG_ATOMIC128_OPT.  Without this we fall back
> to EXCP_ATOMIC to single-step 128-bit atomics, which is
> slow enough to cause some tests to time out.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Thomas, this issue does not quite match the one you bisected, but
> other than the cmpxchg, I don't see any see any qemu_{ld,st}_i128
> being used in BootLinuxS390X.test_s390_ccw_virtio_tcg.
> 
> As far as I can see, this wasn't broken by the addition of
> CONFIG_ATOMIC128_OPT, rather that fix didn't go far enough.
> 
> Anyway, test_s390_ccw_virtio_tcg now passes in 159s on our host.

Thanks, I can confirm that this fixes the issue for me, too.

Tested-by: Thomas Huth <thuth@redhat.com>



