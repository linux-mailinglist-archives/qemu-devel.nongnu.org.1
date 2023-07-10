Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E8174DE36
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 21:30:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIwYn-00023D-2p; Mon, 10 Jul 2023 15:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIwYk-00022m-Pt
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:28:34 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIwYY-00079z-4j
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:28:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fc0aecf107so21258595e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 12:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689017300; x=1691609300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zIDqJsTV+5mfm0yiyfFYte0cwrkRPEHjF/Foqt3Dmks=;
 b=azyxuiMsvywq7yxJM57EycAA4PNP2L68GQdR6x+PCGdZbr6Zqc2WDxkj5N7IVqSNHt
 bZ0NytNh5VPHy4hbSjpaszvUAOuB8xbbK6XNaX0ySLiav9L3Ig9mvBFT9GooeZSrOXB3
 e1VZKx9EGR6JteoFCPnBVz2OI129ZyYNTTVeR6okiRkmo2itX8dgKKb8jWgTM0y+W2dF
 G0q6hT3iDWm7jQhT79sZDfbsnW5kgtELIthN0/kInjCV7GLHUwC85pspzNj9OcW5cs0x
 uSaj6cd2OBOdLzCk+U0J7SueZBy1N345R1JzjhqSpXctbURQn5tS0ZYe2CKQC47jHpb+
 WCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689017300; x=1691609300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zIDqJsTV+5mfm0yiyfFYte0cwrkRPEHjF/Foqt3Dmks=;
 b=bsmmNOD7p1FbFOzHrU0Bfsvwl9FjWAOuAtPY+vNVP21P+EKWgqhIRmPtiwEcflriS1
 HUSegPNXHeW+tJZZ0PgRWbSWHtkzW8pD5Aee1q5ZHSDW1kXRIHrnHy5+ya5L3SnkGOcL
 kAMqXfkBQBtRM2HPwm+R5vdjXa753cVqfYeVvhA/l6Su9OfGZ9yvUXo2OG7gWvHJX8j6
 1eBt1fy/SwC77YB8CR+WM5aUTseLLzwEnRMPY1wruh5hYyw5i2A4OpKiC2WNbzSQQu75
 f14Q7YJ5IKA6NTXvRfGfr0VEb6bAhWZJEdFxfk3zuO6odlzg9BDyjkyGMfNHpcarW9Kl
 qGog==
X-Gm-Message-State: ABy/qLYzJtowiAf+zrGFYQC/Fazlt3/sc4hGchTMIGM512FcyJzvXkmH
 wa2qFxxQTPF51bkD5NQE7DNPrjbIYpNAGadtS5JlHA==
X-Google-Smtp-Source: APBJJlGUV+Fv2GwKx6mSwZlj2Ns3dtp7jK3guWixyKfoEhNjW46V3P95TpB2gz6Cm+1lCiss0nNMIw==
X-Received: by 2002:a1c:7c05:0:b0:3fc:500:db7c with SMTP id
 x5-20020a1c7c05000000b003fc0500db7cmr7931294wmc.21.1689017300363; 
 Mon, 10 Jul 2023 12:28:20 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 y19-20020a05600c20d300b003fc01f7a42dsm648858wmm.8.2023.07.10.12.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 12:28:20 -0700 (PDT)
Message-ID: <781894e9-2565-b54f-8df3-9cbd1cf68e2a@linaro.org>
Date: Mon, 10 Jul 2023 21:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 00/33] target/mips: Finalise the Ingenic MXU ASE support
Content-Language: en-US
To: Siarhei Volkau <lis8215@gmail.com>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Siarhei,

On 8/6/23 12:41, Siarhei Volkau wrote:
> This patch series is aimed to add complete support of the
> Ingenic MXU extensions of version 1 revision 2.
> The serie doesn't split revision 1 and revision 2 of the
> MXU ASE as it ought to be, because I have no hardware which
> supports revision 1 only. The MXU version 2 is not the subject
> of the patch series either.
> 
> All added/fixed instructions were tested on real hardware
> via set of fuzz tests written for that purpose, although
> the tests aren't subject of this patch series.

Thank you very much for your contribution.
This is a bit unfortunate that you did'nt implemented these
opcode using decodetree.
Also various opcodes are not well optimized, and would benefit
from using the TCG gvec API.
I imagine you have been rebasing that for some years now, so I'm
queuing as is to mips-next.
I hope you can share the tests so your work doesn't bitrot
with time (in particular when a good soul converts it to
decodetree).

Regards,

Phil.


