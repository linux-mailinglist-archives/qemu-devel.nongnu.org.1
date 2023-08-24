Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 425E0787881
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 21:28:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZG00-0002Z5-5u; Thu, 24 Aug 2023 15:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZFzy-0002Yj-9P
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 15:28:06 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZFzu-0000d4-GU
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 15:28:06 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68becf931d0so185107b3a.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 12:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692905280; x=1693510080;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M04lHmw/Id/VbCHYP0g0X7Or56mdTvcHxc9Fp0CZ6Pc=;
 b=X52tR3mjQOY4HDtHowDg6alqjobCyfLe8MNToGNFkeUSB8UTdICV1UqYD/yr8xCuih
 muZHBLLwQHpMIlVUwr9/ypE5EFIsLoARqItC6w4Kp/qHfmk6pydaohiGEE6BWp05HZSa
 Q0uB4EojsJ1RsoorlEAJTvtGeBSoXD1rqMI5iDJ/4yuhWFO4A7ju2Q7wNxH8Jal5AdW4
 e7zP2czkWAYAJVOkQNiW/GJxW/zHQlgowqdQEvDgVliqEsCRXrfpq9uvDYYFWoOCtN6A
 5o40dOog65EA1HbTECz1AQ1FUB3fV/DdfCHRLBTv8vz1/OJ7mFKCTwLVna8XYqRrfz/Z
 e97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905280; x=1693510080;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M04lHmw/Id/VbCHYP0g0X7Or56mdTvcHxc9Fp0CZ6Pc=;
 b=isOqloHYU4X/SuaAYAMFBCDmIbhyDCptVzHVuXAPMEMPhk5ErvilmKV+gCBlFusA8T
 3RHv+sr6bt79Gj9Udq19m1Kzrhg9YDR0nP17fd3QfP5zlU4zCDYQDKjenyKB5E/lrgTW
 wxo0cbOrUcpQuvV6bQxR5isowNiPxccLdpsXQMPdhEZ43Gho8ocPuWNuaDL+IgfpOkda
 vbkWCBzL5oyPCpdMmMstzLxiC80gSpT5HXCKgeyTfm7ryq2X9NDm0aSzm7tG/dOUzfUg
 cfWIdyxwGjaPq5fyPHa37oujrMyQ4Z34mDShSr99pbhT3IhJZEVELINx5UuVB+sqFNPf
 ju3Q==
X-Gm-Message-State: AOJu0YwOkOQCeIe5bCF6sliXDO4XMdscr3RsJzuxiDzuchCcQGMNtgjf
 FZ9W3RcAo9KAXTWzS8r6PNi/9g==
X-Google-Smtp-Source: AGHT+IH0SSFAfmbrJizRasYskAMAiNQKZ/Z8onYcdjDyyZrQ68O1qC0x8RBuL2+LDOOfqWKRqF+PDA==
X-Received: by 2002:a05:6a21:279c:b0:104:ad71:f080 with SMTP id
 rn28-20020a056a21279c00b00104ad71f080mr13743708pzb.34.1692905279814; 
 Thu, 24 Aug 2023 12:27:59 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:5418:3064:bd46:c048?
 ([2602:47:d483:7301:5418:3064:bd46:c048])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001bc21222e34sm19087plg.285.2023.08.24.12.27.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 12:27:59 -0700 (PDT)
Message-ID: <a552e422-f7f5-f8b3-a113-4e45a4eac7ae@linaro.org>
Date: Thu, 24 Aug 2023 12:27:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 11/12] gdbstub: replace global gdb_has_xml with a
 function
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230824163910.1737079-1-alex.bennee@linaro.org>
 <20230824163910.1737079-12-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230824163910.1737079-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 8/24/23 09:39, Alex Bennée wrote:
> Try and make the self reported global hack a little less hackish by
> providing a query function instead. As gdb_has_xml was always set if
> we negotiated XML we can now use the presence of ->target_xml as the
> test instead.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   gdbstub/internals.h    |  1 +
>   include/exec/gdbstub.h | 10 +++++-----
>   gdbstub/gdbstub.c      | 12 +++++++-----
>   gdbstub/softmmu.c      |  1 -
>   gdbstub/user.c         |  1 -
>   target/arm/gdbstub.c   |  8 ++++----
>   target/ppc/gdbstub.c   |  4 ++--
>   7 files changed, 19 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

