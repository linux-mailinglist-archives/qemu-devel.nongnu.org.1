Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E972D7C565F
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:06:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZpN-000743-AY; Wed, 11 Oct 2023 10:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZpK-00073A-Qe
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:04:42 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZpJ-0006gi-5g
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:04:42 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-406619b53caso64405615e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697033079; x=1697637879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NsQY/PwS59CozCuyOHmVs2Rpm5bzx23U2EOmVBb2o2E=;
 b=kyr7sl35KP8VbiLUxHFYqtcA86vgKbn7RMxSRFVAaLcj+3dfYF8dK9Nc+6dmDTaB6o
 6AKN+wfS5mtSzydNPRt7999DAw5zF62EfewpmGZgrTFPeSOlrdEB1JNsxtdwurxnjvJ5
 ZAJp9uTD4QP/ekwTPczKGRCk3AAN99zEqjpwwH7lDZGBH7VMRhJUb/nG2m2MfpGA6/Nz
 rdErlmMgSpca4s4SuWFYwTtnXgHG4seOkZt5F71U2vmrT1g9BqfMhVqMu8zgSnz1aOET
 aikDyR2wu/ptL8R0KY9akVtC7y5OKA/wAc8qgJL8A7DPVGNZhxyIiwcEAReQNKBDx3eo
 Np/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697033079; x=1697637879;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NsQY/PwS59CozCuyOHmVs2Rpm5bzx23U2EOmVBb2o2E=;
 b=VZq9wyF986XcZSIuiwtGOybEB2llkAKryopvLYrQ9NOsLfUMHn+M7KbeIrtTfEUNQ3
 Ga4HoD8sHaTzQ0Wnr1+2/gZQ9z5uRQQkdrV86bdV0HXrGMaZ4CaZ2SJsmf3gLdDECJKL
 iXOxUqcy8iw3SUySX9ux9ijX+/oNoeSyR6sG1UNSeO/QigalqhovKBoa5c2nFShOUbBp
 sTJHUIgZcxXNhxyln3zuToBoe/WVF6+w8jZxst2V0xILm5QMp1GmJqTrJlWo45SZmmEC
 CWS3g313YVstwID4vb4qx1+5lWIgz010fhXJcQAIUoN9gSMz4cvJNlj6oDQkXpZjl4hz
 dyAg==
X-Gm-Message-State: AOJu0YycjWw2+f3dthUj2jspE4Q1X5EcuMQrQEzAdwU9u1Y8Cr9iSO/P
 DTE7votLqRnWm/HJxzcu4tVdjg==
X-Google-Smtp-Source: AGHT+IG6rAaBDa2huj7HYzdAmGPUxAkFzJnmS0MeaMjjnfD8nEEE5ce5JKFnFH3u2BqvCMRCLM2t7Q==
X-Received: by 2002:a05:600c:210b:b0:406:548e:bd51 with SMTP id
 u11-20020a05600c210b00b00406548ebd51mr17621981wml.26.1697033079055; 
 Wed, 11 Oct 2023 07:04:39 -0700 (PDT)
Received: from [192.168.69.115] (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 f17-20020a1c6a11000000b004063ea92492sm16880903wmc.22.2023.10.11.07.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 07:04:17 -0700 (PDT)
Message-ID: <bba78e65-39d3-086c-07b1-8ba12daf2f77@linaro.org>
Date: Wed, 11 Oct 2023 16:03:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] target/i386: fix shadowed variable pasto
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com
References: <20231011135350.438492-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231011135350.438492-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 11/10/23 15:53, Paolo Bonzini wrote:
> Commit a908985971a ("target/i386/seg_helper: introduce tss_set_busy",
> 2023-09-26) failed to use the tss_selector argument of the new function,
> which was therefore unused.
> 
> This shows up as a #GP fault when booting old versions of 32-bit
> Linux.
> 
> Fixes: a908985971a ("target/i386/seg_helper: introduce tss_set_busy", 2023-09-26)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/seg_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


