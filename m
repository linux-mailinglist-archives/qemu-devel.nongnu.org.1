Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAB6B1940B
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Aug 2025 14:33:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiXs8-0007Yx-IM; Sun, 03 Aug 2025 08:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uiXs6-0007XR-Py
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 08:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uiXs4-0007sB-Jl
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 08:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754224282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pYG0zn0eu35RTJiu0y1wMB/J9vN8Pa5vh1SY2uLhDOs=;
 b=ABnkPE2KfovgHuqU2N1cLCDkODwU+r6ViTAWWVAn+wPA/a7aPsZIPqn6mrXNkrzccXU4VM
 jjUgk1Egy5BVnerYnxmHJF0S+gd2A1YWRYI5jLPCfVLxf9QkR54fx0imBKqOmYUWaDOCpF
 9lSCGMmfSjdkPy0dZbd0Yyx8daxeBDw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-iuT7bqoOMOSfZ1rDdLb64w-1; Sun, 03 Aug 2025 08:31:21 -0400
X-MC-Unique: iuT7bqoOMOSfZ1rDdLb64w-1
X-Mimecast-MFC-AGG-ID: iuT7bqoOMOSfZ1rDdLb64w_1754224280
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b8d62a680bso1102526f8f.0
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 05:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754224279; x=1754829079;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pYG0zn0eu35RTJiu0y1wMB/J9vN8Pa5vh1SY2uLhDOs=;
 b=gINmDfmP73RDNnqmvIVal+XzgE/ANdnEvL2i0MjEn+9SeyNjTScgxNrXjlAEDOPNCR
 YCKa6rJ1jHEwWZkldsKiggveBZrH4MIiASUNRnM1ErPb20/9W9vMLT8yJ8J5AzT/bkND
 TYrQbo45u/qmNsJT5GT+R4ch5hpnZA4+pwAY85LsBl/CiWzOTT+BbbZRv/00lfHFdVyH
 3QTpdT8G9IsnFr6rLbJJZrJAqftLsUzR5Elr+sLeA798+GxLx014rdweS2ZD3MOPO/n9
 vcodC21dKg2w6kkr7qagpikv0UlXylMOAhpj/mW5M/Biu+4HKBFEBPP/nXkT24nyjlOf
 7Etg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrEL0ExVSy4LTIIBF/yQgx+FpV3hjsp8nb0JEeufEvgiutCsZwHtHBqlAHgr+jTwSebJ3DmaAr/xTz@nongnu.org
X-Gm-Message-State: AOJu0YyC0/C2paWBBYh9XJarnbS11X+v6PSOzLQr5Uar2YJqBmGFENhI
 y7+HWsTMCcUlcbzf/OOfJCWVacQhTVAP+SWRaM3fGSCSSq2qVnUW7KPlSWAW0sE5oUEaaQsbqyc
 zzbqKJ7COQNWWbF/pnScMUPh8kwpdizzLH6D9iHh9NrqozAiV4fk87jNYHYLMVjng
X-Gm-Gg: ASbGncvC4yEu5fzryGLMpi6WL5juhh9yrbBqylheJXfwZnrf5tCuwkdc+Ec6GJVFp6l
 c3nVoJfKkRq7NpikxzvXZyOnFkGEeguUGAGY9e1/8YCra2Md/fLclhWAbQc/LK48bhfqG8v+EvT
 i8DqQV/OafZVxRCQHCBw6rVbusj5pZ+hiBlP5QRdLibvV8M88DZLYY2HGIYM5c4fepzPtujcgmI
 iD4JGecFGhFDKh1gT/XRC0UHE1fuNp5WV7c7nQBRsq7ueTi2anjfBnTkmrt/So64q8cwA+akcVR
 EI0dzj5lqcWBwoz0jbWA45cp/KlX8T09cuxSjuMUlzRN
X-Received: by 2002:a5d:64ed:0:b0:3b7:590d:ac7d with SMTP id
 ffacd0b85a97d-3b8d9561d86mr4966348f8f.1.1754224278979; 
 Sun, 03 Aug 2025 05:31:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPJMb4WPlVrMsdcTmVdaJdH7TwDWjf5gAW8kmkLYYvox4fRs3exgsI+oVENqwML+Lek5HPqA==
X-Received: by 2002:a5d:64ed:0:b0:3b7:590d:ac7d with SMTP id
 ffacd0b85a97d-3b8d9561d86mr4966329f8f.1.1754224278601; 
 Sun, 03 Aug 2025 05:31:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.253.173])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3b79c48a05bsm12221985f8f.69.2025.08.03.05.31.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Aug 2025 05:31:17 -0700 (PDT)
Message-ID: <c101dbc2-9431-4633-8a91-d5d85ce02082@redhat.com>
Date: Sun, 3 Aug 2025 14:31:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] target/arm: Implement CB, CBB, CBH
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250803014019.416797-1-richard.henderson@linaro.org>
 <20250803014019.416797-9-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250803014019.416797-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/3/25 03:40, Richard Henderson wrote:
> +static bool do_cb_cond(DisasContext *s, int cc, int imm,
> +                       int rt, int rm, MemOp mop)

This is a memop...

> +static bool trans_CB_cond(DisasContext *s, arg_CB_cond *a)
> +{
> +    return do_cb_cond(s, a->cc, a->imm, a->rt, a->rm, a->sf ? 64 : 32);
> +}
> +
> +static bool trans_CBB_cond(DisasContext *s, arg_CBB_cond *a)
> +{
> +    return do_cb_cond(s, a->cc, a->imm, a->rt, a->rm, 8);
> +}

... but these use bits

> +static bool trans_CBH_cond(DisasContext *s, arg_CBH_cond *a)
> +{
> +    return do_cb_cond(s, a->cc, a->imm, 16, a->rt, a->rm);
> +}
> +

... and this one also has arguments in the wrong order.

Paolo


