Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1CF7E5332
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 11:16:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0fbt-0001lm-3B; Wed, 08 Nov 2023 05:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fbq-0001fP-O4
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:16:30 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fbo-00061R-1t
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:16:30 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9c53e8b7cf4so1016806766b.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 02:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699438586; x=1700043386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9GoVruUpet30adGmj/mB9OBkOLsemEN/z+Xgx5Edt+w=;
 b=WZByXYPTvxUqKWeFQ6EQzSeOiWjKNbsVJI7KiDDuHWgC+t+tg+pjCzPEJJCTDgHDnw
 o+6rR3S301+th6SiyZsD1UfYoO/ZGDnEgELt7THi2LxWa/E3zzpVA8m+VWTxj5k6lQ+g
 tEFcbzxT6MXnRHsJConfAEn38zfnXZ2sX05pYgQ31QHcqIWjBA5iWCxss3E0a2PSri9C
 36IPKb/TrNutCTnY2niZse5v9tk8AItP9WqKIo3iBHJaGr3BBOcQ7Weixw7RtcqsBkVM
 MN67x8r7Qh3Mfy1BIvYQnk5fKga8OqC9rnXEh25Ow28klG+3Hh1XEjSy59unvqmcZ8Hi
 en4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699438586; x=1700043386;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9GoVruUpet30adGmj/mB9OBkOLsemEN/z+Xgx5Edt+w=;
 b=tOInUDHnGcGVpEekmYbJAu0OQgN6bxziYFJiaHVSkz2kThBU4LS588Emzpuou+Snko
 WW2mNICZuHHapZ8pUe6ZyF45du3VoE36IXC8pRakakXmPIx6GZar6JUmH09ZrEjElhq1
 bS9W+8A1yNB4FG2/1zofQepRdapev0yR/cpeJz+qL7WqfX7C4ZjOblBj8Zu9hqTfPRZz
 nTvwRS38qGk72a+6NZS38FfVbAiSN71stfbgHt+POSapz3NSOaHGKto9FdorDvA97OWf
 t6kwV2KlQtBTXwuTGNIP1W1nOMIDwhzMG9DEMK6ceN8srxNaZpHOpRE+Rnsdr1wQKEW4
 xFsA==
X-Gm-Message-State: AOJu0Yye7ymMfpQEUHrhMUPm7OrHwbnpo5HilJqD0oAI2v0IhiPVQ3Fp
 V4MA/UVfgwLBDJcsg1RBmnZDHCsbHOesCoTtuGs=
X-Google-Smtp-Source: AGHT+IGSLYCNNMW2a0864rVnvjnsUPguIYHWByBy2NQg4hssU0Ab24alMNxcJtGiBvhZ8M54HUJzfA==
X-Received: by 2002:a17:907:da1:b0:9be:e278:4d45 with SMTP id
 go33-20020a1709070da100b009bee2784d45mr1062226ejc.15.1699438586634; 
 Wed, 08 Nov 2023 02:16:26 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a1709062e8e00b00997cce73cc7sm794992eji.29.2023.11.08.02.16.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 02:16:26 -0800 (PST)
Message-ID: <36b2e807-dbd1-4de2-8254-3390cf87369a@linaro.org>
Date: Wed, 8 Nov 2023 11:16:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 65/71] cpu-target: Constify VMState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-66-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-66-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/11/23 07:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   cpu-target.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


