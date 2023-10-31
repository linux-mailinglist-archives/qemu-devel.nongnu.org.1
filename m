Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AC87DCD97
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:17:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxoFd-0008H0-2G; Tue, 31 Oct 2023 08:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxoFa-0008Gq-8K
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 08:53:42 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxoFY-0003s3-EB
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 08:53:41 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9c773ac9b15so837413266b.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 05:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698756817; x=1699361617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KDf9mMPWl1MpMNs/To0F9tholdy9sOxm+J1nkFELtQo=;
 b=SMV3/Eulsf+3odIKLyLtmQtdtHKAvrl8Mc6NSoGcjw1fk2ZVpVyJ9LmNBOq1DitoFT
 6g7FMsHhk2kvnG2D3mjCphHNQVeGMRJYxcLWRDb08V+quhBR0TL1wBFvofkLxqjpm1Qe
 4KMN+A3ADwPasJqfG8xcLxzCAGzLiluEkJU29qbNX8lEpHx8oWm3IXwBxZZdpU9jcRtX
 E5k/fTNmOvlVKWNbcGSzQDVorDI+G5BYNpDv2TTjVq+AXMcq/xfTlP1GzauxTA3ElRbN
 sX1hfKhtfiUB076tQ+kcDDE6xRO4csvPlwA0WXdAqYpGUzlAWsVUoyJb0p0yVFaxOW03
 Ho4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698756817; x=1699361617;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KDf9mMPWl1MpMNs/To0F9tholdy9sOxm+J1nkFELtQo=;
 b=XeZHTof8zWQc/oisv9eS4d3MVeKH6OZoid6OvStJSt0xvCp1faJvOVoGlAZ0981EAo
 MYfhXUObO48ELKZ6imUZtx2Hf7dRf9j0EXTIUsVWuaaUZn9aQ6e50coiO8PQp2oPojEA
 DrjJKkJcGrG+tabT6mqJuMD4NosQpNYKj13yiG5s5s++Es4FZXsUWUhKCe8VOMVhXFJt
 CYoQ2yoFkQp+hSUXGNUKPwoxM8199fFjCzvslmtgas8pm2Mp7PSoCPCDRB2hzW1Hp6fY
 yRbRyXK30WxzuFxvwtWvCcyn65Xd6R3SAEUMXZItqR7wBFAwjzhG0JcurWL/jj0Tm6pC
 50cg==
X-Gm-Message-State: AOJu0YwASbG6XOd78F8WXpBkANBo7ADt2zby6BajibUTw+1Bk7OixJyH
 lvL1qkJDnYzr1jxdobAbzx4U6Q==
X-Google-Smtp-Source: AGHT+IHw3BRHEAOWe251mXBMeROMTjxgNa8nKJspjk2cQIsmvERKpN9yMEl/aF56kOBDRybwVJJWUw==
X-Received: by 2002:a17:907:2cc4:b0:9c6:1143:b52 with SMTP id
 hg4-20020a1709072cc400b009c611430b52mr10840425ejc.55.1698756817412; 
 Tue, 31 Oct 2023 05:53:37 -0700 (PDT)
Received: from [192.168.69.115] (gjh33-h01-176-171-208-14.dsl.sta.abo.bbox.fr.
 [176.171.208.14]) by smtp.gmail.com with ESMTPSA id
 j20-20020a170906051400b009c5c5c2c59csm950128eja.149.2023.10.31.05.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 05:53:37 -0700 (PDT)
Message-ID: <4f825a30-6414-8e3c-2101-057f6bfae6b2@linaro.org>
Date: Tue, 31 Oct 2023 13:53:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: QEMU developers fortnightly conference call for 2023-10-31
To: Juan Quintela <juan.quintela@gmail.com>, afaerber@suse.de, ale@rev.ng,
 anjo@rev.ng, bazulay@redhat.com, bbauman@redhat.com,
 chao.p.peng@linux.intel.com, cjia@nvidia.com, cw@f00f.org,
 david.edmondson@oracle.com, dustin.kirkland@canonical.com,
 eblake@redhat.com, edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com,
 eric.auger@redhat.com, f4bug@amsat.org,
 "felipe@nutanix.com" <felipe.franciosi@nutanix.com>,
 "iggy@theiggy.com" <iggy@kws1.com>, "imp@bsdimp.com" <wlosh@bsdimp.com>,
 jan.kiszka@web.de, jgg@nvidia.com, jidong.xiao@gmail.com,
 jjherne@linux.vnet.ibm.com, joao.m.martins@oracle.com,
 konrad.wilk@oracle.com, mburton@qti.qualcomm.com, mdean@redhat.com,
 mimu@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 quintela@redhat.com, richard.henderson@linaro.org,
 shameerali.kolothum.thodi@huawei.com, stefanha@gmail.com,
 wei.w.wang@intel.com, z.huo@139.com, zwu.kernel@gmail.com
References: <calendar-1ad16449-09cc-40fb-ab4a-24eafcc62d2a@google.com>
 <597d5991-97c5-9e2e-0660-fe5c75b3b1b7@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <597d5991-97c5-9e2e-0660-fe5c75b3b1b7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.053,
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

On 30/10/23 15:56, Philippe Mathieu-Daudé wrote:
> Hi Juan,
> 
> On 30/10/23 12:04, Juan Quintela wrote:
>> QEMU developers fortnightly conference call
>>
>> Hi
>>
>> If you have any topics for this week Conference call, please answer to 
>> this email.
> 
> I don't have anything planned but I can take 30min to briefly
> describe the problems I'm encountering, and present the vision /
> roadmap prepared, which I'll post as RFC soon (right know I'm
> focusing on getting my last PRs ready for soft freeze).

I took some notes here:
https://etherpad.opendev.org/p/qemu-kvm-call-2023-10-31


