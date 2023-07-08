Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5FB74BC5E
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 08:24:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI1M3-0005hD-PS; Sat, 08 Jul 2023 02:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI1Lw-0005gE-7k
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 02:23:35 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI1Lu-0006Mz-Di
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 02:23:31 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3143ccb0f75so3176562f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 23:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688797408; x=1691389408;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mvBL81B+42kaEIgH0Pxk2+x/kApY44H3EBSFNtgOo1M=;
 b=jBiP79Vso92jJdm6NhdPYl3jgEbt2N/ZKSO3EnCRaYnXf7rEQCyhLP3YswZg5wGNxf
 ZawjU3GAA3WmIEV5D+53Yd5IJMl78v9oA/2u4N3wDn8PGsn/Vvj2GF6QwO4JGgcBOaFW
 3dNsScuZ7vsL0yIyDWexsuVX9dw6MAnkj5A9pF04RDH4hx+Jf6+J4mDUzECbRHzVBMmN
 3gDFrzZqUUMzMVihTMmXQqw1dcsD9zON/lbrjXeF9MKkryClFfvIeX42GS9igAcKiWh1
 vwSL1c2Dz57Xp2qVUuoFLWX8zzz3Cat1uwLSHi46zVqAJYj3fHOGNqqqmXZSyB5JYE95
 l6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688797408; x=1691389408;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mvBL81B+42kaEIgH0Pxk2+x/kApY44H3EBSFNtgOo1M=;
 b=GxvFlFNfogJM9XgLMPCsabnXf2PJQX8wmJdlKATkyfLFJo2O8EGYaO1+z+XB/8PJB8
 L7iw77i7ycaGRMNGV+mBPWu8shdHtOyM6m8MdSzIdbnompiE62SiEI+8p/AlrKBM85ow
 EuDt+/b52QNoW86AuVjMfhKuNdvbhOJ69cFSxsDff8+uTdFIoN4niHriXTl+PkU9Fnw9
 I6Bi3DMx9Fwc2+3J2ugjjfP1GbBflx5y8vqJdcYFpX/jyCJmnmqYR4EHLb3L2FbEOemQ
 qShe1SotCZG4vDcPbCRTveFCP3pUe4kEN31QT3dPdif4OrIdw5SK5VAavhJC0rgB9Q1U
 tyOQ==
X-Gm-Message-State: ABy/qLaPzp31prxZWJHcg5F++iQvUBXIRTLIRtCmRDGAQnWUNfBqHTUr
 MkqRRknZm5s83j26vhOkTfACOQ==
X-Google-Smtp-Source: APBJJlEznVHm0B2Ef/P4XPqXZEl2eWCg+lvwD2g8wkpWuuYwkUPMYksQlrtpWRloO6DvX4ROVrh/LQ==
X-Received: by 2002:adf:e64d:0:b0:314:388b:361b with SMTP id
 b13-20020adfe64d000000b00314388b361bmr7890725wrn.12.1688797408570; 
 Fri, 07 Jul 2023 23:23:28 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 v12-20020adfe4cc000000b003143cb109d5sm6131216wrm.14.2023.07.07.23.23.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 23:23:28 -0700 (PDT)
Message-ID: <168c0eb3-07d9-7dfb-de47-7fbebb80ebbc@linaro.org>
Date: Sat, 8 Jul 2023 07:23:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v2 00/59] ppc queue
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, peter.maydell@linaro.org
References: <20230707144100.25389-1-danielhb413@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230707144100.25389-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 7/7/23 15:41, Daniel Henrique Barboza wrote:
> Changes v1->v2:
>   * Dropped patch 60 "ppc: Enable 2nd DAWR support on p10"
> 
> Thanks,
> 
> Daniel
> 
> The following changes since commit 97c81ef4b8e203d9620fd46e7eb77004563e3675:
> 
>    Merge tag 'pull-9p-20230706' ofhttps://github.com/cschoenebeck/qemu  into staging (2023-07-06 18:19:42 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/danielhb/qemu.git  tags/pull-ppc-20230707-1
> 
> for you to fetch changes up to bdb97596f663e9af9741353417c651f0d581de29:
> 
>    ppc/pnv: Add QME region for P10 (2023-07-07 06:32:53 -0300)
> 
> ----------------------------------------------------------------
> ppc patch queue for 2023-07-07:
> 
> In this last queue for 8.1 we have a lot of fixes and improvements all
> around: SMT support for powerNV, XIVE fixes, PPC440 cleanups, exception
> handling cleanups and kvm_pph.h cleanups just to name a few.
> 
> Thanks everyone in the qemu-ppc community for all the contributions for
> the next QEMU 8.1 release.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


