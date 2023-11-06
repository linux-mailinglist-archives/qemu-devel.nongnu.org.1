Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8717E1AFE
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:19:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztrz-0007Mg-Od; Mon, 06 Nov 2023 02:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qztru-0007IF-U0
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:17:54 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qztrt-0005PY-DG
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:17:54 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32f7abbb8b4so2654758f8f.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699255072; x=1699859872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hodLEJrIrf1SgrJbrg7bPvIrnsFm+jWdxqkcAuAiGj8=;
 b=nGju9Cg+nxKNJaQaET2IBil0SW6qEqnZvG+HpkiZ/GeFyO1QxUBcciWYhkxkxUs5/7
 E7rFYA7A0lKDe43Mnv9qwY58hCSeNYHgLUuQ0Lw8x72xnZflEafBAoM4Wiw9a1WeegJI
 kikLHYfFP51XTy+BqOt7NOvK9fNopTAZuLNu0Yj32vytJHWb6oI22GkVfxS/DypsnuhE
 jsWQM9xQUI+AdlK07sxaCiMlKxahElw42c8LWsB1ee9n9CQpY9NA8Cn04dJOL4HQP+E6
 VeAsBmxV3O/FuzBO+ni1Amae74Se7KvD5TIwOhTnlwsJ0/hgXwYGEtTVq+cr75ScpixF
 hllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699255072; x=1699859872;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hodLEJrIrf1SgrJbrg7bPvIrnsFm+jWdxqkcAuAiGj8=;
 b=Vw2xzo2DgHtb74x+gSoe2tsArsFz5V/YBlUzqwXregDozdvjhCXhlEUG6SBNO4H/wd
 fr7eqdFWhxrjQzOrU2Bswf+DWwLowo2697UuGIVPWrXhnwMlWxIiCet7d1ITw/NpHvgQ
 K4QGSY5tYcuCNxJXG5dsYQ2SgpJ5/dD7NuweL/NmzKaImV0Ty1yz858wc/NFYft67DDG
 IAYhbg9YoLdVkFJVnaZpA2aRRxEzwQQrRGtRVhLeZaHWmTR0dbSWFoE31KlyHdMuWlPZ
 HSmgP2DJeFQpyGHPRWx3huCZLhxa56Tw4XpOv840h7vICp47lhXzC2qqCqmFALE2H3XV
 HkwQ==
X-Gm-Message-State: AOJu0YwUGPqIXnaLAE94G+Byzu6mzQvqtheBFjgharr1wzg5gKteLGRm
 KbmPTjpT7dW5uvzmqZgtfTNXLg==
X-Google-Smtp-Source: AGHT+IH6Cg8HyarQaOAQwf1SPNguXE+Um7TXykdkOaoat4ioeBPWEFr32qCxi8hfH4f072Y/uiiTkA==
X-Received: by 2002:a5d:47c4:0:b0:32f:c5ea:72ac with SMTP id
 o4-20020a5d47c4000000b0032fc5ea72acmr5258933wrc.46.1699255071432; 
 Sun, 05 Nov 2023 23:17:51 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 d18-20020adfa352000000b0032fb9c5aa24sm8066371wrb.93.2023.11.05.23.17.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 23:17:51 -0800 (PST)
Message-ID: <6c39fdb9-1a77-3982-3ea5-00f58ca15e2c@linaro.org>
Date: Mon, 6 Nov 2023 08:17:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 02/16] target: Mention 'cpu-qom.h' is target agnostic
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Yanan Wang <wangyanan55@huawei.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Marek Vasut <marex@denx.de>,
 Laurent Vivier <laurent@vivier.eu>, Peter Maydell
 <peter.maydell@linaro.org>, Brian Cain <bcain@quicinc.com>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Michael Rolnik <mrolnik@gmail.com>
References: <20231013140116.255-1-philmd@linaro.org>
 <20231013140116.255-3-philmd@linaro.org> <ZTIo4NpORQvvRcED@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZTIo4NpORQvvRcED@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.137,
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

On 20/10/23 09:14, Zhao Liu wrote:
> Hi Philippe,
> 
> On Fri, Oct 13, 2023 at 04:01:01PM +0200, Philippe Mathieu-Daudé wrote:
>> Date: Fri, 13 Oct 2023 16:01:01 +0200
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: [PATCH v2 02/16] target: Mention 'cpu-qom.h' is target agnostic
>> X-Mailer: git-send-email 2.41.0
>>
>> "target/foo/cpu-qom.h" is supposed to be target agnostic
>> (include-able by any target). Add such mention in the
>> header.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/cpu-qom.h        | 2 +-
>>   target/hppa/cpu-qom.h       | 2 +-
>>   target/microblaze/cpu-qom.h | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> Why not mention this description for other qom-cpu.h in this series,
> e.g., target/i386/cpu-qom.h.

OK, will add a comment in each patch.

> Otherwise,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Thanks!


