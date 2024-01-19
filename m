Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B438330C3
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 23:34:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQxQ2-0004Rl-Gr; Fri, 19 Jan 2024 17:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rQxPv-0004RU-4V
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 17:32:51 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rQxPs-000729-OG
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 17:32:50 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d5cdb4a444so11358385ad.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 14:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705703567; x=1706308367; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=0YwTYO+QEO8XDYKHu4s1aUryeflt+DF1S2EI5cwXGqQ=;
 b=IvzrZfMxEWUgcskYaV1/YCyVxsO7jVBlxMV32Dv+f4pE95LMN7pEHAo/ILx2tQnt7w
 LuGOPfiPkZQZFG665aqiBR2UpLm1mTOqjM4qxR3KD5+6NNm6VhHBMQ8feE4u+CT/z5bc
 cEGALH0Z1+Z98E51hkOM9VP/DJUt2sXf3IzWNN8tIhcGF5hgvPCNTCDnxlD3tWupOXcd
 uqe4U5J0MK5tTuqcWIe1sRyaaLt/otJ5kvDKKp8rzXydqC3B54G5rxaa3gcNVQpn3atd
 LpyhcRLwmNmnRB4KvC99cfhY3+XmBBw8kg9eZD9l8VN/xLlfW8VYnH/Hr5i6WagZlhP6
 D4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705703567; x=1706308367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0YwTYO+QEO8XDYKHu4s1aUryeflt+DF1S2EI5cwXGqQ=;
 b=ikGitEvsJw7PJ/UiVmuwL1za12VRdVWflJ8BJydGVO8USWWz2wYxfPeFkFWz0I0tIv
 pyaCNoBcdFNzzmnEzqiIczCXVDY9/y3+0RxZ85TMZkskDsyiQIqoOsT9w27+NMrhmDUC
 /oAb04uxXH7/ZjzgLvlAzKN79CTefkW9DxH4ZaEI7KoN25hBEHsJowaCCSQ9lgKygRsG
 DC2di1jqhDzqRlRuSLuqbh6SAb9qZfuSkytWP1lMt61eeSZXW24ueOjRvNk3BY0Zkded
 Z6tjo2bRM5zLsEluCuI1YPEWOXqwH5i043kgIymnzNAr/3NG/2sXADmjls1+D5A9IYQH
 wxYA==
X-Gm-Message-State: AOJu0YwWCnyBxn/nKZ10SitFuO01iXw/EFo698d2iI/YncErucgF19y7
 X0pFjQSwo8cYV1lNWuSXeBaxbr0U03PFxCwX8tADAXybuesgR1OTmFhT8UJI
X-Google-Smtp-Source: AGHT+IEy4wk8PcgjG/lb/rDU2GZTF1pSZyO7zBjx/c96W01og8rKymOw3RmnzQP2tmWXpZxpOas7jg==
X-Received: by 2002:a17:902:76c5:b0:1d7:2095:af2a with SMTP id
 j5-20020a17090276c500b001d72095af2amr582838plt.16.1705703566886; 
 Fri, 19 Jan 2024 14:32:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 jj14-20020a170903048e00b001d7273e380fsm834988plb.153.2024.01.19.14.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 14:32:45 -0800 (PST)
Date: Fri, 19 Jan 2024 14:32:44 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 39/41] hw/net/cadence_gem: use FIELD to describe PHYMNTNC
 register fields
Message-ID: <ce54b95a-13da-4788-aa51-2dd21a2aa5fb@roeck-us.net>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
 <20231027143942.3413881-40-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027143942.3413881-40-peter.maydell@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi,

On Fri, Oct 27, 2023 at 03:39:40PM +0100, Peter Maydell wrote:
> From: Luc Michel <luc.michel@amd.com>
> 
> Use the FIELD macro to describe the PHYMNTNC register fields.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: sai.pavan.boddu@amd.com
> Message-id: 20231017194422.4124691-10-luc.michel@amd.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

With qemu v8.2.0 and this patch in place, I get the following error when trying
to enable the network interface on the xilinx-zynq-a9 emulation.

macb e000b000.ethernet eth0: validation of  with support 00,00000000,00005000,00006000 and advertisement 00,00000000,00000000,00000000 failed: -EINVAL
macb e000b000.ethernet eth0: Could not attach PHY (-22)

The problem is gone after reverting this patch. Note that I also had
to revert "hw/net/cadence_gem: perform PHY access on write only", but
that alone did not fix the problem.

Guenter

