Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 401E4718E8B
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 00:30:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4UKb-0007PF-JA; Wed, 31 May 2023 18:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UKS-0007Kb-3m
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:30:05 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UKO-0003xf-0A
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:30:03 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30ae901a9ffso118087f8f.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685572198; x=1688164198;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dPxfrbhvP5n7KvhTOwA7fiECQV3dIU+BFmbqVlP1ikQ=;
 b=iZMLZzjHKTj/tnWeKJHssqL5VG79iRk5+gItdWwYpJ4J5O9HsZTjFsVbc1RBCFr6CE
 V7XDw6CYwF2AX1Y9RK/zqUXjGfJck12i+Fgxj3D8OXwqSfZVDUsXsOW9BD1J1bCPUETs
 +ebr8hn0hchVuKIZNYBhFAFxnQVU1kWelDjr174vRqLZuUr/e5sdERKwDKwgZFBvesGF
 QVpvfZ5Im77HeKbBAtCNULukCZSSg2B8rsjhN2ggbbiChmFvbICkRzqzryzaNTYq/nPx
 xjXaK25McQTIaNuUyq1Owgyy+L8oh1ToSBRaYLpClO51QoUOLWN8kJxo1va6kOm49vYL
 mN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685572198; x=1688164198;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dPxfrbhvP5n7KvhTOwA7fiECQV3dIU+BFmbqVlP1ikQ=;
 b=hPtd1R1AXcEwFw5JM7FJ2qtt4QBYrFeOUFpbvx3TEgQsD5/dk/H4IDVEJWbc84p8sw
 aHHeuPljpUl2Aq6awxOa/Bc+3QwFdYHse6ZXCDbWIbkFzZ800Wej8ALkZliBwQTLKJno
 69rZZWw+yBcPsRQdgo24ynzIvY6omL9AA4IjQwbyN5PHRE4ofcOx7ZlV57L/Ko1GbMXT
 RwgWoWpkQ7Z8aFkWNZeyyYiNae2IqUC6f7J597Jp4QK8D4VfcH1fZDXQLN3xZrFakDpS
 MBC5mkFQ4NMqHH6Y1CSFJjPXenAZoxy+VF5sGSJhMRUFxjKacK1ZH2yaX2pxkpJgBNet
 zd9Q==
X-Gm-Message-State: AC+VfDw/Ek+61vlgL/0bXvfV62YgKrm/e7A4JYDD1nMWpKQNHlooLwLL
 837B3wpWf1hwHVFjTjnjRKEuBw==
X-Google-Smtp-Source: ACHHUZ7VR9ebjXcjq4Qtm0ieXux8e5LrAYVvNGTodmZULNEmg3fRFJJReRkqsUr4Hs/XS++Geg8kLA==
X-Received: by 2002:a5d:6a92:0:b0:307:873d:2ea with SMTP id
 s18-20020a5d6a92000000b00307873d02eamr371799wru.47.1685572198260; 
 Wed, 31 May 2023 15:29:58 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a5d4607000000b0030647449730sm8078049wrq.74.2023.05.31.15.29.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 15:29:57 -0700 (PDT)
Message-ID: <806908a3-11a8-7d17-e13f-8f516bf43744@linaro.org>
Date: Thu, 1 Jun 2023 00:29:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 0/4] vfio/pci: Atomic Ops completer support
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>,
 Robin Voetter <robin@streamhpc.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org,
 clg@redhat.com
References: <20230526231558.1660396-1-alex.williamson@redhat.com>
 <4301d6f4-a394-02e3-4773-823976b2e593@streamhpc.com>
 <20230531162446.2bc9a26c.alex.williamson@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531162446.2bc9a26c.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 1/6/23 00:24, Alex Williamson wrote:
> On Wed, 31 May 2023 23:55:41 +0200
> Robin Voetter <robin@streamhpc.com> wrote:
> 
>> Hi Alex,
>>
>> Thanks for taking the time to implement support for Atomic Op completer
>> support properly :). I have tested out these patches and the kernel
>> patch, and apart from a minor issue with patch 2 everything works fine;
> 
> Yes, Cedric noted the extra semicolon as well, I'm about to post that
> patch as non-RFC since it has no dependencies on anything else.


> Policy decisions like that are generally left to management tools, so
> there would always be a means to enable or disable the feature.  In
> fact, that's specifically why I test that the Atomic Op completer bits
> are unset in the root port before changing them so that this automatic
> enablement could live alongside a command line option to statically
> enable some bits.
> 
> That does however remind me that it is often good with these sorts of
> "clever" automatic features to have an opt-out, so I'll likely add an
> x-no-rp-atomics device option in the next version to provide that.

I was just going to suggest that, just in case :)


