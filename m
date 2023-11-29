Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC8E7FDF37
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 19:21:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8PAq-00053Y-So; Wed, 29 Nov 2023 13:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8PAm-00051I-Rs
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 13:20:33 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8PAb-0002GR-Mp
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 13:20:32 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-332c7d4a6a7so60880f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 10:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701282015; x=1701886815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jrJgUADk/hybonerpgZ6VO/OMxeOJQdGzZfxbZZOY70=;
 b=TROyaSHouSbFU3wYRuvQlZGBPgLsq0FBawUmPftH0rfbkSFnlhRZKnFKxFvnVsJdEL
 9PebhRtxushUe+ZPi+KcPsYqjsQoEPDd9MB9IOZKiEKP3mhDJL5bI1+2woFcaVLZ5s5f
 zUfboFmraUksSTetlYWwZbcISQ6LVqq6dcVA06Y/by/cMpyIEd8X/j1ryLe6zLv3vUt3
 AWKX0TJcDqPjRz2mNiEOldxJPPCkgu+k4511r/3IW/AtuQzD1G2jtxZpPeHFRsh+G+Gf
 j3HK5hju9SpYyX02Ng+2M+WeY4h/+xowwN58pJHl6pIX0wrWwl/Grq+6yEQRnNvrraAr
 g4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701282015; x=1701886815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jrJgUADk/hybonerpgZ6VO/OMxeOJQdGzZfxbZZOY70=;
 b=cLXeO4dAEnvNCCZtDD6jeQvI+rzLMl/lB8g3s1sGur9Ph6spH5g0ojdPp5NEY9I/uR
 a0Ka6zdozTbhg/V3G4s/gGChEW4z4oUoPGR51WFWw0/fz9cm59iVQIC9APtsXaVHRkQP
 hANa5ZVyw2mrz6judr5ThiNet69yh0jAcRkVUF2o3+NO46OysdiEbK5rKG8B4uEmbH3G
 9hIcC+xjOZ2q4Rk3Kv77JwM6mhiAUP+y3U/k7J2RqRF+4NqAuFjHoZE7fUtq+8Ihezgg
 unNUkX4+qPwH3KUWDBrastHYA33BXxMSSkQtZb+tRnF8vs91PUPjYjfkfStayBLGhvzj
 FW6w==
X-Gm-Message-State: AOJu0YxsYRvP7H5quqFlUrH5xQJBO5wxhqtD7Q+62ux/08FiE9d7jUsh
 4vESMc7J9ljDBn/v86SMsK2yfA==
X-Google-Smtp-Source: AGHT+IEUJ3MJLG3PQBcVEp3NGGgN8wy50CRYQN80utadGCUeQYh8RP38QFsvIAIgMpKCfwzlzyAnaA==
X-Received: by 2002:a5d:6405:0:b0:333:1015:a982 with SMTP id
 z5-20020a5d6405000000b003331015a982mr3641219wru.29.1701282015545; 
 Wed, 29 Nov 2023 10:20:15 -0800 (PST)
Received: from [192.168.110.175] (28.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.28]) by smtp.gmail.com with ESMTPSA id
 u13-20020a05600c19cd00b003fefaf299b6sm2990713wmq.38.2023.11.29.10.20.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 10:20:15 -0800 (PST)
Message-ID: <aacb0899-cde7-4722-bde9-8f2106cee06c@linaro.org>
Date: Wed, 29 Nov 2023 19:20:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/misc/ivshmem: Rename ivshmem to ivshmem-pci
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: thuth@redhat.com
References: <20231127052024.435743-1-gustavo.romero@linaro.org>
 <20231127052024.435743-5-gustavo.romero@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231127052024.435743-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 27/11/23 06:20, Gustavo Romero wrote:
> Because now there is also an MMIO ivshmem device (ivshmem-flat.c), and
> ivshmem.c is a PCI specific implementation, rename it to ivshmem-pci.c.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   hw/misc/{ivshmem.c => ivshmem-pci.c} | 0
>   hw/misc/meson.build                  | 2 +-
>   2 files changed, 1 insertion(+), 1 deletion(-)
>   rename hw/misc/{ivshmem.c => ivshmem-pci.c} (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


