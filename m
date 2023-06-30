Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACA6743924
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:14:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFB41-0005gs-A5; Fri, 30 Jun 2023 06:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFB3u-0005Rb-B0
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:09:10 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFB3r-0000qT-7o
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:09:09 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-98934f000a5so199399366b.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 03:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688119745; x=1690711745;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bsrBU/kPcaOyxKgtSl7F1+y/eUb4TLRtmQ5xFx/s774=;
 b=qY9OKpdeqIR1QJTldWUNTkT4s7P6vYFQitpqzRiLrXKdXyOdCH45Dk8eA1L/3vemqt
 8vu/+KslhMsrGbllgJbKryRT18mgFctrUh5f2hv+VcLtu80rtLTXizWANhbtROMr0TTj
 C6HwlKY4Qvutprl9XZDZSI05+J9sFakl62Fx8cprlGzKDJRheeTnGcwA32QuudTsKcxJ
 SNfyx/YBvePD8uu7FjaRGtu9NfJ96C4jNMLuped3XWXmLky1LTIHRP7lUhUT/X/qnLFA
 +XDxxHXR6tvU8NfDT2gtlj9+ibhfSUhqFgyKynzx1HJSpXrxauVKYEBRQCChy5+JjxVT
 PH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688119745; x=1690711745;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bsrBU/kPcaOyxKgtSl7F1+y/eUb4TLRtmQ5xFx/s774=;
 b=f4ZFGzyJcTNJoWDr0NH2xJ5Bx9zjrBPcU1lXz/+os/RfZcdbTgZh5DJxetYqpWD7U1
 thFUAKrGW5fBhNabUSzlPBBbGv4ra7REv8NjYA3RDeyQnksr68viEPTNp01Xkb4oBbRn
 bLPyf7o/eVWNEKNQW4LzfB3byxYXIWJLu14Iwk/GzSD/DCPKPqKMv1C5nQt+oQ0KVWhJ
 Zl3IoMM7KD5J7zgLW4tAhjdfhb8gto+lIjR1AcIRB0hSSX19kj8M8qynpXJcmYsF87cd
 /EaZdSPzUvz286itjqMGg2aqA/PU09t2DNfoBJh/OY4XIk1NW1DLwWfI1dES72I7cTPF
 cfDA==
X-Gm-Message-State: ABy/qLbhjL27flGsiUuOi1Q8HNcU6Q1C+yjt6TSDvU0QoJn2VZOWufWQ
 xJF9ABI2ofJRonUVEwPYEJCzZKoP9QxZr2qjiT8=
X-Google-Smtp-Source: APBJJlEBda9H8RMeV4vc5ek64OUZycApU0XWx4QMlrQiFrR/drSz3sYOGHuhEvqr7AQHJvFC2BHaFA==
X-Received: by 2002:a17:906:1158:b0:988:6bd2:b0a6 with SMTP id
 i24-20020a170906115800b009886bd2b0a6mr1387209eja.10.1688119745501; 
 Fri, 30 Jun 2023 03:09:05 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.211.104])
 by smtp.gmail.com with ESMTPSA id
 ha22-20020a170906a89600b0098e0c0cfb66sm7271042ejb.38.2023.06.30.03.09.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 03:09:05 -0700 (PDT)
Message-ID: <306b1814-3d58-ea03-8755-f48f2e3768c0@linaro.org>
Date: Fri, 30 Jun 2023 12:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 16/17] hw/pci-host/i440fx: Resolve i440fx_init()
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20230630073720.21297-1-shentey@gmail.com>
 <20230630073720.21297-17-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230630073720.21297-17-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 30/6/23 09:37, Bernhard Beschow wrote:
> i440fx_init() is a legacy init function. The previous patches worked towards
> TYPE_I440FX_PCI_HOST_BRIDGE to be instantiated the QOM way. Do this now by
> transforming the parameters passed to i440fx_init() into property assignments.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/pci-host/i440fx.h | 10 ----------
>   hw/i386/pc_piix.c            | 32 +++++++++++++++++++++-----------
>   hw/pci-host/i440fx.c         | 33 +++++----------------------------
>   3 files changed, 26 insertions(+), 49 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

