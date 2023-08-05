Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E69770EA3
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 10:03:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSCFm-0006ur-OF; Sat, 05 Aug 2023 04:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qSCFV-0006mE-Fh
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 04:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qSCFS-0007QO-RM
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 04:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691222574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tNh5S1xaKHWiTsdd501ckIx7mm+TEn+kJI36SKNTf7Y=;
 b=e1wmTEbclZh4rkES26oNA4xXUsF/6ZpYQaT992hOmxOhIc4yX7ZmdV0JjJDe6dsEUnXSfJ
 UeK0NXkFKQblFTyReJ1cI4uim9hrZgqT+wzOXVfanYxREiTmuu04SaqlCf/8CpusZ8+zAr
 3PBnGNjvtmZdnXrIwEkowU3HknyVpXU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-zklTIcjOMx-fYxDdzVhHoQ-1; Sat, 05 Aug 2023 04:02:53 -0400
X-MC-Unique: zklTIcjOMx-fYxDdzVhHoQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fe2fc65f1fso17201875e9.3
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 01:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691222572; x=1691827372;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tNh5S1xaKHWiTsdd501ckIx7mm+TEn+kJI36SKNTf7Y=;
 b=RhFlQW9oQEY5znc/XOlTYMioqyu6fPgRueM1fqPnFWjBiYlTMgjkujwLcangzUHaXE
 Xmr/mxo+eojyxHLKW5zk4ZnkbGH+lnpspnwVOCiiT6EEYY2d2Qdo227awfM3J1zKehfj
 eQmJWNl4360HAqXHrcIc9/n8JINFGOjxosuFoI/8xTGrDfmPzY9qUSktsb+PWM+LrQ32
 GbWPpwoQNqLjmgOo+GI0q3kQnz8flwn3iyS/PJIoIqjMowafcj2js3mm+8PWwVku4BlW
 +BOaZ7RDzPfOZg6yJx51Nt28HqGBeCIFePS7jlma7bGPGP6D0K5asI1+xwiH2MWnLcnH
 0TUQ==
X-Gm-Message-State: AOJu0YzTxwmM/Hgyb7gIluLB1zW29e4QTNx51/aE0y6rQySZUGj7hm5t
 /qYnypn44rsRU+1rOGV+jA8V5lV0ZQ5IUFTz+Xc7ZYq9bcMwegAgI7ltNduWz6FNQ3Mn8x2Miun
 d9vxFtzrUviQWawY=
X-Received: by 2002:a05:600c:20f:b0:3f8:c70e:7ed1 with SMTP id
 15-20020a05600c020f00b003f8c70e7ed1mr3230883wmi.20.1691222571862; 
 Sat, 05 Aug 2023 01:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcisD30fYmRxWzCMCi41MPxD3oHKMQU5VTdp3h3OTLaUdjQsSpQB1aVNCYnzD0NTSLQgni5Q==
X-Received: by 2002:a05:600c:20f:b0:3f8:c70e:7ed1 with SMTP id
 15-20020a05600c020f00b003f8c70e7ed1mr3230854wmi.20.1691222571215; 
 Sat, 05 Aug 2023 01:02:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2d:8e00:a20e:59bc:3c13:4806?
 (p200300d82f2d8e00a20e59bc3c134806.dip0.t-ipconnect.de.
 [2003:d8:2f2d:8e00:a20e:59bc:3c13:4806])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a05600c298100b003fbe791a0e8sm4335382wmd.0.2023.08.05.01.02.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Aug 2023 01:02:50 -0700 (PDT)
Message-ID: <5ea25092-b362-0587-5ad0-f3883cc86ba1@redhat.com>
Date: Sat, 5 Aug 2023 10:02:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] target/s390x: Fix the "ignored match" case in VSTRS
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Claudio Fontana <cfontana@suse.de>, qemu-stable@nongnu.org
References: <20230804233748.218935-1-iii@linux.ibm.com>
 <20230804233748.218935-3-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230804233748.218935-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 05.08.23 01:03, Ilya Leoshkevich wrote:
> Currently the emulation of VSTRS recognizes partial matches in presence
> of \0 in the haystack, which, according to PoP, is not correct:
> 
>      If the ZS flag is one and a zero byte was detected
>      in the second operand, then there can not be a
>      partial match ...
> 
> Add a check for this. While at it, fold a number of explicitly handled
> special cases into the generic logic.

Can we split that off? Or doesn't it make sense to split it off after 
fixing the issue?

-- 
Cheers,

David / dhildenb


