Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B25E1775180
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 05:45:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTa6o-0003Ap-Tk; Tue, 08 Aug 2023 23:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qTa6l-00039B-Uy
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:43:39 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qTa6k-0001Ar-5V
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:43:39 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bbbbb77b38so40184565ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 20:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691552616; x=1692157416;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SaqBFDbbmz+a8U7Y+FYboQz4LeevhqJPOque12cwnBU=;
 b=17tFK4pLB7tyJe8P5+lRymPmEviiK0bcKiAVWXZSFPB5HESNNFfz0OSc1QXM+rno2A
 eUWgR+0tIFASM3jcSlQ/NsqEn3jp4e94hPWtcgN06VJ08YEVq7Iv4Nz3/8YSP+Nf3ipI
 kU+6+aYKLyVafzsF8VxWv9SPRoGN1u6CcOWUB1DvEF7rTM2lQrezPF1JnMVbMWiozRLI
 Ibg/5FTB8PwgyoS5YEnuAcV3a0wLsFvt9lfcsHoPq7hFzXQVWWnwvHAGmzaZQdYai71r
 FuoGCBWJ7nfz6+xl74b6p1322jR+AkyBsWE0tizk8mteSQJnLgLTRWMDponRNumLnHvT
 vmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691552616; x=1692157416;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SaqBFDbbmz+a8U7Y+FYboQz4LeevhqJPOque12cwnBU=;
 b=SxyFZ2al+Fp/nUpK/NMo6HoK9ZY3QvrrgepgXzGisBwObc7nUimknrhMorMHO4lhhE
 IPUPaJc7qvgFrg+7oBgE0Jtism9aqx5+Jx2TUfp3iMeG7YmUqp12sxzluTn0MPV24ndc
 5OQfPFHu5c3BI2tfcF2mKKWnR1YE6F+qutqa+HUHZBXvqs0Fqh3qzGp6YBhGz9JPcqer
 NTM4mQ5ADo1n94f7UPqi/nYyMhU9sBiNMAzHxsYDEwiSnGKjbsFOpJg835QNE9fWonTZ
 7/7n89kieumlX7hKXqcIBU/+/EVAqISr2Z6zm+IfL4YyAfDQb/0gNJZRyBw/8OFW+tTw
 aNaQ==
X-Gm-Message-State: AOJu0YwKb0DJ/PpfsJfOM+01bKavSIaEi36okLk67xGcsMacCnVRKtgZ
 gebIkamZic1NFkioorK7WJL8Kg==
X-Google-Smtp-Source: AGHT+IFuEZT5dS5r0Tcr6CMXQ3f0wHVIH94H9/r9sjVmV/BGfqHSlWRDvxLh7gHlVIAkoZ0YM6TwrQ==
X-Received: by 2002:a17:902:e5d1:b0:1b8:8b72:fa28 with SMTP id
 u17-20020a170902e5d100b001b88b72fa28mr1781642plf.58.1691552616459; 
 Tue, 08 Aug 2023 20:43:36 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a170902d18100b001b9d7c8f44dsm9892530plb.182.2023.08.08.20.43.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 20:43:36 -0700 (PDT)
Message-ID: <cbfd8bb5-7c95-44a7-85ef-8597a5f85242@daynix.com>
Date: Wed, 9 Aug 2023 12:43:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu/osdep: Remove fallback for MAP_FIXED_NOREPLACE
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230808164418.69989-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230808164418.69989-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/08/09 1:44, Richard Henderson wrote:
> In order for our emulation of MAP_FIXED_NOREPLACE to succeed within
> linux-user target_mmap, we require a non-zero value.  This does not
> require host kernel support, merely the bit being defined.
> 
> MAP_FIXED_NOREPLACE was added with glibc 2.28.  From repology.org:
> 
>                    Fedora 36: 2.35
>            CentOS 8 (RHEL-8): 2.28
>                    Debian 11: 2.31
>           OpenSUSE Leap 15.4: 2.31
>             Ubuntu LTS 20.04: 2.31
> 
> Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

