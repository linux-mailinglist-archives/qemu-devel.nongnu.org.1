Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D6F76F97F
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 07:18:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRnCb-0001rA-3R; Fri, 04 Aug 2023 01:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnCH-0001oJ-6A
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:18:03 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnCD-0007EB-JV
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:17:56 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b8ad8383faso15057825ad.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 22:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691126270; x=1691731070;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OarG4nnjy1k/V9Xo2skEGsoLY90Eyf5gFNwVbhkwhHg=;
 b=jhGQk+1DU3uRtSw1swFlzHDTt0QYVQ2WIr1BuxwME/jtlqNQFOuKj94VbkVevplCZp
 LDJGC+qEl5CUTZmFu1yGT5pgtYlJWov2idkuRligKO+tTCHtpfNiZKrBLC/kmkXBfNGu
 33H9RoJ+juha/pVcQgNH6ZaNGBbTKKRwZFk1ncvk/mjRAkWlFNz0YiSEIfGIsytlOMFx
 mKRWxlgZgQPBACgyEQ+vmJFBaj0sFEhNe6DRkWdeIvA5vZUl+90aRaRuRkMLxt0x8xWm
 +dNtEWgm1O5nCNTnBy1RuJAyVbhr1CKFg5jwTerKtoMu3xpzX3YdNO5N1+usrda7mx7L
 JZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691126270; x=1691731070;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OarG4nnjy1k/V9Xo2skEGsoLY90Eyf5gFNwVbhkwhHg=;
 b=UaJ0/oOjovQqoYoPVXlvDutb+sWulaz+cRm5XprMtn0Avo5ToDHTta9t/ak5kDLRJ+
 dSUAVPtVtHpYJ9EmVWiLc2dmmu2T8Sk56cXZvtOs9u2uoquzagdjaZxeCoTq7fBqFAoK
 o3jqOHUvirp6XtUY1Og00dwFiSxM3JHnUJnSYF7SV2EH1iR/EvQkFu1waS4IwcK8OVG9
 DqVYMjyqq6mYvN1yWceC+O34QnoHwUmintssTqE5kHktLSeMn94+9hISS7QH48jnQ/pT
 SQPx2ZeV09snTY4bfW3r/2WhbXUajVgCGnR3OJd583XHGwLVciJp87qJUlBeVvlqtx0u
 13Xg==
X-Gm-Message-State: AOJu0YxoR1QVQfksahTtxYxnFIi2o4a9gVil7iVfaOPWNDeEHeZv52p9
 kUK8sNmIWysYFwPLWy10arGVsw==
X-Google-Smtp-Source: AGHT+IGGftMiWb/Vnq8YC097x6bVcu5InJQSEg1D5gWGop79N6TqScGQWzvgeUr0rbpbOthCITx3hQ==
X-Received: by 2002:a17:902:b686:b0:1bc:e6a:205a with SMTP id
 c6-20020a170902b68600b001bc0e6a205amr856170pls.4.1691126270056; 
 Thu, 03 Aug 2023 22:17:50 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 21-20020a170902c21500b001b0358848b0sm742041pll.161.2023.08.03.22.17.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 22:17:49 -0700 (PDT)
Message-ID: <bc9d2de0-6fd3-4b25-7238-7e620e00f61c@daynix.com>
Date: Fri, 4 Aug 2023 14:17:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/17] linux-user: Define TASK_UNMAPPED_BASE in
 $guest/target_mman.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: joel@jms.id.au, laurent@vivier.eu, deller@gmx.de
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-10-richard.henderson@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230804014517.6361-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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
> Provide default values that are as close as possible to the
> values used by the guest's kernel.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

