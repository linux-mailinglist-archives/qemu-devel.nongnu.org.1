Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D6D7DD60A
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 19:28:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtST-0008TP-Lj; Tue, 31 Oct 2023 14:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxtSP-0008T6-Q3
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:27:18 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxtSI-0000GG-Mz
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:27:17 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-407c3adef8eso48940095e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698776821; x=1699381621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KtVZ0fTu7Jqtp+BqxrV+eWoXuf5dljVjACIPmSE8jho=;
 b=CLzxmPGEJXPDOYobblNDUxUupiT3xnfbeveEfX/+iwcrvQkn2jm2rfSgRw+WjzIM3e
 Hui+DQFdl9sajbUn9sO2ByykO9ZqdJZYZibHuv8STgJN0t+R9jD9DlJVFRjgDuw4rMQi
 OaUezNlyEnBDba/FVbHg6dxyJ3/aMpLmw/AtoG0+7u12H3BG4XGIT4femlrvxAsjdMEe
 apWNgrHfV38E50ehd9v4FzsNzoPgCXuYSiIbm078qcbDseJJJQhrHBxY4z2Nwv1fkDCC
 Y5IaLL+ZPv5nFF9S7CiYzCx9NFY847GjVzv4Fadji25jkG2k3PNhC7DmXndW1m6rPjcW
 kQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698776821; x=1699381621;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KtVZ0fTu7Jqtp+BqxrV+eWoXuf5dljVjACIPmSE8jho=;
 b=QC79HpKJMRrC/+KCcBRHIE4wxzMGS6VlZJq1fO/co1bNUm+WhcF7cn9Pz2FUnLp8IZ
 3HXCPxRBSb7xgHCovGJancujSvuJ7O4v0K2da1NsfQRBklEhLYiSWjD/BFsUDJrPFV1A
 N9l1uqlSmfHlieSwOGZvtC1tAKKln1ma4wODkoi7wMQgzTPfES1Xdkuc4gKtmH32qDRj
 oN9Ei6SC9VjUxFmGEOg7ffwqjDm/sQCzcE17hSgFTjUUV008XCZHnp40Pv/BK8bETp0c
 sByIsxUGbWR0NSWv4/elhuPJ9BCgRv1rWqpdOAICNLp598F6J7frsy4dvV4CJaAYNSg2
 b0ew==
X-Gm-Message-State: AOJu0Yxh20ToAalFjZWC/cmwRFKNFTpXKBxJLRVLjlRTfbQedENPQOU8
 sesNDbHxOCAcsn/FtGMQEXkrKQ==
X-Google-Smtp-Source: AGHT+IG1QYpOrQbefkV+eubYPBI+qiAUICBQgr0rriskh/2B1kqkyfFjuLw1AN6X28zpa7ZLuhS55Q==
X-Received: by 2002:adf:fb90:0:b0:32d:bc6e:7f0e with SMTP id
 a16-20020adffb90000000b0032dbc6e7f0emr10733941wrr.3.1698776820919; 
 Tue, 31 Oct 2023 11:27:00 -0700 (PDT)
Received: from [192.168.69.115] (gjh33-h01-176-171-208-14.dsl.sta.abo.bbox.fr.
 [176.171.208.14]) by smtp.gmail.com with ESMTPSA id
 12-20020a5d47ac000000b0032ddc3b88e9sm2184887wrb.0.2023.10.31.11.26.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 11:27:00 -0700 (PDT)
Message-ID: <0cb317d6-3941-ff03-23c3-2034f39ddc78@linaro.org>
Date: Tue, 31 Oct 2023 19:26:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: QEMU developers fortnightly conference call for 2023-10-31
Content-Language: en-US
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
 wei.w.wang@intel.com, z.huo@139.com, zwu.kernel@gmail.com,
 Leo Hou <leohou163@163.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <calendar-1ad16449-09cc-40fb-ab4a-24eafcc62d2a@google.com>
 <597d5991-97c5-9e2e-0660-fe5c75b3b1b7@linaro.org>
 <4f825a30-6414-8e3c-2101-057f6bfae6b2@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <4f825a30-6414-8e3c-2101-057f6bfae6b2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 31/10/23 13:53, Philippe Mathieu-Daudé wrote:
> On 30/10/23 15:56, Philippe Mathieu-Daudé wrote:
>> Hi Juan,
>>
>> On 30/10/23 12:04, Juan Quintela wrote:
>>> QEMU developers fortnightly conference call
>>>
>>> Hi
>>>
>>> If you have any topics for this week Conference call, please answer 
>>> to this email.
>>
>> I don't have anything planned but I can take 30min to briefly
>> describe the problems I'm encountering, and present the vision /
>> roadmap prepared, which I'll post as RFC soon (right know I'm
>> focusing on getting my last PRs ready for soft freeze).
> 
> I took some notes here:
> https://etherpad.opendev.org/p/qemu-kvm-call-2023-10-31

Today's call recording is available here:
https://fileserver.linaro.org/s/C4F7rF9KBgZsdWD
Enjoy my French!

Phil.


