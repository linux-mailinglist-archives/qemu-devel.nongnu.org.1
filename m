Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B65397710F8
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 19:31:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSL5b-0003BK-FI; Sat, 05 Aug 2023 13:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSL5Z-0003BC-TH
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 13:29:17 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSL5Y-0006tK-Dc
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 13:29:17 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bb775625e2so21566865ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 10:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691256554; x=1691861354;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VFQucMGcxUiQRYAptZpESCMqZla5qf5HYotHrpDtrWE=;
 b=R3/o9f07TzlOcuLNmC+LliaRo2sFQ1LmN+pz6sUTvuKuXp+tkRhjmT18EGXF+mKihI
 0neRPCN4YM+seXyvosPluPN8+sW5NNqhadgIicCj+/pUMH0QEj0VHG26tKGeLEObRTow
 BG/BMyJDpOqjO1Fmrm5J0545A95iEBm/vKYiCA58rA1fECp57WL8KdO3DSM5wATZBxIg
 9u3tFGrx0ZqC4QoFJoAnpwJCblLqq0x6pEq8/MLNCW2eiIZjRwoo1G0ZLEAEKJ6VnOIV
 69GcNN/Mbehsx4JBKlJCxL8yi7MRCjWUUOOnUEP/7jIlHf0D/4Ob6Oy48Wi4Gq4+lO0I
 ftyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691256554; x=1691861354;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VFQucMGcxUiQRYAptZpESCMqZla5qf5HYotHrpDtrWE=;
 b=KUglgxcrsXQrCv0vt9j3e4vMPL6WC2SVEngAdGBxlXOnXAKXznF6YSuxIWLwycl8Mf
 DxS2mJOfEMOVK+EiwI3OfQ8FwZEuTmR+K+7EFDNCHpIT5LYfZuK05h2sCUPZKZGWAHTx
 ZCj6xFTcTuClBerBVSMIJti9VUc5CIN1kjXa+UZi5GBAdH/W6OqAWa9EEql6rHIVLiOt
 16ZK3sOcyINTMWjSKgQ+k7ClWG/CgbOCBCswz/YUdwklPbme+43v2owVbRqCXUkAItJG
 F6a8RRbU8f3DKBCVIjs+jRy+OnvGPzlTwXcBIwxBX5vypMgbZY6UHZzz5cYeqLok8qqT
 nF3w==
X-Gm-Message-State: AOJu0YyyM1zijLTzDqJhFJdIqVW0A5HOrlRayf78UikPceMbdd0Rt7Uf
 vugvLpQ3WEnIYW9wLyIPKa6Tvg==
X-Google-Smtp-Source: AGHT+IHymBJRoc80Eu/bkgfUz9v3dOpw1o3+6LJL/8Ko+I5Nm7bFGd4I6ISS0DPo6OYXVVh1fJYwZg==
X-Received: by 2002:a17:902:a3c8:b0:1b8:8702:1e7c with SMTP id
 q8-20020a170902a3c800b001b887021e7cmr2979654plb.33.1691256554564; 
 Sat, 05 Aug 2023 10:29:14 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:9454:a46f:1c22:a7c6?
 ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 w29-20020a63935d000000b0055bf13811f5sm2627789pgm.15.2023.08.05.10.29.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Aug 2023 10:29:14 -0700 (PDT)
Message-ID: <53a2d13f-b508-0dba-5f0a-1b158372d1a4@linaro.org>
Date: Sat, 5 Aug 2023 10:29:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC][PATCH] Reduce generated code by 3% by increasing MMU indices
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <ZM59CkNZg5n4WXO3@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZM59CkNZg5n4WXO3@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 8/5/23 09:47, Helge Deller wrote:
> Do we want to enable such an performance optimization?
> If so, I see two possibilities:
> 
> a) Re-define NB_MMU_MODES per target

No, we've just gotten rid of per target definitions of NB_MMU_MODES, on the way to being 
able to support multiple targets simultaneously.

This only affects x86, and for only 6 bytes per memory access.  While saving code size is 
a nice goal, I sincerely doubt you can measure any performance difference.

If there were a way to change no more than two lines of code, that would be fine.  But 
otherwise I don't see this as being worth making the rest of the code base any more complex.


r~

