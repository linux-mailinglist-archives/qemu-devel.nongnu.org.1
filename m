Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC31A76F9BE
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 07:58:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRnnm-00006P-V2; Fri, 04 Aug 2023 01:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnnj-00005W-Es
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:56:39 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnng-0005az-AF
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:56:39 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-55fcc15e109so971145a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 22:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691128594; x=1691733394;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dVNgqpuBVarPEl+3jYcmK1Q9DLka8fF3DreiJsUUHZc=;
 b=DOXmVeXS3zgZVQkJHKGMY/L1wtrSyYn1pl+jOh174c/wVZnCm7DmCOwtGrAryNus98
 pieKyVXbj//GHGOU8w8rB1FDv8XN8h/FgmDuisHCSbokrrRFBQQ3pNJOmwq7wJVJaD0v
 hzjvxwpv7tu7QJX3DfhvH+2HXIrYrvl+DiVNEupRhJD9V/kk4WNhPvrSNPvU2gwSP5Hg
 HRGYcTjl5bdXSNhtXetOVAjmmQgLWni6/Z+cXEhVS8A66CR9RlVGqqVHk/2SINUFVf9T
 QYRhpiBgWZ1gMuTbohLP5OIiMA+oRUXp8T1H97AJ47oQ7Iiu4OuQbET2VkQCj85jDN7v
 zLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691128594; x=1691733394;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dVNgqpuBVarPEl+3jYcmK1Q9DLka8fF3DreiJsUUHZc=;
 b=Nf+hU4xY9epngeNsW+2e19PySLDpolFWqIOzS7P7mlwKjiSaBfSjb02aUSqupiGG4B
 vIC7Y9l8lZ7EZI+x2sgDtERJJgne6EU1GDQvjWcBBIiSkIVuE12TUwNJrZ52BZkajv+X
 /hXH7wqkq2NGCaMA6y1nF5DWuWzAV1K0HHEX+P9426KewItlAG+eyKOYHsQCgAF7TZ4P
 KWy3TGN8beVbVgU/zXsqY/fRjKNJPrsnR5uk7tcEeRqkt6zr+invBQiUt4bZUcnJCtBX
 dhnVYuOmPlwgonuwvmfBqgOmqqAiacdS7eC5URMGG9XCRWdMXbGA425Qxy44UoWQyLVn
 eY0g==
X-Gm-Message-State: AOJu0YxYOqV/vhsl/imOF+AOQGSvSrG/wgEM1XMtn3TiPXZ6TwgliMKK
 EzIExKsvEn0dFhioMUjH8V5dGQ==
X-Google-Smtp-Source: AGHT+IG6qytUhb3Vc3pFZc/glvZgpqH0FRNRk85AfKpcq0mp3xGUS2ZPId+WljsyswrjFZBhYdRGEA==
X-Received: by 2002:a05:6a20:dda7:b0:13d:ac08:6b79 with SMTP id
 kw39-20020a056a20dda700b0013dac086b79mr555866pzb.60.1691128594381; 
 Thu, 03 Aug 2023 22:56:34 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 y9-20020aa78049000000b00640dbbd7830sm800715pfm.18.2023.08.03.22.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 22:56:34 -0700 (PDT)
Message-ID: <ffc0b8ba-3ccf-0351-432f-fcbb89cf2e45@daynix.com>
Date: Fri, 4 Aug 2023 14:56:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/17] linux-user: Do not adjust zero_bss for host page
 size
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: joel@jms.id.au, laurent@vivier.eu, deller@gmx.de
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-17-richard.henderson@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230804014517.6361-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/08/04 10:45, Richard Henderson wrote:
> Rely on target_mmap to handle guest vs host page size mismatch.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

