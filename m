Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FECD7B7BBC
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:18:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qny0i-0005aG-TV; Wed, 04 Oct 2023 05:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qny0g-0005Zy-Ud
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:17:39 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qny0f-0003S2-0H
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:17:38 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3248e90f032so1859379f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696411054; x=1697015854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Ge25dLyfZqPnHLKJkRxZfdIzoJzl+k+G3DM+FsgNBA=;
 b=J7Hw0raCJoIYANL2o10pBys6ARVQna41Km4bQsAp7CbKDVE7qCRmzQLc8gWJrD+0Gc
 y7lYZaWCrL4BZm2iKEwXQJpISXTwzFc7HzOP6acXC3fmqRAKRI44JnEwzQ0ciqMWkN5n
 gnOGThRB5s+KfAPjsAIBkh+Wbz2RC3pEA+f4hWLW2pFz6d8gnko2810e3ClpxnpnT2fb
 JWidMJ+PdUGAJ0WJM1gtkoRCbB4E7AZxsmfuzLlz5glYCIuSpFnW4Cy7QsVSCg4t2YHd
 szjWL/CVXGAylT1yWWe8auU1N6dHL0ZH6Cvy5riP31+Ai8qy9qNqHepDlZVn4s4uOMMo
 iElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696411054; x=1697015854;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Ge25dLyfZqPnHLKJkRxZfdIzoJzl+k+G3DM+FsgNBA=;
 b=U08udMP42J8GwisFk0UCK91EhhNn7lgMDIyLVY6tPmGwzPkFFsXk7GGGqJagzA7GCy
 uKgM2mDSpy1C3LV0VKkHln8WAI7Po25JBsTLXFmQ1jXLJnnbB0oSlakXg/gle+oc8xVw
 +p9YwyUcQNbw//nsJAqwKQfMXNIjHz2HZgx8zUFElvoy5NsXWAtMmREunB7ueZzGBR9A
 cw5rnNXoCsRF8+s/EOJMjWvqJrk+O5DMr4vpAYWUsxY1yNgasCUeaR276h5utTnqRNRt
 PKDntOMaI0RI8UQbXOw3KjrSePmcsOWhZ/aAwv9Fbq70wFFrO7uDJ2SCjEXHtCauXVFk
 hOuA==
X-Gm-Message-State: AOJu0YyO6YBWgwNDnyU5RYVC80yijbL7j59c+gEi5j1i8fQA96ggdKEc
 d3kMiQuxIOk74zcAoewWEj/Wc/VrdNwyvbTwzbM=
X-Google-Smtp-Source: AGHT+IFbxWIy6qhLDZeHwS7GvpzVHTbLuf9DR6vRx/lZ08aaH6xbsi3a+1+KIcqIOVFoeUUzJlcPPQ==
X-Received: by 2002:a5d:544e:0:b0:31f:a256:4bbb with SMTP id
 w14-20020a5d544e000000b0031fa2564bbbmr1344896wrv.71.1696411054588; 
 Wed, 04 Oct 2023 02:17:34 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 v11-20020adfedcb000000b0031fd849e797sm3514434wro.105.2023.10.04.02.17.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 02:17:34 -0700 (PDT)
Message-ID: <a55a4808-6748-fdcc-ab90-829d2a903d03@linaro.org>
Date: Wed, 4 Oct 2023 11:17:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/3] sysemu/accel: Simplify sysemu/xen.h
Content-Language: en-US
To: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Cc: Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>
References: <20230905122142.5939-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230905122142.5939-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/9/23 14:21, Philippe Mathieu-Daudé wrote:
> Trivial cleanups which simplify "sysemu/xen.h".
> 
> Philippe Mathieu-Daudé (3):
>    sysemu/xen: Remove unuseful CONFIG_USER_ONLY header guard
>    sysemu/xen: Remove unreachable xen_ram_alloc() code
>    sysemu/xen: Allow elision of xen_hvm_modified_memory()
> 
>   include/exec/ram_addr.h |  8 ++++++--
>   include/sysemu/xen.h    | 24 +++---------------------
>   2 files changed, 9 insertions(+), 23 deletions(-)
> 

ping for trivial patches 1 & 2?

