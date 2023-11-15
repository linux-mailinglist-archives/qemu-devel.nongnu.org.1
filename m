Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 147B07EBA9F
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 01:36:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r33sl-0002xo-FX; Tue, 14 Nov 2023 19:35:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33sj-0002wl-Il
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:35:49 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33si-0006ui-0t
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:35:49 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc5b7057d5so56363255ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 16:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700008545; x=1700613345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VPLdBfG18RXk+Crj3CwgtI2hV3UW6hGZV9Fa5OmCXwY=;
 b=yUQPTR0HGyEWGI02SWer566SyPgFND3BakXFqDPzDFh7Cff63UodmqhrZNyG+JGtU/
 vlAqVsZ4S47H8pU4apyjD5OBJ63NHnkV1/FTQTqTl/lgEOLx2UbkFYSuho2i0UL39cFe
 1S0XHsemcnRxDnyE/A42Xkb0x/U6sOQnLaHB5qjeXaxYOyxr6tRt2ErgkTprXM4xf350
 uSOkrQWSjZKCbjBw6Ykg6TVbI/8fyzh5fhNA2NeMgptkHBd5sXv9yAd40M4+nQEXEaN1
 cM2RuEFiZ2BINTkXPPy8mmjR+ocAi6mRzrIKmNxSthLpvi4Ug0nlnOvv955PvLKf8Bua
 mwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700008545; x=1700613345;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VPLdBfG18RXk+Crj3CwgtI2hV3UW6hGZV9Fa5OmCXwY=;
 b=lVRJgChAqvBYU2ebxDTTznjPzmlkes6vYglcZDjjQpg7dfKYMdRLokMffG/iDUi79U
 JvNMXi0EUrY/U9eNyCopZb9Cm9tvQfNWOZ4xOVTi7JMvic/G2FDLhaA3CwfZrj9srhA/
 q0W9GlPUwni3KqpAjLwiu71GhnUvDcPfonqJ5M/ZzQ4TY98JZOyhWOLt1HLpYKAwyC75
 vqDQvjhqxSZtcqmSlItgb2LumCUmWcpEP476pbDq5G8/wuSCedoT0pr9q+TEv1woa4aH
 4LvgmkP8QGfd/Itw3TJ6nLVYa4lU6+84oCLqNYWSIYOkEoqkXN0aPXqC2DU500ppVJAs
 4bjg==
X-Gm-Message-State: AOJu0YwNhm8eZSFMjaLqQcWGlDZcOcFs1Mr0Z1JG3bfH+6OIAkmCZOa9
 lg2qJUnnUMtzmgIIfxQ7WPA8zLZqwq/74o9We+E=
X-Google-Smtp-Source: AGHT+IEziMkUWaM7g+m9JQSviR2W0ThsAdINsHfBiE/VuFH1pGvta6/jK9fM4OSNceDLQ0jOGp9VSw==
X-Received: by 2002:a17:902:988d:b0:1c9:c6f4:e0c3 with SMTP id
 s13-20020a170902988d00b001c9c6f4e0c3mr3979439plp.62.1700008545552; 
 Tue, 14 Nov 2023 16:35:45 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a17090332c400b001bbfa86ca3bsm6275251plr.78.2023.11.14.16.35.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 16:35:45 -0800 (PST)
Message-ID: <1f8cd22b-e0ea-48e8-95e4-27ff7bd85fce@linaro.org>
Date: Tue, 14 Nov 2023 16:35:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/31] cpu: Add helper cpu_model_from_type()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-6-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-6-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 11/14/23 15:56, Gavin Shan wrote:
> Add helper cpu_model_from_type() to extract the CPU model name from
> the CPU type name in two circumstances: (1) The CPU type name is the
> combination of the CPU model name and suffix. (2) The CPU type name
> is same to the CPU model name.
> 
> The helper will be used in the subsequent commits to conver the
> CPU type name to the CPU model name.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   cpu-target.c          | 15 +++++++++++++++
>   include/hw/core/cpu.h | 12 ++++++++++++
>   2 files changed, 27 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

