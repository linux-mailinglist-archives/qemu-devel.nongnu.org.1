Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6677BFA79
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:58:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBNU-0007vB-Gk; Tue, 10 Oct 2023 07:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBMy-0007bi-JH
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:57:48 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBMv-0000PK-SR
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:57:48 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so1014441266b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 04:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696939064; x=1697543864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xGeU3cXek8o+T1iEneqtkwd23YAA4t01QHHMZH8DEJ4=;
 b=WK3HMFjN109RcUB9XOH3tVzX8ybTg31aWtL5sP19p1F7gb1v0Ds9vwx1+1TZYsIOgw
 P+GTOKyY4opFL2bXLO8Hwadup8POIQq32QOZTPH1JXnyF5Je0qCaBfcfj3pCQCIymOLU
 oH9epFwzfh07xeUwUFm3oC4zN9PNB/Vs6buLx6BA/58a3hDMVGFPPX4t9XJZwFYrj79F
 2Nw0gI1yyVRLrEwCzpnrn5OV6+PGUuKTEvSyIuIrQoTQpPUgOzJj+piLCR91dUi5lkTw
 ZaJ0YdMvE7rvV8nRkjKM4efC+B/YMGlVntsIkBjktOvBAV4a44Z5ipOzJai0+tyKZcx/
 hdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696939064; x=1697543864;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xGeU3cXek8o+T1iEneqtkwd23YAA4t01QHHMZH8DEJ4=;
 b=LEJtvo1BRph9cAIzDK22+PK8Wx8dMsM3m3Ng+5JPAuCDE03ec4Srg1eNVLkp1L4XYi
 uM1TqN2L+GywbF8AI9hDbOxUiohlAI4Csx8dRHZAalQR3oRZHJF33J/UCMi0S24VlCcZ
 mYaL1kqi+2ZNPOrQSg753T8bJdwFeYGRlYtKd8vkrfSXGInA/kWeUR1ghBia2XS6KfAX
 uFeZZEVI8QjpV4RDrd8OAsSLYR+R7Pvpt5xWiOJhjJWrveyLl2TvtVLTXn5ZDrqDPtRJ
 zFjeZC+jcdu86v3DO2r8g17Ri8CmAqjBmcWw9tiABS3RgxUrP0fAvaF4YFy1ZxMcR6Ig
 /jrw==
X-Gm-Message-State: AOJu0Yx/ymfO2ONdKZplWH+ZWMoQoORnLbyeDV79ecMSWmZIIzibXIIq
 /g2aDqYU7qkephYhDdUtea07Uw==
X-Google-Smtp-Source: AGHT+IGU0HbB2cfpV+3WoSB2ZrZhhAuNnOoSXIqzOSH1LZXoMzi1T3GTxxcY1fZiB57PKnTRiAgF3w==
X-Received: by 2002:a17:906:538f:b0:9a2:1ce5:1243 with SMTP id
 g15-20020a170906538f00b009a21ce51243mr16947130ejo.60.1696939064299; 
 Tue, 10 Oct 2023 04:57:44 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 lf18-20020a170906ae5200b009ae5e46210asm8362356ejb.99.2023.10.10.04.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 04:57:43 -0700 (PDT)
Message-ID: <89cbf1ea-8c4e-a582-68c9-ab7844554b49@linaro.org>
Date: Tue, 10 Oct 2023 13:57:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 07/25] configure: remove gcc version suffixes
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Xiaojuan Yang <yangxiaojuan@loongson.cn>, 
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Brad Smith <brad@comstyle.com>, Radoslaw Biernacki <rad@semihalf.com>,
 David Hildenbrand <david@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Nicholas Piggin <npiggin@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Leif Lindholm
 <quic_llindhol@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Maydell
 <peter.maydell@linaro.org>, Yanan Wang <wangyanan55@huawei.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20231009164104.369749-1-alex.bennee@linaro.org>
 <20231009164104.369749-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231009164104.369749-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/10/23 18:40, Alex Bennée wrote:
> The modern packaging of cross GCC's doesn't need the explicit version
> number at the end.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   configure | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


