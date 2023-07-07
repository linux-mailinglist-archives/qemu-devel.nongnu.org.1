Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3D974AAF0
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 08:05:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHeZ2-0004T0-SE; Fri, 07 Jul 2023 02:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHeYz-0004Sm-3U
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 02:03:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHeYx-0002bM-9F
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 02:03:28 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbea14706eso16429955e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 23:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688709805; x=1691301805;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Je+F0HO06b8oGvWmdARhFoGogJwvIC47LHjhY4xC+F8=;
 b=JNHAibcc6bb75fT8enoCDEQbKM57waFObJj5nJ2dzMNA/9XiqMTmjmwH0c3mpjZYnO
 JUbxIdYfY65j4RFUZ8wYb65c1TA8Wumc02+NIJIsVGb8Adb6/VBbRS4mvxY8dl9SofGG
 B2w7MywBRlF35tgLzRoTbAs6biwSuYjwa7TMvGArZc+zYXSviMSc8rN2pmIBWv3aHjlG
 JxvzidvRiq1Lgirkcs241U2qCCxKo9lblcoa5AqDPxJFXvE4AXNK6rob6Ley+0DrN4pF
 /rI7MlHwjmHs1bArxl8rMja5O+F23uQSWkUz3MZ1zjItPFRdBAWFlggfv583sO4ljnDC
 7N5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688709805; x=1691301805;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Je+F0HO06b8oGvWmdARhFoGogJwvIC47LHjhY4xC+F8=;
 b=lOue2pHxXTVRTqPGqI3P1Q4J9X7HkyCS5IsgATl0xXrsoL85Qyyfqz93Ls/0kxGGiu
 EeMc8csYNHV8Ga+ti4zyryFkP+RvmFozGkpYvwGLgKOaf8zs1jqB349B4hcr6FSXKqMh
 SnyI85vAhNvKpfXO8kfiv8ue1/ORDbW+LHh6I6neadN7veggCwxKluI9QB1tIauEpjCv
 XHt0yDsDjVA1ajcAxdimCWy2jV+Xsrx98sXVS1apz2eml8xm0u9MvZJUASGheIBBGxRo
 QdATX71iEFy9AMZOa8YC//N+v/1zwQaSLIxGc5E0+PxQEyWw174ol6DPO/h6Azr9eQhi
 o9jQ==
X-Gm-Message-State: ABy/qLZzsh/+G2BywUxPTJg6bgKdJebycjIjcqmdlT80q8KTeIEH1Wim
 hYVWRtrxhOlK384Dlh/bWLfm8ZPaTcXefvuv8H4=
X-Google-Smtp-Source: APBJJlGLG/yAoi+HKsriWr+S/co2kPJgXcTEBFDXKpuQABfARteGxxc5ZjI0sdWrFb8dUmNgVFPpgw==
X-Received: by 2002:a7b:c408:0:b0:3fb:bc4a:46ad with SMTP id
 k8-20020a7bc408000000b003fbbc4a46admr2934505wmi.9.1688709804899; 
 Thu, 06 Jul 2023 23:03:24 -0700 (PDT)
Received: from [192.168.41.77] ([95.152.217.99])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a7bcc82000000b003fbb0c01d4bsm1426060wma.16.2023.07.06.23.03.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 23:03:24 -0700 (PDT)
Message-ID: <328a84f6-b83c-28c6-aaea-a0c1145c3ec3@linaro.org>
Date: Fri, 7 Jul 2023 07:03:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/2] 9p queue 2023-07-06
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
References: <cover.1688637466.git.qemu_oss@crudebyte.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1688637466.git.qemu_oss@crudebyte.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/6/23 10:57, Christian Schoenebeck wrote:
> The following changes since commit 0618e72d64e434dd6f1bc38b107670474c49fb86:
> 
>    Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu  into staging (2023-07-04 18:40:13 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/cschoenebeck/qemu.git  tags/pull-9p-20230706
> 
> for you to fetch changes up to 3548fa01511b4d8d19d4b187d3989b7033b733d8:
> 
>    MAINTAINERS: raise status of 9p to 'Maintained' (2023-07-06 11:42:08 +0200)
> 
> ----------------------------------------------------------------
> Administrative changes only:
> 
> * Deprecate 9p 'proxy' backend.
> 
> * Raise status of 9p to 'Maintained'.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


