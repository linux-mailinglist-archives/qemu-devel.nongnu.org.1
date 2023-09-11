Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB3079A981
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:15:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfiGW-0003wN-IX; Mon, 11 Sep 2023 10:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfiGT-0003w5-UW
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:51:50 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfiGR-0000Rk-L9
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:51:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-400a087b0bfso48624575e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 07:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694443905; x=1695048705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+g+PzcLXZI7am6/sFewOZL5hgXQpZfXwThkwZ9tCOCs=;
 b=FblNj4iqnjHWy7eN//uXFFwCAHOQtoNhxjhYxTYa9TZOhcUZwrwjQ4TpA6pencxoa7
 lLMa+Rf8slfuvCKoBsCGHSkb0nn4yDlxoRvuh8GKUYVL7iMD3P4q7pLjjSv+bpANMoN+
 FSL5ltw9pWpJD1CaN/tzsyON7fPwKhl7K32W/5BTMKaoJo9/rr19DsDaWXq1/oTAJTJ9
 ifQT7BUN0HgZ+5xPJ+lb6xcVCvxUQo8eupDwvZdB5TSSp4Yqunq5PDCODF7k1Iwlt4pq
 A2B8N6lB68NGoX6PG9NjWGnOPA31e4oas7YQZ9iqf5JoU+4Hk0dVK+FsBDB1nNwZuxOP
 ToLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694443905; x=1695048705;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+g+PzcLXZI7am6/sFewOZL5hgXQpZfXwThkwZ9tCOCs=;
 b=N5x+Jj7ehVkMHND1k8Il73h5mlaywazcQgOfkpm7r1zqnWQHCN9eDjHsTg/MNTnnKu
 W02rD+Yt6C4AuynmGWXA6pYGAHTw7PoBHZj1NnRFCVoQ55I/2Z46VsqyTMBODssbf5Fx
 vj3/39a6Jw94jkprZQXxpkR+xmwqo3qPCfF1fp2i6XcKzJB/7zyuh4tAQ7Qs+n1mGTiU
 E14OHywOG5n9PfbLZ3rut9gXgr5F2nyGTSzmOG4LEV29uIB63DbDK00UUJn3D+VpFJjS
 GSfJprqYCF19X4/cPCFLdZhX3tJnf0vA1WSLihDeleGd5wF+IW/U7iXoBdkz6EVzeQCJ
 VyIQ==
X-Gm-Message-State: AOJu0YyjOKQ5cdqkUHkrLNt2n1x5u6lpkcGObRfgN6HBBlcHl23Z14MO
 FK/PgBeCj7adbCDplJmo2dAigkbrW7xVW+uRIKY=
X-Google-Smtp-Source: AGHT+IH7iCStNS6tAJ+eZ8xGvsk7MbHGcAzDJFQF1X8j4F6V3WcQ5khUD4N3f0DYMgstWNgQZFNptQ==
X-Received: by 2002:a5d:4e0d:0:b0:317:3dff:7189 with SMTP id
 p13-20020a5d4e0d000000b003173dff7189mr7977958wrt.66.1694443905276; 
 Mon, 11 Sep 2023 07:51:45 -0700 (PDT)
Received: from [192.168.69.115] (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 w18-20020a5d6092000000b0031c52e81490sm10326808wrt.72.2023.09.11.07.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 07:51:44 -0700 (PDT)
Message-ID: <fafc1a7e-47cf-b021-5b49-74dc229b5a20@linaro.org>
Date: Mon, 11 Sep 2023 16:51:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/7] linux-user/elfload.c: Correct SME feature names
 reported in cpuinfo
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230911135340.1139553-1-peter.maydell@linaro.org>
 <20230911135340.1139553-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230911135340.1139553-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 11/9/23 15:53, Peter Maydell wrote:
> Some of the names we use for CPU features in linux-user's dummy
> /proc/cpuinfo don't match the strings in the real kernel in
> arch/arm64/kernel/cpuinfo.c. Specifically, the SME related
> features have an underscore in the HWCAP_FOO define name,
> but (like the SVE ones) they do not have an underscore in the
> string in cpuinfo. Correct the errors.
> 
> Fixes: a55b9e7226708 ("linux-user: Emulate /proc/cpuinfo on aarch64 and arm")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/elfload.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


