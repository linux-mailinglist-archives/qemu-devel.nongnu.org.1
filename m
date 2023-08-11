Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3207792F4
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 17:24:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUTyz-0001gB-1G; Fri, 11 Aug 2023 11:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUTyx-0001fo-3J
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:23:19 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUTyu-0000fU-TS
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:23:18 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-267fabc8465so1246429a91.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 08:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691767394; x=1692372194;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hZdFZQIFN0jc51oqaz9N5OsY65rsBjyEydT4UN7bDaY=;
 b=winn+RBdVMthYYbxBIEy+qER+Cwee0eYd6DXxYKF3QzO/WwOHZ1Aa6+DNynGpPV1eA
 xp8o2BFXky//avdZTcnmMgsaGX9bkLIrvQPW/LBiQx2QSrr9L/YN9j6SCNHbFNwilN+F
 rIWtAnw2hovfQEqF5LFycOFVCFIlfFbDcRgUceVABONx1qJnNbCUeMP5g5c8UvWPNXCZ
 97GkkNppo31QIgHgjwIqI/ASWbM8v4lR3q3n4cOO7I/+8Ti7gCqUWQvYWhu9CPXzDmUa
 LRcc1ZOIskTs9MDbjZ3v0ITmBipm9WrcKUzcdBSgxnacZzvY35NfIJG8euZko3GbE/Zf
 WTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691767394; x=1692372194;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hZdFZQIFN0jc51oqaz9N5OsY65rsBjyEydT4UN7bDaY=;
 b=lLOAa1RSQuYGeglATOu2Q5z44qAr392Ey5KS6VaVS58wsR10IW/w8WhdPA57BLqQgZ
 jJcZHguf55rglvbLTke7/IQQnCnzURW1pUe1QaBySwe0VqQPSVMxZOSe3gH0PfL+Pv4f
 eFAdpprSo53Qr2QvQupMVHDzt6culzKtZIZvd3/aX55chwAGAFb/o+YHIos0jvt3R2IQ
 X2TQTJ7J6PFlw2+xPfmKe3iwzDexcoOCKCo9+cT9mFVTMczSOKl/htjw/W1/E3b7td/7
 OmkIGdIS4hlj/IIIhuIU0gKxx/sF9SGUn/PFjLPb+Gp0vaRVEf+JGRFivouoATzLh1iX
 IISw==
X-Gm-Message-State: AOJu0Yzfc2g7CVGaY6GFxzAnOYEuPgmjYraUDr4hUjpEo0hSsmF0Pud/
 qppwE4oe4q1zgS1/IcKwu47Yqg==
X-Google-Smtp-Source: AGHT+IGEo++tQrTcwOYRbF9Bb5Ka8GVyP1450bSjyuq5QwVt0yP2x3S3QySS9jBrzVW8g0t3Teu3aQ==
X-Received: by 2002:a17:90a:1783:b0:268:29cb:f93a with SMTP id
 q3-20020a17090a178300b0026829cbf93amr1544208pja.1.1691767394646; 
 Fri, 11 Aug 2023 08:23:14 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:e773:351d:2db2:8a8a?
 ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 k4-20020a17090a910400b002694da8a9cdsm3446851pjo.48.2023.08.11.08.23.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 08:23:14 -0700 (PDT)
Message-ID: <af285335-f2c5-bcb8-63e4-d3a47634dc5d@linaro.org>
Date: Fri, 11 Aug 2023 08:23:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/8] target/loongarch: Add a check parameter to the
 TRANS macro
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn, c@jia.je
References: <20230811100208.271649-1-gaosong@loongson.cn>
 <20230811100208.271649-3-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230811100208.271649-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
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

On 8/11/23 03:02, Song Gao wrote:
> The default check parmeter is ALL, remove TRANS_64 marco.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Song Gao <gaosong@loongson.cn>

If you're going to remove TRANS_64, you should simply drop the patch that added it, and be 
careful about the final patch ordering such that the LA32 cpu is created after your patch 
3 (which adds avail_64()).

Otherwise there will be a bisection point at which LA32 is enabled, but avail_64 is not 
enforced.


r~

