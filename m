Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAB97B4BBC
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 08:54:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnCoY-0005wc-33; Mon, 02 Oct 2023 02:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCoT-0005wK-OA
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:53:53 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCoN-0003x1-HH
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:53:53 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-504b84d59cbso6815838e87.3
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 23:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696229625; x=1696834425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xcBZsjDw1G+5EYCt0VIhVW0jWHgAELzxXzT9/I6GAQc=;
 b=yVqzNU/26kqBTT0Tvei1kUpZDGsOPwBHX/j4V+Ja9kQB4G/KVCXGd8hyuHWQ4EIeV6
 JYzMZBMmd0+/xZCvDVgGi8l2N3Kt/4UXOUQfmdiWXgPwA3rfnfD4MGOTmL4j81SzvqHh
 tgvdTxf9MC63MXk/vO+yKEiS2O/Hiha+KlBKGMPW82M2uayeLCGDoRWMeLUxpOSZwU0M
 CEL0U4d6rPQ4ODOsOGdcLIRKb/h3gTe2iCAwWI6r9YKHJYbZ0zE5+kpM1ekL8KWivVpd
 0FfHUbA2RfHawFKprs2hkq818gyjXc/edCZfK5Ypa+HCC/KMs3wzLw1dqgSQ1QlqBQbS
 25DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696229625; x=1696834425;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xcBZsjDw1G+5EYCt0VIhVW0jWHgAELzxXzT9/I6GAQc=;
 b=ZwHrt924um0o49diGrAFDs7A3GHoIyQEB9v67jAaMELQx7PEFVXW8TXVTmLndoHrZg
 +3AwpxlcmfGekIrflkgT+dwyt2qtQC0muaU/Hufd54F4MTZ0fY5DGBs9eeIQGvrYBm9f
 Zr1xZdNcIDb65CNgid2BU5xIVBZyv3EeH+NBtwqAc5vMfj5ZYN8zTS6kny+PD2FFPDYY
 0762qhz1CGjky//EiB+cT9zpJ40js0phs0PKhhIRjRfgd7zMo6nm6O15hnYFNhnVFPxd
 s5elMSA0g6fTnK8vrHdQLmNIDmK8izKYlw2PSgl7kHrBhob2JIcsLWox+kwbnNAufpYB
 Sn5Q==
X-Gm-Message-State: AOJu0Yy/8AMcY0/pFuS6oH0CX7V6gvIokDWP45a/j71c8tc9E8QACagY
 V0CjZ8JkTzrsXO0wUE6AWVfdmZoZy5lCNw0IGpw=
X-Google-Smtp-Source: AGHT+IGcQJbTxYVmVhicm7cs0qvq2N/IbkOkLol9qGljgaKd0xYIJsr1LepbFyUK/2/41xbUrAtDRg==
X-Received: by 2002:a05:6512:39cd:b0:503:95b:db02 with SMTP id
 k13-20020a05651239cd00b00503095bdb02mr10645615lfu.18.1696229625406; 
 Sun, 01 Oct 2023 23:53:45 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 v9-20020a5d4b09000000b0032008f99216sm27721320wrq.96.2023.10.01.23.53.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Oct 2023 23:53:45 -0700 (PDT)
Message-ID: <59858fd9-3c1e-32f8-1be9-e1e7d81ce46a@linaro.org>
Date: Mon, 2 Oct 2023 08:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] target/arm/kvm64.c: Remove unused include
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230925110429.3917202-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230925110429.3917202-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.058,
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

On 25/9/23 13:04, Peter Maydell wrote:
> The include of hw/arm/virt.h in kvm64.c is unnecessary and also a
> layering violation since the generic KVM code shouldn't need to know
> anything about board-specifics.  The include line is an accidental
> leftover from commit 15613357ba53a4763, where we cleaned up the code
> to not depend on virt board internals but forgot to also remove the
> now-redundant include line.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/kvm64.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



