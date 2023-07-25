Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C036C7619FE
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:32:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOI8R-0007LR-0I; Tue, 25 Jul 2023 09:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOI8L-0007Ku-Pa
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 09:31:27 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOI8G-0006IT-M8
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 09:31:22 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3159d75606dso4164804f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690291878; x=1690896678;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pDWrcf97wyH3QusTQrjCL22Zef45ve3B1f50G5e1wqQ=;
 b=NYgVk+FgaL3P+Cpm4cprEyo7fnFk+TrzEPZqTLcRX3ju+lYQgjWuEKYbcpvYGBztY2
 unl/ne4PSsAI6I3YdNQW4Rtk1XXHTnhyqRW0a7bcx1B7SCz54cU/YpFAwC4XpMjefI7r
 KwDpGIDuPkFNPBunWrCdyOrjc0eLQZ7z+lwDItgsjrLGnC3GLQBuK2QeZJjMKANSyMsL
 akVLMHVgiGMvvHL/YyS5JWZZg/RiFGzfAjQUANek84n7+Y3Z2JDXbc+x7QVgjAEjk1da
 pmsTbo09ufooLyQSA9DFW8IZvEao27gzMWb1ulVhXfKUNeW9TO+ncXtpPxM/7Nnej73/
 NM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690291878; x=1690896678;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pDWrcf97wyH3QusTQrjCL22Zef45ve3B1f50G5e1wqQ=;
 b=AP1Eh7NEcKjtZLcg0vHA+6Dc66YDscGoWt8sN7zlBaNaGVReplXrnMQXqVeRzBGE83
 wzjyFKUMng/Jyo72W4HR3b2zvPvGaU6tgKOC6in9mvQqx7GaSfi53YmugAX4R0c3pW00
 VDOMSciKvOg6vk5NNhsPGQjlomU0ly+yj8/q9hv6n86+ChktPxLOAZJJSKbPZQHUzGCZ
 SH3WolcvjlPpcitzvjMK9hmgaqeTe5VAwR0NuhSPSrqqPbs0RHA2M91f/+0cWZZZC3fF
 weBCSgBfTXhLuee6jftbD3PLGz82LPGdFSB+sd9WCaQN7qlT8JZPr72Kto0Uz8rQjK1i
 ba5g==
X-Gm-Message-State: ABy/qLblZ1htQ1Uk3Fmwd+flwZkHKKbQrq43gO8O/mnxNb78VX5RrHTz
 Sgq0HvUyFYLDg7Fl1ZsSFTcU2Q==
X-Google-Smtp-Source: APBJJlFrigdeAxTuqTF5kxZ0y/TKg0KRE5mRtNJvw+n8fanjH0h6GnZ16Ewzi6REKl07p3EHiEwsRA==
X-Received: by 2002:a05:6000:11d2:b0:317:6189:fe7a with SMTP id
 i18-20020a05600011d200b003176189fe7amr3363961wrx.58.1690291878616; 
 Tue, 25 Jul 2023 06:31:18 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.203.142])
 by smtp.gmail.com with ESMTPSA id
 bf7-20020a0560001cc700b00317495f88fasm10283726wrb.112.2023.07.25.06.31.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 06:31:18 -0700 (PDT)
Message-ID: <7921da3a-91ce-af1a-b74e-6b8791bdeffb@linaro.org>
Date: Tue, 25 Jul 2023 15:31:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] migration/ram: Refactor precopy ram loading code
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Nikolay Borisov <nborisov@suse.com>, Juan Quintela <quintela@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
References: <20230725132651.18635-1-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230725132651.18635-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 25/7/23 15:26, Fabiano Rosas wrote:
> From: Nikolay Borisov <nborisov@suse.com>
> 
> Extract the ramblock parsing code into a routine that operates on the
> sequence of headers from the stream and another the parses the
> individual ramblock. This makes ram_load_precopy() easier to
> comprehend.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> I'm extracting the parts from the fixed-ram migration series [1] that
> could already go in. This patch is one of them.
> 
> 1- https://lore.kernel.org/r/20230330180336.2791-1-farosas@suse.de
> ---
>   migration/ram.c | 141 +++++++++++++++++++++++++++---------------------
>   1 file changed, 79 insertions(+), 62 deletions(-)

I'd rather 1 patch extracting parse_ramblock() then another
one for parse_ramblocks(), anyhow:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


