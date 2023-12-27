Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA98681EDBF
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 10:22:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIQ6Z-00030x-OC; Wed, 27 Dec 2023 04:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIQ6X-00030d-GK
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 04:21:33 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIQ6V-0003DA-PZ
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 04:21:33 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d3ae326f6so57523895e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 01:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703668889; x=1704273689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=docCXZq5iwB7T+o3eftC6U6/H1dV/BymKMJa+Sz4ubw=;
 b=kZx6HxfBbQ0rM3OnozgEWf59z4JlbiEU9P4CWi5sFPk84J9Ls8lehALsInJ4pi286r
 nCUO4jx31Syxx7zYkMZsDzw/j/mNaAvRhaS9w61mIiT8ZNPPF8WI6vxj3uN1CXVFI7k6
 5QFWAPW0Vk2KqFAYAs7ZyX8FVLxGJMpsxnO40Jp8whYheGFYCtDYdjiO641xe/B873KX
 P10wb7/uzmXcoWLTV4YmS/cQSJ4hTaHpapegFh/0Xs+yHGPltu39L5wWtVOxzkcpWSjC
 9zt3+VS37J22VSbWDcAbL36wXRJeR+1fGaDrpE9qzjVU88Qjt633zrqmWE8rpTSZqB6P
 2l4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703668889; x=1704273689;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=docCXZq5iwB7T+o3eftC6U6/H1dV/BymKMJa+Sz4ubw=;
 b=ogK1sp0IpVRt1JvxgbzBownF4mO4+WuXAOCoPrKTKW6LRcr5DAmtsssGdB84jjchXq
 A/Z+ERy0RLjQeCrb0p0pyFw0PGzD0NzeRjICIATqivzQ3IIPSlP6eqY5S4lsVbha77Mw
 zDD8pUj4sVETbb6V3fenMQE8DpLqgcAPc0WeRZv4pAQqpgpk68aJ+nLoO/JdhRyORovH
 dYrC4QaCu03/1ZLoX6f+gywhxtxYbQ+5UcCNEv7Rhw30ZgC1v7/w6DbD7elydNT/sQZD
 zNLF7jnCiTN85AD6bXAFj2o+uNJGOlRTFnGifiEdZSBt1YehLkailWkUvPdpyVBoOxlP
 GTAw==
X-Gm-Message-State: AOJu0Ywz5As5Kxjr4Xthcgtt+nnG151OBEe5fd1HzUxhKTsAxnDLPK5N
 /4KLWn2eTxVTFdV4GjDvnxWTBC5G0FZlbg==
X-Google-Smtp-Source: AGHT+IGvsfNk9ebdYz7cm/zkwEHC0CGik6nZWV8DkHpPpAIZrSOkBEcrVbxJixanM2L32c5UdKQdkw==
X-Received: by 2002:a05:600c:1615:b0:40d:2f3d:7d8a with SMTP id
 m21-20020a05600c161500b0040d2f3d7d8amr4592301wmn.161.1703668888918; 
 Wed, 27 Dec 2023 01:21:28 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.122])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a05600c310700b0040d5f412e48sm1067658wmo.32.2023.12.27.01.21.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 01:21:28 -0800 (PST)
Message-ID: <9733fe6c-d9ea-4945-ba06-8d23890f22c7@linaro.org>
Date: Wed, 27 Dec 2023 10:21:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailmap: Fix Stefan Weil author email again
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20231227085934.18158-1-philmd@linaro.org>
 <92d0751b-fa39-4fc2-8e55-3b07aa3b3ed4@tls.msk.ru>
 <9d66b444-d0c8-495a-8555-5b70af07bea9@linaro.org>
In-Reply-To: <9d66b444-d0c8-495a-8555-5b70af07bea9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 27/12/23 10:12, Philippe Mathieu-Daudé wrote:
> On 27/12/23 10:09, Michael Tokarev wrote:
>> 27.12.2023 11:59, Philippe Mathieu-Daudé:
>>> Commit 5204b499a6 ("mailmap: Fix Stefan Weil author email")
>>> corrected authorship for patch received at qemu-devel@nongnu.org,
>>> correct now for patch received at qemu-trivial@nongnu.org.
>>>
>>> Fixes: d819fc9516 ("virtio-blk: Fix potential nullptr read access")
>>
>> Do you think a single commit warrants an entry in mailmap?
> 
> If I cared enough to write and post a patch, I suppose so...
> 
> In the past the only limitation was whether someone was willing
> to do the work and send a patch, not the size of the .mailmap
> file.

A more useful use of our time would be a git pre-merge hook on
our CI, but that won't work because PR aren't merged on the CI
but externally, and the final commit is pushed.

The only place I can think of to automate that is to have a
script on the maintainer side. Remembering Peter had a such
script, I found a reference in the list:
https://git.linaro.org/people/pmaydell/misc-scripts.git/commit/?id=f9a317392e8

Stefan, do you mind using Peter's script for your merges?

Thanks,

Phil.

