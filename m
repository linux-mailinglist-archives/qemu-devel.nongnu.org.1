Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A34A476BF76
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:46:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxAv-0003MK-Oz; Tue, 01 Aug 2023 17:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxAs-0003LC-LF
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:45:02 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxAr-0001Ng-0e
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:45:02 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-307d20548adso5489814f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926299; x=1691531099;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XnVFK47bczBPHEcl3zgbPNpHepgV+x+4w/nm2B3IYE0=;
 b=MkT8iFgCKAxmhWE9Xsc1sApD4aWtB9muaDEO076RyIA0JCZD4RrbYeQwhuHvUdstvb
 9+hhkebkBghYwfgYj7Ejz9BPUX0o0TTrhNR2ETNmsIVwkWtBpio+E4pzauGXtK/SUhhw
 g/vhUyk/z5ym0e+umOy3VDAx5DOX/uaQIYVf0Pc+o2XSampK6cGeLk1hVhtXoN85jlOQ
 WLiQ0ENNgcGc8vUXbAQcTTPkhynhVm7F4a8VfZ9sH98p2XCxPJrG0sdF2rcEfN1J7u7Q
 fya7rddFOgYHM3K08LMy+9WEZBs4fKb3HOwkhVDM/byUBk63dnAH+FznWZlCk5BwGeWr
 GlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926299; x=1691531099;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XnVFK47bczBPHEcl3zgbPNpHepgV+x+4w/nm2B3IYE0=;
 b=OJH1mI4at1r/SaJknMHZdYZx8JHJp8JvZah+GEHztJ+Hw834xIStXooP3oUSbikRdW
 G0dwAakPQegTahwvDwmO/TnsvfWKPZzmiwZlbP438/6APGJ9D2G79tvqIFgLex7ZKLh+
 TeeV37VVkbkjkwY153joqEz1m2fbhzlg5goyxh8snvYdcNpK5nAGHB0fCVC5Nzpw0hOL
 d9RZbhct906oTXAsxvA1pM3JfRUujkgAcL1Uby4SjDgO8KRr70qP9rssynWA2/1nUTTz
 6UX4h7dZOGvI0hwrw2iFHpl9AYeREk1XOEsnbDPCifIAcfxZotU4Wg7xhxJQ8Fi9oM39
 9ZKw==
X-Gm-Message-State: ABy/qLZmDVDeXdj3belLyrNaxjVhL+qxkFenQBAf9cHdPk/QzQoLRKHX
 uez4tOd+UijKniEL0r8KL16fhA==
X-Google-Smtp-Source: APBJJlH2GCZxDhXcpgvzLOmsactyasVaxog84UZOq94+xISvXgDoFza4NWLZ5zCUGBK1UTwdGpqtjg==
X-Received: by 2002:a5d:4691:0:b0:317:6ebe:d7c5 with SMTP id
 u17-20020a5d4691000000b003176ebed7c5mr3130759wrq.51.1690926299401; 
 Tue, 01 Aug 2023 14:44:59 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a5d44d0000000b00317b5c8a4f1sm334597wrr.60.2023.08.01.14.44.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 14:44:58 -0700 (PDT)
Message-ID: <47054edf-0909-66b3-5ae6-04a638c37822@linaro.org>
Date: Tue, 1 Aug 2023 23:44:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] Fix some typos in documentation and comments
Content-Language: en-US
To: Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: libvir-list@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20230730180329.851576-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230730180329.851576-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 30/7/23 20:03, Stefan Weil wrote:
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
> 
> This patch was triggered by a spelling check for the generated
> QEMU documentation using codespell. It does not try to fix all
> typos which still exist in the QEMU code, but has a focus on
> those required to fix the documentation. Nevertheless some code
> comments with the same typos were fixed, too.
> 
> I think the patch is trivial, so maybe it can still be included
> in the upcoming release, but that's not strictly necessary.
> 
> Stefan
> 
>   docs/about/deprecated.rst    | 2 +-
>   docs/devel/qom.rst           | 2 +-
>   docs/system/devices/nvme.rst | 2 +-
>   hw/core/loader.c             | 4 ++--
>   include/exec/memory.h        | 2 +-
>   ui/vnc-enc-tight.c           | 2 +-
>   6 files changed, 7 insertions(+), 7 deletions(-)

Thanks, queued via misc-fixes.

