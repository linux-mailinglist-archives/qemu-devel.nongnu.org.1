Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C60B07D8D13
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 04:17:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwCOB-0006Pw-IF; Thu, 26 Oct 2023 22:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qwCO9-0006Pl-Is
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 22:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qwCO7-0005UO-FN
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 22:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698372950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SujuKJOsg5kLTaRcRIfISD9eAm6lGymc+WLFiwViKoU=;
 b=Vxt/CFvQcpP8fTDMEP4MQC0sxmwSaeA8jn7rfMQfDjw0muJcNvqSTm8VaevyMn3azM0Sym
 MvSnb7TjAx3yBC0yT5BY9GQhMz4iLwCKYQZ0MVUuadxr8kobuKaQkndOZJkskKXLYO+fhv
 BrP0bZ6awNqiv/aV++FcuQzFpNhy9Qw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-4LdqA6N0OPKfS80r4rSOKg-1; Thu, 26 Oct 2023 22:15:45 -0400
X-MC-Unique: 4LdqA6N0OPKfS80r4rSOKg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66d120c28afso21043566d6.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 19:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698372945; x=1698977745;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SujuKJOsg5kLTaRcRIfISD9eAm6lGymc+WLFiwViKoU=;
 b=NOcKg7t0ghHBInWv154RI9b2ZfH4RFuAZzYoZ7+TmJRiPg0uBSo4f32KcwhJ9tPhst
 isTKkN/VmQobkM/WREQ8stMHsJZdc1Z5/ZS2DvQJpOc4KAs/xtjoe0CAUfP7fRcPf2uu
 DhwVbfUDjU8ISBp6lsJq6RS+4H7X6FRW43OuBjjbWeERzsRr2raxBe6iMWXHlM/sbE/9
 x1ZbPfj6ORDJcU8zEAZG0DZEVYJBAOnpM5N99Z4k+YXFx35m7BhG9ec1Hl/gf+fZBl1S
 R4cwE1+TYDPmyd+uL1sxl572QqveNKpgkycAsMBEiYy7+0gipxhqw88deZjA/olZoA2R
 pKCQ==
X-Gm-Message-State: AOJu0YwQKusK2iIeAC9NR/ur3x79KBmVLjZIa8HITwJbEbhA2plReaO9
 ZT5WzYCuOhveAGCViMBr6Jya75Tbws8L0y9h1jC6lz8OwipYXSY2Ft6Q0OGR9pOLuedYqe8XENR
 rfaDID61vuZLb0zs=
X-Received: by 2002:a0c:aad1:0:b0:66d:a1ae:e762 with SMTP id
 g17-20020a0caad1000000b0066da1aee762mr1270173qvb.14.1698372945044; 
 Thu, 26 Oct 2023 19:15:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSJmIcfFlCwzObzMi8S0IHEeof/R0bjWVxP/w6p9RKfR6ln3Hnp9vlX602tXDMgnjD2R1EDA==
X-Received: by 2002:a0c:aad1:0:b0:66d:a1ae:e762 with SMTP id
 g17-20020a0caad1000000b0066da1aee762mr1270168qvb.14.1698372944733; 
 Thu, 26 Oct 2023 19:15:44 -0700 (PDT)
Received: from [172.19.1.246] ([192.80.84.35])
 by smtp.googlemail.com with ESMTPSA id
 m14-20020a0ce8ce000000b0066d1bae2326sm260864qvo.57.2023.10.26.19.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 19:15:44 -0700 (PDT)
Message-ID: <da77b016-64a0-47bc-bb5f-6a8259375335@redhat.com>
Date: Fri, 27 Oct 2023 04:15:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/29] tcg/i386: Support TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
 <20231026001542.1141412-27-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20231026001542.1141412-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/26/23 02:14, Richard Henderson wrote:
> 
> +    } else if ((i & ~0xff00) == 0 && r < 4) {
> +        tcg_out_modrm(s, OPC_GRP3_Eb, EXT3_TESTi, r);

Should be "r + 4".

Paolo

> +        tcg_out8(s, i >> 8);
>      } else {



