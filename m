Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD64776F481
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 23:12:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRfcO-00021e-FD; Thu, 03 Aug 2023 17:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRfcM-000213-F6
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 17:12:22 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRfcL-0005Rx-04
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 17:12:22 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bc1c1c68e2so9967205ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 14:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691097139; x=1691701939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=As+ERIUrD0IaW7ogbeDfd68h0VQGRppMM3xAQTCouVU=;
 b=owLgXUvT851bfNzas+GMjl2Psxw96fTc5Nh5tRiFS+jCI2JlixdKyjLx0SOE9R4eRH
 LmHHnSn7HbFLa6C1JzqkUP2xj7Q5nJkV+VgwWnw26wt/VmVT5NLP+z08mGFIiiJyI+9W
 fr41+Gao5VqvxAUAgqXqHaDhJC5y4O83832jnnxlt7MtRjXwXkzk5OecaQANn4yH+eQW
 5PGT7j2TQp7SzdFhKZJu00V6l1o1D2W2b6FOLTbtNFPTJOBrw7tIgqSou892aFDHBn/T
 LGOFW84VkdCtYTIe3AErXEBxv6i5/aSYMByZCVdgGlttvp1B76aBmVLcg1g1p0WP9FPW
 x97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691097139; x=1691701939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=As+ERIUrD0IaW7ogbeDfd68h0VQGRppMM3xAQTCouVU=;
 b=dBTK8T17uSRvjUOeRJ0UyLZkEuTRWOJL4dqmnR1sdVKXY/Qlk2dSFRVh+aATuRTIeO
 XToJUMHDHosc59Lq7a+sxQJIWsFtH6Gd6YaK1fo9UZ2xTVFB3y3vPtjQte5VE5wTN90F
 Nwn71deY1snCavCfL42KOdchvuvsUizF9XfobaCIicNAulLmn8MVAKjEOkT7aIeu44o+
 vPQIomkCrl1eIaJcyqlcIPEeaVj88VjxxEBxN88UPKIwG8bmuIR3gfCjsPFNPfXN+PLM
 W7N5tLk4M+94x8wtFI20m1T9/1+C/aRWAHUA87jkW/CXBSjgOX/vA2TujPah2b6TuOLh
 qfEw==
X-Gm-Message-State: AOJu0YyeE94CA3Qby4x4dctBQPEsW1Ud/2bqEPVuwqGGIhbiCCu09bAR
 OlEF5STsx+XFyPKVSD6dBTtakA==
X-Google-Smtp-Source: AGHT+IGTkM2yJAEafYHNzzLrwoIthCSOr+vDaUmMlTESs/r4Eg/nIVl62DSwwBtIKEXAv4+yeD7olQ==
X-Received: by 2002:a17:902:a50e:b0:1bc:4adb:ed with SMTP id
 s14-20020a170902a50e00b001bc4adb00edmr704158plq.38.1691097139470; 
 Thu, 03 Aug 2023 14:12:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.144.105])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a170902d48d00b001b801044466sm296724plg.114.2023.08.03.14.12.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 14:12:19 -0700 (PDT)
Message-ID: <5621a3cb-21a9-a830-4117-3e65b589384c@linaro.org>
Date: Thu, 3 Aug 2023 14:12:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/3] linux-user: Emulate /proc/cpuinfo for Alpha
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Michael Cree <mcree@orcon.net.nz>
References: <20230803204803.639733-1-deller@gmx.de>
 <20230803204803.639733-4-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230803204803.639733-4-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 8/3/23 13:48, Helge Deller wrote:
> +    dprintf(fd, "cpu active mask\t\t: %016llx\n", (unsigned long long) cpu_mask);

PRIx64 better than using long long.


r~

