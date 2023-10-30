Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BAF7DBC36
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:57:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxThS-0004e1-3h; Mon, 30 Oct 2023 10:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxThG-0004dl-UH
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:56:55 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxThD-00068x-Rr
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:56:53 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99de884ad25so702345666b.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 07:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698677810; x=1699282610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pQMRtWxsI4t+NcNx7UGjR4E6aFEp3nrV+4mdFZI7m9I=;
 b=QEfqMSK9uEYBQRMwTE+z6Pu4NB6HD2sOE9ZpCfYUvs41zD9qkPyeQ01kbqpAcoTic0
 gh2ytONVxOKjMLXeFsmbYPJxoqSCg8GLjeaVV/Z3d1xIVIkcGgDsFdcMPHk71aLy+XEy
 1ZyMgZ11Ik+zGicm+CkNn2Re0KUC14jqKm5OJY8dpNeueWB/xg/TIAWk2rgmgH4V9mL5
 eQrMncBoVBKVgscNrCuHV49Kgi1R0glvACgvjNw47S7Um+rGCj2v0rXQK7HxLrq7H75v
 dIV+gMV63Sno3DEUIa6JgIiTT86bQsKA21nQRVp1BN/S2Nj/eGqWsxIxZa7ULjMkqvDQ
 Vrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698677810; x=1699282610;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pQMRtWxsI4t+NcNx7UGjR4E6aFEp3nrV+4mdFZI7m9I=;
 b=ZKwPON9O5rCtVInazL5Rge1MDwTDf7LyMHWBnSpbna9/AxWcOmgnFm2dWzh9efLn/n
 Nq4aRURK0H2zmIGynYyJNSJOLqIIMeM5KKIUM1dFwkjCRVKGIuSFehaIFmTMnst4+S/k
 wo0kdQAJbJGWwvhhAqFMqqMKj6CLE7oBQmTUNy1tAb3WDJqCYmAdL/etJuTpEFu8sr7P
 wpcLkEmwgDT/o/e7HeGecdZBOdM9+NdIUguRkMOTmKbPp9VNHoGl3zRqB/TzqmWP0weV
 08mDtY9fACji8niR0154SRZEbBR1JrAdPpnzLUqQsGuEMEiWPiKJbis+LUpT4nUa0Wfc
 edFw==
X-Gm-Message-State: AOJu0Yw4ieFU3Rigcrq4jy9GRGfnEovLEADQVSplS5DxO+EBnQyRsQOj
 mtb/2WT++jwa6jROsNxHrBqeDA==
X-Google-Smtp-Source: AGHT+IEonnQ+hpMIUhzHXc+dozXmHvtTL1ycIt8M39P6Xjpwtggotcy4daAZk5ybEvmEDCV0909rrQ==
X-Received: by 2002:a17:906:da84:b0:9be:30c2:b8fd with SMTP id
 xh4-20020a170906da8400b009be30c2b8fdmr8520043ejb.66.1698677809867; 
 Mon, 30 Oct 2023 07:56:49 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 gj22-20020a170907741600b009d152059ad7sm4695098ejc.39.2023.10.30.07.56.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 07:56:49 -0700 (PDT)
Message-ID: <597d5991-97c5-9e2e-0660-fe5c75b3b1b7@linaro.org>
Date: Mon, 30 Oct 2023 15:56:44 +0100
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
 wei.w.wang@intel.com, z.huo@139.com, zwu.kernel@gmail.com
References: <calendar-1ad16449-09cc-40fb-ab4a-24eafcc62d2a@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <calendar-1ad16449-09cc-40fb-ab4a-24eafcc62d2a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.441,
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

Hi Juan,

On 30/10/23 12:04, Juan Quintela wrote:
> QEMU developers fortnightly conference call
> 
> Hi
> 
> If you have any topics for this week Conference call, please answer to 
> this email.

I don't have anything planned but I can take 30min to briefly
describe the problems I'm encountering, and present the vision /
roadmap prepared, which I'll post as RFC soon (right know I'm
focusing on getting my last PRs ready for soft freeze).

> Thanks, Juan.
> 
> QEMU developers fortnightly conference call
> Tuesday 2023-10-31 ⋅ 14:00 – 15:00 (Central European Time - Madrid)
> If you need call details, please contact me: quintela@redhat.com 
> <mailto:quintela@redhat.com>
> 
> 
>     Location
> 
> https://meet.jit.si/kvmcallmeeting
> View map 
> <https://www.google.com/url?q=https%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&sa=D&ust=1699095840000000&usg=AOvVaw2MfLnjN20yFq03yus22z_j>



