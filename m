Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D9F7438C0
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 11:55:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFAqc-0006zp-6G; Fri, 30 Jun 2023 05:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFAqY-0006zc-OZ
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:55:22 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFAqW-0004BS-LU
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:55:21 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-313f18f5295so1979006f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 02:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688118919; x=1690710919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tRtGYnhM1vvs0oyIoDpwmXbh/di+/7Tdd8TMBOuQXEQ=;
 b=hfKaWN5xNkWQc4XAMJbCTEp1i58tSg5oOGQqmkVIzNZiJYnGj6MmSmJf4EihtmupzV
 9thxWOiwAIjcX7/dwlFsNRbsFa+RSUOtut3Yj9t1tUrgNaSrEYnNcozWDqdzDXg29Jzc
 eEcXBYvZVHFmFBPPTHEdYSQEXdB8WcViZKftrPkuu66bcOM1QxQ29AH3RyHVFB6ighzf
 0mAthoop3iTKAUR8iMehyfg2bp7KeoH4STX0qrcbDagOx7E5SP90nqFT5WwdWKOQCwLd
 0NAjUCKLb5Q0ewuCWamOQL5RRJ7SyTjhI6dOMS8BT1xTCU+pBPx6k4cRo9Og8wurI2wy
 yUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688118919; x=1690710919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tRtGYnhM1vvs0oyIoDpwmXbh/di+/7Tdd8TMBOuQXEQ=;
 b=FBZoIUB+cJmpeUCodL3iQZDfQR8Q1iTCJs27h+WWKTw+5P0tWUauoFnl6PlQcjy+Ie
 XQuebBUJRGfgqXbodlMoKx1NqFFf9dcyvx95R0YtdbiqBiocJRWv4/48i+2aCJI/MEth
 DqcBC5a9PcWZMTR5fZGS/OUKs18/KQiznxIN+YvtCQzzpV8zjfZ2WO8xVY+qCl6dDyIL
 t+NCyusiGkg1daCYxIxAFC+E6vkuh6Pgx4q9yawpbnzJcgg2guSnBr4Q4BdHdK/YV3s7
 dxp5k+t9o//rB5S/MWRdWTOR+ck/YphPE0fYUBgUPZP+R4lM/9Bf3qIpuN3LS0Vc2z02
 6zow==
X-Gm-Message-State: ABy/qLbOi4QRSBy6OzH8YfAlQsUkmTJBxTuy1IPYlklNKTw51yBQLEci
 LR3J+OoB2Li4Re2XW9JSxW6vpQ==
X-Google-Smtp-Source: APBJJlG4kxSil4GuXSR7htY4b4L2JslJXlYdE5+XFfepG2nlgONqYBaMKnWpw0sErt9YHtjKKsoGMA==
X-Received: by 2002:adf:f84f:0:b0:313:f371:aede with SMTP id
 d15-20020adff84f000000b00313f371aedemr1773478wrq.1.1688118919129; 
 Fri, 30 Jun 2023 02:55:19 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 m9-20020adff389000000b00313f551b032sm12124457wro.53.2023.06.30.02.55.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 02:55:18 -0700 (PDT)
Message-ID: <a5927706-4ab1-c633-9489-5c8eaf9973d3@linaro.org>
Date: Fri, 30 Jun 2023 11:55:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/16] vfio queue
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20230630052235.1934154-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630052235.1934154-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/30/23 07:22, Cédric Le Goater wrote:
> The following changes since commit 4d541f63e90c81112c298cbb35ed53e9c79deb00:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2023-06-29 13:16:06 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/  tags/pull-vfio-20230630
> 
> for you to fetch changes up to 0cc889c8826cefa5b80110d31a62273b56aa1832:
> 
>    vfio/pci: Free leaked timer in vfio_realize error path (2023-06-30 06:02:51 +0200)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * migration: New switchover ack to reduce downtime
> * VFIO migration pre-copy support
> * Removal of the VFIO migration experimental flag
> * Alternate offset for GPUDirect Cliques
> * Misc fixes

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


