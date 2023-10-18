Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F06E7CD1D2
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 03:31:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsvO7-0007h2-SZ; Tue, 17 Oct 2023 21:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsvO5-0007gl-L6
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 21:30:17 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsvO4-00027O-16
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 21:30:17 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-581d487f8dbso705981eaf.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 18:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697592614; x=1698197414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=voCgoMh+8ymEPIubud5PmRWw7N1AAbANUkBu6nufkvc=;
 b=a2/DTB8UK7+iOVhFTXZJsBL4bqm/KpxDJDdKD4Xg8iQM8v3yIkZMYkW9z4OmtXewE8
 Nf7aWZP1K6r28kP2/+1FSJwF0ggwnGftZ5WEZcQEOKN67nLQ2lJQmlno5TtnUjzlSm1x
 4jmrqWBwYc18hR0rtPUUE/hxqqSwSxK5Shh5LDpjiAU+RnrK2WgvpkF8wpEjOOUcsoh6
 UyM9gwB9xdPz3F9e94kX0c/5BsLnhK9f7eOYBIncvCOYGGDy3EVWI3UTS3OOiPUUatDa
 Q1hEhwWQMzChuaJ1MVug86z2ZA2aaBpuFEGYxMVS23DTryPx3eyY0gOyXJPdkuVsGlTf
 YFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697592614; x=1698197414;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=voCgoMh+8ymEPIubud5PmRWw7N1AAbANUkBu6nufkvc=;
 b=PWEWu7h5Nau89bpAsrDVAX7lbGA8ilFh7eewa5xgOK0bNgXGOM6VZ0mgCuwaayyQxM
 5iLZfJ2bKUgBiPm/mH3xPePN6dMsqsrsEmqHQiB44p/8zHyKcOi+e8URDzxrhT2KnLre
 d9BOcYczL+uaDy4AwDb0A44RDx4ggchYmYKiCE3NW/FAtvufy8v3v5adIG5Zv46zsxYC
 aGvFAK2LJCwx6dUbtbLnfeZLDegD7t8oQoS+vbqvddPEIb34r1ASvldnDiqWCrVazypc
 qbqLPZXdKuMFB6yxHOzsRp3uS/zMeujgtBVqSqQFjmjHKCdMhBMUA8TA1R3zBrOLq09J
 gZrw==
X-Gm-Message-State: AOJu0Yx3qodXLIfrq1T64/L85x+5JeZu1F1q4JeNQsgkq+p/7EMnEcz+
 IoofGgdWhK5ff6AX2INRUkjlig==
X-Google-Smtp-Source: AGHT+IHtbslR3IL/tV5fiwJrHeKQONf+xbjriFI6wUQh8ggM7iNOXlSuzrtWYOqrZyOnwfOpRQQoGA==
X-Received: by 2002:a05:6358:3a0e:b0:13a:d269:bd22 with SMTP id
 g14-20020a0563583a0e00b0013ad269bd22mr5962945rwe.25.1697592613927; 
 Tue, 17 Oct 2023 18:30:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 q3-20020aa79603000000b00692cb1224casm2056566pfg.183.2023.10.17.18.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 18:30:13 -0700 (PDT)
Message-ID: <e97eaffb-6921-4d3c-aee2-9622aaa08b73@linaro.org>
Date: Tue, 17 Oct 2023 18:30:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] tests/tcg/i386: initialize more registers in
 test-avx
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231014100121.109817-1-pbonzini@redhat.com>
 <20231014100121.109817-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231014100121.109817-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/14/23 03:01, Paolo Bonzini wrote:
> Some instructions use YMM0 implicitly, or use YMM9 as a read-modify-write
> register destination.  Initialize those registers as well.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

