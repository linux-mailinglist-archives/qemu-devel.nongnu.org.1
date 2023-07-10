Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 385DC74D554
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:26:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpxH-0007Nd-V0; Mon, 10 Jul 2023 08:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIpx8-0007LV-Gm
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:25:23 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIpx6-0007CD-LK
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:25:18 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso4542691f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688991913; x=1691583913;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M3kOBNeNQ+Ieh6U14WkmPRZeKwr67ZPQu1HOwi1Z08U=;
 b=OjJJlEou5IVL+PrpIPur8duy8XPLJ2bPQtfpMTPjURt4FBd+8gH2YtND0vvYF1BYho
 u01nc9kzRpuK9RhqkHr/FMiMeOvQRw3IPK2SSi3Vw/6yGbk3pVdYxiFKcGM+ZKfQM5uX
 SgNfbpCXMoCc4atD6rcZ3kYXg5IA+lj4CCNa3ocoZKx4EJZ8ntrwh4TLAMukKP3WjuVR
 msn8LJoUqedp8An8vx5sv39DcEN2i9pLg8iShTktLv55q1jwo9mXRNZkOVALncMk70Ob
 vczhTkhGXBaLvvqIAPFyrp98rAAXxJDte4piJv1D/ztkyu+3tE5uP5Sw2biwVhYR9VFD
 0u2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688991913; x=1691583913;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M3kOBNeNQ+Ieh6U14WkmPRZeKwr67ZPQu1HOwi1Z08U=;
 b=BJjPcFqZBUURQN6L0POBhxy1xilr9qFxHzzM7WE/Txb/AgwiWJoaPbGCmqH4OAmqQ1
 AA42W2OLEif/1NGLFFXJj5JRqcVxCwmAQxU+8cIgYWN2Dpt7KB7z5zoiMognrZ9L+bjT
 u2qUC4/Q/gaJJcz/QpauanHtjLuI08xm43lnu1Iv066ysIB1mEGnF6eM0e7JPo5VdOZP
 DO/YN3GVA+HC2CqAcHItfjSsy9JM/zitCfjdZqwS4MWizlknSSoJ4XtHC/4sUgu/z4nX
 Vi/l7LHzC5OeXRTViUkmnD/U8PruMaYNF4A9Mx1LUl9j5aD3Fc3Hr1xdEfWiQdLWGF+l
 xeBA==
X-Gm-Message-State: ABy/qLZMKzTCS8G6zd7LVtwDf7Dyv9+y7qJpAFQpxVY+XADAL7fVNI9K
 QaJlKqz58GDgCes7+GO3gek8Tg==
X-Google-Smtp-Source: APBJJlHqCdVG+Uv1zKUwYIyfweMrbCxGXZUyonusviXgQuETdh78lAECkw/dQJC2KO9xmQs+ZcKdSQ==
X-Received: by 2002:a5d:4b04:0:b0:313:e613:6f86 with SMTP id
 v4-20020a5d4b04000000b00313e6136f86mr10708640wrq.38.1688991913516; 
 Mon, 10 Jul 2023 05:25:13 -0700 (PDT)
Received: from [192.168.8.133] ([148.252.133.210])
 by smtp.gmail.com with ESMTPSA id
 k10-20020adff28a000000b0031434cebcd8sm11628268wro.33.2023.07.10.05.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 05:25:13 -0700 (PDT)
Message-ID: <53eca0e7-8718-bc66-285b-1c752882333c@linaro.org>
Date: Mon, 10 Jul 2023 13:25:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v2 00/11] vfio queue
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20230710075937.459263-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710075937.459263-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 7/10/23 08:59, Cédric Le Goater wrote:
> The following changes since commit 2ff49e96accc8fd9a38e9abd16f0cfa0adab1605:
> 
>    Merge tag 'pull-tcg-20230709' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-07-09 15:01:43 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/  tags/pull-vfio-20230710
> 
> for you to fetch changes up to c00aac6f1428d40a4ca2ab9b89070afc2a5bf979:
> 
>    vfio/pci: Enable AtomicOps completers on root ports (2023-07-10 09:52:52 +0200)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * Fixes in error handling paths of VFIO PCI devices
> * Improvements of reported errors for VFIO migration
> * Linux header update
> * Enablement of AtomicOps completers on root ports
> * Fix for unplug of passthrough AP devices

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


