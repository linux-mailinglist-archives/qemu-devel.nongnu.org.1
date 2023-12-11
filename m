Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5D380D904
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 19:50:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rClLg-0007x9-7c; Mon, 11 Dec 2023 13:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rClLd-0007vs-R2
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:49:45 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rClLZ-0001zV-Hn
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:49:45 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-54cdef4c913so11926289a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 10:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702320580; x=1702925380; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HMifsXyiMj/1Cud3aqEOFpseFKshxf0R5FnIN9t1RZo=;
 b=YUHBJ38xy2XWDYWKFVzA8dd1tSJzLPGnuQZugsJYQ8wx5+37IXt1hMuMn0LpxWhlvV
 gnjvXZIdI/QKktmd2U553SkqSsakRTWEJpBpeNyDe0JkLjUdk2GG+kHtbf83iHDrsaaI
 +MPRhBfcVSdHGwNmVLlEZINK4GBoky7OMNLzv8gT7w7TjkZCc/v91es143RDf4+COpOJ
 qrQ7LQUnsp3TzXr7kbqaNEcRm3KbyK1Lt42FNSocrSSunAVaLaCS2Xt7VEkOo5B9NZXR
 giMvNhZ6u/3Y2y6nHdOAnFweb2UgvuSfLI/xKRddbsjI6+xvDtsc9F1JpX6L+TL80JR3
 UzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702320580; x=1702925380;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HMifsXyiMj/1Cud3aqEOFpseFKshxf0R5FnIN9t1RZo=;
 b=OD7G1ZpR7wzA+bgmxxA13+gMtWn4GMWdTiQpjBFhCB9hOabu2FXUaV9l5XCsXdux7g
 iqWtWS4SAR5bx6aj7dqKk7jnOcbyQRnkiIBQL8Q0lBv8orcfaZWHJNIjMstmK2sdhkv3
 R/8tEufPoUUOMjsCPs7NuqSTwdhVqJLiBmz1PrNTvIEAoOsTJprtj9056m9ry+nt79EJ
 MZ5EE/rfKE2eC3z/VnLtQzHF5y7yG40V+AJ78G83tpJhBLJBnJnimkf9s9u1bSAWfrH/
 sXz20GbZ86iXqfOjEBlpPM5u6sHz5wHqpZGijvd/ohJyOtUf8Xq3LEwElUCTDQXXhsuT
 tEXA==
X-Gm-Message-State: AOJu0YwYr547+oeZUZnf3Je+6ovZ8WtdiaNL47kb7KFnLO17lx92YtcQ
 sE2pyuB6eSdLXLmEY5fU4lsuVg==
X-Google-Smtp-Source: AGHT+IGL95uW5K1zeBFz31wVSmV6wQbcOF19UrdvVp68txCEJTASBuKIyBLS5MBKfeDyYAHwqyFvxA==
X-Received: by 2002:a17:906:2209:b0:a00:ab1a:c81 with SMTP id
 s9-20020a170906220900b00a00ab1a0c81mr3826808ejs.22.1702320579759; 
 Mon, 11 Dec 2023 10:49:39 -0800 (PST)
Received: from [192.168.69.100] (cor91-h02-176-184-30-150.dsl.sta.abo.bbox.fr.
 [176.184.30.150]) by smtp.gmail.com with ESMTPSA id
 sa16-20020a1709076d1000b00a1da72b8752sm5176361ejc.212.2023.12.11.10.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 10:49:38 -0800 (PST)
Message-ID: <6569eff3-cbb2-4430-8311-e2a875a7602f@linaro.org>
Date: Mon, 11 Dec 2023 19:49:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU developers fortnightly conference call for agenda for
 2023-12-12
Content-Language: en-US
To: Brian Cain <bcain@quicinc.com>
References: <calendar-98548e19-3517-40fa-a2ae-1c384aa3f98f@google.com>
Cc: Juan Quintela <juan.quintela@gmail.com>, afaerber@suse.de, ale@rev.ng,
 anjo@rev.ng, bbauman@redhat.com, chao.p.peng@linux.intel.com,
 cjia@nvidia.com, cw@f00f.org, eblake@redhat.com, edgar.iglesias@gmail.com,
 elena.ufimtseva@oracle.com, eric.auger@redhat.com, f4bug@amsat.org,
 "felipe@nutanix.com" <felipe.franciosi@nutanix.com>,
 "iggy@theiggy.com" <iggy@kws1.com>, "imp@bsdimp.com" <wlosh@bsdimp.com>,
 jan.kiszka@web.de, jgg@nvidia.com, jidong.xiao@gmail.com,
 jjherne@linux.vnet.ibm.com, joao.m.martins@oracle.com,
 konrad.wilk@oracle.com, mburton@qti.qualcomm.com, mdean@redhat.com,
 mimu@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 quintela@redhat.com, richard.henderson@linaro.org,
 shameerali.kolothum.thodi@huawei.com, stefanha@gmail.com,
 wei.w.wang@intel.com, z.huo@139.com, zwu.kernel@gmail.com
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <calendar-98548e19-3517-40fa-a2ae-1c384aa3f98f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

Cc'ing Brian (this could be a good place to discuss Hexagon semihosting)

On 5/12/23 14:47, Juan Quintela wrote:
> QEMU developers fortnightly conference call
> 
> Hi
> If you have any topics for the last qemu conference call of the year, 
> feel free to answer to this email.
> 
> Later, Juan.
> 
> QEMU developers fortnightly conference call
> Tuesday 2023-12-12 ⋅ 15:00 – 16:00 (Central European Time - Madrid)
> If you need call details, please contact me: quintela@redhat.com 
> <mailto:quintela@redhat.com>
> 
> 
>     Location
> 
> https://meet.jit.si/kvmcallmeeting
> View map 
> <https://www.google.com/url?q=https%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&sa=D&ust=1702216020000000&usg=AOvVaw1xrpPSmMRu9niy1trqCKrA>


