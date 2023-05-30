Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA5C716C95
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:34:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q449v-00072h-32; Tue, 30 May 2023 14:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q449m-00070r-BU
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:33:22 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q449k-0002mq-KP
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:33:18 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-25673e8c464so1764531a91.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685471595; x=1688063595;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6K3AOaDX4DbO4iac5lm/Krumr48EP1mAe79NUo7b7js=;
 b=GvtjQN9CDVRZMT97eBf2ATERLxR/7dTLQp+j/LgyXI+DAQiUjSdp5/MuAWPQMeuQB8
 pDltl1g8fjiqEF7jxBvUNmHdc35EqQ3dQ0oHMpZrLBD3EoL/Esp3NuugK0fzQSU08jkU
 Vph9K3LNQney8sW+IzQ9mLTsYJoBCRXCVh+OzBsnLIw9BN0t4lc+XA2P8FgoNhVRxb71
 h7iwPSD50vvWaqUWt8yMUGrNnVWUDOI44KFfB1Kvnxj3UMY3ras7d5owZNNFJ8ie5a/3
 Wq5PXEMzMHI7aNrjDaXnwpQXErCW6ucnUHp6s+N4VIu2yiyg0R73XwL9byImgWW+Ny6h
 0Mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685471595; x=1688063595;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6K3AOaDX4DbO4iac5lm/Krumr48EP1mAe79NUo7b7js=;
 b=mCjmLoNRnLiTfccszIzagypTNwqGcFnZKWmSdJjk7XiF2vCy/kyJ6vqkIR2VCp/tGi
 9CgmuA9KAQrEmHxxPtbHVWCL0hzY0razomkafu3btVX/5HF/+aQbNHHytSmCdw1Zu6NM
 +fwK3uoAQIrhVMfot2HJ2Z2tHxy/j3okfciSOhKUdPsSr4ZdMmCsKH/IPELc/CpZNiaI
 RfxrTab0SAMW3K0mYM0iD3d4gDDpvlKxuVZRZXByBMZw5WpRYwBLzOPnzXsUArS+uqkE
 7m6iEQOPskaVqJVOl4DEIvbeOLIIZ4SLPKEWzdYZwjYbe/iUlIjy9G4JdzaMPLJ2uKBh
 pwHw==
X-Gm-Message-State: AC+VfDyWT9hQo2NFYR6Xt7QdPMqy3h11ETl2kZQp9WqA7kI/Ox9vlXds
 4fVhEqZF+56Km1bcxW7pZsE5Yg==
X-Google-Smtp-Source: ACHHUZ52Sky2ZbGJXjk+CKYYAk4m3dR8sIoB1Z5VQxdZSzWMapcQ9xNhchG/jnRF2yrGwXNNkXi2cg==
X-Received: by 2002:a17:90b:1811:b0:253:9766:749e with SMTP id
 lw17-20020a17090b181100b002539766749emr3640408pjb.16.1685471595024; 
 Tue, 30 May 2023 11:33:15 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:35a2:c45d:7485:f488?
 ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a17090ae00500b0025677ccf217sm4395875pjy.1.2023.05.30.11.33.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 11:33:14 -0700 (PDT)
Message-ID: <295d3015-3aa6-ad0d-43d4-a5b2eef6d9bf@linaro.org>
Date: Tue, 30 May 2023 11:33:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/32] Block layer patches
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20230530163239.576632-1-kwolf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530163239.576632-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/30/23 09:32, Kevin Wolf wrote:
> The following changes since commit aa9bbd865502ed517624ab6fe7d4b5d89ca95e43:
> 
>    Merge tag 'pull-ppc-20230528' ofhttps://gitlab.com/danielhb/qemu  into staging (2023-05-29 14:31:52 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git  tags/for-upstream
> 
> for you to fetch changes up to 60f782b6b78211c125970768be726c9f380dbd61:
> 
>    aio: remove aio_disable_external() API (2023-05-30 17:37:26 +0200)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - Fix blockdev-create with iothreads
> - Remove aio_disable_external() API

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


