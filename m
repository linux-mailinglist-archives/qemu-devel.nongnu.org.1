Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B57E5323
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 11:14:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0fYW-0006Xd-QO; Wed, 08 Nov 2023 05:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fYV-0006XV-O5
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:13:03 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fYT-00055J-SC
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:13:03 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9db6cf8309cso993605366b.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 02:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699438380; x=1700043180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VUA60IgiytyNCO8z4iupV76Su4frTSdi43qI1fs8Xgw=;
 b=tXlHp+tstKKgS0Olynx+QgFgvw55oD2PH6nK5eECZFsP0cp2C92bgfoj6xsaX51H8y
 FikGq2bXBUCchhL+mh0VajbOLIjPriyVNrMviwvH6Ponfawhqy9sL3w9lif2oFqRp4e+
 fym4ceVnQJBnQyuiQj33RCQ8MEQ8fHFSUnG0iDZE6dhXd0bCzloP+acsoybXqXXIZeJU
 CQbMvDLCQe0C6scwnJF36gugYRRMjYJsOhOrYcavagMlhjK04SZWFP1/L+EK9rt3Vu3U
 fs5cnrvR4oxP0RfSINfsldBmI+2Cx6PF8WM8pYQZT/qVolvAQtngNOkXA0DDV7h0Q2D8
 sFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699438380; x=1700043180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VUA60IgiytyNCO8z4iupV76Su4frTSdi43qI1fs8Xgw=;
 b=txfix6td1QH5J+4OgvAOd9WzLUUFG8kjI8zJCqHMimhGXTref/Ml60MWJXJbr9JiE1
 fGLf+pVA6dC9v6yCBZdO3FdSxKraCAabZpHfNJAD04rxQxEUWrG5mxvi4mfke9ejWMDj
 Az1OBy9QCtMP/KSiJkB2GKnAqrJaPl3XNyEYN2b+1YXZNPX3DZvUN00zwgem8UKIV+JV
 edha7IkrP+gL2yE8EOelmU03+IhHSFj8qr60rkS0moa5CjRaI9kMFEgNdadZbFSX0eAK
 kEHQKxanba/VeAD8Nn8I/J/YXHknUWZi22N3U7oT0ZJEImFuRunovEu4d51vSR+0OARS
 f0BA==
X-Gm-Message-State: AOJu0YxEomHkUUIyHB9eDkn5A1dveNkmaSjOotijCDrWNbQ8oWQiHAzp
 9ddDVuVP8zFVDFS8gEd0VCY8Nw==
X-Google-Smtp-Source: AGHT+IFFJS62Xzqj870PHYlJyZnDsuUfTZzaadEH55YS9eRdsgFmxz1SGtBGRx/lvTS12KCA5/8wiA==
X-Received: by 2002:a17:906:478b:b0:9c7:5667:5648 with SMTP id
 cw11-20020a170906478b00b009c756675648mr993947ejc.51.1699438379667; 
 Wed, 08 Nov 2023 02:12:59 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a1709062e8e00b00997cce73cc7sm794992eji.29.2023.11.08.02.12.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 02:12:59 -0800 (PST)
Message-ID: <5ee04cbd-d1df-4757-a316-7646671753c7@linaro.org>
Date: Wed, 8 Nov 2023 11:12:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/71] target/cris: Constify VMState in machine.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 6/11/23 07:57, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/cris/machine.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


